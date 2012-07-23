Message-ID: <1343049740.23118.24.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/6] external/sepolicy: allow media_app more permissions
 on sdcard
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:22:20 -0400
In-Reply-To: <1342739276-1686-2-git-send-email-hqjiang1988@gmail.com>
References: <Hi, all>
	 <1342739276-1686-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/app.te b/app.te
> index 0866e95..a5ff295 100644
> --- a/app.te
> +++ b/app.te
> @@ -41,7 +41,7 @@ allow media_app cache_file:dir rw_dir_perms;
>  allow media_app cache_file:file create_file_perms;
>  # Access sdcard.
>  allow media_app sdcard:dir create_dir_perms;
> -allow media_app sdcard:file create_file_perms;
> +allow media_app sdcard:file { create_file_perms link_file_perms };
>  # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
>  allow media_app qtaguid_proc:file rw_file_perms;
>  allow media_app qtaguid_device:chr_file r_file_perms;

create_file_perms already contains link_file_perms, so this does
nothing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
