Subject: Re: libselinux patch to add securetty rewritten with getline and
	using Lindent
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <45A3AE94.40300@redhat.com>
References: <45A3AE94.40300@redhat.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:11:19 -0500
Message-Id: <1168373479.7993.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.33.3/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-1.33.3/include/selinux/selinux.h	2007-01-09 09:49:51.000000000 -0500
@@ -406,6 +406,7 @@
 	extern const char *selinux_homedir_context_path(void);
 	extern const char *selinux_media_context_path(void);
 	extern const char *selinux_contexts_path(void);
+	extern const char *selinux_securetty_context_path(void);

(nit) The above function is called "securetty_context" but the file is
called "securetty_contexts".  And the file actually contains just type
names.  Seems prone to confusion.  Other question is whether we should
be re-using the term 'securetty' here since it has a different meaning
in /etc/securetty (ttys from which root can login).

@@ -413,12 +414,15 @@
 	extern const char *selinux_translations_path(void);
 	extern const char *selinux_netfilter_context_path(void);
 	extern const char *selinux_path(void);
-
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 	extern int selinux_check_passwd_access(access_vector_t requested);
 	extern int checkPasswdAccess(access_vector_t requested);
 
+/* Check if the tty_context is defined as a securetty
+   Return 1 if secure, 0 if not, or -1 if otherwise. */
+	extern int selinux_check_securetty_context(security_context_t
+						   tty_context);

If it is going to be a boolean function, I think I'd call it
selinux_is_securetty_context() or similar.  But note that this requires
care in the callers to explicitly check for != 1, versus a simple if
(selinux_check_securetty_context(c)) { handle_error(); } that you could
do if it followed the convention of returning 0 on secure tty and < 0 on
insecure tty or error (ala security_check_context).

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_check_securetty_context.c libselinux-1.33.3/src/selinux_check_securetty_context.c
--- nsalibselinux/src/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/src/selinux_check_securetty_context.c	2007-01-09 10:00:58.000000000 -0500
@@ -0,0 +1,54 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include "selinux_internal.h"
+#include "context_internal.h"
+
+int selinux_check_securetty_context(security_context_t tty_context)
+{
+	char *line = NULL;
+	char *start, *end = NULL;
+	size_t line_len = 0;
+	size_t len;

Should be ssize_t len;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
