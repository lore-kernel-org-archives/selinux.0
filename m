Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4C2VvMg004460
	for <selinux@tycho.nsa.gov>; Sun, 11 May 2008 22:31:57 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4C2VtNE016623
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 02:31:56 GMT
Message-ID: <4827AC15.5000608@ak.jp.nec.com>
Date: Mon, 12 May 2008 11:31:49 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn>	 <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn>	 <47E33A66.6030705@ak.jp.nec.com>	 <1206384282.16113.205.camel@gorn.columbia.tresys.com>	 <47E8D58B.5040707@ak.jp.nec.com>	 <1206451493.16113.217.camel@gorn.columbia.tresys.com>	 <47EB6E41.9040309@ak.jp.nec.com> <1206624233.16113.291.camel@gorn>	 <47EC7910.2060505@ak.jp.nec.com> <1209995318.8276.13.camel@gorn>
In-Reply-To: <1209995318.8276.13.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2008-03-28 at 13:50 +0900, KaiGai Kohei wrote:
>>>> Do you consider they are really complex type_transition rules now?
>>>> They are not conditional, not set operations.
>>> Sounds like they are ok, but I'd have to see the policy to make sure.
>> I'm sorry, I din't submit the latest one yet, although I gave assurance
>> to update some points you pointed out.
>>
>> The attached one is the latest one.
>> Please confirm this version.
>>
>> Significant updates:
>> - kernel_relabelfrom_unlabeled_database() is added to kernel/kernel.if.
>>    It enables sepgsql_unconfined_type to relabel unlabaled_t to other types.
>> - Any types/attributes/booleans are declared at the head of services/postgresql.te.
>> - postgresql_userdom_template() requires tree arguments of prefix, domain and role.
>> - Naming convention is changed. When userdomain tries to create a new object,
>>    it is labeled as FOO_sepgsql_table_t, not sepgsql_FOO_table_t.
>> - The target of type_transition is unconditional.
>>    If userdomain create a new objects, it is always labeled as FOO_sepgsql_xxx_t.
>>    If others create a new one, it is always labeled as sepgsql_xxx_t.
>> - A new attribute of sepgsql_unpriv_client_type provides baseline permissions to
>>    attached domain. It is necessary to avoid to deploy sepgsql_enable_users_ddl
>>    boolean within interfaces.
>> - The meanings of sepgsql_client_type is changed. It means a set of domains
>>    connectable to SE-PostgreSQL.

Chris, I'm sorry for my late responding.

> I'd like to wrap this one up, so I spent some time revising the patch
> (attached).  Its just about ready to merge.  Is the neverallow really
> needed?

It might be a too much restriction.
I agree to drop the neverallow rule.

> Also, I'd still strongly urge you to reconsider adding the
> postgresql_contexts file with the default object labels.  I think this
> is the clearest example why:
> 
> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
> 
> What object is being transitioned on?  Other type transitions are
> clearer: a file being created in a directory or a message enqueued to a
> message queue.  I won't block merging the policy over this, but I think
> the postgresql_contexts is the better method.

This type transition rule means a new database is created on a database
management system. A database management system can maintain several
databases in same time, like several files are placed under a directory.
An only difference between a directory and a database management system
is whether it is a process, or not. So, I don't think it is unnatural
method to decide a correct context of newly created database.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
