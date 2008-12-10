Subject: Re: [PATCH] SELinux: open perms on sockets, AF_UNIX
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, dwalsh@redhat.com
In-Reply-To: <1228865476.3737.13.camel@localhost.localdomain>
References: <1228865476.3737.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 08:33:58 -0500
Message-Id: <1228916038.23307.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-12-09 at 18:31 -0500, Eric Paris wrote:
> When I did open permissions I didn't think any sockets would have an open.
> Turns out AF_UNIX sockets can have an open when they are bound to the
> filesystem namespace.  This patch adds a new SOCK_FILE__OPEN permission.
> It's safe to add this as the open perms are already predicated on
> capabilities and capabilities means we have unknown perm handling so
> systems should be as backwards compatible as the policy wants them to
> be.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=475224
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
> This is pretty much untested (just compiled) as I can't get linux-next
> to boot. (i'm a bit scared to turn off the redzone overwrite detection
> that is killing it, but I'll try in the morning)  It should be obvious
> and safe.  This might be unwarrented, does anyone see a use in providing
> an open distinction on AF_UNIX sockets?  Are we happy with the socket
> perms that are already there?  Who thinks I should just silence the
> dmesg spam?
> 
>  security/selinux/hooks.c                     |    2 ++
>  security/selinux/include/av_perm_to_string.h |    2 ++
>  security/selinux/include/av_permissions.h    |    2 ++
>  3 files changed, 6 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 51e8c75..984f0af 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1800,6 +1800,8 @@ static inline u32 open_file_to_av(struct file *file)
>  			av |= FIFO_FILE__OPEN;
>  		else if (S_ISDIR(mode))
>  			av |= DIR__OPEN;
> +		else if (S_ISSOCK(mode))
> +			av |= SOCK_FILE__OPEN;
>  		else
>  			printk(KERN_ERR "SELinux: WARNING: inside %s with "
>  				"unknown mode:%o\n", __func__, mode);
> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> index c0c8854..31df1d7 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -24,6 +24,7 @@
>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
>     S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
>     S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
> +   S_(SECCLASS_SOCK_FILE, SOCK_FILE__OPEN, "open")
>     S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
>     S_(SECCLASS_FD, FD__USE, "use")
>     S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
> @@ -152,6 +153,7 @@
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
> +   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")

Unrelated diff?  Defined in refpolicy yet?

>     S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read")
>     S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write")
>     S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> index 0ba79fe..d645192 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -174,6 +174,7 @@
>  #define SOCK_FILE__SWAPON                         0x00004000UL
>  #define SOCK_FILE__QUOTAON                        0x00008000UL
>  #define SOCK_FILE__MOUNTON                        0x00010000UL
> +#define SOCK_FILE__OPEN                           0x00020000UL
>  #define FIFO_FILE__IOCTL                          0x00000001UL
>  #define FIFO_FILE__READ                           0x00000002UL
>  #define FIFO_FILE__WRITE                          0x00000004UL
> @@ -707,6 +708,7 @@
>  #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
>  #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
>  #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
> +#define NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT     0x04000000UL

Ditto.

>  #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
>  #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
>  #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
