Subject: Re: user guide drafts: Maintaining SELinux Labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        Glenn Faden <Glenn.Faden@sun.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48F547BE.7070201@redhat.com>
References: <737og9$5vh3i@dmzms99902.na.baesystems.com>
	 <48ED4FBC.4020303@redhat.com>
	 <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil>
	 <48F02876.3020203@redhat.com>
	 <1223993726.5193.41.camel@moss-spartans.epoch.ncsc.mil>
	 <48F547BE.7070201@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 08:45:52 -0400
Message-Id: <1224074752.15903.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-15 at 11:30 +1000, Murray McAllister wrote:
> Stephen Smalley wrote:
> > 2) the file security context may not be allowed to exist within the
> > target file system (e.g. top secret file may not be created within a
> > filesystem capped at secret, passwd_exec_t file may not be created on
> > removable media).
> Is that because of the file systems on most removable media, or 
> something else?
> 
> I made an ext3 file system on an USB drive, and "cp --preserve=context 
> /usr/bin/passwd /removable/media" preserved the passwd_exect_t type. I 
> tested this on Red Hat Enterprise Linux 5.2 and Fedora Rawhide.

That's because you didn't mount that filesystem with a context= mount
option.  Which hald and friends ought to do for removable media by
default.  There are two situations:
- the filesystem on the removable media may not support extended
attributes at all, or
- the filesystem on the removable media may support them but we may not
want to trust removable media in the same way we apply nosuid nodev
typically when mounting it.

> I started the section again. Hopefully it is almost right now :(
> 
> Copying Files and Directories
> 
> When a file or directory is copied, a new file or directory is created 
> if it does not exist. That new file or directory's context is based on 
> default-labeling rules, not the original file or directory's context 
> (unless options were used to preserve the original context). For 
> example, files created in user home directories are labeled with the 
> user_home_t type:
> 
> $ touch file1
> $ ls -Z file1
> -rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1
> 
> If such a file is copied to another directory, such as /etc/, the new 
> file is created in accordance to default-labeling rules for the /etc/ 
> directory. Copying a file (without additional options) may not preserve 
> the original context:
> 
> $ ls -Z file1
> -rw-rw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0 file1
> # cp file1 /etc/
> $ ls -Z /etc/file1
> -rw-r--r--  root root unconfined_u:object_r:etc_t:s0   /etc/file1
> 
> When file1 is copied to /etc/, if /etc/file1 does not exist, /etc/file1 
> is created as a new file. As shown in the example above, /etc/file1 is 
> labeled with the etc_t type, in accordance to default-labeling rules.
> 
> When a file is copied over an existing file, the existing file's context 
> is preserved, unless the user specified cp options to preserve the 
> context of the original file, such as --preserve=context. SELinux policy 
> may prevent contexts from being preserved during copies.

Sounds better.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
