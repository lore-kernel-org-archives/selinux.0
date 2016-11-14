Subject: Re: [PATCH] libsepol: fix checkpolicy dontaudit compiler bug
To: selinux@tycho.nsa.gov
References: <1479139145-32596-1-git-send-email-sds@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a17a65be-21d6-8cad-047f-39fd9f11330d@tycho.nsa.gov>
Date: Mon, 14 Nov 2016 11:07:20 -0500
MIME-Version: 1.0
In-Reply-To: <1479139145-32596-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2016 10:59 AM, Stephen Smalley wrote:
> The combining logic for dontaudit rules was wrong, causing
> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
> rule.
> 
> Reported-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Sorry, that's not correct either.  NAKing my own patch.

> ---
>  libsepol/src/expand.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 004a029..cdfb792 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1850,10 +1850,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>  			 */
>  			avdatump->data &= cur->data;
>  		} else if (specified & AVRULE_DONTAUDIT) {
> -			if (avdatump->data)
> -				avdatump->data &= ~cur->data;
> -			else
> -				avdatump->data = ~cur->data;
> +			avdatump->data &= ~cur->data;
>  		} else if (specified & AVRULE_XPERMS) {
>  			xperms = avdatump->xperms;
>  			if (!xperms) {
> 
