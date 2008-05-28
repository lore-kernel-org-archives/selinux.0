Message-ID: <483CC83A.7080103@ak.jp.nec.com>
Date: Wed, 28 May 2008 11:49:30 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: cpebenito@tresys.com, ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add support for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com> <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>> e.g)
>> selabel_lookup(sehandle, &context, "user_u:user_r:user_t:s0", 0);
>> returns "user_u:object_r:sepgsql_db_t:s0".
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

I think it can be a good candidate to describe type_transition for
db_database class, because another subsystem (socket) adopts self
relationship approach and we can avoid unnecessary confusion.

Chris, can you change type_transition rules for db_database, as follows?

  type_transition postgresql_t self:db_database sepgsql_db_t;
  type_transition sepgsql_client_type self_t:db_database sepgsql_db_t;

In this approach, I think configuration files are not necessary basically.

However, I'm attracted to Eamon's idea.
If there is a configuration file to describe what database object should
have what context, we can also provide a restorecon for database objects.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
