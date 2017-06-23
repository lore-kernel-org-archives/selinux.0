Message-ID: <1498249800.2063.9.camel@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] Enable security.selinux in user namespaces
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, ebiederm@xmission.com,
 containers@lists.linux-foundation.org
Cc: lkp@01.org, xiaolong.ye@intel.com, linux-kernel@vger.kernel.org,
 zohar@linux.vnet.ibm.com, serge@hallyn.com, tycho@docker.com,
 James.Bottomley@HansenPartnership.com, christian.brauner@mailbox.org,
 vgoyal@redhat.com, amir73il@gmail.com,
 linux-security-module@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov
Date: Fri, 23 Jun 2017 16:30:00 -0400
In-Reply-To: <1498157989-11814-4-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1498157989-11814-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-06-22 at 14:59 -0400, Stefan Berger wrote:
> Before the current modifications, SELinux extended attributes were
> visible inside the user namespace but changes in patch 1 hid them.
> This patch enables security.selinux in user namespaces and allows
> them to be written to in the same way as security.capability.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  fs/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 045be85..37686ee 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -138,6 +138,7 @@ xattr_permission(struct inode *inode, const char
> *name, int mask)
>   */
>  static const char *const userns_xattrs[] = {
>  	XATTR_NAME_CAPS,
> +	XATTR_NAME_SELINUX,
>  	NULL
>  };
>  

(cc SELinux maintainers, curiously omitted from these patches)

I don't think this works for SELinux. You don't deal with actually
supporting multiple security.selinux attributes within SELinux itself
(and I'm not asking you to do so), and without such support, this can't
operate as intended. With these patches applied, IIUC, a setxattr() of
security.selinux within a userns will end up setting only security.seli
nux@uid=1000 on disk, but will then tell SELinux to update its in-core
security label to the new value (via security_inode_post_setxattr).
Meanwhile, on a subsequent getxattr(), you'll call
security_inode_getsecurity() with the security.selinux@uid=1000 name,
which will always fail because SELinux doesn't know anything about your
new scheme, and then you'll call the filesystem handler and returns its
value, which is no longer connected in any way to the actual label
being used by SELinux.  Also, SELinux itself makes calls to
__vfs_getxattr() and __vfs_setxattr_noperm(), and I don't think your
name remapping is correct in those cases.

You also can't hide security.selinux within user namespaces.  Today
userspace can get and set security.selinux attributes within user
namespaces (if allowed by policy), and further can specify the label to
use for new files via /proc/self/attr/fscreate, which unsurprisingly
isn't addressed by your changes.  Changing that would be a userspace
break.
