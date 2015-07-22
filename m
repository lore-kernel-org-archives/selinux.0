Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6MGES3M000958
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 12:14:28 -0400
Received: by obbop1 with SMTP id op1so137094275obb.2
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 09:14:26 -0700 (PDT)
Date: Wed, 22 Jul 2015 11:14:22 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 6/7] selinux: Ignore security labels on user namespace
 mounts
Message-ID: <20150722161422.GC124342@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-7-git-send-email-seth.forshee@canonical.com>
 <55A7B055.4050809@tycho.nsa.gov> <55AFBE85.6010809@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AFBE85.6010809@tycho.nsa.gov>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, linux-fsdevel@vger.kernel.org,
 selinux@tycho.nsa.gov, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 22, 2015 at 12:02:13PM -0400, Stephen Smalley wrote:
> On 07/16/2015 09:23 AM, Stephen Smalley wrote:
> > On 07/15/2015 03:46 PM, Seth Forshee wrote:
> >> Unprivileged users should not be able to supply security labels
> >> in filesystems, nor should they be able to supply security
> >> contexts in unprivileged mounts. For any mount where s_user_ns is
> >> not init_user_ns, force the use of SECURITY_FS_USE_NONE behavior
> >> and return EPERM if any contexts are supplied in the mount
> >> options.
> >>
> >> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > 
> > I think this is obsoleted by the subsequent discussion, but just for the
> > record: this patch would cause the files in the userns mount to be left
> > with the "unlabeled" label, and therefore under typical policies,
> > completely inaccessible to any process in a confined domain.
> 
> The right way to handle this for SELinux would be to automatically use
> mountpoint labeling (SECURITY_FS_USE_MNTPOINT, normally set by
> specifying a context= mount option), with the sbsec->mntpoint_sid set
> from some related object (e.g. the block device file context, as in your
> patches for Smack).  That will cause SELinux to use that value instead
> of any xattr value from the filesystem and will cause attempts by
> userspace to set the security.selinux xattr to fail on that filesystem.
>  That is how SELinux normally deals with untrusted filesystems, except
> that it is normally specified as a mount option by a trusted mounting
> process, whereas in your case you need to automatically set it.

Excellent, thank you for the advice. I'll start on this when I've
finished with Smack.

Seth
