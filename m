Message-ID: <5436A035.5030506@tycho.nsa.gov>
Date: Thu, 09 Oct 2014 10:48:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeffrey Vander Stoep <jeffv@google.com>, Selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
In-Reply-To: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/08/2014 08:41 PM, Jeffrey Vander Stoep wrote:
> First time poster to the list. I would appreciate feedback/suggestions
> regarding the following patch.
> 
> This patch which provides SELinux control over network interface MAC
> addresses. This patch allows access to the MAC address to be controlled by
> policy. Network MAC addresses are a long lived unique device identifier,
> and a security policy may wish to control access to the identifier without
> further limiting network use, perhaps for privacy reasons.
> 
> The existing SE Linux permissions are too coarse in that they only allow
> blanket read/no-read access to this socket ioctl. We would like to consider
> both the read/no-read permission as well as an additional permission that
> checks the ioctl cmd argument. This allows applications to continue
> accessing the IP address, netmask, etc, while being denied access to the
> MAC address.

There was some earlier discussion of filtering ioctls via SELinux.  If
you want to do that in general, this approach won't get you there - it
cannot scale to deal with more than a handful of ioctl commands.  If
however you truly only want this control for this particular ioctl
command, see below for comments on the code.  Otherwise, if you want to
explore a generic facility for ioctl filtering, I can send you pointers
to the earlier discussions.

> 
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

You can't safely call file_has_perm() with a SOCKET permission as the
file may reference an object with a non-socket security class.  So for
example, if a process called ioctl with this command value on a file,
you'd end up getting a very different permission check - whatever that
permission bit corresponds to in the file security class (I guess
nothing at this point, but could potentially be filled in the future).
So I think you need to first check that the file represents a socket
before performing the second check.  The other alternative would be to
define the permission in COMMON_FILE_SOCK_PERMS so that it is defined
for all objects that can be presented by struct file, but that would
waste a permission bit for the file classes.

For the first option, something along the lines of:
struct inode *inode = file->f_path.dentry->d_inode;
struct socket *socket;
if (inode->i_sb->s_magic != SOCKFS_MAGIC)
	break;
socket = SOCKET_I(inode);
error = sock_has_perm(current, socket->sk, SOCKET__GET_HWADDR);
break;


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
>  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr",
> "read", \
>      "write", "associate", "unix_read", "unix_write"
