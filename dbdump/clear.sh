USER="appfactory"
PASS="xxxx"
for table in attachments                        
mysql -h appfactory-prod.xxxxx.xxxx.amazonaws.com -u$USER -p$PASS  -Bse ""

attachments auth_sources                       boards changes  changeset_parents  changesets                          
 changesets_issues                   
 comments                            
 custom_fields                       
 custom_fields_projects              
 custom_fields_trackers              
 custom_values                       
 documents                           
 enabled_modules                     
 enumerations                        
 groups_users                        
 issue_categories                    
 issue_relations                     
 issue_statuses                      
 issues                              
 journal_details                     
 journals                            
 member_roles                        
 members                             
 messages                            
 news                                
 open_id_authentication_associations 
 open_id_authentication_nonces       
 projects                            
 projects_trackers                   
 queries                             
 repositories                        
 roles                               
 schema_migrations                   
 settings                            
 time_entries                        
 tokens                              
 trackers                            
 user_preferences                    
 users                               
 versions                            
 watchers                            
 wiki_content_versions               
 wiki_contents                       
 wiki_pages                          
 wiki_redirects                      
 wikis                               
 workflows 
