To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180306115808.17470-1-vmojzis@redhat.com>
 <20180306115808.17470-4-vmojzis@redhat.com>
 <6fea57bc-4f8a-04e6-a3f8-f9a855bdd4fe@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <129578f3-5191-dde4-1601-aa67842bbc92@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 15:24:02 -0500
MIME-Version: 1.0
In-Reply-To: <6fea57bc-4f8a-04e6-a3f8-f9a855bdd4fe@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 3/3] libsemanage: replace access() checks to make setuid
 programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/07/2018 09:59 AM, Stephen Smalley wrote:
> On 03/06/2018 06:58 AM, Vit Mojzis wrote:
>> access() uses real UID instead of effective UID which causes false
>> negative checks in setuid programs.
>> Replace access(,F_OK) (i.e. tests for file existence) by stat().
>> And access(,R_OK) by fopen(,"r")

Also, in addition to fixing the code, please update the patch description since the last line is no longer accurate.

>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c     | 133 +++++++++++++++++++++++++--------------
>>  libsemanage/src/semanage_store.c |  16 ++++-
>>  2 files changed, 99 insertions(+), 50 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index 49cac14f..4e2af810 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -140,6 +140,7 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
>>  int semanage_direct_connect(semanage_handle_t * sh)
>>  {
>>  	const char *path;
>> +	struct stat sb;
>>  
>>  	if (semanage_check_init(sh, sh->conf->store_root_path))
>>  		goto err;
>> @@ -302,10 +303,16 @@ int semanage_direct_connect(semanage_handle_t * sh)
>>  
>>  	/* set the disable dontaudit value */
>>  	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
>> -	if (access(path, F_OK) == 0)
>> +
>> +	if (stat(path, &sb) == 0)
>>  		sepol_set_disable_dontaudit(sh->sepolh, 1);
>> -	else
>> +	else if (errno == ENOENT) {
>> +		/* The file does not exist */
>>  		sepol_set_disable_dontaudit(sh->sepolh, 0);
>> +	} else {
>> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +		goto err;
>> +	}
>>  
>>  	return STATUS_SUCCESS;
>>  
>> @@ -1139,6 +1146,7 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
>>  	int status = 0;
>>  	int i;
>>  	char cil_path[PATH_MAX];
>> +	struct stat sb;
>>  
>>  	assert(sh);
>>  	assert(modinfos);
>> @@ -1155,9 +1163,13 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
>>  		}
>>  
>>  		if (semanage_get_ignore_module_cache(sh) == 0 &&
>> -				access(cil_path, F_OK) == 0) {
>> +				(status = stat(cil_path, &sb)) == 0) {
>>  			continue;
>>  		}
>> +		if (status != 0 && errno != ENOENT) {
>> +			ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
>> +			goto cleanup; //an error in the "stat" call
>> +		}
>>  
>>  		status = semanage_compile_module(sh, &modinfos[i]);
>>  		if (status < 0) {
>> @@ -1196,6 +1208,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>  	struct cil_db *cildb = NULL;
>>  	semanage_module_info_t *modinfos = NULL;
>>  	mode_t mask = umask(0077);
>> +	struct stat sb;
>>  
>>  	int do_rebuild, do_write_kernel, do_install;
>>  	int fcontexts_modified, ports_modified, seusers_modified,
>> @@ -1234,10 +1247,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>  
>>  	/* Create or remove the disable_dontaudit flag file. */
>>  	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
>> -	if (access(path, F_OK) == 0)
>> +	if (stat(path, &sb) == 0)
>>  		do_rebuild |= !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
>> -	else
>> +	else if (errno == ENOENT) {
>> +		/* The file does not exist */
>>  		do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
>> +	} else {
>> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> 
> We need to ensure that retval is set in all of these cases.  Safest to always set it before goto cleanup,
> either explicitly to -1 or to return value of stat() call above.
> 
>> +		goto cleanup;
>> +	}
>>  	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
>>  		FILE *touch;
>>  		touch = fopen(path, "w");
>> @@ -1259,10 +1277,16 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>  
>>  	/* Create or remove the preserve_tunables flag file. */
>>  	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
>> -	if (access(path, F_OK) == 0)
>> +	if (stat(path, &sb) == 0)
>>  		do_rebuild |= !(sepol_get_preserve_tunables(sh->sepolh) == 1);
>> -	else
>> +	else if (errno == ENOENT) {
>> +		/* The file does not exist */
>>  		do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
>> +	} else {
>> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +		goto cleanup;
>> +	}
> 
> Ditto
> 
>> +
>>  	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
>>  		FILE *touch;
>>  		touch = fopen(path, "w");
>> @@ -1299,40 +1323,24 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>  	 * a rebuild.
>>  	 */
>>  	if (!do_rebuild) {
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> -		}
>> -
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> -		}
>> -
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> -		}
>> -
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> -		}
>> -
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> -		}
>> +		int files[] = {SEMANAGE_STORE_KERNEL,
>> +					   SEMANAGE_STORE_FC,
>> +					   SEMANAGE_STORE_SEUSERS,
>> +					   SEMANAGE_LINKED,
>> +					   SEMANAGE_SEUSERS_LINKED,
>> +					   SEMANAGE_USERS_EXTRA_LINKED};
>> +
>> +		for (i = 0; i < (int) sizeof(files); i++) {
>> +			path = semanage_path(SEMANAGE_TMP, files[i]);
>> +			if (stat(path, &sb) != 0) {
>> +				if (errno != ENOENT) {
>> +					ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +					goto cleanup;
> 
> Ditto
> 
>> +				}
>>  
>> -		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> -			do_rebuild = 1;
>> -			goto rebuild;
>> +				do_rebuild = 1;
>> +				goto rebuild;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -1465,7 +1473,7 @@ rebuild:
>>  			goto cleanup;
>>  
>>  		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
>> -		if (access(path, F_OK) == 0) {
>> +		if (stat(path, &sb) == 0) {
>>  			retval = semanage_copy_file(path,
>>  						    semanage_path(SEMANAGE_TMP,
>>  								  SEMANAGE_STORE_SEUSERS),
>> @@ -1473,12 +1481,18 @@ rebuild:
>>  			if (retval < 0)
>>  				goto cleanup;
>>  			pseusers->dtable->drop_cache(pseusers->dbase);
>> -		} else {
>> +		} else if (errno == ENOENT) {
>> +			/* The file does not exist */
>>  			pseusers->dtable->clear(sh, pseusers->dbase);
>> +		} else {
>> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +			goto cleanup;
> 
> Ditto
> 
>>  		}
>>  
>> +
>> +
>>  		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
>> -		if (access(path, F_OK) == 0) {
>> +		if (stat(path, &sb) == 0) {
>>  			retval = semanage_copy_file(path,
>>  						    semanage_path(SEMANAGE_TMP,
>>  								  SEMANAGE_USERS_EXTRA),
>> @@ -1486,8 +1500,12 @@ rebuild:
>>  			if (retval < 0)
>>  				goto cleanup;
>>  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
>> -		} else {
>> +		} else if (errno == ENOENT) {
>> +			/* The file does not exist */
>>  			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
>> +		} else {
>> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +			goto cleanup;
> 
> Ditto
> 
>>  		}
>>  	}
>>  
>> @@ -1817,6 +1835,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>  	ssize_t _data_len;
>>  	char *_data;
>>  	int compressed;
>> +	struct stat sb;
>>  
>>  	/* get path of module */
>>  	rc = semanage_module_get_path(
>> @@ -1829,8 +1848,8 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>  		goto cleanup;
>>  	}
>>  
>> -	if (access(module_path, F_OK) != 0) {
>> -		ERR(sh, "Module does not exist: %s", module_path);
>> +	if (stat(module_path, &sb) != 0) {
>> +		ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
>>  		rc = -1;
>>  		goto cleanup;
>>  	}
>> @@ -1859,7 +1878,12 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>  		goto cleanup;
>>  	}
>>  
>> -	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && access(input_file, F_OK) != 0) {
>> +	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && stat(input_file, &sb) != 0) {
>> +		if (errno != ENOENT) {
>> +			ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
> 
> Ditto
> 
>> +			goto cleanup;
>> +	
>> +
>>  		rc = semanage_compile_module(sh, _modinfo);
>>  		if (rc < 0) {
>>  			goto cleanup;
>> @@ -2004,6 +2028,12 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
>>  	}
>>  
>>  	if (stat(path, &sb) < 0) {
>> +		if (errno != ENOENT) {
>> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +			status = -1;
>> +			goto cleanup;
>> +		}
>> +
>>  		*enabled = 1;
>>  	}
>>  	else {
>> @@ -2330,6 +2360,12 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
>>  
>>  	/* set enabled/disabled status */
>>  	if (stat(fn, &sb) < 0) {
>> +		if (errno != ENOENT) {
>> +			ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
>> +			status = -1;
>> +			goto cleanup;
>> +		}
>> +
>>  		ret = semanage_module_info_set_enabled(sh, *modinfo, 1);
>>  		if (ret != 0) {
>>  			status = -1;
>> @@ -2738,6 +2774,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>>  	int status = 0;
>>  	int ret = 0;
>>  	int type;
>> +	struct stat sb;
>>  
>>  	char path[PATH_MAX];
>>  	mode_t mask = umask(0077);
>> @@ -2838,7 +2875,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>>  			goto cleanup;
>>  		}
>>  
>> -		if (access(path, F_OK) == 0) {
>> +		if (stat(path, &sb) == 0) {
>>  			ret = unlink(path);
>>  			if (ret != 0) {
>>  				ERR(sh, "Error while removing cached CIL file %s: %s", path, strerror(errno));
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index 4bd1d651..10f8b306 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -514,6 +514,7 @@ char *semanage_conf_path(void)
>>  {
>>  	char *semanage_conf = NULL;
>>  	int len;
>> +	struct stat sb;
>>  
>>  	len = strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEMANAGE_CONF_FILE);
>>  	semanage_conf = calloc(len + 1, sizeof(char));
>> @@ -522,7 +523,12 @@ char *semanage_conf_path(void)
>>  	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_path(),
>>  		 SEMANAGE_CONF_FILE);
>>  
>> -	if (access(semanage_conf, R_OK) != 0) {
>> +	if (stat(semanage_conf, &sb) != 0) {
>> +		if (errno != ENOENT) {
>> +			/* semanage_conf exists but can't be accessed */
>> +			return NULL;
> 
> Not sure this is what we want. I think we'd just return semanage_conf here, and then let the caller fail when it tries to access it, so that we get a useful error message with the pathname.
> 
>> +		}
>> +
>>  		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CONF_FILE);
>>  	}
>>  
>> @@ -1508,8 +1514,14 @@ int semanage_split_fc(semanage_handle_t * sh)
>>  static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
>>  
>>  	int r;
>> +	struct stat sb;
>> +
>> +	if (stat(path, &sb) < 0) {
>> +		if (errno != ENOENT) {
>> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +			return -1;
>> +		}
>>  
>> -	if (access(path, F_OK) != 0) {
>>  		return 0;
>>  	}
>>  
>>
> 
> 
