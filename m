Subject: [patch] libsemanage:  clear errno ENOMEM from libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 16:41:22 -0500
Message-Id: <1196372482.24040.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On errors during libsepol processing (missing requirements, 
neverallow failure, etc), we are getting a bogus "Could not allocate memory"
message appended to the libsepol error message by libsemanage when
it reports strerror(errno), which was added to provide useful messages
on e.g. filesystem full or read-only filesystem errors.  It appears that
errno is getting set by glibc upon some memory allocations performed by
libsepol even when it ultimately succeeds.  So for now, clear such errnos
from libsepol - on real out of memory conditions, libsepol already tells
us that in its own error message.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsemanage/src/debug.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: trunk/libsemanage/src/debug.c
===================================================================
--- trunk/libsemanage/src/debug.c	(revision 2692)
+++ trunk/libsemanage/src/debug.c	(working copy)
@@ -103,6 +103,10 @@
 	if (!sh->msg_callback)
 		return;
 
+	/* Clear transient memory allocation error, non-fatal. */
+	if (errno == ENOMEM)	
+		errno = 0; 
+
 	va_start(ap, fmt);
 	vsnprintf(buffer, sizeof(buffer), fmt, ap);
 	va_end(ap);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
