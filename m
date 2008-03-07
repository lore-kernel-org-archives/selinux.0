From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] SELinux: introduce permissive types
Date: Fri, 7 Mar 2008 15:21:23 -0500
Cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org
References: <1204919043.2891.50.camel@localhost.localdomain>
In-Reply-To: <1204919043.2891.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803071521.24037.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 07 March 2008 2:44:03 pm Eric Paris wrote:
> Introduce the concept of a permissive type.  A new ebitmap is
> introduced to the policy database which indicates is a given type has
> the permissive bit set or not.  This bit is tested for the scontext
> of any policy denial.  Thus the bit if meaningless on types which
> only appear as the target of a decision (such such as typically a
> file type).  A domain running with a permissive type will be allowed
> to perform any action similarly to when the system is globally set
> permissive.
>
> When going through the kernel to find out where the scontext is not
> that of a domain I found FILESYSTEM__ASSOCIATE and any number of
> networking permissions.  Can Paul or anyone comment on if the
> permissive bit on the scontext of the access decisions make sense? 
> My understanding is that ?most?all? of these sids will naturally flow
> from the executing domain (and if people use set_socket_con they know
> enough to fix it themselves).  So the permissive bit makes sense and
> should be allowed.

You should only see domains used as objects in some of the networking 
controls and not types used as subjects (is a packet an object or no?) 
so I think you are okay here.

> The permissive bit on a type used for files would allow it to
> associate with any FS.  Is this an issue?  Should I not check
> permissive on such operations?
>
> If we do want further restrictions on what operations should be
> affected by the permissive bit and what should I believe just about
> anything is possible, but it starts getting unmaintainable pretty
> quickly.  Maybe we just want to enforce convention in the toolchain
> that all types which are labeled permissive must have the 'domain'
> attribute or something like that. If you can load a policy with
> random bits set you win anyway so is kernel enforcement of permissive
> bits on non-domains an issue?
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
>
> ---
>
> Testing basically subsisted of adding a new policy module which
> turned an existing type into a permissive type.  In my case I made
> ntpd_t permissive and then ran programs as runcon -t ntpd_t 'script' 
> We would get a log message only one time just like is seen with the
> global non-enforcing.  Removing that policy module would reset the
> AVC and would subsequently deny the decision.
>
> Patches for libsepol and checkpolicy will be forthcoming as soon as I
> get them cleaned up to the point where they don't look like I just
> threw up in the code base and out popped permissive domains.

The secrets of SELinux tool development revealed!

 ;)

>  security/selinux/avc.c              |    9 ++++++++-
>  security/selinux/include/security.h |    5 ++++-
>  security/selinux/ss/policydb.c      |   11 +++++++++++
>  security/selinux/ss/policydb.h      |    2 ++
>  security/selinux/ss/services.c      |   15 +++++++++++++++
>  5 files changed, 40 insertions(+), 2 deletions(-)
>

...

> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -26,13 +26,14 @@
>  #define POLICYDB_VERSION_AVTAB		20
>  #define POLICYDB_VERSION_RANGETRANS	21
>  #define POLICYDB_VERSION_POLCAP		22
> +#define POLICYDB_VERSION_PERMISSIVE	23
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define
> POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VAL
>UE #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
>  #endif

I believe you need to update the Kconfig maximum policy version too.

> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c index f374186..97b4453 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -416,6 +416,21 @@ inval_class:
>  	return -EINVAL;
>  }
>
> +/*
> + * Given a sid find if the type has the permissive flag set
> + */
> +int security_permissive_sid(u32 sid)
> +{
> +	struct context *context;
> +	u32 type;
> +
> +	context = sidtab_search(&sidtab, sid);
> +	BUG_ON(!context);
> +
> +	type = context->type;
> +	return ebitmap_get_bit(&policydb.permissive_map, type);
> +}

I'm almost certain you need to do this wrapped with POLICY_RDLOCK and 
POLICY_RDUNLOCK.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
