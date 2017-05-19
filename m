Subject: Re: [PATCH 3/3] libsemanage: replace access(, F_OK) checks to make
 setuid programs work
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1488219577.19819.19.camel@tycho.nsa.gov>
 <20170505124947.21392-1-vmojzis@redhat.com>
 <20170505124947.21392-4-vmojzis@redhat.com>
 <1494016356.5745.27.camel@tycho.nsa.gov>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <8db18f54-14e7-f51f-ec3c-0eaefa6c8bee@redhat.com>
Date: Fri, 19 May 2017 14:22:28 +0200
MIME-Version: 1.0
In-Reply-To: <1494016356.5745.27.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 5.5.2017 22:32, Stephen Smalley wrote:
> On Fri, 2017-05-05 at 14:49 +0200, Vit Mojzis wrote:
>> access() uses real UID instead of effective UID which causes false
>> negative checks in setuid programs.
>> Replace access(,F_OK) (i.e. tests for file existence) by stat().
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>   libsemanage/src/direct_api.c | 36 +++++++++++++++++++++-------------
>> --
>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c
>> b/libsemanage/src/direct_api.c
>> index 508277d..35ca1b0 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -272,7 +272,9 @@ int semanage_direct_connect(semanage_handle_t *
>> sh)
>>   
>>   	/* set the disable dontaudit value */
>>   	path = semanage_path(SEMANAGE_ACTIVE,
>> SEMANAGE_DISABLE_DONTAUDIT);
>> -	if (access(path, F_OK) == 0)
>> +
>> +	struct stat sb;
>> +	if (stat(path, &sb) == 0)
> Need to check errno as well to ensure that it is just ENOENT when
> stat() returns non-zero; anything else is an error.
Thank you for the feedback. I was trying to keep behavioral changes to a 
minimum. In case "access" call failed (it can encounter all the errors 
that "stat" can except for EOVERFLOW) the code assumed that the file 
doesn't exist and this patch preserves said behavior.
But if you think think that the calling function should fail instead, I 
can rework the patch.
>
> stat() can produce a SELinux getattr denial, whereas access(F_OK)
> doesn't perform any SELinux check beyond directory search access.
That is a fair point and I don't have a solution for it. However in my 
understanding the calling process should have the "getattr" access 
permission (and it should even be able to create the file in most cases).
>
>>   		sepol_set_disable_dontaudit(sh->sepolh, 1);
>>   	else
>>   		sepol_set_disable_dontaudit(sh->sepolh, 0);
>> @@ -1101,8 +1103,9 @@ static int
>> semanage_compile_hll_modules(semanage_handle_t *sh,
>>   			goto cleanup;
>>   		}
>>   
>> +		struct stat sb;
>>   		if (semanage_get_ignore_module_cache(sh) == 0 &&
>> -				access(cil_path, F_OK) == 0) {
>> +				stat(cil_path, &sb) == 0) {
>>   			continue;
>>   		}
>>   
>> @@ -1165,7 +1168,8 @@ static int
>> semanage_direct_commit(semanage_handle_t * sh)
>>   
>>   	/* Create or remove the disable_dontaudit flag file. */
>>   	path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_DISABLE_DONTAUDIT);
>> -	if (access(path, F_OK) == 0)
>> +	struct stat sb;
>> +	if (stat(path, &sb) == 0)
>>   		do_rebuild |= !(sepol_get_disable_dontaudit(sh-
>>> sepolh) == 1);
>>   	else
>>   		do_rebuild |= (sepol_get_disable_dontaudit(sh-
>>> sepolh) == 1);
>> @@ -1190,7 +1194,7 @@ static int
>> semanage_direct_commit(semanage_handle_t * sh)
>>   
>>   	/* Create or remove the preserve_tunables flag file. */
>>   	path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_PRESERVE_TUNABLES);
>> -	if (access(path, F_OK) == 0)
>> +	if (stat(path, &sb) == 0)
>>   		do_rebuild |= !(sepol_get_preserve_tunables(sh-
>>> sepolh) == 1);
>>   	else
>>   		do_rebuild |= (sepol_get_preserve_tunables(sh-
>>> sepolh) == 1);
>> @@ -1231,37 +1235,37 @@ static int
>> semanage_direct_commit(semanage_handle_t * sh)
>>   	 */
>>   	if (!do_rebuild) {
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_STORE_KERNEL);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_STORE_FC);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_STORE_SEUSERS);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_SEUSERS_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_USERS_EXTRA_LINKED);
>> -		if (access(path, F_OK) != 0) {
>> +		if (stat(path, &sb) != 0) {
>>   			do_rebuild = 1;
>>   			goto rebuild;
>>   		}
>> @@ -1395,7 +1399,7 @@ rebuild:
>>   			goto cleanup;
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_SEUSERS_LINKED);
>> -		if (access(path, F_OK) == 0) {
>> +		if (stat(path, &sb) == 0) {
>>   			retval = semanage_copy_file(path,
>>   						    semanage_path(SE
>> MANAGE_TMP,
>>   								  SE
>> MANAGE_STORE_SEUSERS),
>> @@ -1408,7 +1412,7 @@ rebuild:
>>   		}
>>   
>>   		path = semanage_path(SEMANAGE_TMP,
>> SEMANAGE_USERS_EXTRA_LINKED);
>> -		if (access(path, F_OK) == 0) {
>> +		if (stat(path, &sb) == 0) {
>>   			retval = semanage_copy_file(path,
>>   						    semanage_path(SE
>> MANAGE_TMP,
>>   								  SE
>> MANAGE_USERS_EXTRA),
>> @@ -1732,7 +1736,8 @@ static int
>> semanage_direct_extract(semanage_handle_t * sh,
>>   		goto cleanup;
>>   	}
>>   
>> -	if (access(module_path, F_OK) != 0) {
>> +	struct stat sb;
>> +	if (stat(module_path, &sb) != 0) {
>>   		ERR(sh, "Module does not exist: %s", module_path);
>>   		rc = -1;
>>   		goto cleanup;
>> @@ -1762,7 +1767,7 @@ static int
>> semanage_direct_extract(semanage_handle_t * sh,
>>   		goto cleanup;
>>   	}
>>   
>> -	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") &&
>> access(input_file, F_OK) != 0) {
>> +	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") &&
>> stat(input_file, &sb) != 0) {
>>   		rc = semanage_compile_module(sh, _modinfo);
>>   		if (rc < 0) {
>>   			goto cleanup;
>> @@ -2737,7 +2742,8 @@ static int
>> semanage_direct_install_info(semanage_handle_t *sh,
>>   			goto cleanup;
>>   		}
>>   
>> -		if (access(path, F_OK) == 0) {
>> +		struct stat sb;
>> +		if (stat(path, &sb) == 0) {
>>   			ret = unlink(path);
>>   			if (ret != 0) {
>>   				ERR(sh, "Error while removing cached
>> CIL file %s: %s", path, strerror(errno));
