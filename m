Message-ID: <483C6BEA.8040101@tycho.nsa.gov>
Date: Tue, 27 May 2008 16:15:38 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add support for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil> <1211914557.5008.72.camel@gorn.columbia.tresys.com>
In-Reply-To: <1211914557.5008.72.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
>   
>> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
>>     
>>> On Tue, 2008-05-27 at 13:14 -0400, Stephen Smalley wrote:
>>>       
>>>> On Mon, 2008-05-26 at 19:30 +0900, KaiGai Kohei wrote:
>>>>         
>>>>> Hello,
>>>>>
>>>>> The attached patch enables to obtain the default security context of newly
>>>>> created database, defined at /etc/selinux/*/contexts/postgresql_contexts .
>>>>>
>>>>> The format is as follows:
>>>>> --------
>>>>> #
>>>>> # Config file for SE-PostgreSQL
>>>>> #
>>>>> # <domain of client>  <type of newly created database>
>>>>> unconfined_t    sepgsql_db_t
>>>>> *               sepgsql_db_t
>>>>> --------
>>>>>
>>>>> '*' means default security context, if given key is not matched for any entry.
>>>>>
>>>>> This API requires the security context of client as a key, and it returns
>>>>> a security context to be attached for a newly created database.
>>>>> It has a type field defined in the right-hand of config file, and inherits
>>>>> user and lower-range field of given security context as a key.
>>>>>
>>>>> e.g)
>>>>> selabel_lookup(sehandle, &context, "user_u:user_r:user_t:s0", 0);
>>>>> returns "user_u:object_r:sepgsql_db_t:s0".
>>>>>           

The selabel functionality is meant for situations where you want to 
label an object but you don't have the appropriate inputs to a 
type-transition, only some name for the object that comes from an 
external namespace, e.g. file name, X windows property name, etc.

For example, if you wanted to label databases or tables differently 
depending on their name, selabel would help with this.  Doesn't Postgres 
have default, administrative tables that contain all the permissions, 
user names, and other bookkeeping?  They have fixed names, so they would 
be a prime candidate for selabel support.

Here, you do have a source context, so please use transitions for this 
(see below).


>>>> Chris is investigating the use of roles on objects in order to provide
>>>> more fully featured RBAC support without requiring use of per-role
>>>> domains.  Hardcoding the use of object_r won't be future compatible for
>>>> that situation, and more generally we don't want to hardcode policy
>>>> information in libselinux at all.
>>>>
>>>> I'm also unclear as to why type_transition rules aren't a better way of
>>>> expressing the above, although I know you've been discussing this with
>>>> Chris for some time.  Logically I'd expect the client domain to be the
>>>> source type of the transition, and the type for the newly created
>>>> database to be the new/result type of the transition.  What to use as
>>>> the target type is less clear; we'd have a similar issue if we were to
>>>> use type_transitions for e.g. sockets.  It could either be the client
>>>> domain both as source and target (self relationship, no related object)
>>>> or the client domain as source and the object manager domain as target.
>>>>
>>>> Chris, what is the objection to using type transitions here, as they are
>>>> for labeling new objects and this seems to fit that situation?
>>>>         
>>> I think KaiGai took my idea a little to far.  My issue was just to have
>>> postgres determine what the default label for its objects are via
>>> postgresql_contexts.  A derived role/type still makes sense to be stated
>>> via (type|role)_transition.  I suspect there was confusion on this
>>> point.  I mainly had an issue with statements like:
>>>
>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
>>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
>>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
>>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
>>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
>>>       

I don't see the problem with the above statements - seems like a 
reasonable use of transitions to me.  If you don't like the first four 
transitions, then I would ask -- why not simply eliminate the target 
types in those rules and label all of those objects with postgresql_t 
(default transition)?  Clearly the names are just for convenience.  You 
did a similar thing with the X policy: going through and combining types.

The X server does the same kind of thing for objects that are created by 
the server itself, such as the root window.  A type transition is 
performed to label it taking the same form as the rules above.  I had a 
type transition from xserver_t to label it (remember x_root_window_t?)  
IIRC you got rid of that type.

>> The first four statements don't make sense to me; the last one does make
>> sense (i.e. when a postgres client creates a new database, where the
>> only related "object" in view is that object manager's context, label
>> the new database with sepgsql_db_t).  That last instance seems valid as
>> a way of expressing types for new databases; the first four statements
>> seem to be more suited to this postgres contexts configuration (as they
>> are independent of client domain entirely).
>>     
>
> If we have a default contexts configuration, then none of the above
> statements would be needed:  speaking of the last statement, in the
> absence a type_transition, clients that create databases would still get
> sepgsql_db_t as the type for the database, since that is the default
> database type.
>
> Nonetheless, it sounds like you don't have a problem with the libselinux
> change, as long as its just for the default contexts only, right?  Then
> creating objects with something other than the default context would be
> the job of type_transition.
>   


I don't see why we need this file if the default names are really just 
alternative ways of saying "postgresql_t."

>   
>>> which I feel should be instead be expressed in a postgresql_contexts
>>> file that says the default context for a database is ::seqpgsql_db_t,
>>> default context for table is ::sepgsql_sysobj_t, etc.
>>>
>>> This makes perfect sense staying as a type_transition in the policy:
>>>
>>> type_transition staff_t sepgsql_sysobj_t:db_tuple staff_sepgsql_sysobj_t;
>>>
>>>       


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
