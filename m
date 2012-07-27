Message-ID: <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over
 system_data_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Fri, 27 Jul 2012 14:37:38 -0400
In-Reply-To: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 11:34 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/app.te b/app.te
> index 85de816..dca2e0c 100644
> --- a/app.te
> +++ b/app.te
> @@ -83,6 +83,8 @@ allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_
>  # App sdcard file accesses
>  allow platformappdomain sdcard:dir create_dir_perms;
>  allow platformappdomain sdcard:file create_file_perms;
> +# System data file accesses XXX????
> +allow platformappdomain system_data_file:file open;
>  
>  #
>  # Untrusted apps.

Need to know more about the denial to diagnose.
Also, enabling syscall audit may help with getting full pathnames,
although you likely need the ARM audit patches for that.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
