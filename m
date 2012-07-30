Message-ID: <1343650449.2346.0.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] add read permission over dev_type to appdomain on
 android_cts enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 08:14:09 -0400
In-Reply-To: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
References: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:40 -0700, Haiqing Jiang wrote:
> ---
>  cts.te |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/cts.te b/cts.te
> index 489be1a..ff8a9f0 100644
> --- a/cts.te
> +++ b/cts.te
> @@ -20,7 +20,7 @@ allow appdomain file_type:dir r_dir_perms;
>  allow appdomain fs_type:dir r_dir_perms;
>  allow appdomain dev_type:dir r_dir_perms;
>  allow appdomain file_type:dir_file_class_set getattr;
> -allow appdomain dev_type:dir_file_class_set getattr;
> +allow appdomain dev_type:dir_file_class_set { getattr read };
>  allow appdomain fs_type:dir_file_class_set getattr;
>  
>  # Execute the shell or other system executables.

I don't think you want to allow all app domains to read all devices.
Nor should that be required even for CTS.  Which devices triggered
denials?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
