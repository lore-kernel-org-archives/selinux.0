Subject: Re: [PATCH v2 2/8] genhomedircon: move fallback user to
 genhomedircon_user_entry_t
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-3-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b8ccf4b3-15b0-d50c-be4b-20c30a1a3af4@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 12:54:44 -0400
MIME-Version: 1.0
In-Reply-To: <1461391499-20593-3-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/23/2016 02:04 AM, Jason Zaman wrote:
> The fallback user is used in all the write functions, making it use a
> struct allows us to have everything consistent between normal and
> fallback users.
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>

When you split a patch into a series, the goal is to ensure that the
code remains in a working state after each patch in the series.
Otherwise, git bisect will often find broken states in the future.
So, we have two options:
1. You can refactor this patch set so that it does compile after each
patch (currently breaks on this one at least).
2. I can squash them all into one logical change.

> ---
>  libsemanage/src/genhomedircon.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 09c2a10..1e35b7e 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -83,17 +83,6 @@
>  #define FALLBACK_USER_LEVEL "s0"
>  #define DEFAULT_LOGIN "__default__"
>  
> -typedef struct {
> -	const char *fcfilepath;
> -	int usepasswd;
> -	const char *homedir_template_path;
> -	char *fallback_user;
> -	char *fallback_user_prefix;
> -	char *fallback_user_level;
> -	semanage_handle_t *h_semanage;
> -	sepol_policydb_t *policydb;
> -} genhomedircon_settings_t;
> -
>  typedef struct user_entry {
>  	char *name;
>  	char *sename;
> @@ -104,6 +93,15 @@ typedef struct user_entry {
>  } genhomedircon_user_entry_t;
>  
>  typedef struct {
> +	const char *fcfilepath;
> +	int usepasswd;
> +	const char *homedir_template_path;
> +	genhomedircon_user_entry_t *fallback;
> +	semanage_handle_t *h_semanage;
> +	sepol_policydb_t *policydb;
> +} genhomedircon_settings_t;
> +
> +typedef struct {
>  	const char *search_for;
>  	const char *replace_with;
>  } replacement_pair_t;
> @@ -1046,10 +1044,16 @@ int semanage_genhomedircon(semanage_handle_t * sh,
>  	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
>  					   SEMANAGE_FC_HOMEDIRS);
>  
> -	s.fallback_user = strdup(FALLBACK_USER);
> -	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
> -	s.fallback_user_level = strdup(FALLBACK_USER_LEVEL);
> -	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL) {
> +	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
> +	if (s.fallback == NULL) {
> +		retval = STATUS_ERR;
> +		goto done;
> +	}
> +
> +	s.fallback->sename = strdup(FALLBACK_USER);
> +	s.fallback->prefix = strdup(FALLBACK_USER_PREFIX);
> +	s.fallback->level = strdup(FALLBACK_USER_LEVEL);
> +	if (s.fallback->sename == NULL || s.fallback->prefix == NULL || s.fallback->level == NULL) {
>  		retval = STATUS_ERR;
>  		goto done;
>  	}
> @@ -1073,9 +1077,7 @@ done:
>  	if (out != NULL)
>  		fclose(out);
>  
> -	free(s.fallback_user);
> -	free(s.fallback_user_prefix);
> -	free(s.fallback_user_level);
> +	pop_user_entry(&(s.fallback));
>  	ignore_free();
>  
>  	return retval;
> 
