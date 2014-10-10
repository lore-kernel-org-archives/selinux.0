Message-ID: <543823FB.7060706@tycho.nsa.gov>
Date: Fri, 10 Oct 2014 14:22:51 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <5436A035.5030506@tycho.nsa.gov>
 <CABXk95C2XumO3C9Hb21QgxrQXv3By=kr5QSpOmg6x_unYWmHdA@mail.gmail.com>
In-Reply-To: <CABXk95C2XumO3C9Hb21QgxrQXv3By=kr5QSpOmg6x_unYWmHdA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/09/2014 02:48 PM, Jeffrey Vander Stoep wrote:
> Thank you for catching that. Here is the patch updated with your
> recommendations:
> 
> ---
>  security/selinux/hooks.c            | 14 ++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1e1266b..5105341 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3104,10 +3104,14 @@ static void selinux_file_free_security(struct file
> *file)
>   file_free_security(file);
>  }
> 
> +static int sock_has_perm(struct task_struct *task, struct sock *sk, u32
> perms);

Don't know if Paul agrees, but I'd tend to just move the entire
sock_has_perm() function up to before the beginning of any of the hook
functions (i.e. before the /* Hook functions begin here. */ comment)
rather than having a separate function prototype.  That's what we've
done for other helper functions that get called from various hooks.

Paul: Also wondering if sock_has_perm() ought to take a cred instead of
a task pointer these days (noticing the discrepancy between
file_has_perm and sock_has_perm below). And whether it even needs to
take the task/cred argument at all or could just use current_sid()
always given that all of its callers appear to pass current to it,
although I suppose it is more general/parallel to leave it.

Otherwise, I think the code is ok.  The patch was whitespace-damaged /
mangled by your mail client, so you'll want to fix that and disable html
mail when posting a final version (after addressing Paul's question
about any other hardware identifiers that might need similar controls).

> +
>  static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>        unsigned long arg)
>  {
>   const struct cred *cred = current_cred();
> +    struct inode *inode = file->f_path.dentry->d_inode;
> +    struct socket *socket;
>   int error = 0;
> 
>   switch (cmd) {
> @@ -3142,6 +3146,16 @@ static int selinux_file_ioctl(struct file *file,
> unsigned int cmd,
>      SECURITY_CAP_AUDIT);
>   break;
> 
> +    case SIOCGIFHWADDR:
> +        error = file_has_perm(cred, file, FILE__IOCTL);
> +        if (error)
> +            break;
> +        if (inode->i_sb->s_magic != SOCKFS_MAGIC)
> +            break;
> +        socket = SOCKET_I(inode);
> +        error = sock_has_perm(current, socket->sk, SOCKET__GET_HWADDR);
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
>  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr",
> "read", \
>      "write", "associate", "unix_read", "unix_write"
> 
