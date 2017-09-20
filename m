Message-ID: <1505939406.31597.12.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan.Zarsky.jzarsky@redhat.com, selinux@tycho.nsa.gov
Date: Wed, 20 Sep 2017 16:30:06 -0400
In-Reply-To: <20170913081642.7260-1-jzarsky@redhat.com>
References: <20170913081642.7260-1-jzarsky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] libsepol: fix memory leak in sepol_bool_query()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-09-13 at 10:16 +0200, Jan.Zarsky.jzarsky@redhat.com wrote:
> From: Jan Zarsky <jzarsky@redhat.com>
> 
> When sepol_bool_query() returns NULL response, variable name is not
> freed. Fix this by calling free() before returning.
> 
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>

Thanks, applied.

> ---
>  libsepol/src/booleans.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
> index c914a28..30fcf29 100644
> --- a/libsepol/src/booleans.c
> +++ b/libsepol/src/booleans.c
> @@ -155,6 +155,7 @@ int sepol_bool_query(sepol_handle_t * handle,
>  	booldatum = hashtab_search(policydb->p_bools.table, name);
>  	if (!booldatum) {
>  		*response = NULL;
> +		free(name);
>  		return STATUS_SUCCESS;
>  	}
>  
