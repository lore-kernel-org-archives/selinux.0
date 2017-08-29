Message-ID: <1504011284.5220.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeffrey Vander Stoep <jeffv@google.com>, SELinux <Selinux@tycho.nsa.gov>
Date: Tue, 29 Aug 2017 08:54:44 -0400
In-Reply-To: <CABXk95BhYEZUQn74_H5Y0Ogxm23ZoLZA2Eiz22QTJwKG741B=Q@mail.gmail.com>
References: <CABXk95BhYEZUQn74_H5Y0Ogxm23ZoLZA2Eiz22QTJwKG741B=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: sysfs symlinks in genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-08-28 at 14:58 -0700, Jeffrey Vander Stoep via Selinux
wrote:
> Genfs_contexts does not label symlinks in sysfs, instead it leaves
> them with the default “sysfs” label. Is this a bug?

We excluded symlinks from genfscon labeling back when only proc was
using genfscon for per-file labeling and we encountered a compatibility
problem when /proc/net was moved to /proc/self/net for network
namespaces (see commit cited below). Suddenly applications were getting
proc_net_t:lnk_file read denials when accessing /proc/net because
existing policies only allowed proc_t:lnk_file read and
proc_net_t:dir/file read, so new kernel + old policy broke userspace,
which is not allowed by Linus.  At the time, I couldn't see a use case
where we would need to support per-file labeling of symlinks in proc,
since the only meaningful operation on a proc symlink is read/getattr. 
The real access controls are to the individual directories/files, not
the symlinks.

Do you truly need per-file labeling of symlinks in sysfs?  What's the
use case?  I guess it is an inconsistency between the support for sysfs
labeling via setxattr vs genfscon, but there are likely other more
significant inconsistencies due to the support for pathname regexes in
file_contexts versus pathname prefixes in genfscon, e.g. see
https://github.com/SELinuxProject/selinux-kernel/issues/29

That said, I agree it is an ugly hack and should likely be removed if
it doesn't cause compatibility problems (we'd need to test on RHEL 6/7
at least).

Have you measured to see the impact of switching from setxattr to
genfscon for sysfs labeling?

commit ea6b184f7d521a503ecab71feca6e4057562252b
Author: Stephen Smalley <sds@tycho.nsa.gov>
Date:   Mon Sep 22 15:41:19 2008 -0400

    selinux: use default proc sid on symlinks
    
    As we are not concerned with fine-grained control over reading of
    symlinks in proc, always use the default proc SID for all proc
symlinks.
    This should help avoid permission issues upon changes to the proc
tree
    as in the /proc/net -> /proc/self/net example.
    This does not alter labeling of symlinks within /proc/pid
directories.
    ls -Zd /proc/net output before and after the patch should show the
differenc
e.
    
    Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
    Signed-off-by: James Morris <jmorris@namei.org>
