Message-ID: <55AFFFBD.8040907@tycho.nsa.gov>
Date: Wed, 22 Jul 2015 16:40:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 6/7] selinux: Ignore security labels on user namespace
 mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-7-git-send-email-seth.forshee@canonical.com>
 <55A7B055.4050809@tycho.nsa.gov> <55AFBE85.6010809@tycho.nsa.gov>
 <20150722161422.GC124342@ubuntu-hedt> <55AFFC32.6070701@tycho.nsa.gov>
In-Reply-To: <55AFFC32.6070701@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/2015 04:25 PM, Stephen Smalley wrote:
> On 07/22/2015 12:14 PM, Seth Forshee wrote:
>> On Wed, Jul 22, 2015 at 12:02:13PM -0400, Stephen Smalley wrote:
>>> On 07/16/2015 09:23 AM, Stephen Smalley wrote:
>>>> On 07/15/2015 03:46 PM, Seth Forshee wrote:
>>>>> Unprivileged users should not be able to supply security labels
>>>>> in filesystems, nor should they be able to supply security
>>>>> contexts in unprivileged mounts. For any mount where s_user_ns is
>>>>> not init_user_ns, force the use of SECURITY_FS_USE_NONE behavior
>>>>> and return EPERM if any contexts are supplied in the mount
>>>>> options.
>>>>>
>>>>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>>>>
>>>> I think this is obsoleted by the subsequent discussion, but just for the
>>>> record: this patch would cause the files in the userns mount to be left
>>>> with the "unlabeled" label, and therefore under typical policies,
>>>> completely inaccessible to any process in a confined domain.
>>>
>>> The right way to handle this for SELinux would be to automatically use
>>> mountpoint labeling (SECURITY_FS_USE_MNTPOINT, normally set by
>>> specifying a context= mount option), with the sbsec->mntpoint_sid set
>>> from some related object (e.g. the block device file context, as in your
>>> patches for Smack).  That will cause SELinux to use that value instead
>>> of any xattr value from the filesystem and will cause attempts by
>>> userspace to set the security.selinux xattr to fail on that filesystem.
>>>  That is how SELinux normally deals with untrusted filesystems, except
>>> that it is normally specified as a mount option by a trusted mounting
>>> process, whereas in your case you need to automatically set it.
>>
>> Excellent, thank you for the advice. I'll start on this when I've
>> finished with Smack.
> 
> Not tested, but something like this should work. Note that it should
> come after the call to security_fs_use() so we know whether SELinux
> would even try to use xattrs supplied by the filesystem in the first place.
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 564079c..84da3a2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -745,6 +745,30 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         goto out;
>                 }
>         }
> +
> +       /*
> +        * If this is a user namespace mount, no contexts are allowed
> +        * on the command line and security labels must be ignored.
> +        */
> +       if (sb->s_user_ns != &init_user_ns) {
> +               if (context_sid || fscontext_sid || rootcontext_sid ||
> +                   defcontext_sid) {
> +                       rc = -EACCES;
> +                       goto out;
> +               }
> +               if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> +                       struct block_device *bdev = sb->s_bdev;
> +                       sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
> +                       if (bdev) {
> +                               struct inode_security_struct *isec =
> bdev->bd_inode;

That should be bdev->bd_inode->i_security.

> +                               sbsec->mntpoint_sid = isec->sid;
> +                       } else {
> +                               sbsec->mntpoint_sid = current_sid();
> +                       }
> +               }
> +               goto out_set_opts;
> +       }
> +
>         /* sets the context of the superblock for the fs being mounted. */
>         if (fscontext_sid) {
>                 rc = may_context_mount_sb_relabel(fscontext_sid, sbsec,
> cred);
> @@ -813,6 +837,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                 sbsec->def_sid = defcontext_sid;
>         }
> 
> +out_set_opts:
>         rc = sb_finish_set_opts(sb);
>  out:
>         mutex_unlock(&sbsec->lock);
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
