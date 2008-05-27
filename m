Subject: Re: [PATCH] libselinux: add support for
	/contexts/postgresql_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: cpebenito@tresys.com, ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <483A9137.5050509@ak.jp.nec.com>
References: <483A9137.5050509@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 13:14:37 -0400
Message-Id: <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-26 at 19:30 +0900, KaiGai Kohei wrote:
> Hello,
> 
> The attached patch enables to obtain the default security context of newly
> created database, defined at /etc/selinux/*/contexts/postgresql_contexts .
> 
> The format is as follows:
> --------
> #
> # Config file for SE-PostgreSQL
> #
> # <domain of client>  <type of newly created database>
> unconfined_t    sepgsql_db_t
> *               sepgsql_db_t
> --------
> 
> '*' means default security context, if given key is not matched for any entry.
> 
> This API requires the security context of client as a key, and it returns
> a security context to be attached for a newly created database.
> It has a type field defined in the right-hand of config file, and inherits
> user and lower-range field of given security context as a key.
> 
> e.g)
> selabel_lookup(sehandle, &context, "user_u:user_r:user_t:s0", 0);
> returns "user_u:object_r:sepgsql_db_t:s0".

Chris is investigating the use of roles on objects in order to provide
more fully featured RBAC support without requiring use of per-role
domains.  Hardcoding the use of object_r won't be future compatible for
that situation, and more generally we don't want to hardcode policy
information in libselinux at all.

I'm also unclear as to why type_transition rules aren't a better way of
expressing the above, although I know you've been discussing this with
Chris for some time.  Logically I'd expect the client domain to be the
source type of the transition, and the type for the newly created
database to be the new/result type of the transition.  What to use as
the target type is less clear; we'd have a similar issue if we were to
use type_transitions for e.g. sockets.  It could either be the client
domain both as source and target (self relationship, no related object)
or the client domain as source and the object manager domain as target.

Chris, what is the objection to using type transitions here, as they are
for labeling new objects and this seems to fit that situation?

> This patch is implemented based on the previous discussion at:
>   http://marc.info/?l=selinux&m=120999566809541&w=2
> 
> Thanks,
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  include/selinux/label.h   |    2
>  include/selinux/selinux.h |    1
>  src/file_path_suffixes.h  |    1
>  src/label.c               |   20 +++-
>  src/label_internal.h      |    4
>  src/label_pgsql.c         |  209 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/selinux_config.c      |    9 +
>  src/selinux_internal.h    |    1
>  8 files changed, 243 insertions(+), 4 deletions(-)
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
