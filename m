Subject: Re: [PATCH 03/13] libsemanage: move the module store to
 /var/lib/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com,
        jwcart2@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <1261610760-4724-4-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
Content-Type: text/plain
Date: Fri, 08 Jan 2010 09:28:22 -0500
Message-Id: <1262960902.13162.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-12-23 at 18:25 -0500, Caleb Case wrote:
> This patch moves the module store from /etc/selinux/<store>/modules to
> /var/lib/selinux/<store>.

Can the path prefix (i.e. /var/lib/selinux) be made configurable?

> This move will allow for the use of a read-only /etc/selinux. Currently
> that is not possible with semanage because of the lock files.
> 
> A consequence of this move is that packagers of libsemanage should
> create the /var/lib/selinux directory.
> ---
>  libsemanage/src/direct_api.c     |   20 ++----------------
>  libsemanage/src/semanage_store.c |   39 ++++++++++++++++++++++++-------------
>  libsemanage/src/semanage_store.h |    5 +++-
>  3 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index f09c7cf..5fb4523 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -89,12 +89,7 @@ static struct semanage_policy_table direct_funcs = {
>  
>  int semanage_direct_is_managed(semanage_handle_t * sh)
>  {
> -	char polpath[PATH_MAX];
> -
> -	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
> -		 sh->conf->store_path);
> -
> -	if (semanage_check_init(polpath))
> +	if (semanage_check_init(sh, semanage_root_path()))
>  		goto err;
>  
>  	if (semanage_access_check(sh) < 0)
> @@ -111,13 +106,9 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
>   */
>  int semanage_direct_connect(semanage_handle_t * sh)
>  {
> -	char polpath[PATH_MAX];
>  	const char *path;
>  
> -	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
> -		 sh->conf->store_path);
> -
> -	if (semanage_check_init(polpath))
> +	if (semanage_check_init(sh, semanage_root_path()))
>  		goto err;
>  
>  	if (sh->create_store)
> @@ -1416,12 +1407,7 @@ static int semanage_direct_list(semanage_handle_t * sh,
>  
>  int semanage_direct_access_check(semanage_handle_t * sh)
>  {
> -	char polpath[PATH_MAX];
> -
> -	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
> -		 sh->conf->store_path);
> -
> -	if (semanage_check_init(polpath))
> +	if (semanage_check_init(sh, semanage_root_path()))
>  		return -1;
>  
>  	return semanage_store_access_check(sh);
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 0a55ce0..049818a 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -3,8 +3,9 @@
>   *	    Jason Tang <jtang@tresys.com>
>   *          Christopher Ashworth <cashworth@tresys.com>
>   *          Chris PeBenito <cpebenito@tresys.com>
> + *	    Caleb Case <ccase@tresys.com>
>   *
> - * Copyright (C) 2004-2006 Tresys Technology, LLC
> + * Copyright (C) 2004-2006,2009 Tresys Technology, LLC
>   * Copyright (C) 2005 Red Hat, Inc.
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -88,8 +89,6 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
>  	"/tmp"
>  };
>  
> -/* this is the module store path relative to selinux_policy_root() */
> -#define SEMANAGE_MOD_DIR "/modules"
>  /* relative path names to enum sandbox_paths for special files within
>   * a sandbox */
>  static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
> @@ -157,14 +156,14 @@ static int semanage_init_paths(const char *root)
>  	if (!root)
>  		return -1;
>  
> -	prefix_len = (strlen(root) + strlen(SEMANAGE_MOD_DIR));
> +	prefix_len = strlen(root);
>  
>  	for (i = 0; i < SEMANAGE_NUM_FILES; i++) {
>  		len = (strlen(semanage_relative_files[i]) + prefix_len);
>  		semanage_files[i] = calloc(len + 1, sizeof(char));
>  		if (!semanage_files[i])
>  			return -1;
> -		sprintf(semanage_files[i], "%s%s%s", root, SEMANAGE_MOD_DIR,
> +		sprintf(semanage_files[i], "%s%s", root,
>  			semanage_relative_files[i]);
>  	}
>  
> @@ -186,16 +185,11 @@ static int semanage_init_store_paths(const char *root)
>  	int i, j;
>  	size_t len;
>  	size_t prefix_len;
> -	char *prefix;
>  
>  	if (!root)
>  		return -1;
>  
> -	prefix_len = (strlen(root) + strlen(SEMANAGE_MOD_DIR));
> -	prefix = calloc(prefix_len + 1, sizeof(char));
> -	if (!prefix)
> -		return -1;
> -	sprintf(prefix, "%s%s", root, SEMANAGE_MOD_DIR);
> +	prefix_len = strlen(root);
>  
>  	for (i = 0; i < SEMANAGE_NUM_STORES; i++) {
>  		for (j = 0; j < SEMANAGE_STORE_NUM_PATHS; j++) {
> @@ -204,14 +198,13 @@ static int semanage_init_store_paths(const char *root)
>  			semanage_paths[i][j] = calloc(len + 1, sizeof(char));
>  			if (!semanage_paths[i][j])
>  				goto cleanup;
> -			sprintf(semanage_paths[i][j], "%s%s%s", prefix,
> +			sprintf(semanage_paths[i][j], "%s%s%s", root,
>  				semanage_store_paths[i],
>  				semanage_sandbox_paths[j]);
>  		}
>  	}
>  
>        cleanup:
> -	free(prefix);
>  	return 0;
>  }
>  
> @@ -223,16 +216,28 @@ static int semanage_init_store_paths(const char *root)
>   *
>   * Note that this function is NOT thread-safe.
>   */
> -int semanage_check_init(const char *root)
> +int semanage_check_init(semanage_handle_t *sh, const char *prefix)
>  {
>  	int rc;
>  	if (semanage_paths_initialized == 0) {
> +		char root[PATH_MAX];
> +
> +		rc = snprintf(root,
> +			      sizeof(root),
> +			      "%s/%s",
> +			      prefix,
> +			      sh->conf->store_path);
> +		if (rc < 0 || rc >= (int)sizeof(root))
> +			return -1;
> +
>  		rc = semanage_init_paths(root);
>  		if (rc)
>  			return rc;
> +
>  		rc = semanage_init_store_paths(root);
>  		if (rc)
>  			return rc;
> +
>  		semanage_paths_initialized = 1;
>  	}
>  	return 0;
> @@ -259,6 +264,12 @@ const char *semanage_path(enum semanage_store_defs store,
>  	return semanage_paths[store][path_name];
>  }
>  
> +/* Return the root of the semanage store. */
> +const char *semanage_root_path(void)
> +{
> +	return "/var/lib/selinux";
> +}
> +
>  /* Return a fully-qualified path + filename to the semanage
>   * configuration file.  The caller must not alter the string returned
>   * (and hence why this function return type is const).
> diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
> index 112edb6..c76ecfe 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -62,11 +62,14 @@ enum semanage_sandbox_defs {
>  	SEMANAGE_STORE_NUM_PATHS
>  };
>  
> +const char *semanage_root_path(void);
> +
>  /* FIXME: this needs to be made a module store specific init and the
>   * global configuration moved to another file.
>   */
>  const char *semanage_conf_path(void);
> -int semanage_check_init(const char *root);
> +
> +int semanage_check_init(semanage_handle_t *sh, const char *prefix);
>  
>  extern const char *semanage_fname(enum semanage_sandbox_defs file_enum);
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
