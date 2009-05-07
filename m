Subject: SELinux and access(2), we want to know.
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 07 May 2009 15:18:44 -0400
Message-Id: <1241723924.2791.107.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux (and I assume all LSMs) have a bit of a problem with with the
access(2) call.  If a process calls access("/etc/shadow", R_OK) I claim
that we darn sure better return the same result that open("/etc/shadow",
O_RDONLY) would return.  I'm guessing noone is going to argue that
point.  Lets me also say this is only interesting if DAC allows a given
operation but MAC disallows it.  If DAC denies the request none of this
matters.

The only way to tell the right result for access() is for SELinux to
actually do the checks between (subject, file, read).  Again not a lot
of controversy here.

Lets say that the LSM does not allow read for the given subject
to /etc/shadow.  SELinux just denied an operation.  Today we log that a
process was just denied the ability to read /etc/shadow.  But the
process didn't actually try to read it.  If you surf with nautilus
to /etc it's going to call access() on everything to decide what kind of
little icons to put up there.  This could generate hundreds of SELinux
denials that nautilus tried to read everything in /etc.

What SELinux has to do today for programs like this is to not audit the
permission check (subject, file, read).  The problem here is that if the
program does act badly, and actually tries to read the file rather than
just call access() SELinux won't notify us, or report the denial in the
audit log.

I want/need a way for SELinux to know that a particular check can from
access() rather than from a truly misbehaving program.  That way I can
not send denial messages to the log if people just call access(2) but
will send a denial if the program does something illegal.  We had a long
discussion on the SELinux list about how we want to handle and log the
differences, but from the point of view of the VFS all that matters is
that we want to know when inode_permission is being called in access()
or from somewhere else.  The discussion was between not logging ANY
denials SELiunx causes from the access() call and being smarter about
only not logging those we really don't care about in a more fine grained
manor (I plan to go with fine grained version of not logging denials).
The philosophical question is really if there is (and I claim there is)
a difference between access() and open() and if we agree there is a
difference SELinux needs to know about it so logging those is different.

I propose 2 possible solutions.
1) a new VFS flag next to MAY_READ, MAY_WRITE and friends possibly
called "FROM_ACCESS" which we pass down to the LSM in faccessat during
the inode_permission call.

2) a new LSM hook.  security_inode_access_permission() which is called
from inode_permission() along with associated flags and such to
inode_permissions so the LSM knows where this call is coming from.

3) I've also heard it hinted that we could do this with audit by just
having audit drop the denials that include the access(2) syscall and the
scontext and tcontext for the slew of things the SELinux policy writers
know we are not interested in.  And while it seems good, now we have
SELinux 'policy' in places other than the policy, harder to distribute,
and it requires that everyone who turns on SELinux also turns on syscall
auditing with its associated overhead.

Obviously I think the right thing to decide if an LSM wants to send a
denial message or not is the LSM.  The only problem I have is that the
LSM doesn't know today when it is getting different types or requests
and so can't make that decision.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
