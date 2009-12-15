Subject: FILE__EXECMOD and other assorted file permission layout issues
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 16:53:04 -0500
Message-Id: <1260913984.2788.80.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I started poking around the other day and realized FILE__EXECMOD and how
it is used can be problematic.  Namely with blk files it is possible to
cause the kernel to check SECCLASS_BLK_FILE + FILE__EXECMOD.  Turns out
0x00080000 isn't defined for SECCLASS_BLK_FILE.  It appears at some
point in history the same thing was found for char files and we added
EXECUTE_NO_TRANS and ENTRYPOINT to get it to line up.

We can't leave it the way it is for block files as if a perm ever gets
to there the kernel could check the wrong thing.  The 'easiest' fix is
to move the EXECMOD declaration into COMMON_FILE_PERMS, and I'm assuming
you can't call mmap + write + mprotect on a socket, else we need to move
it to COMMON_FILE_SOCK_PERMS if I understand correctly.

If you agree it's a problem we should address and this is a good method
I'll look into the details.

The other thing I noticed is that we don't use FILE__SWAPON at all.
Should I just drop SWAPON from the list of kernel perms?

OPEN.  I did the horrid per secclass open perms.  Should I move that
into COMMON_FILE_SOCK_PERMS and drop all of the special case code?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
