Subject: Re: user guide drafts: "Mounting File Systems"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>, Daniel Walsh <dwalsh@redhat.com>
In-Reply-To: <48FBCBC3.2070507@redhat.com>
References: <48EF03BA.90901@redhat.com>
	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>
	 <48F69C5D.8050504@redhat.com>
	 <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>
	 <48FBCBC3.2070507@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Oct 2008 09:37:32 -0400
Message-Id: <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-10-20 at 10:07 +1000, Murray McAllister wrote:
> Stephen Smalley wrote:
> > On Thu, 2008-10-16 at 11:43 +1000, Murray McAllister wrote:
> >> Changing the Default Context
> >>
> >> As the Linux root user, use the mount -o 
> >> defcontext=SELinux_user:role:type:level command to change "the default 
> >> security context for unlabeled files"[1]. The defcontext option requires 
> >> a file system that supports extended attributes, since context context
> > 
> > double word
> > 
> >> changes for newly-created files that would otherwise be labeled with the 
> >> file_t type are written to disk.
> > 
> > What?  The point is that defcontext= is meaningless if the filesystem
> > doesn't support extended attributes because it means "treat files that
> > lack an extended attribute as if they had this context".  But the
> > defcontext itself is not stored on disk.
> I was trying to explain (tested on Fedora Rawhide):
> 
> 1. create a logical volume. mkfs.ext3 [new logical volume].
> 3. create a /test/ directory. mount the logical volume to /test/
> 5. create /test/file. This file uses the file_t type.
> 6. unmount.
> 7. mount with defcontext option. create /test/file2. File2 uses type 
> specified with defcontext. "file" is still labeled with the file_t type.
> 9. remount with no context option. file2 still has the type specified 
> with previous defcontext option.
> 
> Is this the expected behavior?

Yes, but not because the defcontext= is being stored on disk.  The
defcontext= option tells the kernel how to internally label files that
lack an extended attribute on disk.  When you create a new file, the
kernel computes a security context for the new file as previously
described based on a combination of the process context and the parent
directory context and optionally a type transition rule if one applies
and stores the computed security context as an extended attribute of the
file.  In your sequence of commands above, what is happening is that the
root directory of the filesystem is internally being labeled by the
kernel with the defcontext value (without ever being stored), and this
is affecting how new files are being labeled since they inherit their
type from the parent directory by default, and those new file labels are
being stored.  But the defcontext= value itself is NOT being stored on
disk.

> >> Multiple NFS Mounts from the same Export
> >>
> >> To mount a single NFS export multiple times using a different SELinux 
> >> context for each mount, use the mount -o nosharecache,context options. 
> >> The context specified with with context option is not written to disk:
> >>
> >> # mount hostname:/export /local/mount/web -o 
> >> nosharecache,context="system_u:object_r:httpd_sys_content_t:s0"
> >> # mount hostname:/export /local/mount/database -o 
> >> nosharecache,context="system_u:object_r:mysqld_db_t:s0"
> > 
> > Caveat:  Do not ever do this for overlapping mounts or you'll create a
> > situation where the same file is accessible under two different security
> > contexts.
> Is overlapping what I have done above, or do you mean manually mounting 
> an NFS export to the same directory that mounts the NFS export via 
> autofs?

It is what you did above - mounting the same subdirectory (/export) from
the same server (hostname) with two different security contexts.  Then
the same files are accessible under two different security contexts.  If
you instead mounted different subdirectories, e.g. /export/web
and /export/db, then it would be ok.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
