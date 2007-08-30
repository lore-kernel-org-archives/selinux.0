Subject: Re: SELinux security and passed file descriptors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: viro@ftp.linux.org.uk, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <10698.1188486734@redhat.com>
References: <10698.1188486734@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 11:19:55 -0400
Message-Id: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 16:12 +0100, David Howells wrote:
> Hi Stephen,
> 
> Imagine you have two processes, say A and B, running with different security
> contexts.  If A opens a file and passed the file descriptor to B (sends it
> over an AF_UNIX socket perhaps), then what security context should be assumed
> when B operates on the file descriptor?  A's security, or B's?
> 
> 
> I would have thought it should be A's security, since A opened the file.  This
> is usually the case for UID/GID/mode information (which are resident on the
> file struct) and other FS-specific access contexts (in the in-kernel AFS's
> case, this includes the kerberos ticket A used to access the file, and I
> believe the same is true in NFS's case).
> 
> 
> However, having just been looking through security/selinux/hooks.c, this isn't
> always the case with SELinux.  For ioctls, for example, B's security context
> will be used.  The same goes for reading and writing.
> 
> This is surely incorrect.  This can mean A can pass a file that it can read
> and write to B that B can't then read or write because it doesn't have access,
> even though it ought to be able to because *A* can.

That's how mandatory access control is supposed to work; otherwise, a
flaw in A can leak the descriptor to B at will in violation of security
policy.  And it has caught any number of bugs in applications as well as
the kernel where a descriptor is unwittingly leaked across exec.

Now, we do revalidate access to open files when they are passed across
local IPC (see selinux_file_receive) and when they are inherited across
an exec that changes SIDs (see selinux_bprm_post_apply_creds ->
flush_unauthorized_files), so we don't strictly need the rechecking of
access on read/write to control propagation.

The rechecking of access on read/write is instead to permit revocation
of access upon file relabels (setxattr) and policy changes (boolean
change or reload).  However, that doesn't give us complete coverage
(e.g. mmap'd file or in-progress operation that has passed the check).
If/when the revoke support ever gets to a usable state and is merged, we
might use that instead, i.e. do a selective revoke if access is no
longer granted to the new file label or under the new policy upon
setxattr or policy change rather than rechecking on use.  But I'm not
sure how well that will work.

There is also some discussion going on presently about optimizing
selinux_file_permission, e.g. only rechecking under certain conditions
(any one of process SID, file SID, or policy seqno has changed since
open-time check).

> At least, that's how I interpret the code.
> 
> 
> If I'm right, and this is incorrect behaviour, then I have most of a patch
> that I'm working on to pass the appropriate credentials around.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
