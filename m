Subject: Re: selinux_inode_init_security() initialises XATTR_SELINUX_SUFFIX
 and not XATTR_NAME_SELINUX?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BANLkTi=KPssQQitdX7gQnJbtE7WByxgBgQ@mail.gmail.com>
References: <BANLkTi=KPssQQitdX7gQnJbtE7WByxgBgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 07:43:07 -0400
Message-ID: <1305891787.21855.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-05-19 at 14:05 -0700, Sam Gandhi wrote:
> Hello SeLinux Experts,
> 
> Looking at the latest SELinux code I see that in function
> selinux_inode_init_security() the initial XATTR is initialised as
> XATTR_SELINUX_SUFFIX ("security.selinux"), where as all the
> subsequence searches are done with XATTR_NAME_SELINUX.  Unfortunately
> I don't understand why initialisation is done with
> XATTR_SELINUX_SUFFIX ("selinux")
> 
> Should we be making following change to the code?

No.  The callers know that this is an attribute in the "security."
namespace and only want the suffix.  Some filesystem implementations
will then prepend the "security." prefix and store the entire name,
while others only store the suffix using an index that identifies the
namespace.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8fb2488..c8d14d5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2566,7 +2566,7 @@ static int selinux_inode_init_security(struct
> inode *inode, struct inode *dir,
>                 return -EOPNOTSUPP;
> 
>         if (name) {
> -               namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_NOFS);
> +               namep = kstrdup(XATTR_NAME_SELINUX, GFP_NOFS);
>                 if (!namep)
>                         return -ENOMEM;
>                 *name = namep;
> 
> 
> 
> -Sam
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
