Message-ID: <1498164380.2134.13.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 2/2] genhomedircon: avoid use of non-standard
 `getpwent_r`
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Patrick Steinhardt <ps@pks.im>, selinux@tycho.nsa.gov
Date: Thu, 22 Jun 2017 16:46:20 -0400
In-Reply-To: <a5bcd8fbcc2f094e12c346bed9ef7733154525dd.1498124363.git.ps@pks.im>
References: <cover.1498124363.git.ps@pks.im>
 <a5bcd8fbcc2f094e12c346bed9ef7733154525dd.1498124363.git.ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-06-22 at 11:45 +0200, Patrick Steinhardt wrote:
> The `getpwent_r` function is a non-standard but reentrant version of
> the
> POSIX-defined `getpwent` function. While it should provide the
> benefit
> of being safe to use in multi-threaded environments, it disallows us
> from compiling with libc implementations which stick to the POSIX
> standard more closely.
> 
> As libsemanage may be used in a multi-threaded environment, being
> reentrant may in fact be quite important to us. As such, simply
> switching out `getpwent_r` against its non-reentrant function can
> prove
> quite dangerous. But interestingly enough, the glibc implementation
> of
> `getpwent_r` does not even guarantee being reentrant. Quoting from
> getpwent_r(7):
> 
>     NOTES
> 
>     The function getpwent_r() is not really reentrant since it shares
>     the reading position in the stream with all other threads.
> 
> As such, it is non-reentrant in the same sense as its simple
> `getpwent`
> brother and can simply be switched out without losing any guarantees
> here.

Thanks, both patches applied.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  libsemanage/src/genhomedircon.c | 34 +++++++----------------------
> -----
>  1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c
> b/libsemanage/src/genhomedircon.c
> index e8c95ee4..b9a74b73 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -290,14 +290,11 @@ static semanage_list_t
> *get_home_dirs(genhomedircon_settings_t * s)
>  	semanage_list_t *homedir_list = NULL;
>  	semanage_list_t *shells = NULL;
>  	fc_match_handle_t hand;
> -	char *rbuf = NULL;
>  	char *path = NULL;
> -	long rbuflen;
>  	uid_t temp, minuid = 500, maxuid = 60000;
>  	int minuid_set = 0;
> -	struct passwd pwstorage, *pwbuf;
> +	struct passwd *pwbuf;
>  	struct stat buf;
> -	int retval;
>  
>  	path = semanage_findval(PATH_ETC_USERADD, "HOME", "=");
>  	if (path && *path) {
> @@ -362,14 +359,9 @@ static semanage_list_t
> *get_home_dirs(genhomedircon_settings_t * s)
>  	free(path);
>  	path = NULL;
>  
> -	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> -	if (rbuflen <= 0)
> -		goto fail;
> -	rbuf = malloc(rbuflen);
> -	if (rbuf == NULL)
> -		goto fail;
> +	errno = 0;
>  	setpwent();
> -	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen,
> &pwbuf)) == 0) {
> +	while ((pwbuf = getpwent()) != NULL) {
>  		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid >
> maxuid)
>  			continue;
>  		if (!semanage_list_find(shells, pwbuf->pw_shell))
> @@ -411,9 +403,10 @@ static semanage_list_t
> *get_home_dirs(genhomedircon_settings_t * s)
>  		}
>  		free(path);
>  		path = NULL;
> +		errno = 0;
>  	}
>  
> -	if (retval && retval != ENOENT) {
> +	if (errno) {
>  		WARN(s->h_semanage, "Error while fetching users.  "
>  		     "Returning list so far.");
>  	}
> @@ -422,14 +415,12 @@ static semanage_list_t
> *get_home_dirs(genhomedircon_settings_t * s)
>  		goto fail;
>  
>  	endpwent();
> -	free(rbuf);
>  	semanage_list_destroy(&shells);
>  
>  	return homedir_list;
>  
>        fail:
>  	endpwent();
> -	free(rbuf);
>  	free(path);
>  	semanage_list_destroy(&homedir_list);
>  	semanage_list_destroy(&shells);
> @@ -1064,10 +1055,7 @@ static int
> get_group_users(genhomedircon_settings_t * s,
>  	long grbuflen;
>  	char *grbuf = NULL;
>  	struct group grstorage, *group = NULL;
> -
> -	long prbuflen;
> -	char *pwbuf = NULL;
> -	struct passwd pwstorage, *pw = NULL;
> +	struct passwd *pw = NULL;
>  
>  	grbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>  	if (grbuflen <= 0)
> @@ -1104,15 +1092,8 @@ static int
> get_group_users(genhomedircon_settings_t * s,
>  		}
>  	}
>  
> -	prbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> -	if (prbuflen <= 0)
> -		goto cleanup;
> -	pwbuf = malloc(prbuflen);
> -	if (pwbuf == NULL)
> -		goto cleanup;
> -
>  	setpwent();
> -	while ((retval = getpwent_r(&pwstorage, pwbuf, prbuflen,
> &pw)) == 0) {
> +	while ((pw = getpwent()) != NULL) {
>  		// skip users who also have this group as their
>  		// primary group
>  		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
> @@ -1131,7 +1112,6 @@ static int
> get_group_users(genhomedircon_settings_t * s,
>  	retval = STATUS_SUCCESS;
>  cleanup:
>  	endpwent();
> -	free(pwbuf);
>  	free(grbuf);
>  
>  	return retval;
