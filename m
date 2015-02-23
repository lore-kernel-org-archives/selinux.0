Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1NDL3im028652
 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2015 08:21:03 -0500
Message-ID: <54EB292D.9010904@tresys.com>
Date: Mon, 23 Feb 2015 08:20:45 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Chris PeBenito <cpebenito@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] Fix error path in mls_semantic_level_expand().
References: <1424617943-12541-1-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1424617943-12541-1-git-send-email-cpebenito@tresys.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/22/2015 10:12 AM, Chris PeBenito wrote:
> If the level contains a category that is not associated with a sensitivity,
> the code correctly detects the condition, but does not return an error.
> 
> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

Acked-by: Steve Lawrence <slawrence@tresys.com>

Thanks!

> ---
>  libsepol/src/expand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 467f7a7..3193ef5 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -914,10 +914,11 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
>  		}
>  		for (i = cat->low - 1; i < cat->high; i++) {
>  			if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
> -				ERR(h, "Category %s can not be associate with "
> +				ERR(h, "Category %s can not be associated with "
>  				    "level %s",
>  				    p->p_cat_val_to_name[i],
>  				    p->p_sens_val_to_name[l->sens - 1]);
> +				return -1;
>  			}
>  			if (ebitmap_set_bit(&l->cat, i, 1)) {
>  				ERR(h, "Out of memory!");
> 
