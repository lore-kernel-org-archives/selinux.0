Message-ID: <1343415170.17570.83.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] installd unlink platform_app_data_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Fri, 27 Jul 2012 14:52:50 -0400
In-Reply-To: <1343414653-3998-1-git-send-email-hqjiang1988@gmail.com>
References: <1343414653-3998-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 11:44 -0700, Haiqing Jiang wrote:
> ---
>  installd.te |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/installd.te b/installd.te
> index ce9122b..a2c7bb4 100644
> --- a/installd.te
> +++ b/installd.te
> @@ -20,5 +20,6 @@ dontaudit installd self:capability sys_admin;
>  selinux_check_context(installd)
>  # Read /seapp_contexts, presently on the rootfs.
>  allow installd rootfs:file r_file_perms;
> -# Unlink app_data_file
> +# Unlink app_data_file and platform_app_data_file
>  allow installd app_data_file:lnk_file unlink;
> +allow installd platform_app_data_file:lnk_file unlink;

Just add lnk_file to the earlier rule for data_file_type and drop these
two rules altogether.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
