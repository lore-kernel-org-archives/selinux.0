Message-ID: <1343049432.23118.19.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/3] external/sepolicy: the media apps from third-party
 are labeled with media_app instead of untrusted_app
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:17:12 -0400
In-Reply-To: <1342734563-32644-2-git-send-email-hqjiang1988@gmail.com>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	 <1342734563-32644-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> From: hqjiang <hqjiang1988@gmail.com>
> 
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

Wouldn't this allow an arbitrary third party app to run in media_app,
just by using android.process.media as its package name?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
