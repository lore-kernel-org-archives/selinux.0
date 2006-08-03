Subject: [PATCH] SELinux: 0/3-v2 clean up locking and semaphore usage
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:04:35 -0400
Message-Id: <1154639075.8428.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch set attempts to do a little cleanup in SELinux code
concerning the usage of semaphores which we init to 1.  First off there
is nothing wrong with semaphores but with the introduction of simple
mutexes a slightly faster interface is available (see
Documentation/mutex-design.txt)  Since mutexes save time and space I'm
going to try to deal with both of the semaphores I see in the selinux
code.

The first patch completely eliminates the inode_security_set_security
function which was only being called from superblock_doinit.  Since
there was only 1 caller I rolled it back into superblock_doinit.  Also
since superblock_doinit is called while mounting, and before the root
inode is available to anything else we don't need to worry about locking
the isec->sem.  So the locking was completely dropped.

The second patch converts the remaining isec->sem into a mutex.  The
same locking is provided only in the faster smaller mutex rather than
slower sem.

The third patch is the most controversial I'm sure.  I just completely
eliminate the sbsec->sem.  This was used to lock the updating of the
superblock security struct inside superblock_doinit.  superblock_doinit
is only called from vfs_kern_mount and from selinux_complete_init.  The
operation with vfs_kern_mount is protected from races because the
&mnt->mnt_sb->s_umount write lock will always be held in the call to
security_sb_kern_mount (which works down to superblock_doinit) so the
only thing I was really concerned about was selinux_complete_init.  It
seems to me though that the ss_initialized variable will stop infinite
recursion between the two even without locking and that we need not
worry about races between vfs_kern_mount and selinux_complete_init since
nothing should be able to mount while we are still processing the
initial policy load in init.  Please though, let me know if I am
misunderstanding the race potentials of selinux_complete_init.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
