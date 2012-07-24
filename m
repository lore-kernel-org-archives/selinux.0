Message-ID: <1343135061.2383.27.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] external/sepolicy: mediaserver open application data
 files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Tue, 24 Jul 2012 09:04:21 -0400
In-Reply-To: <1343080975-25536-2-git-send-email-hqjiang1988@gmail.com>
References: <1343080975-25536-1-git-send-email-hqjiang1988@gmail.com>
	 <1343080975-25536-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-23 at 15:02 -0700, Haiqing Jiang wrote:
> ---
>  mediaserver.te |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.

> 
> diff --git a/mediaserver.te b/mediaserver.te
> index 057e39d..39618a5 100644
> --- a/mediaserver.te
> +++ b/mediaserver.te
> @@ -11,7 +11,7 @@ binder_call(mediaserver, binderservicedomain)
>  binder_call(mediaserver, appdomain)
>  binder_service(mediaserver)
>  allow mediaserver app_data_file:dir search;
> -allow mediaserver app_data_file:file { read getattr };
> +allow mediaserver app_data_file:file r_file_perms;
>  r_dir_file(mediaserver, sdcard)
>  allow mediaserver sdcard:file write;
>  allow mediaserver camera_device:chr_file rw_file_perms;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
