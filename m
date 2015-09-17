Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8H0P3Dn011583
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 20:25:09 -0400
Received: by obbbh8 with SMTP id bh8so1775396obb.0
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 17:25:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442433764-80826-3-git-send-email-seth.forshee@canonical.com>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
 <1442433764-80826-3-git-send-email-seth.forshee@canonical.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 16 Sep 2015 17:24:47 -0700
Message-ID: <CALCETrXoAi91JN4VLD2ybPgkD_J26=2_N-fyCCjOPL5Swo7kGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] userns: Simpilify MNT_NODEV handling.
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 16, 2015 at 1:02 PM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> - Consolidate the testing if a device node may be opened in a new
>   function may_open_dev.
>
> - Move the check for allowing access to device nodes on filesystems
>   not mounted in the initial user namespace from mount time to open
>   time and include it in may_open_dev.
>
> This set of changes removes the implicit adding of MNT_NODEV which
> simplifies the logic in fs/namespace.c and removes a potentially
> problematic user visible difference in how normal and unprivileged
> mount namespaces work.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

> -               /* Only in special cases allow devices from mounts
> -                * created outside the initial user namespace.
> -                */
> -               if (!(type->fs_flags & FS_USERNS_DEV_MOUNT)) {
> -                       flags |= MS_NODEV;
> -                       mnt_flags |= MNT_NODEV | MNT_LOCK_NODEV;
> -               }

This is an ABI change.  It's probably okay, but I think the commit
message should make it clear what's happening.


--Andy
