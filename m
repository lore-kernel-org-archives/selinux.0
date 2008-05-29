Message-ID: <483EF06E.7080406@tycho.nsa.gov>
Date: Thu, 29 May 2008 14:05:34 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov> <1211981040.5008.105.camel@gorn.columbia.tresys.com>
In-Reply-To: <1211981040.5008.105.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-05-27 at 16:15 -0400, Eamon Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
>>>   
>>>       
>>>> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
>>>>         
>>>>> I mainly had an issue with statements like:
>>>>>
>>>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
>>>>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
>>>>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
>>>>>       
>>>>>           
>> I don't see the problem with the above statements - seems like a 
>> reasonable use of transitions to me.  If you don't like the first four 
>> transitions, then I would ask -- why not simply eliminate the target 
>> types in those rules and label all of those objects with postgresql_t 
>> (default transition)?  Clearly the names are just for convenience.  You 
>> did a similar thing with the X policy: going through and combining types.
>>     
>
> I don't think this is the same situation.  Having a table labeled
> postgresql_t doesn't make sense to me, since postgresql_t is the type of
> the server process.  Though, I suppose that if it wasn't an object
> manager, then the objects would implicitly be postgresql_t and/or
> postgresql_db_t.  So to conclude my stream of consciousness, I'm
> compelled by your argument, but I'm not sure its enough to change my
> position

If it's not the same situation, it sounds pretty darn close: the X 
server also acts as a "client" when it starts up, and various objects 
are created by the server before any real clients connect.  For example 
root window and default colormap.

 From xserver.if:

        # Labeling rules for default windows and colormaps
        type_transition $1_xserver_t $1_xserver_t:{ x_drawable x_colormap } $1_rootwindow_t;




-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
