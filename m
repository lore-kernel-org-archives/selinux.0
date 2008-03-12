Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2C8gF6B013121
	for <selinux@tycho.nsa.gov>; Wed, 12 Mar 2008 04:42:15 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2C8gCUK029946
	for <selinux@tycho.nsa.gov>; Wed, 12 Mar 2008 08:42:14 GMT
Message-ID: <47D7975E.7000805@ak.jp.nec.com>
Date: Wed, 12 Mar 2008 17:42:06 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn> <47D6BA17.5080606@kaigai.gr.jp>
In-Reply-To: <47D6BA17.5080606@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris,

This is a summary of this thread.
I think we have three iseeues now, as follows:

[1] unconfined_t is not always unconfined
The current my policy does not allow unconfined domains to invoke
user defined functions, because malicious queries can be stored in.
Thus, unconfined domain has to confirm its harmless and relabel it
to sepgsql_proc_t type.
However, this approach does not allow unconfined domain works as its name.

[2] conditional unconfined domain
Most of administrative users less less frequently requires widespread
permissions in operation phase, different from construction phase.
Thus, a option to revoke unconfined authorities is worthwhile for
secure database administration.
However, no other domain has a similar option.

[3] conditional type_transition
Applying per-user local type is a good idea. It enables to separate
database objects logically. However, I think the default types created
by DBA should be labeled as a common type, not a local one.
 e.g) I want to be labeled as "sepgsql_table_t" on a newly created tables,
      not "sepgsql_unconfined_table_t".
If unconfined domain is conditional, it depends on the tunable whether
the subject is DBA, or not. So, type_transition need to be conditional.


I can understand [2] is an odd manner in the current upstreamed policy
design. Therefore, it can remove [3] of conditional type_transiton with
"sepgsql_enable_unconfined".
However, I want to remain [1] rules. As unconfined_t is restricted at
execmem and execmod, it should be handled as a special case for risky
situation.
In addition, I want to provide end-users a option to turn on/off
applying per-user local types. If end-users decide to apply MCS
for logical separation or they don't need it, per-users local types
are not necessary. A new tunable ("sepgsql_enable_unified" for example)
can be considerable, but it means type_transition rules are put within
tunable block.

Thanks,

KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
>> On Sun, 2008-03-09 at 23:24 +0900, KaiGai Kohei wrote:
>>> Christopher J. PeBenito wrote:
>>>> On Fri, 2008-03-07 at 10:52 +0900, Kohei KaiGai wrote:
>>>>> Christopher J. PeBenito wrote:
>>>>>> On Wed, 2008-02-27 at 17:00 +0900, Kohei KaiGai wrote:
>>>>>>> The attached patch provides security policies related to
>>>>>>> SE-PostgreSQL.
>>>> [...]
>>>>>>> +typeattribute unlabeled_t      sepgsql_database_type;
>>>>>>> +typeattribute unlabeled_t      sepgsql_table_type;
>>>>>>> +typeattribute unlabeled_t      sepgsql_procedure_type;
>>>>>>> +typeattribute unlabeled_t      sepgsql_blob_type;
>>>>>> Usage of unlabeled_t here is not permitted.
>>>>> Is it appropriate manner to deploy optional_policy at kernel/kernel.te?
>>>> Why is this needed at all?
>>> Database objects have persistent security context, as filesystem doing.
>>> If their security contexts are invalidated by policy reloading etc, it is
>>> necessary them to be relabeled.
>>>
>>> Above rules enables administrative domains to access and relabel these objects
>>> in this case.
>> You need to add interfaces in the kernel module.
> 
> Are you saying I should put new interfaces on kernel/kernel.if and use them in
> services/postgresql.te? Or inverse meaning?
> 
>>>>>>> +########################################
>>>>>>> +#
>>>>>>> +# SE-PostgreSQL Administrative domain local policy
>>>>>>> +#                    (sepgsql_unconfined_type)
>>>>>>> +
>>>>>>> +tunable_policy(`sepgsql_enable_unconfined',`
>>>>>>> +       allow sepgsql_unconfined_type sepgsql_database_type : db_database *;
>>>>>>> +       allow sepgsql_unconfined_type sepgsql_module_type : db_database { install_module };
>>>>>>> +       allow sepgsql_unconfined_type sepgsql_table_type : { db_table db_column db_tuple } *;
>>>>>>> +       allow sepgsql_unconfined_type { sepgsql_procedure_type - sepgsql_user_proc_t } : db_procedure *;
>>>>>>> +       allow sepgsql_unconfined_type sepgsql_user_proc_t : db_procedure { create drop getattr setattr relabelfrom relabelto };
>>>>>>> +       allow sepgsql_unconfined_type sepgsql_blob_type : db_blob *;
>>>>>>> +       allow sepgsql_unconfined_type postgresql_t : db_blob { import export };
>>>>>>> +
>>>>>>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_proc_t;
>>>>>>> +',`
>>>>>>> +       type_transition { sepgsql_unconfined_type - sepgsql_server_type } sepgsql_database_type : db_procedure sepgsql_user_proc_t;
>>>>>>> +')
>>>>>> Why is this tunable?  Why is there a different type_transition behavior?
>>>>> I intend that users can turn off this tunable during its operation phase
>>>>> after initial database setting up, to prevent applying unconfined accesses.
>>>>>
>>>>> When sepgsql_enable_unconfined is disabled, sepgsql_unconfined_type works
>>>>> as if they are sepgsql_client_type, because sepgsql_unconfined_domain() interface
>>>>> associates a domain with sepgsql_(unconfined|client)_type.
>>>> The problem is that this is inconsistent with the way other
>>>> *_unconfined() access works.
>>> However, this feature to disclaim widespread permissions is worthwhile in database
>>> management system, because it is less frequently required in operation phase different
>>> from construction phase.
>>> So, I think the default security policy should provide a way to restrict permissions
>>> for administrative domain.
>>>
>>> If you concerned about its name is confusable with other *_unconfined() interfaces,
>>> `sepgsql_enable_unconfined' can be renamed to `sepgsql_enable_administrative' and
>>> ditto for the name of interface.
>> It seems to make more sense to have the interfaces be unconditional, and
>> then have the tunable at the call site.
> 
> Is it possible?
> Currently, we cannot put TYPEATTRIBUTE statement in a tunable block.
> If caller side put postgresql_unconfined() in a tunable block, we cannot build it well.
> 
>>> In the latest my patch, newly created tables are labeled as sepgsql_FOO_table_t
>>> when client does not belong to administrative domains. Because unconfined_t loses
>>> the grounds of its widespread permission when the boolean is disabled,
>> unconfined_t is going to have to always have unconfined access.
> 
> I can understand unconfined_t should work as its literal.
> 
> However, I'm worry about unconfined domain can invoke user defined functions
> with his capabilities, because it can contain malicious queries.
> In my current policy, it denies unconfined domains to invoke user defined
> functions directly. They have to confirm its harmless and to relabel it to
> sepgsql_proc_t.
> 
> It is a different issue from the tunable unconfined domain.
> However, I want you to understand allowing unconfined domains to invoke
> user defined functions directly is fundamentally risky.
> (Thus, I don't allow unconfined domains to invoke sepgsql_FOO_proc_t.)
> 
>>>  it works as
>>> a generic domain. It also includes behavior changing in type_transition for tables.
>> I'll have to re-review it, but I'm still uneasy about changing
>> type_transitions.
> 
> I think the default type of database objects should be common, not a local type
> like sepgsql_FOO_table_t. When it works as a DBA, a newly created table should
> be labled as sepgsql_table_t, even if unconfined_t has its local sepgsql_unconfined_table_t.
> Thus, type_transition also need to be tunable, if unconfined domain is tunable.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
