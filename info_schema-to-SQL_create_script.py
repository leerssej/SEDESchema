#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np

isc = pd.read_csv("information_schema.columns.csv")
isc
# for SQL prepared
# https://data.stackexchange.com/stackoverflow/query/1023678
# isc = pd.read_csv("SEDE_tabsColsTypes.csv")


# In[6]:


isc.TABLE_SCHEMA.unique()


# In[3]:


isc.DATA_TYPE.unique()


# In[4]:


isc.CHARACTER_MAXIMUM_LENGTH.unique()


# In[5]:


# find the maximum character length specified
max_len = isc.CHARACTER_MAXIMUM_LENGTH.max()


# In[170]:


# set the -1 values to the maximum character length specified
isc.loc[isc.CHARACTER_MAXIMUM_LENGTH == -1, 'CHARACTER_MAXIMUM_LENGTH'] = max_len
isc.loc[isc.IS_NULLABLE == 'NO', 'is_null'] = 'NOT NULL'
isc.is_null.fillna('NULL', inplace=True)
isc


# In[171]:


def len_prec(row):
    if 'varchar' in row.DATA_TYPE: 
        val = row.DATA_TYPE + "(" + str(int(row.CHARACTER_MAXIMUM_LENGTH)) + ")"
    elif 'int' in row.DATA_TYPE:
        val = row.DATA_TYPE + "(" + str(int(row.NUMERIC_PRECISION)) + ")"
    else:
        val = row.DATA_TYPE
    return val

isc['datatype_lenprec'] = isc.transform(len_prec, axis=1)
isct = isc.loc[isc.TABLE_NAME == 'Users', ['TABLE_NAME', 'ORDINAL_POSITION', 'COLUMN_NAME',
       'DATA_TYPE', 'CHARACTER_MAXIMUM_LENGTH', 'datatype_lenprec']]
isct


# In[172]:


# list of all the tables
ist = isc.groupby('TABLE_NAME').min().reset_index()['TABLE_NAME'].to_frame()
ist


# In[173]:


def create_attrib(grp):
    return "\t".join(grp.COLUMN_NAME + " " + grp.datatype_lenprec + " " + grp.is_null + ",\n")

new_attribs = (isc
               .groupby('TABLE_NAME')
               .apply(create_attrib)
               .to_frame(name='attribs')
              )


# In[174]:


new_df = pd.merge(ist, new_attribs, on='TABLE_NAME')


# In[207]:


def create_table(tbl_grp):
    return "\nCREATE TABLE " + tbl_grp.TABLE_NAME + " (\n\t" +                 tbl_grp.attribs +             "\tPRIMARY KEY ( Id )\n);             \n"
df_script = (new_df
             .groupby('TABLE_NAME')
             .apply(create_table)
             .to_frame(name='create_table_script')
             .reset_index().create_table_script
            )
df_script


# In[310]:


# write script into a csv
## it will write each table as an individual string
df_script.to_csv("new_script.csv", index = False)


# In[311]:


# Select all columns with ID in the name
isid = isc.loc[isc.COLUMN_NAME.str.contains('Id'), ['TABLE_NAME', 'COLUMN_NAME']]
# drop all the primary key column names
isid = isid.loc[isid.COLUMN_NAME != 'Id', :]
# extrapolate the foreign table's name from the Id Columns Prefixed name
isid['id_prefix'] = isid.COLUMN_NAME.str.extract(r'(?P<foreign>^.*)Id')
isid['projected_foreign_table'] = isid.id_prefix + 's'
# create column containing boolean of check to see if projected table is in list of tables
isid.loc[isid.projected_foreign_table.isin(list(ist.TABLE_NAME)), 'is_table'] = True

# display the collection that correspond correctly to the tables
istid = isid.loc[isid.is_table == True, :]
istid
# isid.loc[isid.is_table != True]
# isid


# In[312]:


# sample foreign key constraint format
# ALTER TABLE PostTags 
# ADD CONSTRAINT Fk_PostTags_Posts FOREIGN KEY ( PostId ) 
# REFERENCES Posts( Id ) ;

# create function to script out constraints from table rows
def create_fk_constraints(row):
    return "\nALTER TABLE {tbl_name} \nADD CONSTRAINT Fk_{tbl_name}_{frgn_tbl} FOREIGN KEY ( {col_name} ) \nREFERENCES {frgn_tbl}( Id ) ;\n"     .format(tbl_name = row.TABLE_NAME,            col_name = row.COLUMN_NAME,            frgn_tbl = row.projected_foreign_table
           )
            
# # singleton test
# create_fk_constraints(isid.iloc[0,:])

# create_fk_script for the standard pk_Table.ID_fk_TableId pairs 
create_fk_script = (istid
                    .apply(create_fk_constraints, axis = 1)
                   )

