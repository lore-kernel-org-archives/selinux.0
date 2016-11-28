Subject: Re: [PATCH 1/5] libsepol: do not modify p->p_roles.nprim in
 role_set_expand
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e02bdae2-167f-8bae-7f30-09d4fe7048b6@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 09:19:58 -0500
MIME-Version: 1.0
In-Reply-To: <20161123220646.23504-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2016 05:06 PM, Nicolas Iooss wrote:
> There is no reason to modify the number of roles defined in a policy
> when no role is being inserted.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/expand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 32df6f8b2ce6..7244e01fb50d 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2424,7 +2424,7 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
>  	ebitmap_init(r);
>  
>  	if (x->flags & ROLE_STAR) {
> -		for (i = 0; i < p->p_roles.nprim++; i++)
> +		for (i = 0; i < p->p_roles.nprim; i++)
>  			if (ebitmap_set_bit(r, i, 1))
>  				return -1;
>  		return 0;
> 
