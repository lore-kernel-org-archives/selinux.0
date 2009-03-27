Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RFgbGv030941
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 11:42:37 -0400
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RFcccj016483
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 15:38:39 GMT
Message-ID: <49CCF41D.4090603@manicmethod.com>
Date: Fri, 27 Mar 2009 11:43:25 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com>
In-Reply-To: <49CA8934.1040200@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> Joshua Brindle wrote:
>> Andy Warner wrote:
>>   
>>> KaiGai Kohei wrote:
>>>     
>>>> As I noted in the previous message, SE-PostgreSQL is postponed to
>>>> the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
>>>> list, unfortunately.
>>>> However, it also mean a good chance to revise its design because
>>>> we have a few months before v8.5 development cycle launched.
>>>>
>>>> 1. Changes in object classes and access vectors
>>>>  - add db_database:{superuser} permission
>>>>   
>>>>  - remove db_database:{get_param set_param} permission
>>>>  - remove db_table/db_column/db_tuple:{use} permission
>>>>
>>>>   Please refer the previous messages for them.
>>>>
>>>>  - add new object class "db_schema"
>>>>   As Andy noted, we directly put database objects under the
>>>>   db_database class directly. But, some of database objects
>>>>   are created under a schema object.
>>>>   In other word, RDBMS's design has three level hierachy as:
>>>>      <database>  (<-- some DBMSs calls it as <catalog>)
>>>>       + <schema>
>>>>          + <tables>, <procedures>, ...
>>>>
>>>>   Now, we control user's DDL statement via permissions on
>>>>   the sepgsql_sysobj_t type as row-level controls.
>>>>   But I think db_schema object class here is meaningful
>>>>   to match SQL's design and analogy to the dir class.
>>>>
>>>>   The new db_schema object class inherits six permissions
>>>>   from common database objects, and defines three its own
>>>>   permissions: add_object, remove_object, usage
>>>>   
>>>>       
>>> I would suggest that the SQL catalog object should also be supported. 
>>> Though not common in implementation, it is part of the SQL spec. Our 
>>> DBMS (Trusted RUBIX) supports it, and for us it is basically another 
>>> level in the naming. (database.catalog.schema.table). I would suggest 
>>> that a db_catalog object be included with the same basic semantics as 
>>> the db_schema object.
>>>
>>>     
>>
>> Is there more information available about how Trusted RUBIX uses SELinux? I see
>> on the webpage a brief mention of it but no detailed page like the other access
>> control models, nor in the security policy manager data sheet.
>>   
> 
> On our download page (http://rubix.com/cms/downloads) there is a pdf 
> called the Trusted RUBIX SELinux Guide.
> Because our SELinux integration is very new we have not updated our 
> website to reflect it yet. The above Guide is the best source of how we 
> use SELinux. I can also answer any questions you have.
> 
> In general, I created a concept called an "object set" which may be 
> created with SELinux interfaces. An object set is all DBMS objects under 
> (and including) a named catalog object. An object set may include any 
> number of schemata, tables, views, etc. An admin may create an object 
> set and roles to administer the object set. They may also use provided 
> interfaces to give a domain restricted SQL access to the access set 
> (e.g., full sql, select only, insert, update, DDL, etc.). The intent was 
> to partition security domains by database subtree and provide easy 
> interfaces for them to create roles and control SQL access.
> 

I see now. When the db object classes were proposed we hoped they would be
general enough to cover other dbms's, it looks like we weren't far off. I have
some comments for permission sets found in the document mentioned above, for
example:

CREATE TABLE: db_database {access}; dir {search} on catalog; dir {search
add_name} on schema; db_table {create} on table

you require dir search, add_name. What is the source context in this case? Is
Trusted RUBIX doing avc_has_perm calls with dir as the object class on behalf of
the connected client or is the server masquerading as the client and those
checks are done by SELinux? I don't think it is a good idea to muddle the object
class ownership concept by doing checks for classes which are owned by another
object manager (except in the case that you are proxying access for that object
manager, such as the case for samba).

Were the db object classes incomplete for you so you needed to use filesystem
object classes? I'm trying to get a feeling for what the motivation was behind
these checks.

Is Trusted RUBIX with these SELinux checks actually released, are the access
checks set in stone? I'd like to see as much consistency between dbms object
models as possible so that policy won't be dramatically different between them.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
