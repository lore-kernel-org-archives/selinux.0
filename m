Subject: Re: [PATCH v4 7/7] genhomedircon: fix FALLBACK_NAME regex
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
 <1462003092-4611-8-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fbe149b9-3af4-8285-770e-0bf25cb0bc53@tycho.nsa.gov>
Date: Mon, 2 May 2016 08:46:13 -0400
MIME-Version: 1.0
In-Reply-To: <1462003092-4611-8-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/30/2016 03:58 AM, Jason Zaman wrote:
> Originally the fallback regex for the username was either ".*" or
> "[^/]*". The second is more correct but still can match nothing.
> changing the * to + means that it must match at least one character.
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied the entire series.

> ---
>  libsemanage/src/genhomedircon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 6c6eaef..c5ea436 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -86,7 +86,7 @@
>  #define FALLBACK_SENAME "user_u"
>  #define FALLBACK_PREFIX "user"
>  #define FALLBACK_LEVEL "s0"
> -#define FALLBACK_NAME ".*"
> +#define FALLBACK_NAME "[^/]+"
>  #define FALLBACK_UIDGID "[0-9]+"
>  #define DEFAULT_LOGIN "__default__"
>  
> @@ -1024,7 +1024,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
>  		for (h = homedirs; h; h = h->next) {
>  			Ustr *temp = ustr_dup_cstr(h->data);
>  
> -			if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
> +			if (!temp || !ustr_add_cstr(&temp, "/" FALLBACK_NAME)) {
>  				ustr_sc_free(&temp);
>  				retval = STATUS_ERR;
>  				goto done;
> 
