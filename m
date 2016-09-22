Subject: Re: [PATCH v2 1/1] genhomedircon: remove hardcoded refpolicy strings
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <1474501947-7314-1-git-send-email-gary.tierney@gmx.com>
 <1474501947-7314-2-git-send-email-gary.tierney@gmx.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0675c188-becd-d27c-7b3b-c392b1bd9510@tycho.nsa.gov>
Date: Thu, 22 Sep 2016 12:05:11 -0400
MIME-Version: 1.0
In-Reply-To: <1474501947-7314-2-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 07:52 PM, Gary Tierney wrote:
> Removes the "system_u" and "s0" string literals from refpolicy and
> replaces the seuser and range in each homedir, uid, and username context
> specification for every user.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>

Thanks, applied.

> ---
>  libsemanage/src/genhomedircon.c | 87 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 13 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index cce3884..3fc9e7a 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -82,9 +82,6 @@
>  #define TEMPLATE_USERNAME "%{USERNAME}"
>  #define TEMPLATE_USERID "%{USERID}"
>  
> -#define TEMPLATE_SEUSER "system_u"
> -#define TEMPLATE_LEVEL "s0"
> -
>  #define FALLBACK_SENAME "user_u"
>  #define FALLBACK_PREFIX "user"
>  #define FALLBACK_LEVEL "s0"
> @@ -92,6 +89,8 @@
>  #define FALLBACK_UIDGID "[0-9]+"
>  #define DEFAULT_LOGIN "__default__"
>  
> +#define CONTEXT_NONE "<<none>>"
> +
>  typedef struct user_entry {
>  	char *name;
>  	char *uid;
> @@ -599,14 +598,81 @@ static int write_replacements(genhomedircon_settings_t * s, FILE * out,
>  	return STATUS_ERR;
>  }
>  
> +static int write_contexts(genhomedircon_settings_t *s, FILE *out,
> +			  semanage_list_t *tpl, const replacement_pair_t *repl,
> +			  const genhomedircon_user_entry_t *user)
> +{
> +	Ustr *line = USTR_NULL;
> +	sepol_context_t *context = NULL;
> +	char *new_context_str = NULL;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		line = replace_all(tpl->data, repl);
> +		if (!line) {
> +			goto fail;
> +		}
> +
> +		const char *old_context_str = extract_context(line);
> +		if (!old_context_str) {
> +			goto fail;
> +		}
> +
> +		if (strcmp(old_context_str, CONTEXT_NONE) == 0) {
> +			if (check_line(s, line) == STATUS_SUCCESS &&
> +			    !ustr_io_putfileline(&line, out)) {
> +				goto fail;
> +			}
> +
> +			continue;
> +		}
> +
> +		sepol_handle_t *sepolh = s->h_semanage->sepolh;
> +
> +		if (sepol_context_from_string(sepolh, old_context_str,
> +					      &context) < 0) {
> +			goto fail;
> +		}
> +
> +		if (sepol_context_set_user(sepolh, context, user->sename) < 0 ||
> +		    sepol_context_set_mls(sepolh, context, user->level) < 0) {
> +			goto fail;
> +		}
> +
> +		if (sepol_context_to_string(sepolh, context,
> +					    &new_context_str) < 0) {
> +			goto fail;
> +		}
> +
> +		if (!ustr_replace_cstr(&line, old_context_str,
> +				       new_context_str, 1)) {
> +			goto fail;
> +		}
> +
> +		if (check_line(s, line) == STATUS_SUCCESS) {
> +			if (!ustr_io_putfileline(&line, out)) {
> +				goto fail;
> +			}
> +		}
> +
> +		ustr_sc_free(&line);
> +		sepol_context_free(context);
> +		free(new_context_str);
> +	}
> +
> +	return STATUS_SUCCESS;
> +fail:
> +	ustr_sc_free(&line);
> +	sepol_context_free(context);
> +	free(new_context_str);
> +	return STATUS_ERR;
> +}
> +
>  static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
>  				  semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
>  {
>  	replacement_pair_t repl[] = {
> -		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
>  		{.search_for = TEMPLATE_HOME_DIR,.replace_with = user->home},
>  		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
> -		{.search_for = TEMPLATE_LEVEL,.replace_with = user->level},
>  		{NULL, NULL}
>  	};
>  
> @@ -618,7 +684,7 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
>  			return STATUS_ERR;
>  	}
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_contexts(s, out, tpl, repl, user);
>  }
>  
>  static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
> @@ -640,11 +706,10 @@ static int write_username_context(genhomedircon_settings_t * s, FILE * out,
>  		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
>  		{.search_for = TEMPLATE_USERID,.replace_with = user->uid},
>  		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
> -		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
>  		{NULL, NULL}
>  	};
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_contexts(s, out, tpl, repl, user);
>  }
>  
>  static int write_user_context(genhomedircon_settings_t * s, FILE * out,
> @@ -653,11 +718,10 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
>  	replacement_pair_t repl[] = {
>  		{.search_for = TEMPLATE_USER,.replace_with = user->name},
>  		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
> -		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
>  		{NULL, NULL}
>  	};
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_contexts(s, out, tpl, repl, user);
>  }
>  
>  static int seuser_sort_func(const void *arg1, const void *arg2)
> @@ -1074,9 +1138,6 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
>  		if (strcmp(name, DEFAULT_LOGIN) == 0)
>  			continue;
>  
> -		if (strcmp(name, TEMPLATE_SEUSER) == 0)
> -			continue;
> -
>  		/* find the user structure given the name */
>  		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
>  			    (int (*)(const void *, const void *))
> 
