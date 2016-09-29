Subject: Re: [PATCH] libsepol: fix xperm mapping between avrule and avtab
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
References: <1475167105-16420-1-git-send-email-jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d2f7a452-764a-1c87-f11d-fdc09dceed3c@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 13:03:04 -0400
MIME-Version: 1.0
In-Reply-To: <1475167105-16420-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2016 12:38 PM, Jeff Vander Stoep wrote:
> Commit 915fa8f08f4f moves the xperm specified value directly from
> avrule to avtab. The mapping between them is currently the same,
> but may not always be. Instead these values should be mapped using
> values defined in av_extended_perms_t and avtab_extended_perms_t.
> 
> Fixes: 915fa8f08f4f ("checkpolicy: switch operations to extended perms")
> 
> Change-Id: Ic9f4031c9381b2ff6cc46043fb1602758ef4c224
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Thanks, applied.

> ---
>  libsepol/src/expand.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index e6d3ef1..004a029 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1855,20 +1855,31 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>  			else
>  				avdatump->data = ~cur->data;
>  		} else if (specified & AVRULE_XPERMS) {
> -			if (!avdatump->xperms) {
> +			xperms = avdatump->xperms;
> +			if (!xperms) {
>  				xperms = (avtab_extended_perms_t *)
>  					calloc(1, sizeof(avtab_extended_perms_t));
>  				if (!xperms) {
>  					ERR(handle, "Out of memory!");
>  					return -1;
>  				}
> -				node->datum.xperms = xperms;
> +				avdatump->xperms = xperms;
>  			}
> -			node->datum.xperms->specified = extended_perms->specified;
> -			node->datum.xperms->driver = extended_perms->driver;
>  
> +			switch (extended_perms->specified) {
> +			case AVRULE_XPERMS_IOCTLFUNCTION:
> +				xperms->specified = AVTAB_XPERMS_IOCTLFUNCTION;
> +				break;
> +			case AVRULE_XPERMS_IOCTLDRIVER:
> +				xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
> +				break;
> +			default:
> +				return -1;
> +			}
> +
> +			xperms->driver = extended_perms->driver;
>  			for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
> -				node->datum.xperms->perms[i] |= extended_perms->perms[i];
> +				xperms->perms[i] |= extended_perms->perms[i];
>  		} else {
>  			assert(0);	/* should never occur */
>  		}
> 
