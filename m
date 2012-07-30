Message-ID: <1343650601.2346.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] Appdomain write to cgroup on android_cts enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 08:16:41 -0400
In-Reply-To: <1343429484-6978-1-git-send-email-hqjiang1988@gmail.com>
References: <1343429484-6978-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:51 -0700, Haiqing Jiang wrote:
> ---
>  cts.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/cts.te b/cts.te
> index ff8a9f0..7877b19 100644
> --- a/cts.te
> +++ b/cts.te
> @@ -31,6 +31,9 @@ allow appdomain system_file:file rx_file_perms;
>  allow appdomain apk_tmp_file:file rw_file_perms;
>  allow appdomain shell_data_file:file r_file_perms;
>  
> +# Write to cgroup
> +allow appdomain cgroup:dir write;

Likely should get merged into domain.te rule for cgroup:dir.
Future work: Investigate finer-grained labeling for kernel cgroup pseudo
filesystem (requires kernel modifications), and use it to only allow
access to specific cgroup subdirectory.

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
