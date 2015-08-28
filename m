Subject: Re: [PATCH 1/3] libsepol: fix memory leak when destroying avtab
 containing extended avrules
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
 <1440788386-17637-2-git-send-email-slawrence@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55E0B77C.6000001@tycho.nsa.gov>
Date: Fri, 28 Aug 2015 15:33:16 -0400
MIME-Version: 1.0
In-Reply-To: <1440788386-17637-2-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/28/2015 02:59 PM, Steve Lawrence wrote:
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  libsepol/src/avtab.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 799b98f..a800416 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -309,6 +309,10 @@ void avtab_destroy(avtab_t * h)
>  	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		while (cur != NULL) {
> +			if (cur->key.specified & AVTAB_XPERMS) {
> +				free(cur->datum.xperms);
> +			}
> +			
>  			temp = cur;
>  			cur = cur->next;
>  			free(temp);
> 
