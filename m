Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2PHhBPf024126
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 13:43:11 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2PHhARR019673
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 17:43:10 GMT
Message-ID: <49CA6D24.3040007@manicmethod.com>
Date: Wed, 25 Mar 2009 13:43:00 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com>
In-Reply-To: <49C9E101.1050400@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> KaiGai Kohei wrote:
>> As I noted in the previous message, SE-PostgreSQL is postponed to
>> the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
>> list, unfortunately.
>> However, it also mean a good chance to revise its design because
>> we have a few months before v8.5 development cycle launched.
>>
>> 1. Changes in object classes and access vectors
>>  - add db_database:{superuser} permission
>>   
>>  - remove db_database:{get_param set_param} permission
>>  - remove db_table/db_column/db_tuple:{use} permission
>>
>>   Please refer the previous messages for them.
>>
>>  - add new object class "db_schema"
>>   As Andy noted, we directly put database objects under the
>>   db_database class directly. But, some of database objects
>>   are created under a schema object.
>>   In other word, RDBMS's design has three level hierachy as:
>>      <database>  (<-- some DBMSs calls it as <catalog>)
>>       + <schema>
>>          + <tables>, <procedures>, ...
>>
>>   Now, we control user's DDL statement via permissions on
>>   the sepgsql_sysobj_t type as row-level controls.
>>   But I think db_schema object class here is meaningful
>>   to match SQL's design and analogy to the dir class.
>>
>>   The new db_schema object class inherits six permissions
>>   from common database objects, and defines three its own
>>   permissions: add_object, remove_object, usage
>>   
> I would suggest that the SQL catalog object should also be supported. 
> Though not common in implementation, it is part of the SQL spec. Our 
> DBMS (Trusted RUBIX) supports it, and for us it is basically another 
> level in the naming. (database.catalog.schema.table). I would suggest 
> that a db_catalog object be included with the same basic semantics as 
> the db_schema object.
> 

Is there more information available about how Trusted RUBIX uses SELinux? I see
on the webpage a brief mention of it but no detailed page like the other access
control models, nor in the security policy manager data sheet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
