From: David Howells <dhowells@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: viro@ftp.linux.org.uk, dhowells@redhat.com, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
Subject: SELinux security and passed file descriptors
Date: Thu, 30 Aug 2007 16:12:14 +0100
Message-ID: <10698.1188486734@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi Stephen,

Imagine you have two processes, say A and B, running with different security
contexts.  If A opens a file and passed the file descriptor to B (sends it
over an AF_UNIX socket perhaps), then what security context should be assumed
when B operates on the file descriptor?  A's security, or B's?


I would have thought it should be A's security, since A opened the file.  This
is usually the case for UID/GID/mode information (which are resident on the
file struct) and other FS-specific access contexts (in the in-kernel AFS's
case, this includes the kerberos ticket A used to access the file, and I
believe the same is true in NFS's case).


However, having just been looking through security/selinux/hooks.c, this isn't
always the case with SELinux.  For ioctls, for example, B's security context
will be used.  The same goes for reading and writing.

This is surely incorrect.  This can mean A can pass a file that it can read
and write to B that B can't then read or write because it doesn't have access,
even though it ought to be able to because *A* can.

At least, that's how I interpret the code.


If I'm right, and this is incorrect behaviour, then I have most of a patch
that I'm working on to pass the appropriate credentials around.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
