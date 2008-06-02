Subject: Re: [PATCH]
	libselinux:	add	support	for	/contexts/postgresql_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <48442E7E.9050303@tycho.nsa.gov>
References: <483A9137.5050509@ak.jp.nec.com>
	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>
	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>
	 <483C6BEA.8040101@tycho.nsa.gov>
	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>
	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>
	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>
	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 02 Jun 2008 14:39:15 -0400
Message-Id: <1212431955.31546.94.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-02 at 13:31 -0400, Eamon Walsh wrote:
> KaiGai Kohei wrote:
> > Christopher J. PeBenito wrote:
> >> On Thu, 2008-05-29 at 20:22 -0400, Eamon Walsh wrote:
> >>> Christopher J. PeBenito wrote:
> >>>> On Thu, 2008-05-29 at 14:05 -0400, Eamon Walsh wrote:
> >>>>> Christopher J. PeBenito wrote:
> >>>>>> On Tue, 2008-05-27 at 16:15 -0400, Eamon Walsh wrote:
> >>>>>>> Christopher J. PeBenito wrote:
> >>>>>>>> On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
> >>>>>>>>> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
> >>>>>>>>>> I mainly had an issue with statements like:
> >>>>>>>>>>
> >>>>>>>>>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
> >>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
> >>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
> >>>>>>>>>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
> >>>>>>>>>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
> >>>>>>>>>>       
> >>>>>>> I don't see the problem with the above statements - seems like a 
> >>>>>>> reasonable use of transitions to me.  If you don't like the first four 
> >>>>>>> transitions, then I would ask -- why not simply eliminate the target 
> >>>>>>> types in those rules and label all of those objects with postgresql_t 
> >>>>>>> (default transition)?  Clearly the names are just for convenience.  You 
> >>>>>>> did a similar thing with the X policy: going through and combining types.
> >>>>>>>     
> >>>>>>>         
> >>>>>>>               
> >>>>>> I don't think this is the same situation.  Having a table labeled
> >>>>>> postgresql_t doesn't make sense to me, since postgresql_t is the type of
> >>>>>> the server process.  Though, I suppose that if it wasn't an object
> >>>>>> manager, then the objects would implicitly be postgresql_t and/or
> >>>>>> postgresql_db_t.  So to conclude my stream of consciousness, I'm
> >>>>>> compelled by your argument, but I'm not sure its enough to change my
> >>>>>> position
> >>>>>>       
> >>>>>>             
> >>>>> If it's not the same situation, it sounds pretty darn close: the X 
> >>>>> server also acts as a "client" when it starts up, and various objects 
> >>>>> are created by the server before any real clients connect.  For example 
> >>>>> root window and default colormap.
> >>>>>
> >>>>>  From xserver.if:
> >>>>>
> >>>>>         # Labeling rules for default windows and colormaps
> >>>>>         type_transition $1_xserver_t $1_xserver_t:{ x_drawable x_colormap } $1_rootwindow_t;
> >>>>>     
> >>>>>           
> >>>> Its significantly different since this deals with derived types while
> >>>> postgres doesn't.
> >>>>   
> >>>>         
> >>> That's the policy writer's decision to make.  What if I make my own 
> >>> policy and I want to use derived types for postgres?
> >>>       
> >> I never argued that type transitions shouldn't work.  My problem is the
> >> default type in the absence of type transitions.  In fact there are
> >> derived types in the current postgres policy, and I'm fine with them.
> >>     
> 
> It sounds to me like selabel might be best for this. The tables,
> databases, procedures, and blobs have names, and those names can be used
> in a mapping to contexts. There can be setcreatecon overrides to this as
> well. selabel has a wildcard for setting a default context.
> 
> But putting a hard-coded context into a file just to avoid a few type
> transition rules is totally bogus to me. I find it strange that it's
> considered a "simplification" to use a default_context file rather than
> policy rules, as though it's some kind of huge win. Adding a
> default_context file requires new libselinux API, which bloat affects
> all SELinux users. I've also never seen a coherent solution for managing
> these files. They are part of the security policy, which means updates
> to them must be atomic with the policy load or there will be race
> conditions affecting their users.

I'm out of arguments; clearly I'm in the minority on this issue.  I
already said I wouldn't block the policy over this, so KaiGai, if you
would send a last patch based on the revisions I made [1], let see if we
can finally get this merged.

[1] http://marc.info/?l=selinux&m=120999566809541&w=2

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
