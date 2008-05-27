Subject: Re: [PATCH] libselinux: add support for
	/contexts/postgresql_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, ewalsh@tycho.nsa.gov,
        selinux@tycho.nsa.gov
In-Reply-To: <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
References: <483A9137.5050509@ak.jp.nec.com>
	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 27 May 2008 13:55:42 -0400
Message-Id: <1211910942.5008.57.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-05-27 at 13:14 -0400, Stephen Smalley wrote:
> On Mon, 2008-05-26 at 19:30 +0900, KaiGai Kohei wrote:
> > Hello,
> > 
> > The attached patch enables to obtain the default security context of newly
> > created database, defined at /etc/selinux/*/contexts/postgresql_contexts .
> > 
> > The format is as follows:
> > --------
> > #
> > # Config file for SE-PostgreSQL
> > #
> > # <domain of client>  <type of newly created database>
> > unconfined_t    sepgsql_db_t
> > *               sepgsql_db_t
> > --------
> > 
> > '*' means default security context, if given key is not matched for any entry.
> > 
> > This API requires the security context of client as a key, and it returns
> > a security context to be attached for a newly created database.
> > It has a type field defined in the right-hand of config file, and inherits
> > user and lower-range field of given security context as a key.
> > 
> > e.g)
> > selabel_lookup(sehandle, &context, "user_u:user_r:user_t:s0", 0);
> > returns "user_u:object_r:sepgsql_db_t:s0".
> 
> Chris is investigating the use of roles on objects in order to provide
> more fully featured RBAC support without requiring use of per-role
> domains.  Hardcoding the use of object_r won't be future compatible for
> that situation, and more generally we don't want to hardcode policy
> information in libselinux at all.
> 
> I'm also unclear as to why type_transition rules aren't a better way of
> expressing the above, although I know you've been discussing this with
> Chris for some time.  Logically I'd expect the client domain to be the
> source type of the transition, and the type for the newly created
> database to be the new/result type of the transition.  What to use as
> the target type is less clear; we'd have a similar issue if we were to
> use type_transitions for e.g. sockets.  It could either be the client
> domain both as source and target (self relationship, no related object)
> or the client domain as source and the object manager domain as target.
> 
> Chris, what is the objection to using type transitions here, as they are
> for labeling new objects and this seems to fit that situation?

I think KaiGai took my idea a little to far.  My issue was just to have
postgres determine what the default label for its objects are via
postgresql_contexts.  A derived role/type still makes sense to be stated
via (type|role)_transition.  I suspect there was confusion on this
point.  I mainly had an issue with statements like:

type_transition postgresql_t postgresql_t:db_database sepgsql_db_t;
type_transition postgresql_t sepgsql_database_type:db_table sepgsql_sysobj_t;
type_transition postgresql_t sepgsql_database_type:db_procedure sepgsql_proc_t;
type_transition postgresql_t sepgsql_database_type:db_blob sepgsql_blob_t;
type_transition sepgsql_client_type postgresql_t:db_database sepgsql_db_t;

which I feel should be instead be expressed in a postgresql_contexts
file that says the default context for a database is ::seqpgsql_db_t,
default context for table is ::sepgsql_sysobj_t, etc.

This makes perfect sense staying as a type_transition in the policy:

type_transition staff_t sepgsql_sysobj_t:db_tuple staff_sepgsql_sysobj_t;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
