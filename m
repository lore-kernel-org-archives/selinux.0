Message-ID: <1506609472.7655.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 28 Sep 2017 10:37:52 -0400
In-Reply-To: <20170626123835.8234-3-vmojzis@redhat.com>
References: <1495202170.2209.3.camel@tycho.nsa.gov>
 <20170626123835.8234-1-vmojzis@redhat.com>
 <20170626123835.8234-3-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] libsemanage: replace access(, F_OK) checks to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-06-26 at 14:38 +0200, Vit Mojzis wrote:
> access() uses real UID instead of effective UID which causes false
> negative checks in setuid programs.
> Replace access(,F_OK) (i.e. tests for file existence) by stat().
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Did you decide to not pursue this further?  I didn't see any follow-up
since my last set of comments in June.

> ---
>  libsemanage/src/direct_api.c | 50 +++++++++++++++++++++++++++++-----
> ----------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c
> b/libsemanage/src/direct_api.c
> index ed11a7c..3d1c354 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -296,10 +296,19 @@ int semanage_direct_connect(semanage_handle_t *
> sh)
>  
>  	/* set the disable dontaudit value */
>  	path = semanage_path(SEMANAGE_ACTIVE,
> SEMANAGE_DISABLE_DONTAUDIT);
> -	if (access(path, F_OK) == 0)
> +
> +	struct stat sb;
> +	if (stat(path, &sb) == 0)
>  		sepol_set_disable_dontaudit(sh->sepolh, 1);
> -	else
> -		sepol_set_disable_dontaudit(sh->sepolh, 0);
> +	else{
> +		if (errno == ENOENT){
> +			sepol_set_disable_dontaudit(sh->sepolh, 0);
> +		}
> +		else{
> +			ERR(sh, "Unable to access disable_dontaudit
> file at %s: %s\n",path , strerror(errno));
> +			goto err;
> +		}
> +	}
>  
>  	return STATUS_SUCCESS;
>  
> @@ -1114,6 +1123,7 @@ static int
> semanage_compile_hll_modules(semanage_handle_t *sh,
>  	int status = 0;
>  	int i;
>  	char cil_path[PATH_MAX];
> +	struct stat sb;
>  
>  	assert(sh);
>  	assert(modinfos);
> @@ -1130,9 +1140,12 @@ static int
> semanage_compile_hll_modules(semanage_handle_t *sh,
>  		}
>  
>  		if (semanage_get_ignore_module_cache(sh) == 0 &&
> -				access(cil_path, F_OK) == 0) {
> +				(status = stat(cil_path, &sb)) == 0)
> {
>  			continue;
>  		}
> +		if (status != 0 && status != ENOENT) {
> +			goto cleanup; //an error in the "stat" call
> +		}
>  
>  		status = semanage_compile_module(sh, &modinfos[i]);
>  		if (status < 0) {
> @@ -1200,7 +1213,8 @@ static int
> semanage_direct_commit(semanage_handle_t * sh)
>  
>  	/* Create or remove the disable_dontaudit flag file. */
>  	path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_DISABLE_DONTAUDIT);
> -	if (access(path, F_OK) == 0)
> +	struct stat sb;
> +	if (stat(path, &sb) == 0)
>  		do_rebuild |= !(sepol_get_disable_dontaudit(sh-
> >sepolh) == 1);
>  	else
>  		do_rebuild |= (sepol_get_disable_dontaudit(sh-
> >sepolh) == 1);
> @@ -1225,7 +1239,7 @@ static int
> semanage_direct_commit(semanage_handle_t * sh)
>  
>  	/* Create or remove the preserve_tunables flag file. */
>  	path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_PRESERVE_TUNABLES);
> -	if (access(path, F_OK) == 0)
> +	if (stat(path, &sb) == 0)
>  		do_rebuild |= !(sepol_get_preserve_tunables(sh-
> >sepolh) == 1);
>  	else
>  		do_rebuild |= (sepol_get_preserve_tunables(sh-
> >sepolh) == 1);
> @@ -1266,37 +1280,37 @@ static int
> semanage_direct_commit(semanage_handle_t * sh)
>  	 */
>  	if (!do_rebuild) {
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_KERNEL);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_FC);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_SEUSERS);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_SEUSERS_LINKED);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_USERS_EXTRA_LINKED);
> -		if (access(path, F_OK) != 0) {
> +		if (stat(path, &sb) != 0) {
>  			do_rebuild = 1;
>  			goto rebuild;
>  		}
> @@ -1431,7 +1445,7 @@ rebuild:
>  			goto cleanup;
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_SEUSERS_LINKED);
> -		if (access(path, F_OK) == 0) {
> +		if (stat(path, &sb) == 0) {
>  			retval = semanage_copy_file(path,
>  						    semanage_path(SE
> MANAGE_TMP,
>  								  SE
> MANAGE_STORE_SEUSERS),
> @@ -1444,7 +1458,7 @@ rebuild:
>  		}
>  
>  		path = semanage_path(SEMANAGE_TMP,
> SEMANAGE_USERS_EXTRA_LINKED);
> -		if (access(path, F_OK) == 0) {
> +		if (stat(path, &sb) == 0) {
>  			retval = semanage_copy_file(path,
>  						    semanage_path(SE
> MANAGE_TMP,
>  								  SE
> MANAGE_USERS_EXTRA),
> @@ -1785,7 +1799,8 @@ static int
> semanage_direct_extract(semanage_handle_t * sh,
>  		goto cleanup;
>  	}
>  
> -	if (access(module_path, F_OK) != 0) {
> +	struct stat sb;
> +	if (stat(module_path, &sb) != 0) {
>  		ERR(sh, "Module does not exist: %s", module_path);
>  		rc = -1;
>  		goto cleanup;
> @@ -1815,7 +1830,7 @@ static int
> semanage_direct_extract(semanage_handle_t * sh,
>  		goto cleanup;
>  	}
>  
> -	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") &&
> access(input_file, F_OK) != 0) {
> +	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") &&
> stat(input_file, &sb) != 0) {
>  		rc = semanage_compile_module(sh, _modinfo);
>  		if (rc < 0) {
>  			goto cleanup;
> @@ -2790,7 +2805,8 @@ static int
> semanage_direct_install_info(semanage_handle_t *sh,
>  			goto cleanup;
>  		}
>  
> -		if (access(path, F_OK) == 0) {
> +		struct stat sb;
> +		if (stat(path, &sb) == 0) {
>  			ret = unlink(path);
>  			if (ret != 0) {
>  				ERR(sh, "Error while removing cached
> CIL file %s: %s", path, strerror(errno));
