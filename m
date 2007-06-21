MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libselinux: add x_contexts path lookup function
Date: Wed, 20 Jun 2007 21:23:49 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588D01896@exchange.columbia.tresys.com>
In-Reply-To: <467989CD.8010008@tycho.nsa.gov>
References: <467989CD.8010008@tycho.nsa.gov>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This patch adds an selinux_x_context_path() function
> identical to selinux_media_context_path(), fixing a hardcoded
> path in the X label backend.
> 
> I'm bothered that some of these pathnames are exposed in the
> interface. I assume that this done so libsemanage knows where to look.
> But having them in the interface could encourage users to
> depend on them instead of libsemanage.
> 
> There are also a lot of these functions, maybe we should just
> expose the internal function that takes a type code.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-By: Joshua Brindle <method@manicmethod.com>

Pretty trivial, I'd say merge at will (or wait for another ack, either
way)

I still don't like the labeling logic being here but I guess that battle
was lost, some apps (DBus, postgres) still maintain their own labeling
system, DBus could be moved to this probably but postgres will need to
maintain labels in the tables themselves. 

> ---
> 
>  include/selinux/selinux.h |    1 +
>  src/file_path_suffixes.h  |    1 +
>  src/label_x.c             |    2 +-
>  src/selinux_config.c      |   10 +++++++++-
>  src/selinux_internal.h    |    1 +
>  5 files changed, 13 insertions(+), 2 deletions(-)
> 
> 
> Index: libselinux/include/selinux/selinux.h
> ===================================================================
> --- libselinux/include/selinux/selinux.h	(revision 2488)
> +++ libselinux/include/selinux/selinux.h	(working copy) @@ -454,6
>  +454,7 @@ extern const char *selinux_file_context_local_path(void);
>  extern const char *selinux_homedir_context_path(void);
>  extern const char *selinux_media_context_path(void);
> +extern const char *selinux_x_context_path(void);
>  extern const char *selinux_contexts_path(void);  extern
> const char *selinux_securetty_types_path(void);
>  extern const char *selinux_booleans_path(void);
> Index: libselinux/src/file_path_suffixes.h
> ===================================================================
> --- libselinux/src/file_path_suffixes.h	(revision 2488)
> +++ libselinux/src/file_path_suffixes.h	(working copy) @@ -18,3
+18,4
>      @@ S_(NETFILTER_CONTEXTS, "/contexts/netfilter_contexts")
>      S_(FILE_CONTEXTS_HOMEDIR,
> "/contexts/files/file_contexts.homedir")
>      S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
> +    S_(X_CONTEXTS, "/contexts/x_contexts")
> Index: libselinux/src/selinux_internal.h
> ===================================================================
> --- libselinux/src/selinux_internal.h	(revision 2488)
> +++ libselinux/src/selinux_internal.h	(working copy) @@ -65,6 +65,7 @@
>      hidden_proto(selinux_booleans_path)
>      hidden_proto(selinux_customizable_types_path)
>      hidden_proto(selinux_media_context_path)
> +    hidden_proto(selinux_x_context_path)
>      hidden_proto(selinux_path)
>      hidden_proto(selinux_check_passwd_access)
>      hidden_proto(selinux_check_securetty_context)
> Index: libselinux/src/label_x.c
> ===================================================================
> --- libselinux/src/label_x.c	(revision 2488)
> +++ libselinux/src/label_x.c	(working copy)
> @@ -107,7 +107,7 @@
> 
>  	/* Open the specification file. */
>  	if (!path)
> -		path = "/etc/selinux/refpolicy/contexts/x_contexts";
> +		path = selinux_x_context_path();
>  	if ((fp = fopen(path, "r")) == NULL)
>  		return -1;
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
> Index: libselinux/src/selinux_config.c
> ===================================================================
> --- libselinux/src/selinux_config.c	(revision 2488)
> +++ libselinux/src/selinux_config.c	(working copy)
> @@ -38,7 +38,8 @@
>  #define FILE_CONTEXTS_HOMEDIR 16
>  #define FILE_CONTEXTS_LOCAL 17
>  #define SECURETTY_TYPES   18
> -#define NEL               19
> +#define X_CONTEXTS        19
> +#define NEL               20
> 
>  /* New layout is relative to SELINUXDIR/policytype. */
> static char *file_paths[NEL]; @@ -369,3 +370,10 @@  }
> 
>  hidden_def(selinux_file_context_local_path)
> +
> +const char *selinux_x_context_path()
> +{
> +	return get_path(X_CONTEXTS);
> +}
> +
> +hidden_def(selinux_x_context_path)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
