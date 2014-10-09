MIME-Version: 1.0
In-Reply-To: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
Date: Wed, 8 Oct 2014 21:01:04 -0400
Message-ID: <CADjGSjg0c7X2kY1_qUg4GgKtOnkmFkPsmEMDXxwmj7a-h+K+5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
From: Joshua Brindle <brindle@quarksecurity.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 8, 2014 at 8:41 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> First time poster to the list. I would appreciate feedback/suggestions
> regarding the following patch.
>
> This patch which provides SELinux control over network interface MAC
> addresses. This patch allows access to the MAC address to be controlled by
> policy. Network MAC addresses are a long lived unique device identifier, and
> a security policy may wish to control access to the identifier without
> further limiting network use, perhaps for privacy reasons.
>
> The existing SE Linux permissions are too coarse in that they only allow
> blanket read/no-read access to this socket ioctl. We would like to consider
> both the read/no-read permission as well as an additional permission that
> checks the ioctl cmd argument. This allows applications to continue
> accessing the IP address, netmask, etc, while being denied access to the MAC
> address.
>

If someone has another system on the same network they can just get
the address by pinging it and running arp -a, right?

What use case do you see covering by adding this permission?

> Thanks,
> Jeff Vander Stoep
>
> ---
>  security/selinux/hooks.c            | 7 +++++++
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1e1266b..cb65fd9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct file *file,
> unsigned int cmd,
>      SECURITY_CAP_AUDIT);
>   break;
>
> +    case SIOCGIFHWADDR:
> +        error = file_has_perm(cred, file, FILE__IOCTL);
> +        if (error)
> +            break;
> +        error = file_has_perm(cred, file, SOCKET__GET_HWADDR);
> +        break;
> +
>   /* default case assumes that the command will go
>   * to the file's ioctl() function.
>   */
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index c32ff7b..306f0d2 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -7,7 +7,7 @@
>
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> -    "sendto", "recv_msg", "send_msg", "name_bind"
> +    "sendto", "recv_msg", "send_msg", "name_bind", "get_hwaddr"
>
>  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read",
> \
>      "write", "associate", "unix_read", "unix_write"
> --
> 2.1.0.rc2.206.gedb03e5
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
