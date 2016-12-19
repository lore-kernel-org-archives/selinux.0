Message-ID: <1482172359.28570.53.camel@tycho.nsa.gov>
Subject: Re: [PATCH 6/7] libsemanage: genhomedircon: drop ustr dependency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 19 Dec 2016 13:32:39 -0500
In-Reply-To: <20161219130404.11496-7-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
 <20161219130404.11496-7-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 14:04 +0100, Nicolas Iooss wrote:
> ustr library uses old (pre-C99) "extern inline" semantic. This makes
> it
> incompatible with recent versions of gcc and clang, which default to
> C99 standard. Distributions have shipped patched versions of this
> library to fix issues (e.g. Gentoo package uses this patch:
> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/ustr/files/us
> tr-1.0.4-gcc_5-
> check.patch?id=7dea6f8820f36bf389e6315044bea7507553bed0
> ) but there is no upstream solution to make ustr compatible with C99
> standard.
> 
> The git tree of ustr (http://www.and.org/ustr/ustr.git) has not been
> updated since 2008 and the developer of this project did not reply to
> emails.
> 
> Therefore update genhomedircon implementation in order to no longer
> rely on ustr library.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/genhomedircon.c | 137 +++++++++++++++++++-----------
> ----------
>  1 file changed, 66 insertions(+), 71 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c
> b/libsemanage/src/genhomedircon.c
> index 5e9d7224a06e..4b7352c8648a 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -239,46 +238,35 @@ static int fcontext_matches(const
> semanage_fcontext_t *fcontext, void *varg)
>  {
>  	const char *oexpr = semanage_fcontext_get_expr(fcontext);
>  	fc_match_handle_t *handp = varg;
> -	struct Ustr *expr;
> +	char *expr = NULL;
>  	regex_t re;
>  	int type, retval = -1;
> +	size_t len;
>  
>  	/* Only match ALL or DIR */
>  	type = semanage_fcontext_get_type(fcontext);
>  	if (type != SEMANAGE_FCONTEXT_ALL && type !=
> SEMANAGE_FCONTEXT_ALL)
>  		return 0;
>  
> -	/* Convert oexpr into a Ustr and anchor it at the beginning
> */
> -	expr = ustr_dup_cstr("^");
> -	if (expr == USTR_NULL)
> -		goto done;
> -	if (!ustr_add_cstr(&expr, oexpr))
> -		goto done;
> +	len = strlen(oexpr);
>  
>  	/* Strip off trailing ".+" or ".*" */
> -	if (ustr_cmp_suffix_cstr_eq(expr, ".+") ||
> -	    ustr_cmp_suffix_cstr_eq(expr, ".*")) {
> -		if (!ustr_del(&expr, 2))
> -			goto done;
> -	}
> +	if (len >= 2 && oexpr[len - 2] == '.' && strchr("+*",
> oexpr[len - 1]))
> +		len -= 2;
>  
>  	/* Strip off trailing "(/.*)?" */
> -	if (ustr_cmp_suffix_cstr_eq(expr, "(/.*)?")) {
> -		if (!ustr_del(&expr, 6))
> -			goto done;
> -	}
> +	if (len >= 6 && !strncmp(oexpr + len - 6, "(/.*)?", 6))
> +		len -= 2;

Should be len -= 6;
Maybe we should make this code less fragile, e.g. #define the
expressions and use sizeof(X)-1 for the lengths in the strncmp() and -=
statements, wrap it all up with a macro.

> @@ -523,44 +511,51 @@ static semanage_list_t
> *make_template(genhomedircon_settings_t * s,
>  	return template_data;
>  }
>  
> -static Ustr *replace_all(const char *str, const replacement_pair_t *
> repl)
> +static char *replace_all(const char *str, const replacement_pair_t *
> repl)
>  {
> -	Ustr *retval = USTR_NULL;
> +	char *retval, *retval2;
>  	int i;
>  
>  	if (!str || !repl)
> -		goto done;
> -	if (!(retval = ustr_dup_cstr(str)))
> -		goto done;
> +		return NULL;
>  
> -	for (i = 0; repl[i].search_for; i++) {
> -		ustr_replace_cstr(&retval, repl[i].search_for,
> -				  repl[i].replace_with, 0);
> +	retval = strdup(str);
> +	for (i = 0; retval != NULL && repl[i].search_for; i++) {
> +		retval2 = semanage_str_replace(repl[i].search_for,
> +					       repl[i].replace_with,
> retval, 0);
> +		free(retval);
> +		retval = retval2;
>  	}
> -	if (ustr_enomem(retval))
> -		ustr_sc_free(&retval);
> -
> -      done:
>  	return retval;
>  }
>  
> -static const char * extract_context(Ustr *line)
> +static const char *extract_context(const char *line)
>  {
> -	const char whitespace[] = " \t\n";
> -	size_t off, len;
> -
> -	/* check for trailing whitespace */
> -	off = ustr_spn_chrs_rev(line, 0, whitespace,
> strlen(whitespace));
> -
> -	/* find the length of the last field in line */
> -	len = ustr_cspn_chrs_rev(line, off, whitespace,
> strlen(whitespace));
> -
> -	if (len == 0)
> +	const char whitespace[] = {' ', '\t', '\n'};
> +	const char *p = line;
> +	size_t off;
> +
> +	off = strlen(p);
> +	p += off;
> +	/* consider trailing whitespaces */
> +	while (off > 0) {
> +		p -= 1;
> +		off -= 1;
> +		if (!memchr(whitespace, *p, sizeof(whitespace)))

if (!isspace(*p))

> +			break;
> +	}
> +	if (off == 0)
>  		return NULL;
> -	return ustr_cstr(line) + ustr_len(line) - (len + off);
> +
> +	/* find the last field in line */
> +	while (off > 0 && !memchr(whitespace, *(p - 1),
> sizeof(whitespace))) {

while (off > 0 && !isspace(*p))

> +		p -= 1;
> +		off -= 1;
> +	}
> +	return p;
>  }
