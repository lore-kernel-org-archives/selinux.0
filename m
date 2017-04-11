Message-ID: <1491935926.14576.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH 6/6] libsepol: do not wrap integers when checking bound
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 11 Apr 2017 14:38:46 -0400
In-Reply-To: <20170407204431.8572-6-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
 <20170407204431.8572-6-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-07 at 22:44 +0200, Nicolas Iooss wrote:
> Some invalid policies might have p->p_types.nprim = 0. When parsing
> such a policy, "i > p->p_types.nprim - 1" is always false even though
> reading p->type_val_to_struct[i] triggers a segmentation fault.
> 
> Make type_set_expand() return an error when parsing such a policy by
> handling correctly when p->p_types.nprim is zero.
> 
> This issue has been found while fuzzing semodule_package with the
> American Fuzzy Lop.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied these six patches.

> ---
>  libsepol/src/expand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 315fc65cfd7e..54bf781d335f 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2527,7 +2527,7 @@ int type_set_expand(type_set_t * set, ebitmap_t
> * t, policydb_t * p,
>  				 * invalid policies might have more
> types set in the ebitmap than
>  				 * what's available in the
> type_val_to_struct mapping
>  				 */
> -				if (i > p->p_types.nprim - 1)
> +				if (i >= p->p_types.nprim)
>  					goto err_types;
>  
>  				if (!p->type_val_to_struct[i]) {
