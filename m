Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21138
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 08:26:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA29395
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:25:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA29391
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:25:39 GMT
Date: Fri, 21 Jun 2002 08:25:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: selinux cramfs
In-Reply-To: <3D1312C0.6060602@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0206210807570.12888-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Debian User wrote:

> Im using cramfs for a read only root filesystem.
> How does selinux do the labeling then? Is it just an integer associated
> with inodes? Maybe I have to read the white papers all over again.

The SELinux module only tries to assign labels to filesystem types that
are known to be supported.  We've made the labeling behavior more
configurable and general since the last release, but that won't help
with your particular problem.  SELinux uses one of four approaches to
label inodes in the filesystem, based on the filesystem type, plus some
specialized logic for /proc/PID and /proc/sys.  Any unrecognized
filesystem types are left with the unlabeled SID and its corresponding
context.

The four approaches are:

1) Use a persistent label mapping.  This is appropriate for filesystems
that have unique and persistent inode numbers.  A two-level mapping is
maintained in each filesystem between inode numbers and integer PSIDs and
between PSIDs and security contexts.  The mapping is typically initialized
via setfiles, although the kernel will try to automatically initialize the
mapping to a minimal state if a filesystem is mounted that lacks any
mapping.  SELinux uses this approach for ext2, ext3, and reiserfs, and
it should also work for alternate filesystems like XFS.  If extended
attributes become widely available in filesystems, then SELinux will
likely be retargeted to take advantage of them for this purpose.

2) Use the allocating task SID.  This is appropriate for the pipefs and
sockfs pseudo filesystems, where we want the pipes and sockets to be
labeled with the SID of the allocating task (the kind of object in this
case is implicit from the security class).

3) Use a transition SID computed from the allocating task SID and the
filesystem SID.  This is appropriate for the devpts and tmpfs pseudo
filesystems, where we want the inodes to be labeled with a SID that
expresses information about both the allocating task and the kind of
object being represented (i.e. is it a pty, a shared memory object, etc?).

4) Use a context obtained from a configuration based on filesystem
type, pathname prefix matching and file type.  This is appropriate for
pseudo filesystems like proc (outside of /proc/PID and /proc/sys), devfs,
usbdevfs, and driverfs.  In the current release, this is only done for
devfs, with hardcoded logic for proc and usbdevfs, but we have
subsequently generalized the mechanism so that it can be applied to other
filesystem types.

Specialized logic in the module ensures that the /proc/PID entries are
labeled with the SID of the associated task and that the /proc/sys entries
are labeled with the SID of the corresponding sysctl variable.

You might be able to handle cramfs to some degree using the new
genfs_contexts configuration, which is a generalization of devfs_contexts.
That isn't in the current release, but will be in the next one.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
