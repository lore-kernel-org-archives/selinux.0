Subject: Re: [PATCH] SELinux: new permission between tty audit and audit
 socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sgrubb@redhat.com,
        tmraz@redhat.com
In-Reply-To: <1236278615.10235.5.camel@localhost.localdomain>
References: <1236278615.10235.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 Mar 2009 14:54:31 -0500
Message-Id: <1236282871.11138.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-03-05 at 13:43 -0500, Eric Paris wrote:
> New selinux permission to separate the ability to turn on tty auditing from
> the ability to set audit rules.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/include/av_perm_to_string.h |    1 +
>  security/selinux/include/av_permissions.h    |    1 +
>  security/selinux/nlmsgtab.c                  |    2 +-
>  3 files changed, 3 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> index c7531ee..31df1d7 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -153,6 +153,7 @@
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
> +   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")
>     S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read")
>     S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write")
>     S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> index 0b8f9b2..d645192 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -708,6 +708,7 @@
>  #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
>  #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
>  #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
> +#define NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT     0x04000000UL
>  #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
>  #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
>  #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 4ed7bab..c6875fd 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -113,7 +113,7 @@ static struct nlmsg_perm nlmsg_audit_perms[] =
>  	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
>  	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
>  	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
> -	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
> +	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT	},
>  };
>  
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
