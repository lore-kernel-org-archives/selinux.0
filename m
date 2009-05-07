Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47D8Ru8014361
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 09:08:27 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n47D8QBE026729
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 13:08:26 GMT
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <49ED34B2.4010906@ak.jp.nec.com>
References: <49D1DA85.1030902@ak.jp.nec.com>
	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>
	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>
	 <49D563A9.1000607@ak.jp.nec.com>  <49D965CA.4030908@ak.jp.nec.com>
	 <1240258044.19211.767.camel@gorn.columbia.tresys.com>
	 <49ED34B2.4010906@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 07 May 2009 09:08:07 -0400
Message-Id: <1241701687.19211.1252.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-21 at 11:51 +0900, KaiGai Kohei wrote:
> Chris, the attached patch is the part you already OK'ed.
> 
> - rework: Add a comment of "deprecated" for deprecated permissions.
> - bugfix: MCS policy did not constrain the following permissions.
>     db_database:{getattr}
>     db_table:{getattr lock}
>     db_column:{getattr}
>     db_procedure:{drop getattr setattr}
>     db_blob:{getattr import export}
> - rework: db_table:{lock} is moved to reader side, because it makes
>   impossible to refer read-only table with foreign-key constraint.
>   (FK checks internally acquire explicit locks.)
> - bugfix: some of permissions in db_procedure class are allowed
>   on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
>   It should allow them on sepgsql_trusted_proc_exec_t.
>   I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
>   such kind of confusion, as Chris suggested before.
> - rework: we should not allow db_procedure:{install} on the
>   sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
>   procedure implicitly.
> - bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
>   but it is required whrn the largeobject is refered.
> - bugfix: MLS policy didn't constrain the db_procedure class.
> 
> I'll send the rest of patches after we determine what prefix is preferable
> for unprivileged domains.

Merged.

> Christopher J. PeBenito wrote:
> > On Mon, 2009-04-06 at 11:15 +0900, KaiGai Kohei wrote:
> >> The attached patch provides some of reworks and bugfuxes
> >> except for new object classes and permissions.
> >>
> >> - rework: Add a comment of "not currently in use" for deprecated
> >>   permissions, but its definitions are not removed.
> > 
> > "deprecated" should be sufficient.
> > 
> >> - bugfix: MCS policy did not constrain the following permissions.
> >>     db_database:{getattr}
> >>     db_table:{getattr lock}
> >>     db_column:{getattr}
> >>     db_procedure:{drop getattr setattr}
> >>     db_blob:{getattr import export}
> > 
> > Looks ok to me.
> > 
> >> - rework: All the newly created database objects by unprivileged
> >>   clients are prefixed with "user_", and these are controled via
> >>   sepgsql_enable_users_ddl.
> > 
> > I don't think we should be mixing user content with other unpriv
> > clients.
> > 
> >>   The current policy allows httpd_t to created a function labeled
> >>   as sepgsql_proc_t which is also allowed to be installed as a
> >>   system internal entity (db_procedure:{install}).
> >>   It is a potentially risk for trojan horse.
> >>
> >> - rework: postgresql_role() shares most part of postgresql_unpriv_client().
> > 
> > See above comment.
> > 
> >> - bugfix: some of permissions in db_procedure class are allowed
> >>   on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
> >>   It should allow them on sepgsql_trusted_proc_exec_t.
> >>   I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
> >>   such kind of confusion, as Chris suggested before.
> >>
> >> - rework: we should not allow db_procedure:{install} on the
> >>   sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
> >>   procedure implicitly.
> >>
> >> - rework: db_table:{lock} is moved to reader side, because it makes
> >>   impossible to refer read-only table with foreign-key constraint.
> >>   (FK checks internally acquire explicit locks.)
> >>
> >> - bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
> >>   but it is required whrn the largeobject is refered.
> >>
> >> - bugfix: MLS policy didn't constrain the db_procedure class.
> > 
> > Seems ok.
> > 
> > It would be helpful to break up the patch into a set to make it easier
> > to review in the future.
> > 
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
