Subject: Re: user guide drafts: "Mounting File Systems"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        dwalsh@redhat.com
In-Reply-To: <1223646314.8664.34.camel@localhost.localdomain>
References: <48EF03BA.90901@redhat.com>
	 <1223644300.25569.41.camel@moss-spartans.epoch.ncsc.mil>
	 <1223646314.8664.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 09:51:03 -0400
Message-Id: <1223646663.25569.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-10 at 09:45 -0400, Eric Paris wrote:
> On Fri, 2008-10-10 at 09:11 -0400, Stephen Smalley wrote:
> > On Fri, 2008-10-10 at 17:26 +1000, Murray McAllister wrote:
> > > Hi,
> > > 
> > > The following is a rough draft for the "Mounting File Systems" sections. 
> > > Any comments and corrections are appreciated.
> > > 
> > > Thanks!
> > > 
> > > Mounting File Systems
> > > 
> > > By default, when a third extended file system (ext3) is mounted, the 
> > 
> > You should generalize this to "a filesystem that supports extended
> > attributes, such as ext[234], jfs, xfs, or jffs2".
> > 
> > > files and directories on the file system are labeled with the file_t 
> > > type.
> > 
> > Not exactly.  The correct statement is that a file that does not have a
> > security context set on disk (due to being created on a non-selinux
> > kernel) on a filesystem that supports extended attributes will be
> > treated as having the file_t type (or more precisely, the security
> > context associated with the file initial SID).  On a properly labeled
> > filesystem, there should be no files with file_t.
> 
> might be worth mentioning that the context assigned to unlabeled files
> on filesystems that supports xattrs can be set with defcontext=.   opps,
> I see you did that later on, only as sds pointed out you didn't get it
> quite right.
> 
> <aside> Dan, you always said you disliked how file_t meant there was no
> label and unlabeled_t meant there was a bad label.  Maybe we could move
> to using defcontext= to assign a type you like for at least the file_t
> case... </aside>
> 
> > > * Context changes are written to disk, and are not lost if the file 
> > > system is unmounted. Newly-created files and files copied to such a file 
> > > system inherit the SELinux context specified with the -o defcontext 
> > > option. For example, if a file system is mounted with the -o 
> > > defcontext="system_u:object_r:httpd_sys_content_t:s0" option, and a new 
> > > file is created on the mounted file system, that file is labeled with 
> > > the httpd_sys_content_t type. If the file system is unmounted and then 
> > > mounted without a context option, that file is still labeled with the 
> > > httpd_sys_content_t type.
> 
> I didn't know this (am I supposed to admit that?)  I always thought
> normal label inheritance still took place even with defcontext=.
> Anyway, if you can double check that would be great...
> 
> mount -o httpd_sys_context_t
> mkdir testdir/
> chcon tmp_t testdir/
> touch testdir/file
> ls -lZ testdir/
> 
> if file is httpd_sys_context_t you are right.  if file is tmp_t normal
> inheritance took place....
> 
> > I'm pretty sure that James and/or Eric have written description of all
> > of the context mount options before.
> > fscontext= sets the filesystem security context, a context that is
> > applied for certain permission checks on the entire filesystem like
> > mounting as well as used to control what file security contexts can
> > exist within the filesystem.
> 
> Its not relevant to 99% of people at this time (same for defcontext and
> rootcontext), but that might change if we start making better policies
> to protect against accidental information leakage. All three should get
> a short blurb, context= needs the most description.  The most
> interesting use of fscontext is the 'associate' permission check.  It
> allows you to say that things labeled company_confidential_t are not
> allowed to be saved on a filesystem with fscontext=removable_media_t.
> We don't make much (any?) use of this feature, but fscontext is a very
> general label controlling the entire fs, can it be mounted, can certain
> data be written to it, etc, etc...
> 
> > rootcontext= sets the security context for the root directory of the
> > filesystem, useful for e.g. tmpfs mounts where you want the root to take
> > on a specific context but allow other files within it to have individual
> > contexts.
> 
> again, not brilliantly interesting for most people as usually dan just
> fixes it with a restorecon somewhere in the init scripts for most
> people.  I find it most useful when mounting tmpfs somewhere.  Say you
> want to make /usr/src/redhat/BUILD a tmpfs.  Easiest way to make sure
> you don't see any denials or need extra magic would be to include a
> rootcontext=src_t in the fstab...

BTW, one interesting tidbit from OpenSolaris FMAC - in Solaris, the
uid/gid/mode information for the root directory of a tmpfs mount
defaults to the attributes of the underlying mount point directory, so I
did likewise for the security context.  Which means that I can set the
security context on the mount point directory as desired (tmp_t
for /tmp, var_run_t for /var/run, ...) and then the tmpfs mount will
pick up the right label automatically from the mount point.  I don't
know if that makes sense in Linux, as they infer the default uid/gid
from the mounting process instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
