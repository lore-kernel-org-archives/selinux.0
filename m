Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26Ipip5024492
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 13:51:44 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m26IphwA005954
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 18:51:43 GMT
Message-ID: <47D03D3D.8060307@manicmethod.com>
Date: Thu, 06 Mar 2008 13:51:41 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com>
In-Reply-To: <1204817238.3994.59.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
>   
>> The attached patch provides security policies related to
>> SE-PostgreSQL.
>>
>> The followings are updates/unchanges from the previous version
>> submitted
>> at two weeks ago. These updates replaced most of the part in the
>> previous
>> one.
>>
>> - The targets of this patch are moved to services/postgresql.*,
>>    although the previous one added new entries.
>>     
>
>   
>> +tunable_policy(`sepgsql_enable_auditallow',`
>> +       auditallow domain sepgsql_database_type  : db_database all_db_database_perms;
>> +       auditallow domain sepgsql_table_type     : db_table all_db_table_perms;
>> +       auditallow domain sepgsql_table_type     : db_column all_db_column_perms;
>> +       auditallow domain sepgsql_procedure_type : db_procedure all_db_procedure_perms;
>> +       auditallow domain sepgsql_blob_type      : db_blob all_db_blob_perms;
>> +       auditallow domain sepgsql_server_type    : db_blob { import export };
>> +       auditallow domain sepgsql_module_type    : db_database { install_module };
>> +')
>>     


A couple questions about the install_module and load_module permissions. 
First they seem here to be refering to sepgsql_module_type as the object 
which currently are lib_t and textrel_shlib_t, file types. So the object 
class of db_database seems to be inaccurate.

Also, after looking at the code I don't see why install_module and 
load_module need to be different permissions, granted they are a 
privileged operation but why not collapse them into a single access vector?

Also, why are blobs a separate object class? How is it a privileged 
operation to use blobs in a table? As far as reading and writing them 
they should be treated like any other column, shouldn't they?

And one more question. I see you have a type transition for 
sepgsql_proc_t but I never saw sepgsql_proc_t as the subject of any 
rules, which I don't understand. The hooks appear to always use the 
client_sid as the subject but for stored procedures to be useful they 
may need to access data that the client wouldn't be able to, or did I 
miss something?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
