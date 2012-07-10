Message-ID: <1341926211.16964.6.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/2] SELinux: include definition of new capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Date: Tue, 10 Jul 2012 09:16:51 -0400
In-Reply-To: <1341598410-29965-1-git-send-email-eparis@redhat.com>
References: <1341598410-29965-1-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-06 at 14:13 -0400, Eric Paris wrote:
> The kernel has added CAP_WAKE_ALARM and CAP_EPOLLWAKEUP.  We need to
> define these in SELinux so they can be mediated by policy.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/include/classmap.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index b8c5372..0b04fd9 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -145,7 +145,9 @@ struct security_class_mapping secclass_map[] = {
>  	    "node_bind", "name_connect", NULL } },
>  	{ "memprotect", { "mmap_zero", NULL } },
>  	{ "peer", { "recv", NULL } },
> -	{ "capability2", { "mac_override", "mac_admin", "syslog", NULL } },
> +	{ "capability2",
> +	  { "mac_override", "mac_admin", "syslog", "wake_alarm", "epollwakeup",
> +	    NULL } },
>  	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
>  	{ "tun_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
