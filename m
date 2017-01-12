Message-ID: <1484256222.16361.23.camel@tycho.nsa.gov>
Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 12 Jan 2017 16:23:42 -0500
In-Reply-To: <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
 <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-01-12 at 20:47 +0000, Alan Jenkins wrote:
> On 12/01/17 20:01, Stephen Smalley wrote:
> > On Wed, 2017-01-11 at 12:41 +0000, Alan Jenkins wrote:
> > > fixfiles links to restorecon.  However if you start with
> > > restorecon
> > > "restore file(s) default SELinux security contexts", you can
> > > easily
> > > miss the fixfiles script.  fixfiles is more generally useful than
> > > `restorecon -R`.   For example `restorecon -R /` is not as good
> > > as
> > > `fixfiles restore`, because the restorecon command will try to
> > > relabel
> > > `/sys` and fail noisily.
> > Thanks, applied both patches.
>  yay!
> 
> >   Wondering though about the behavior
> > you describe above; restorecon -R /sys only issues one error
> > message
> > for me and otherwise works fine,
> > # restorecon -R /sys
> > Could not set context for /sys/fs/cgroup:  Read-only file system
>  
> It turned out fixfiles also generated similar noise.  I suspect this
> involved `-v` (in both cases), sorry.
> 
> Fedora Workstation 25:
> "fixfiles spams warnings about debugfs. (docs say it only touches
> "real" filesystems!)" https://bugzilla.redhat.com/show_bug.cgi?id=141
> 2747
> 
> Perhaps the root cause is actually the same.  I still prefer the
> messages from fixfiles though.  It explicitly detected conflicting
> labels on hardlinks
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1411371
> 
> and informed me in advance when it decided to traverse and relabel
> five of my virtual filesystems
> Checking / /boot /dev /dev/hugepages /dev/mqueue /dev/pts /dev/shm
> /home /run /run/user/1000 /run/user/1001 /run/user/42 /sys
> /sys/fs/pstore /sys/kernel/debug /tmp
> (I doubt devtmpfs files are _intended_ to be labeled like this
> either.  OTOH the stupidity doesn't seem to affect it, so I won't
> complain there).

By default, it includes any filesystem with the seclabel mount option
from /proc/mounts; this is a kernel-generated option that indicates
that the filesystem is known to support setting of security labels by
userspace.  restorecon (and setfiles) can be further instructed to skip
specific directories via the -e option.  fixfiles is just a wrapper
script around setfiles and/or restorecon depending on its options.
 setfiles was the original SELinux filesystem labeling utility,
oriented to labeling a list of filesystems based on a specified
file_contexts configuration, potentially even on a SELinux-disabled
host.  fixfiles and restorecon were later additions by Red Hat as more
user-friendly options, and then still later restorecon kept growing in
functionality and duplicating setfiles that we coalesced them
(restorecon is just a link that alters the default options and command-
line interface).

setfiles walks a filesystem at a time, which facilitates the hard link
conflict detection logic.  restorecon in contrast just recurses a
directory tree (with -R) and doesn't care about filesystem boundaries,
so if we wanted to turn on hard link conflict detection for it, we'd
need to augment that logic to save the device numbers too.  Possible
but hasn't been a priority.
