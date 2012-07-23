Message-ID: <1343050558.23118.35.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 6/6] external/sepolicy: android_cts test denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:35:58 -0400
In-Reply-To: <1342739276-1686-7-git-send-email-hqjiang1988@gmail.com>
References: <Hi, all>
	 <1342739276-1686-7-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> ---
>  cts.te |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/cts.te b/cts.te
> index 3600e94..08b770e 100644
> --- a/cts.te
> +++ b/cts.te
> @@ -39,4 +39,25 @@ dontaudit appdomain self:netlink_kobject_uevent_socket create;
>  
>  # Tries to override DAC restrictions but expects to fail.
>  dontaudit shell self:capability dac_override;
> +
> +# CTS test denials
> +# Allow CTS test apks access to apk_tmp_file and shell_data_file
> +allow appdomain apk_tmp_file:file rw_file_perms;
> +allow appdomain shell_data_file:file r_file_perms;

These are presently allowed to platform_app; maybe you should need to
assign platform_app to the CTS apps?

> +# Allow CTS test apks socket permissions (for testing networking functions (e.g., bluetooth))
> +allow untrusted_app self:socket { bind create setopt shutdown listen };

app_bluetooth boolean or use one of the other app domains.

> +# Allow CTS Test apks to access to app/system_data_file
> +allow appdomain app_data_file:file r_file_perms;

Already allowed, but not across MLS categories (and this won't help).

> +allow appdomain system_data_file:file { x_file_perms open };

app_ndk boolean

> +# android.permission test denies
> +allow appdomain block_device:lnk_file r_file_perms;

Try to generalize, e.g.
allow appdomain dev_type:lnk_file r_file_perms;
would cover all device type symlinks.

> +allow appdomain cgroup:dir w_file_perms;
> +allow appdomain media_app:lnk_file r_file_perms;

Should already be allowed by:
allow appdomain domain:{ file lnk_file } r_file_perms;
in cts.te.

> +allow appdomain radio_device:lnk_file r_file_perms;
> +allow appdomain untrusted_app:lnk_file r_file_perms;

Ditto.

> +allow appdomain zygote:netlink_selinux_socket getattr;
> +# android.security test deny
> +allow appdomain untrusted_app:netlink_route_socket { read bind create };
> +# android.util test deny
> +allow appdomain log_device:chr_file r_file_perms;
>  }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
