Message-ID: <483D847F.8000300@kaigai.gr.jp>
Date: Thu, 29 May 2008 01:12:47 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483CBA23.9020505@ak.jp.nec.com> <1211979385.5008.92.camel@gorn.columbia.tresys.com>
In-Reply-To: <1211979385.5008.92.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2008-05-28 at 10:49 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
>>>> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
>>>>> I mainly had an issue with statements like:
>>>>>
>>>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
>>>>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
>>>> The first four statements don't make sense to me; the last one does make
>>>> sense (i.e. when a postgres client creates a new database, where the
>>>> only related "object" in view is that object manager's context, label
>>>> the new database with sepgsql_db_t).  That last instance seems valid as
>>>> a way of expressing types for new databases; the first four statements
>>>> seem to be more suited to this postgres contexts configuration (as they
>>>> are independent of client domain entirely).
>>> If we have a default contexts configuration, then none of the above
>>> statements would be needed:  speaking of the last statement, in the
>>> absence a type_transition, clients that create databases would still get
>>> sepgsql_db_t as the type for the database, since that is the default
>>> database type.
>> As I wrote in the reply to Stephen, it is not a default context.
>> These rules are used to initialize SE-PostgreSQL itself with proper
>> security context.
> 
> In my opinion, it is in fact the default context, despite what you say.
> Otherwise you wouldn't have all sorts of type_transitions to the above
> types for not only the server, but the generic clients.  I suspect you
> would never want to run with no type transitions and have all of the
> objects labeled postgresql_t.  That seems like a bad default
> configuration.

Yes, I did not want database objects to inherit postgresql_t in the default
policy.
However, it is theoretically possible, when someone writes a policy
which allows to create database object with postgresql_t on db_database
class.
No need to say, it is so confusable context naming. So, I applied
type_transition rules to attach proper context for any database objects.

>> ﻿> Nonetheless, it sounds like you don't have a problem with the libselinux
>>> change, as long as its just for the default contexts only, right?  Then
>>> creating objects with something other than the default context would be
>>> the job of type_transition.
>> What do you think the type_transition rules on db_database class should
>> be described as a relationship between a client process and ... ?
> 
> I suspect that there is no right answer, only a less bad answer, which
> would have to be the server process type.  Unfortunately I don't see
> anything better, unless you want to transition on the default database
> type.

I don't oppose to provide the default type of db_database class object
as the root of type_transition chain, because it has no parent object.

However, I don't think these hints for rest of object classes are necessary,
because they have hierarchic relationships, like ones between directory and
files on filesystem.
I think we should pay attention the resemblance with filesystem.

>> I don't think we need default contexts for any database object managed
>> under database itself (like table, column, procedure, ...).
> 
> I don't agree.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
