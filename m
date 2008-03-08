Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m281XgoF020274
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 20:33:42 -0500
Received: from mail.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m281Xe8X005428
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 01:33:41 GMT
Message-ID: <47D1ECF6.1030805@kaigai.gr.jp>
Date: Sat, 08 Mar 2008 10:33:42 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Kohei KaiGai <kaigai@ak.jp.nec.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com> <1204817238.3994.59.camel@gorn.columbia.tresys.com> <47D03D3D.8060307@manicmethod.com> <47D0A68B.1030002@ak.jp.nec.com> <47D16A6C.7090909@manicmethod.com>
In-Reply-To: <47D16A6C.7090909@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>> Also, after looking at the code I don't see why install_module and 
>>> load_module need to be different permissions, granted they are a 
>>> privileged operation but why not collapse them into a single access 
>>> vector?
>>
>> load_module is a permission to associate a database and a loadable 
>> module,
>> like filesystem:associate permission.
>>
>> When we tries to load a shared library module, the following permissins
>> are required.
>>
>> (Client)   (Shared Library) : db_database install_module;
>> (Client)   (Database)       : db_database install_module;
>> (Database) (Shared Library) : db_database load_module;
>>
>> `install_module' defines a relationship between a client and 
>> database/library.
>> `load_module' defines a relationship between a database and library.
>>
> 
> I see, do you have an actual use case for load_module? I don't know that 
> filesystem:associate has ever been used in a useful way, though I might 
> just not know of such a use.

The db_database:install_module is evaluated when client tries to
declare a function implemented at external shared library file.
The db_database:load_module is evaluated whenever SE-PostgreSQL
tries to load a shared library file.

In the later case, it has to be evaluated after server process
restarting. If someone replace shared library files during
SE-PostgreSQL stopping, the prior checks are invalid.

However, I doubt a bit whether SE-PostgreSQL should check the first
relationship between client and shared libraries, or not.
It may not be a work as `reference monitor for SQL'.

<snip>

>>> And one more question. I see you have a type transition for 
>>> sepgsql_proc_t but I never saw sepgsql_proc_t as the subject of any 
>>> rules, which I don't understand. The hooks appear to always use the 
>>> client_sid as the subject but for stored procedures to be useful they 
>>> may need to access data that the client wouldn't be able to, or did I 
>>> miss something?
>>
>> When a sepgsql_client_domain invokes sepgsql_trusted_proc_t, the 
>> client_sid
>> is transted into sepgsql_trusted_domain_t.
>> However, domain transition is kept in invokations for another 
>> procedure type.
>> sepgsql_proc_t is always a object type, as postgresql_exex_t is always 
>> a file
>> type, not a domain.
>>
> 
> What if you call multiple procedures in a single call? Are the domain 
> transition lifetimes limited to while the procedure is running? Are the 
> other columns queried in the same query the original caller context?

Yes, we can put several different trusted procedure in a single call.
Yes, every domain transition lifetimes are limited to while the procedure
is running. However, setting up function arguments are not included within
the lifetime of domain transition.
Yes, other columns are refered in the original client context.

> e.g., if I did:
> 
> select fname, lname, get_ssn(ssn), dob, get_cr(cr);
> 
> and there were type_transitions for get_ssn and get_cr, how are the 
> transitions handled?

If "ssn" and "cr" are hidden from the client, the above query is not
suceeded, even if get_ssn() and get_cr() is declared as trusted procedure.

The context is original one when it read "ssn" and "cr" to set up
arguments of trusted procedure, so it cannot refer these columns.
You have to give get_ssn()/get_cr() a key to refer this table,
then these functions run another query under new domain.

Please consider the following situation:
select fname, lname, get_ssn(malicious_intercept(ssn)), ...

If we can refer "ssn", it breaks everything :)

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
