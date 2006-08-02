Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72DJWhC027384
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 09:19:32 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72DJLa2008058
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 13:19:22 GMT
Subject: Re: [PATCH 1/6] netfilter integration take 2: add
	netfilter_contexts path to libselinux
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154457787.31522.147.camel@sgc.columbia.tresys.com>
References: <1154457787.31522.147.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 09:19:25 -0400
Message-Id: <1154524765.27457.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:
> Adds a netfilter_contexts path in the contexts dir of the policy to
> libselinux.
> 
>  libselinux/include/selinux/selinux.h |    1 +
>  libselinux/src/file_path_suffixes.h  |    1 +
>  libselinux/src/selinux_config.c      |   10 +++++++++-
>  libselinux/src/selinux_internal.h    |    1 +
>  libselinux/src/selinuxswig.i         |    1 +
>  5 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --exclude .svn -purN trunk/libselinux/include/selinux/selinux.h netfilter-integration/libselinux/include/selinux/selinux.h
> --- trunk/libselinux/include/selinux/selinux.h	2006-07-03 10:42:01.031370000 -0400
> +++ netfilter-integration/libselinux/include/selinux/selinux.h	2006-07-14 11:15:32.967437750 -0400
> @@ -398,6 +398,7 @@ extern "C" {
>  	extern const char *selinux_users_path(void);
>  	extern const char *selinux_usersconf_path(void);
>  	extern const char *selinux_translations_path(void);
> +	extern const char *selinux_netfilter_context_path(void);
>  	extern const char *selinux_path(void);
>  
>  /* Check a permission in the passwd class.
> diff --exclude .svn -purN trunk/libselinux/src/file_path_suffixes.h netfilter-integration/libselinux/src/file_path_suffixes.h
> --- trunk/libselinux/src/file_path_suffixes.h	2006-07-03 10:42:01.031370000 -0400
> +++ netfilter-integration/libselinux/src/file_path_suffixes.h	2006-07-14 11:15:33.003440000 -0400
> @@ -14,3 +14,4 @@ S_(BINPOLICY, "/policy/policy")
>      S_(USERS_DIR, "/users/")
>      S_(SEUSERS, "/seusers")
>      S_(TRANSLATIONS, "/setrans.conf")
> +    S_(NETFILTER_CONTEXTS, "/contexts/netfilter_contexts")
> diff --exclude .svn -purN trunk/libselinux/src/selinux_config.c netfilter-integration/libselinux/src/selinux_config.c
> --- trunk/libselinux/src/selinux_config.c	2006-07-03 10:42:01.031370000 -0400
> +++ netfilter-integration/libselinux/src/selinux_config.c	2006-07-14 11:15:36.527660250 -0400
> @@ -35,7 +35,8 @@
>  #define USERS_DIR         12
>  #define SEUSERS           13
>  #define TRANSLATIONS      14
> -#define NEL               15
> +#define NETFILTER_CONTEXTS    15
> +#define NEL               16
>  
>  /* New layout is relative to SELINUXDIR/policytype. */
>  static char *file_paths[NEL];
> @@ -384,3 +385,10 @@ const char *selinux_translations_path()
>  }
>  
>  hidden_def(selinux_translations_path)
> +
> +const char *selinux_netfilter_context_path()
> +{
> +	return get_path(NETFILTER_CONTEXTS);
> +}
> +
> +hidden_def(selinux_netfilter_context_path)
> diff --exclude .svn -purN trunk/libselinux/src/selinux_internal.h netfilter-integration/libselinux/src/selinux_internal.h
> --- trunk/libselinux/src/selinux_internal.h	2006-07-03 10:42:01.031370000 -0400
> +++ netfilter-integration/libselinux/src/selinux_internal.h	2006-07-14 11:15:32.979438500 -0400
> @@ -54,6 +54,7 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(selinux_failsafe_context_path)
>      hidden_proto(selinux_removable_context_path)
>      hidden_proto(selinux_file_context_path)
> +    hidden_proto(selinux_netfilter_context_path)
>      hidden_proto(selinux_homedir_context_path)
>      hidden_proto(selinux_user_contexts_path)
>      hidden_proto(selinux_booleans_path)
> diff --exclude .svn -purN trunk/libselinux/src/selinuxswig.i netfilter-integration/libselinux/src/selinuxswig.i
> --- trunk/libselinux/src/selinuxswig.i	2006-06-28 14:51:13.728585000 -0400
> +++ netfilter-integration/libselinux/src/selinuxswig.i	2006-07-31 11:06:39.166223250 -0400
> @@ -107,6 +107,7 @@ extern const char *selinux_customizable_
>  extern const char *selinux_users_path(void);
>  extern const char *selinux_usersconf_path(void);
>  extern const char *selinux_translations_path(void);
> +extern const char *selinux_netfilter_context_path(void);
>  extern const char *selinux_path(void);
>  extern int selinux_check_passwd_access(access_vector_t requested);
>  extern int checkPasswdAccess(access_vector_t requested);
> 
> 

Looks good to me.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
