Message-ID: <1343049530.23118.20.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 2/3] external/sepolicy: install daemon link/unlink
 application data files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:18:50 -0400
In-Reply-To: <1342734563-32644-3-git-send-email-hqjiang1988@gmail.com>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	 <1342734563-32644-3-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> From: hqjiang <hqjiang1988@gmail.com>
> 
> ---
>  installd.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/installd.te b/installd.te
> index 466125e..5211f0a 100644
> --- a/installd.te
> +++ b/installd.te
> @@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;
>  selinux_check_context(installd)
>  # Read /seapp_contexts, presently on the rootfs.
>  allow installd rootfs:file r_file_perms;
> +# Link/Unlink app_data_file
> +allow installd app_data_file:lnk_file link_file_perms;

What actual permissions were required?  link (create a hard link)
doesn't make sense on a symlink (lnk_file).  unlink and rename are
legitimate, but wondering whether anything other than unlink was
required.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
