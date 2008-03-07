Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m272LKJt014573
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 21:21:20 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m272LHwt026056
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 02:21:18 GMT
Message-ID: <47D0A68B.1030002@ak.jp.nec.com>
Date: Fri, 07 Mar 2008 11:20:59 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D03D3D.8060307@manicmethod.com>
In-Reply-To: <47D03D3D.8060307@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Christopher J. PeBenito wrote:
>> On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
>>  
>>> The attached patch provides security policies related to
>>> SE-PostgreSQL.
>>>
>>> The followings are updates/unchanges from the previous version
>>> submitted
>>> at two weeks ago. These updates replaced most of the part in the
>>> previous
>>> one.
>>>
>>> - The targets of this patch are moved to services/postgresql.*,
>>>    although the previous one added new entries.
>>>     
>>
>>  
>>> +tunable_policy(`sepgsql_enable_auditallow',`
>>> +       auditallow domain sepgsql_database_type  : db_database 
>>> all_db_database_perms;
>>> +       auditallow domain sepgsql_table_type     : db_table 
>>> all_db_table_perms;
>>> +       auditallow domain sepgsql_table_type     : db_column 
>>> all_db_column_perms;
>>> +       auditallow domain sepgsql_procedure_type : db_procedure 
>>> all_db_procedure_perms;
>>> +       auditallow domain sepgsql_blob_type      : db_blob 
>>> all_db_blob_perms;
>>> +       auditallow domain sepgsql_server_type    : db_blob { import 
>>> export };
>>> +       auditallow domain sepgsql_module_type    : db_database { 
>>> install_module };
>>> +')
>>>     
> 
> 
> A couple questions about the install_module and load_module permissions. 
> First they seem here to be refering to sepgsql_module_type as the object 
> which currently are lib_t and textrel_shlib_t, file types. So the object 
> class of db_database seems to be inaccurate.

Is it appropriate to define a new permission in file class to associate
a database with a library file?

> Also, after looking at the code I don't see why install_module and 
> load_module need to be different permissions, granted they are a 
> privileged operation but why not collapse them into a single access vector?

load_module is a permission to associate a database and a loadable module,
like filesystem:associate permission.

When we tries to load a shared library module, the following permissins
are required.

(Client)   (Shared Library) : db_database install_module;
(Client)   (Database)       : db_database install_module;
(Database) (Shared Library) : db_database load_module;

`install_module' defines a relationship between a client and database/library.
`load_module' defines a relationship between a database and library.

> Also, why are blobs a separate object class? How is it a privileged 
> operation to use blobs in a table? As far as reading and writing them 
> they should be treated like any other column, shouldn't they?

In MySQL, blob is one of the data types, and it can be stored in a table.
However, blob is a set of tuples stored in pg_largeobject system catalog
in PostgreSQL. To separate large binary object into small blocks improves
ramdam access performance, but dameges to consistency in access control.
It is the reason why SE-PostgreSQL need special care for blobs.

http://www.postgresql.org/docs/8.3/static/catalog-pg-largeobject.html

BTW, current PostgreSQL does not have any access controls mechanism
in large object. :(

> And one more question. I see you have a type transition for 
> sepgsql_proc_t but I never saw sepgsql_proc_t as the subject of any 
> rules, which I don't understand. The hooks appear to always use the 
> client_sid as the subject but for stored procedures to be useful they 
> may need to access data that the client wouldn't be able to, or did I 
> miss something?

When a sepgsql_client_domain invokes sepgsql_trusted_proc_t, the client_sid
is transted into sepgsql_trusted_domain_t.
However, domain transition is kept in invokations for another procedure type.
sepgsql_proc_t is always a object type, as postgresql_exex_t is always a file
type, not a domain.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
