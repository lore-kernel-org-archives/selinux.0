Subject: Re: [PATCH] libselinux: add support
	for	/contexts/postgresql_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ewalsh@tycho.nsa.gov,
        selinux@tycho.nsa.gov
In-Reply-To: <483CBA23.9020505@ak.jp.nec.com>
References: <483A9137.5050509@ak.jp.nec.com>
	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>
	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>
	 <483CBA23.9020505@ak.jp.nec.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2008 08:56:25 -0400
Message-Id: <1211979385.5008.92.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-28 at 10:49 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2008-05-27 at 14:34 -0400, Stephen Smalley wrote:
> >> On Tue, 2008-05-27 at 13:55 -0400, Christopher J. PeBenito wrote:
> >>> I mainly had an issue with statements like:
> >>>
> >>> type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
> >>> type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
> >>> type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
> >>> type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
> >>> type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;
> >> The first four statements don't make sense to me; the last one does make
> >> sense (i.e. when a postgres client creates a new database, where the
> >> only related "object" in view is that object manager's context, label
> >> the new database with sepgsql_db_t).  That last instance seems valid as
> >> a way of expressing types for new databases; the first four statements
> >> seem to be more suited to this postgres contexts configuration (as they
> >> are independent of client domain entirely).
> > 
> > If we have a default contexts configuration, then none of the above
> > statements would be needed:  speaking of the last statement, in the
> > absence a type_transition, clients that create databases would still get
> > sepgsql_db_t as the type for the database, since that is the default
> > database type.
> 
> As I wrote in the reply to Stephen, it is not a default context.
> These rules are used to initialize SE-PostgreSQL itself with proper
> security context.

In my opinion, it is in fact the default context, despite what you say.
Otherwise you wouldn't have all sorts of type_transitions to the above
types for not only the server, but the generic clients.  I suspect you
would never want to run with no type transitions and have all of the
objects labeled postgresql_t.  That seems like a bad default
configuration.

> ﻿> Nonetheless, it sounds like you don't have a problem with the libselinux
> > change, as long as its just for the default contexts only, right?  Then
> > creating objects with something other than the default context would be
> > the job of type_transition.
> 
> What do you think the type_transition rules on db_database class should
> be described as a relationship between a client process and ... ?

I suspect that there is no right answer, only a less bad answer, which
would have to be the server process type.  Unfortunately I don't see
anything better, unless you want to transition on the default database
type.

> I don't think we need default contexts for any database object managed
> under database itself (like table, column, procedure, ...).

I don't agree.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
