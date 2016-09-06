Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
Date: Tue, 6 Sep 2016 15:13:17 -0400
MIME-Version: 1.0
In-Reply-To: <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/06/2016 09:48 AM, Gary Tierney wrote:
> Removes the "system_u" and "s0" string literals from refpolicy and
> replaces the seuser and range in each homedir, uid, and username context
> specification for every user.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  libsemanage/src/genhomedircon.c | 79 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index cce3884..cca97f6 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -20,6 +20,7 @@
>   *  02110-1301  USA
>   */
>  
> +#include <selinux/context.h>

I think we likely want to use the sepol/context_record.h (already
included here) functions instead.  Those are already in use by
libsemanage.  I agree it is confusing and not helped by the fact that we
lack man pages for most sepol functions.  Sorry.


>  #include <semanage/handle.h>
>  #include <semanage/seusers_policy.h>
>  #include <semanage/users_policy.h>
> @@ -82,9 +83,6 @@
>  #define TEMPLATE_USERNAME "%{USERNAME}"
>  #define TEMPLATE_USERID "%{USERID}"
>  
> -#define TEMPLATE_SEUSER "system_u"
> -#define TEMPLATE_LEVEL "s0"
> -
>  #define FALLBACK_SENAME "user_u"
>  #define FALLBACK_PREFIX "user"
>  #define FALLBACK_LEVEL "s0"
> @@ -92,6 +90,8 @@
>  #define FALLBACK_UIDGID "[0-9]+"
>  #define DEFAULT_LOGIN "__default__"
>  
> +#define CONTEXT_NONE "<<none>>"
> +
>  typedef struct user_entry {
>  	char *name;
>  	char *uid;
> @@ -599,14 +599,72 @@ static int write_replacements(genhomedircon_settings_t * s, FILE * out,
>  	return STATUS_ERR;
>  }
>  
> +static int write_user_replacements(genhomedircon_settings_t *s, FILE *out,
> +			  semanage_list_t *tpl, const replacement_pair_t *repl,
> +			  const genhomedircon_user_entry_t *user)
> +{
> +	Ustr *line = USTR_NULL;
> +	context_t context = NULL;
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
> +			if (check_line(s, line) &&
> +			    !ustr_io_putfileline(&line, out)) {
> +				goto fail;
> +			}
> +
> +			continue;
> +		}
> +
> +		context = context_new(old_context_str);

sepol_context_from_string()

> +		if (!context) {
> +			goto fail;
> +		}
> +
> +		if (context_user_set(context, user->sename) != 0 ||

sepol_context_set_user()

> +		    context_range_set(context, user->level) != 0) {

sepol_context_set_mls()

> +			goto fail;
> +		}
> +
> +		const char *new_context_str = context_str(context);

sepol_context_to_string()

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
> +		context_free(context);

sepol_context_free()

> +	}
> +
> +	return STATUS_SUCCESS;
> +fail:
> +	ustr_sc_free(&line);
> +	context_free(context);
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
> @@ -618,7 +676,7 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
>  			return STATUS_ERR;
>  	}
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_user_replacements(s, out, tpl, repl, user);
>  }
>  
>  static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
> @@ -640,11 +698,10 @@ static int write_username_context(genhomedircon_settings_t * s, FILE * out,
>  		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
>  		{.search_for = TEMPLATE_USERID,.replace_with = user->uid},
>  		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
> -		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
>  		{NULL, NULL}
>  	};
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_user_replacements(s, out, tpl, repl, user);
>  }
>  
>  static int write_user_context(genhomedircon_settings_t * s, FILE * out,
> @@ -653,11 +710,10 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
>  	replacement_pair_t repl[] = {
>  		{.search_for = TEMPLATE_USER,.replace_with = user->name},
>  		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
> -		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
>  		{NULL, NULL}
>  	};
>  
> -	return write_replacements(s, out, tpl, repl);
> +	return write_user_replacements(s, out, tpl, repl, user);
>  }
>  
>  static int seuser_sort_func(const void *arg1, const void *arg2)
> @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
>  		if (strcmp(name, DEFAULT_LOGIN) == 0)
>  			continue;
>  
> -		if (strcmp(name, TEMPLATE_SEUSER) == 0)
> -			continue;
> -

This yields a warning/error on Fedora:
$ sudo semodule -B
libsemanage.add_user: user system_u not in password file

And I end up with a slightly different file_contexts.homedirs:
@@ -39,7 +39,6 @@
 /home/[^/]+/\.xauth.*	--	unconfined_u:object_r:xauth_home_t:s0
 /home/[^/]+/\.Xauth.*	--	unconfined_u:object_r:xauth_home_t:s0
 /home/[^/]+/\.local.*	unconfined_u:object_r:gconf_home_t:s0
-/home/[^/]+/\.gvfs/.*	<<none>>
 /home/[^/]+/\.cache(/.*)?	unconfined_u:object_r:cache_home_t:s0
 /home/[^/]+/\.gnupg(/.+)?	unconfined_u:object_r:gpg_secret_t:s0
 /home/[^/]+/\.irssi(/.*)?	unconfined_u:object_r:irc_home_t:s0
@@ -51,7 +50,6 @@
 /home/[^/]+/\.pyzor(/.*)?	unconfined_u:object_r:spamc_home_t:s0
 /home/[^/]+/\.razor(/.*)?	unconfined_u:object_r:spamc_home_t:s0
 /home/[^/]+/\.spamd(/.*)?	unconfined_u:object_r:spamc_home_t:s0
-/home/[^/]+/\.debug(/.*)?	<<none>>
 /home/[^/]+/vmware(/.*)?	unconfined_u:object_r:vmware_file_t:s0
 /home/[^/]+/\.fonts(/.*)?	unconfined_u:object_r:user_fonts_t:s0
 /home/[^/]+/\.gconf(d)?(/.*)?	unconfined_u:object_r:gconf_home_t:s0

The homedir_template has:
...
HOME_DIR/\.gvfs/.*      <<none>>
HOME_DIR/\.cache(/.*)?  system_u:object_r:cache_home_t:s0
HOME_DIR/\.gnupg(/.+)?  system_u:object_r:gpg_secret_t:s0
HOME_DIR/\.irssi(/.*)?  system_u:object_r:irc_home_t:s0
HOME_DIR/irclog(/.*)?   system_u:object_r:irc_home_t:s0
HOME_DIR/\.adobe(/.*)?  system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.gnash(/.*)?  system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.webex(/.*)?  system_u:object_r:mozilla_home_t:s0
HOME_DIR/\.pulse(/.*)?  system_u:object_r:pulseaudio_home_t:s0
HOME_DIR/\.pyzor(/.*)?  system_u:object_r:spamc_home_t:s0
HOME_DIR/\.razor(/.*)?  system_u:object_r:spamc_home_t:s0
HOME_DIR/\.spamd(/.*)?  system_u:object_r:spamc_home_t:s0
HOME_DIR/\.debug(/.*)?  <<none>>
...


>  		/* find the user structure given the name */
>  		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
>  			    (int (*)(const void *, const void *))
> 
