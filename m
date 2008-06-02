Message-ID: <4843CB24.1040000@ak.jp.nec.com>
Date: Mon, 02 Jun 2008 19:27:48 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>
In-Reply-To: <1212150456.31546.16.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2008-05-29 at 20:22 -0400, Eamon Walsh wrote:
>> Christopher J. PeBenito wrote:
>>> On Thu, 2008-05-29 at 14:05 -0400, Eamon Walsh wrote:
>>>   
>>>> Christopher J. PeBenito wrote:
>>>>     
>>>>> On Tue, 2008-05-27 at 16:15 -0400, Eamon Walsh wrote:
>>>>>   
>>>>>       
>>>>>> Christopher J. PeBenito wrote:
>>>>>>     
>>>>>>         
>>>>>>> On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
>>>>>>>>         
>>>>>>>>             
>>>>>>>>> I mainly had an issue with statements like:
>>>>>>>>>
>>>>>>>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
>>>>>>>>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
>>>>>>>>>       
>>>>>>>>>           
>>>>>>>>>               
>>>>>> I don't see the problem with the above statements - seems like a 
>>>>>> reasonable use of transitions to me.  If you don't like the first four 
>>>>>> transitions, then I would ask -- why not simply eliminate the target 
>>>>>> types in those rules and label all of those objects with postgresql_t 
>>>>>> (default transition)?  Clearly the names are just for convenience.  You 
>>>>>> did a similar thing with the X policy: going through and combining types.
>>>>>>     
>>>>>>         
>>>>> I don't think this is the same situation.  Having a table labeled
>>>>> postgresql_t doesn't make sense to me, since postgresql_t is the type of
>>>>> the server process.  Though, I suppose that if it wasn't an object
>>>>> manager, then the objects would implicitly be postgresql_t and/or
>>>>> postgresql_db_t.  So to conclude my stream of consciousness, I'm
>>>>> compelled by your argument, but I'm not sure its enough to change my
>>>>> position
>>>>>       
>>>> If it's not the same situation, it sounds pretty darn close: the X 
>>>> server also acts as a "client" when it starts up, and various objects 
>>>> are created by the server before any real clients connect.  For example 
>>>> root window and default colormap.
>>>>
>>>>  From xserver.if:
>>>>
>>>>         # Labeling rules for default windows and colormaps
>>>>         type_transition $1_xserver_t $1_xserver_t:{ x_drawable x_colormap } $1_rootwindow_t;
>>>>     
>>> Its significantly different since this deals with derived types while
>>> postgres doesn't.
>>>   
>> That's the policy writer's decision to make.  What if I make my own 
>> policy and I want to use derived types for postgres?
> 
> I never argued that type transitions shouldn't work.  My problem is the
> default type in the absence of type transitions.  In fact there are
> derived types in the current postgres policy, and I'm fine with them.

IIUC, SE-PostgreSQL has to decide the security context of a newly created
objects as follows:

1. It invokes security_compute_create_raw() to decide the security context
   of a newly created object, came from the policy.
2. It checks whether it come from TYPE_TRANSITION rule, or not.
   (What API is available to check it?)
3. If there is no TYPE_TRANSITION rule, it refers the configuration file
   to get the default context and applies it as if the context is explicitly
   specified by hand.
4. It checks xxxx:{ create } permission for the given security context.

It differs from the behavior of setfscreatecon on filesystem, and will
be confusable. I think the default come from configuration file should
work, as if a user specifies a security context explicitly.

If I misunderstood and you want to add a feature like setfscreatecon,
adding a database parameter is more suitable implementation for postgresql,
like:
  postgres=# SET sepgsql_table_createcon   \
                 'system_u:object_r:sepgsql_secret_t:SystemHigh'

Users can specify it on the frontend (psql), and it read ~/.psqlrc and
apply it on the startup.

However, I don't think TYPE_TRANSITION toward sepgsql_db_t, sepgsql_table_t, ...
are unnecessary, even if such the default option is added, because we don't
use setfscreatecon as alternatives of TYPE_TRANSITION on filesystem.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
