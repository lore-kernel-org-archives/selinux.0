Subject: Re: Why does SELinux treat access(file, W_OK) the same way as
	write(fd, "XYZ")?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45115DD9.2020603@redhat.com>
References: <45115DD9.2020603@redhat.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 17:03:56 -0400
Message-Id: <1158786236.15340.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 11:27 -0400, Daniel J Walsh wrote:
> Shouldn't the access(file, W_OK) be treated as a getattr rather then a 
> write access?
> 
> Several apps including the kernel do access checks on open file 
> descriptors and we end up having to write dontaudit rules on {read write 
> append} when what we really only want to allow the getattr.

>From an interface/behavior POV, if an application successfully calls
access(file, W_OK), it expects a subsequent open(file, O_RDWR) to
succeed (*).  So checking different permissions on access(2) vs. open(2)
seems prone to application confusion.

>From an implementation POV, access(2) just calls the kernel's
permission() function internally, and thus SELinux sees no difference
between it and an open(2).  There aren't separate permission checking
code paths or security hooks for the two operations, either for DAC or
SELinux.  The only difference is that access(2) brackets the call to
permission() with manipulation of the uid/gid/capabilities so that the
check is made against the "real" credentials rather than the "effective"
credentials, but such manipulation is not done for the SELinux
SID/context.

(*) Unless the application is suid/sgid and the caller was authorized to
write but the new fs uid/gid is not.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
