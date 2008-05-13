Message-ID: <4828FF50.4090305@ak.jp.nec.com>
Date: Tue, 13 May 2008 11:39:12 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, ewalsh@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn>	 <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn>	 <47E33A66.6030705@ak.jp.nec.com>	 <1206384282.16113.205.camel@gorn.columbia.tresys.com>	 <47E8D58B.5040707@ak.jp.nec.com>	 <1206451493.16113.217.camel@gorn.columbia.tresys.com>	 <47EB6E41.9040309@ak.jp.nec.com> <1206624233.16113.291.camel@gorn>	 <47EC7910.2060505@ak.jp.nec.com> <1209995318.8276.13.camel@gorn>	 <4827AC15.5000608@ak.jp.nec.com>  <4828552F.5060409@kaigai.gr.jp> <1210615044.11188.17.camel@gorn>
In-Reply-To: <1210615044.11188.17.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> (sorry for the dupe KaiGai, but I got a delivery failure on the nsa addresses)
I have not got this message via nsa list. :-(

> On Mon, 2008-05-12 at 23:33 +0900, KaiGai Kohei wrote:
>>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
>>>>
>>>> What object is being transitioned on?  Other type transitions are
>>>> clearer: a file being created in a directory or a message enqueued to a
>>>> message queue.  I won't block merging the policy over this, but I think
>>>> the postgresql_contexts is the better method.
>>> This type transition rule means a new database is created on a database
>>> management system. A database management system can maintain several
>>> databases in same time, like several files are placed under a directory.
>>> An only difference between a directory and a database management system
>>> is whether it is a process, or not. So, I don't think it is unnatural
>>> method to decide a correct context of newly created database.
>> In properly speaking, I oppose to drop type_transition rule for a newly
>> created database object, don't oppose the postgresql_contexts file.
>> I noticed they are not exclusive options after a carefull consideration.
>>
>> The biggest concern of dropping type_transition is that we cannot decide
>> what security context should be attached for a new database when
>> the postgresql_contexts is lost, if we completely depends on this file.
>> We can help the situation, if we can decide it with type_transition rule
>> when the file or proper entries are not found.
> 
> I'd say its not unreasonable to require that postgresql_contexts exists.
> If it doesn't, it could just create the databases unlabeled, or the
> services fails to start when its missing.  I don't know which is the
> better answer, so I'll reference another object manager.  Eamon, what do
> you do in the X server when the x_contexts file is incomplete or
> missing?

Hmm...
Because the policy does not allow to create a database with unlabeled_t,
I will choose the later option (failing services when starting up).

Is it possible to add a new initial security context to provide a fallback
context of newly created databases as an alternative of "unlabeled"?
It will be better, if we can got a proper context when the postgresql_context
is missing.

>> If you feel strange to use the context of server process as the target
>> of the type_transition, using the root directory of database cluster
>> is an alternative idea. (It is '/var/lib/sepgsql/data' in default.)
>> Any database files are placed under the directory, like filed placed
>> under a directory.
> 
> I think that this is much less desirable option than what we have right
> now.  Database objects don't exist outside of postgresql since its a
> userspace object manager.  The fact that they're stored as files in a
> directory isn't relevant from the database object's perspective.

OK, please forget this idea.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
