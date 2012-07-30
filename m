Message-ID: <1343652922.2346.19.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] appdomain r/w apk_tmp_file and shell_data_file on
 android_cts enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 08:55:22 -0400
In-Reply-To: <1343427185-6377-1-git-send-email-hqjiang1988@gmail.com>
References: <1343427185-6377-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:13 -0700, Haiqing Jiang wrote:
> ---
>  cts.te |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Applied.  However, for each such denial, we need to consider whether
these should only be allowed for CTS purposes or whether they belong as
part of the base policy in general (and if the latter, whether they are
required for all app domains or just some of them).  

> diff --git a/cts.te b/cts.te
> index 3600e94..489be1a 100644
> --- a/cts.te
> +++ b/cts.te
> @@ -27,6 +27,10 @@ allow appdomain fs_type:dir_file_class_set getattr;
>  allow appdomain shell_exec:file rx_file_perms;
>  allow appdomain system_file:file rx_file_perms;
>  
> +# Accesses to apk_tmp_file and shell_data_file
> +allow appdomain apk_tmp_file:file rw_file_perms;
> +allow appdomain shell_data_file:file r_file_perms;
> +
>  # Read routing information.
>  allow netdomain self:netlink_route_socket { create read write nlmsg_read };
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
