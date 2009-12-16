Subject: Re: FILE__EXECMOD and other assorted file permission layout issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1260913984.2788.80.camel@localhost>
References: <1260913984.2788.80.camel@localhost>
Content-Type: text/plain
Date: Wed, 16 Dec 2009 10:21:53 -0500
Message-Id: <1260976913.19290.30.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-12-15 at 16:53 -0500, Eric Paris wrote:
> I started poking around the other day and realized FILE__EXECMOD and how
> it is used can be problematic.  Namely with blk files it is possible to
> cause the kernel to check SECCLASS_BLK_FILE + FILE__EXECMOD.  Turns out
> 0x00080000 isn't defined for SECCLASS_BLK_FILE.  It appears at some
> point in history the same thing was found for char files and we added
> EXECUTE_NO_TRANS and ENTRYPOINT to get it to line up.

Yes, here:
http://marc.info/?t=110719285000001&r=1&w=2
http://marc.info/?l=linux-kernel&m=110726995005177&w=2

> We can't leave it the way it is for block files as if a perm ever gets
> to there the kernel could check the wrong thing.  The 'easiest' fix is
> to move the EXECMOD declaration into COMMON_FILE_PERMS, and I'm assuming
> you can't call mmap + write + mprotect on a socket, else we need to move
> it to COMMON_FILE_SOCK_PERMS if I understand correctly.

I don't believe you need to put it into COMMON_FILE_SOCK_PERMS.

> If you agree it's a problem we should address and this is a good method
> I'll look into the details.

Yes, that sounds right, and we no longer need to worry about it lining
up with the policy definitions thankfully.

> The other thing I noticed is that we don't use FILE__SWAPON at all.
> Should I just drop SWAPON from the list of kernel perms?

Either that or forward port the LSM hook that used it from the original
LSM patches and SELinux module ;)

> OPEN.  I did the horrid per secclass open perms.  Should I move that
> into COMMON_FILE_SOCK_PERMS and drop all of the special case code?

Just COMMON_FILE_PERMS, I think.   Don't confuse the sock_file class
(socket file object in the filesystem) with the socket classes (socket
object).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
