Message-ID: <1343049803.23118.25.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 2/6] external/sepolicy: mediaserver open application
 data files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:23:23 -0400
In-Reply-To: <1342739276-1686-3-git-send-email-hqjiang1988@gmail.com>
References: <Hi, all>
	 <1342739276-1686-3-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> ---
>  mediaserver.te |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/mediaserver.te b/mediaserver.te
> index 057e39d..d3f0334 100644
> --- a/mediaserver.te
> +++ b/mediaserver.te
> @@ -25,6 +25,7 @@ allow mediaserver sysfs:file rw_file_perms;
>  # XXX Why?
>  allow mediaserver apk_data_file:file { read getattr };
>  allow mediaserver ion_device:chr_file rw_file_perms;
> +allow mediaserver app_data_file:file open;
>  
>  # To use remote processor
>  allow mediaserver rpmsg_device:chr_file rw_file_perms;

If this is required, then merge it into the existing allow rule for
app_data_file, at which point you can just use r_file_perms;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
