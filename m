Message-ID: <1343135023.2383.25.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] external/sepolicy: install daemon unlink
 application data files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Tue, 24 Jul 2012 09:03:43 -0400
In-Reply-To: <1343064137-17849-2-git-send-email-hqjiang1988@gmail.com>
References: <1343064137-17849-1-git-send-email-hqjiang1988@gmail.com>
	 <1343064137-17849-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-23 at 10:22 -0700, Haiqing Jiang wrote:
> From: hqjiang <hqjiang1988@gmail.com>
> 
> ---
>  installd.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied.  However notice that you could have done this more generally by
using the data_file_type attribute or even combining into the earlier
rule, e.g.
-allow installd data_file_type:file { getattr unlink };
+allow installd data_file_type:{ file lnk_file } { getattr unlink };

> 
> diff --git a/installd.te b/installd.te
> index 466125e..ce9122b 100644
> --- a/installd.te
> +++ b/installd.te
> @@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;
>  selinux_check_context(installd)
>  # Read /seapp_contexts, presently on the rootfs.
>  allow installd rootfs:file r_file_perms;
> +# Unlink app_data_file
> +allow installd app_data_file:lnk_file unlink;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