# append the fk constraints to the table create script
with open('new_script.csv', 'a') as create_table_script:
    (create_fk_script
     .to_csv(create_table_script, header = False, index = False)
    )


# In[313]:


# create pk_fk constraints for the secondary fk's
## select out just the non-standard fk_id's referencing the user tables
isuid = (isid
         .loc[isid.is_table != True, 'TABLE_NAME':'id_prefix']
         .loc[isid.COLUMN_NAME.str.contains('User|Moderator'), :]    
        )
## add in the correct projected table for this Users subsets
isuid['projected_foreign_table'] = 'Users'

# create a script for the non-standard users foreign keys
create_users_fk_script = isuid.apply(create_fk_constraints, axis = 1)

# append the non-standard user_id fk constraints to the creation and standard FK_scripts
with open('new_script.csv', 'a') as create_table_script:
    create_users_fk_script.to_csv(create_table_script, header = False, index = False)

isuid


# In[314]:


# select what hasn't been handled yet
isnuid = isid.loc[(isid.is_table != True) & (isid.COLUMN_NAME.str.contains('User|Moderator') == False), :]
isnuid


# In[319]:


# anything with Posts in TableName needs to reference Posts Id
## except link type Id (1 = relatedPost, 3 = duplicate)
## except PostNoticeTypes Table_name

ispid = (isnuid
         .loc[(isnuid.TABLE_NAME.str.contains('Post')) | \
              (isnuid.COLUMN_NAME.str.contains('Post|DuplicateOfQuestionId')), :
             ]
         .loc[(isnuid.TABLE_NAME.str.contains('Type') == False) & \
              (isnuid.COLUMN_NAME.str.contains('Type') == False), :
             ]
        )
## add in the correct projected table for this Posts subset
ispid['projected_foreign_table'] = 'Posts'

# create a script for the non-standard users foreign keys
create_posts_fk_script = ispid.apply(create_fk_constraints, axis = 1)

# append the non-standard post_id fk constraints to the creation and standard FK_scripts
with open('new_script.csv', 'a') as create_table_script:
    create_posts_fk_script.to_csv(create_table_script, header = False, index = False)
ispid


# In[316]:


# gather together all the columns that were 
from itertools import chain
constraints_already_added = list(chain(istid.index.values, isuid.index.values, ispid.index.values))
# isid.loc[isid.isin(constraints_already_added), :]
isid[~isid.index.isin(constraints_already_added)]


# In[317]:


# handling the naming convention outliers

## ReviewTaskResults.RejectionReasonId to reference ReviewRejectionReasons.Id
create_reviewtaskresults_fk = "\nALTER TABLE ReviewTaskResults \nADD CONSTRAINT Fk_ReviewTaskResults_ReviewRejectionReasons FOREIGN KEY ( RejectionReasonId ) \nREFERENCES ReviewRejectionReasons( Id ) ;\n"

## ReviewTasks.CompletedByReviewTaskId to reference ReviewTaskResults.Id
create_reviewtasks_fk = "\nALTER TABLE ReviewTasks \nADD CONSTRAINT Fk_ReviewTasks_CompletedByReviewTaskId FOREIGN KEY ( CompletedByReviewTaskId ) \nREFERENCES ReviewTaskResults( Id ) ;\n"

## TagSynonyms.SourceTagName to reference Tags.TagName
## TagSynonyms.TargetTagName to reference Tags.TagName
create_tagsynonyms_tagnames_fk = "\nALTER TABLE TagSynonyms \nADD CONSTRAINT Fk_TagSynonymsSourceTagName_Tags FOREIGN KEY ( SourceTagName ) \nREFERENCES Tags( TagName ) ;\nALTER TABLE TagSynonyms \nADD CONSTRAINT Fk_TagSynonymsTargetTagName_Tags FOREIGN KEY ( TargetTagName ) \nREFERENCES Tags( TagName ) ;\n"


# combine outlier strings into single series
create_singleton_fks = pd.Series([create_reviewtaskresults_fk,                                  create_reviewtasks_fk,                                  create_tagsynonyms_tagnames_fk])

# append the singletons into the script
with open('new_script.csv', 'a') as create_table_script:
    create_singleton_fks.to_csv(create_table_script, index = False)


# In[318]:


# rewrite the script with all of the string quotes and extra line endings removed.
def organize_data(location='./new_script.csv'):
    with open(location, "r", encoding="utf-8") as f:
        name_string = f.read()
        name_string = name_string.replace('"\n"','')
        name_string = name_string.replace('"', '')
    return name_string



text_file = open("info_schema_create_tables.sql", "w")
text_file.write(organize_data())
text_file.close()
# organize_data().write('quote_free_script.csv')

