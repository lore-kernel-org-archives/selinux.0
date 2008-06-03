Subject: Re:
	[PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <48451C0C.6060303@ak.jp.nec.com>
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
	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 03 Jun 2008 08:37:12 -0400
Message-Id: <1212496632.31546.105.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-06-03 at 19:25 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:

> > I'm out of arguments; clearly I'm in the minority on this issue.  I
> > already said I wouldn't block the policy over this, so KaiGai, if you
> > would send a last patch based on the revisions I made [1], let see if we
> > can finally get this merged.
> > 
> > [1] http://marc.info/?l=selinux&m=120999566809541&w=2
> 
> I'll submit a revised version later.
> (Now we cannot update SVN repository, due to server maintenance.)
> 
> Before this, I want to modify the following points:
> 
> - neverallow rule should be removed, as you suggested before.
> 
> - The type_transition rule for newly created database should be
>   described with "self" as its target, like:
>     type_transition sepgsql_client_type self : db_database sepgsql_db_t;
>   The purpose is to make clear its meanings that this type_transition
>   has no appropriate parent as socket creation.

Unfortunately self doesn't work in type_transitions.

> - postgresql_unconfined() interface should also associate a domin
>   with sepgsql_client_type, not only sepgsql_unconfined_type.
>   dontaudit rules on row-level logs are not disabled for unconfined
>   clients. And, it's not useful to write additional policy module.

I don't understand what you mean about the dontaudits.  Otherwise, you
should recheck the unconfined rules.  I'm fairly sure I copied anything
relevant from the client rules into unconfined so I didn't have to add
both attributes in postgresql_unconfined().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
