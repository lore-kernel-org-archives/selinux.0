Message-ID: <1511800156.23941.8.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Mon, 27 Nov 2017 11:29:16 -0500
In-Reply-To: <20171121141940.24371-1-plautrba@redhat.com>
References: <20171121141940.24371-1-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] libsemanage: Use umask(0077) for fopen() write operations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-11-21 at 15:19 +0100, Petr Lautrbach wrote:
> When a calling process uses umask(0) some files in the SELinux module
> store can be created to be world writeable. With this patch,
> libsemanage
> sets umask(0077) before fopen() operations and restores the original
> umask value when it's done.
> 
> Fixes:
> drwx------. /var/lib/selinux/targeted/active
> -rw-rw-rw-. /var/lib/selinux/targeted/active/booleans.local
> -rw-rw-rw-. /var/lib/selinux/targeted/active/policy.linked
> -rw-rw-rw-. /var/lib/selinux/targeted/active/seusers.local
> 
> drwx------.
> /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t
> -rw-rw-rw-.
> /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t/cil
> -rw-rw-rw-.
> /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t/lang_e
> xt
> drwx------. /var/lib/selinux/targeted/active/modules/disabled
> -rw-rw-rw-.
> /var/lib/selinux/targeted/active/modules/disabled/zosremote
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/src/database_file.c  |  3 +++
>  libsemanage/src/direct_api.c     | 15 +++++++++++++++
>  libsemanage/src/semanage_store.c |  4 ++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/libsemanage/src/database_file.c
> b/libsemanage/src/database_file.c
> index a21b3eeb..d0172e73 100644
> --- a/libsemanage/src/database_file.c
> +++ b/libsemanage/src/database_file.c
> @@ -119,13 +119,16 @@ static int dbase_file_flush(semanage_handle_t *
> handle, dbase_file_t * dbase)
>  	cache_entry_t *ptr;
>  	const char *fname = NULL;
>  	FILE *str = NULL;
> +	mode_t mask = 0;

Why do we need to initialize this here?

>  
>  	if (!dbase_llist_is_modified(&dbase->llist))
>  		return STATUS_SUCCESS;
>  
>  	fname = dbase->path[handle->is_in_transaction];
>  
> +	mask = umask(0077);
>  	str = fopen(fname, "w");
> +	umask(mask);
>  	if (!str) {
>  		ERR(handle, "could not open %s for writing: %s",
>  		    fname, strerror(errno));
> diff --git a/libsemanage/src/direct_api.c
> b/libsemanage/src/direct_api.c
> index 00ad8201..46072f92 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1176,6 +1176,7 @@ static int
> semanage_direct_commit(semanage_handle_t * sh)
>  	sepol_policydb_t *out = NULL;
>  	struct cil_db *cildb = NULL;
>  	semanage_module_info_t *modinfos = NULL;
> +	mode_t mask = 0;

Why do we need to initialize mask here?

>  
>  	int do_rebuild, do_write_kernel, do_install;
>  	int fcontexts_modified, ports_modified, seusers_modified,
> @@ -1212,6 +1213,8 @@ static int
> semanage_direct_commit(semanage_handle_t * sh)
>  	/* Rebuild if explicitly requested or any module changes
> occurred. */
>  	do_rebuild = sh->do_rebuild | sh->modules_modified;
>  
> +	mask = umask(0077);
> +
>  	/* Create or remove the disable_dontaudit flag file. */
>  	path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_DISABLE_DONTAUDIT);
>  	if (access(path, F_OK) == 0)
> @@ -1645,6 +1648,10 @@ cleanup:
>  	semanage_remove_directory(semanage_final_path
>  				  (SEMANAGE_FINAL_TMP,
>  				   SEMANAGE_FINAL_TOPLEVEL));
> +	if (mask) {
> +		umask(mask);
> +	}

Why is this conditional?

> +
>  	return retval;
>  }
>  
> @@ -2016,6 +2023,7 @@ static int
> semanage_direct_set_enabled(semanage_handle_t *sh,
>  	const char *path = NULL;
>  	FILE *fp = NULL;
>  	semanage_module_info_t *modinfo = NULL;
> +	mode_t mask = 0;

Ditto

>  
>  	/* check transaction */
>  	if (!sh->is_in_transaction) {
> @@ -2076,7 +2084,9 @@ static int
> semanage_direct_set_enabled(semanage_handle_t *sh,
>  
>  	switch (enabled) {
>  		case 0: /* disable the module */
> +			mask = umask(0077);
>  			fp = fopen(fn, "w");
> +			umask(mask);
>  
>  			if (fp == NULL) {
>  				ERR(sh,
> @@ -2722,7 +2732,9 @@ static int
> semanage_direct_install_info(semanage_handle_t *sh,
>  	int type;
>  
>  	char path[PATH_MAX];
> +	mode_t mask = 0;

No need to initialize this here.
>  
> +	mask = umask(0077);

And this should go after local variable declarations or get folded into
the declaration above.

>  	semanage_module_info_t *higher_info = NULL;
>  	semanage_module_key_t higher_key;
>  	ret = semanage_module_key_init(sh, &higher_key);
> @@ -2834,6 +2846,9 @@ cleanup:
>  	semanage_module_info_destroy(sh, higher_info);
>  	free(higher_info);
>  
> +	if (mask) {
> +		umask(mask);
> +	}

Why conditional?

>  	return status;
>  }
>  
> diff --git a/libsemanage/src/semanage_store.c
> b/libsemanage/src/semanage_store.c
> index 63c80b04..74fbb677 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -2099,11 +2099,13 @@ int semanage_write_policydb(semanage_handle_t
> * sh, sepol_policydb_t * out,
>  	const char *kernel_filename = NULL;
>  	struct sepol_policy_file *pf = NULL;
>  	FILE *outfile = NULL;
> +	mode_t mask = 0;
>  
>  	if ((kernel_filename =
>  	     semanage_path(SEMANAGE_TMP, file)) == NULL) {
>  		goto cleanup;
>  	}
> +	mask = umask(0077);

Just move this before the first goto cleanup and then you don't need to
initialize mask or make the test below conditional.

>  	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
>  		ERR(sh, "Could not open kernel policy %s for
> writing.",
>  		    kernel_filename);
> @@ -2127,6 +2129,8 @@ int semanage_write_policydb(semanage_handle_t *
> sh, sepol_policydb_t * out,
>  	if (outfile != NULL) {
>  		fclose(outfile);
>  	}
> +	if (mask != 0)
> +		umask(mask);
>  	sepol_policy_file_free(pf);
>  	return retval;
>  }
