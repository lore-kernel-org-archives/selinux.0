Message-ID: <1482162379.28570.29.camel@tycho.nsa.gov>
Subject: Re: [PATCH 4/7] libsemanage: simplify string utilities functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 19 Dec 2016 10:46:19 -0500
In-Reply-To: <20161219130404.11496-5-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
 <20161219130404.11496-5-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 14:04 +0100, Nicolas Iooss wrote:
> Use string functions from C standard library instead of ustr. This
> makes
> the code simpler and make utilities.c no longer depend on ustr
> library.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/utilities.c | 64 +++++++++++++--------------------
> ------------
>  1 file changed, 18 insertions(+), 46 deletions(-)
> 
> diff --git a/libsemanage/src/utilities.c
> b/libsemanage/src/utilities.c
> index f48ffa489d14..b5b92b085310 100644
> --- a/libsemanage/src/utilities.c
> +++ b/libsemanage/src/utilities.c
> @@ -26,7 +26,6 @@
>  #include <string.h>
>  #include <sys/types.h>
>  #include <assert.h>
> -#include <ustr.h>
>  
>  #define TRUE 1
>  #define FALSE 0
> @@ -74,64 +73,37 @@ char *semanage_split_on_space(const char *str)
>  {
>  	/* as per the man page, these are the isspace() chars */
>  	const char *seps = "\f\n\r\t\v ";
> -	size_t slen = strlen(seps);
> -	size_t off = 0, rside_len = 0;
> -	char *retval = NULL;
> -	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
> +	size_t off = 0;
>  
>  	if (!str)
> -		goto done;
> -	if (!(ustr = ustr_dup_cstr(str)))
> -		goto done;
> -	temp =
> -	    ustr_split_spn_chrs(ustr, &off, seps, slen, USTR_NULL,
> -				USTR_FLAG_SPLIT_DEF);
> -	if (!temp)
> -		goto done;
> -	/* throw away the left hand side */
> -	ustr_sc_free(&temp);
> -
> -	rside_len = ustr_len(ustr) - off;
> -	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
> -	if (!temp)
> -		goto done;
> -	retval = strdup(ustr_cstr(temp));
> -	ustr_sc_free(&temp);
> +		return NULL;
>  
> -      done:
> -	ustr_sc_free(&ustr);
> -	return retval;
> +	/* skip one token and the spaces before and after it */
> +	off = strspn(str, seps);
> +	off += strcspn(str + off, seps);
> +	off += strspn(str + off, seps);
> +	return strdup(str + off);
>  }
>  
>  char *semanage_split(const char *str, const char *delim)
>  {
> -	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
> -	size_t off = 0, rside_len = 0;
> -	char *retval = NULL;
> +	char *retval;
> +	size_t delim_len;
>  
>  	if (!str)
> -		goto done;
> +		return NULL;
>  	if (!delim || !(*delim))
>  		return semanage_split_on_space(str);
> -	ustr = ustr_dup_cstr(str);
> -	temp =
> -	    ustr_split_cstr(ustr, &off, delim, USTR_NULL,
> USTR_FLAG_SPLIT_DEF);
> -	if (!temp)
> -		goto done;
> -	/* throw away the left hand side */
> -	ustr_sc_free(&temp);
> -
> -	rside_len = ustr_len(ustr) - off;
>  
> -	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
> -	if (!temp)
> -		goto done;
> -	retval = strdup(ustr_cstr(temp));
> -	ustr_sc_free(&temp);
> +	retval = strstr(str, delim);
> +	if (retval == NULL)
> +		return NULL;
>  
> -      done:
> -	ustr_sc_free(&ustr);
> -	return retval;
> +	delim_len = strlen(delim);
> +	do {
> +		retval += delim_len;
> +	} while (!strncmp(retval, delim, delim_len));

This seems unnecessarily complicated.  Do we expect this to ever be
called on a string containing repeating instances of the delimeter?

> +	return strdup(retval);
>  }
>  
>  int semanage_list_push(semanage_list_t ** list, const char *data)
