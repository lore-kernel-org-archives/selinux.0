Message-ID: <1342100148.8057.27.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Correct the denies of android.process.media when
 accessing to mtp_device
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Thu, 12 Jul 2012 09:35:48 -0400
In-Reply-To: <1342046389-9271-2-git-send-email-hqjiang1988@gmail.com>
References: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
	 <1342046389-9271-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 15:39 -0700, hqjiang wrote:
> ---
>  seapp_contexts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/seapp_contexts b/seapp_contexts
> index 502206a..1e98f91 100644
> --- a/seapp_contexts
> +++ b/seapp_contexts
> @@ -38,3 +38,4 @@ user=app_* seinfo=shared domain=shared_app levelFromUid=true
>  user=app_* seinfo=media domain=media_app levelFromUid=true
>  user=app_* seinfo=release domain=release_app levelFromUid=true
>  user=app_* seinfo=release name=com.android.browser domain=browser_app levelFromUid=true
> +user=app_* name=android.process.media domain=media_app levelFromUid=true

android.process.media was correctly labeled for us on the Xoom.  Need to
track down the real cause of the problem (if it persists after a
re-sync), not just hide it via configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
