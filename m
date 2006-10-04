Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94GqsRD022586
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 12:52:54 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94Gph5l023193
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:51:43 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 88CE73797E
	for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2006 12:52:54 -0400 (EDT)
Message-ID: <4523E6D5.1040805@hp.com>
Date: Wed, 04 Oct 2006 12:52:37 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] enable/disable context translation in libselinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


There was a discussion on the redhat-lspp mailing list about a problem
with mcstransd and whether it needs to check whether the user is allowed
to see a translated context.  See
https://www.redhat.com/archives/redhat-lspp/2006-September/msg00086.html

While prototyping adding an avc_has_perm() to the mcstransd, we discovered
that avc_has_perm() can go down a path where it needs to translate the
context in order to make the check, which is not what we want to do from
mcstransd.  Stephen suggested adding a call in libselinux to allow a process
to enabled/disable translations for subsequent calls into libselinux so
the following patch does that.  Comments?

I'm also including a patch to mcstransd as a sample user of the library
routine but this patch is not ready for prime time since as Stephen pointed
out, we probably need a new class and permission so that the translation
policy can be different from the file access policy, Dan would like to see
the access check be configurable via setrans.conf and mcstransd still
doesn't use getpeercon().  I believe Darrel is going to take a shot
at at least the policy part.

-- ljk

 include/selinux/selinux.h |    4 ++++
 src/setrans_client.c      |   15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

--- libselinux-1.30.28/src/setrans_client.c     2006-09-13 13:37:04.000000000 -0400
+++ libselinux-1.30.28.ljk/src/setrans_client.c 2006-10-04 11:35:48.000000000 -0400
@@ -17,6 +17,7 @@
 #include "setrans_internal.h"

 static int mls_enabled = -1;
+static int trans_enabled = 1;

 // Simple cache
 static __thread security_context_t prev_t2r_trans = NULL;
@@ -245,7 +246,7 @@ int selinux_trans_to_raw_context(securit
                return 0;
        }

-       if (!mls_enabled) {
+       if (!mls_enabled || !trans_enabled) {
                *rawp = strdup(trans);
                goto out;
        }
@@ -287,7 +288,7 @@ int selinux_raw_to_trans_context(securit
                return 0;
        }

-       if (!mls_enabled) {
+       if (!mls_enabled || !trans_enabled) {
                *transp = strdup(raw);
                goto out;
        }
@@ -320,3 +321,13 @@ int selinux_raw_to_trans_context(securit
 }

 hidden_def(selinux_raw_to_trans_context)
+
+/*
+ * Enable/disable context translation.
+ * 0 means disable.
+ */
+void selinux_set_translation (int value)
+{
+       trans_enabled = value;
+       return;
+}
--- libselinux-1.30.28/include/selinux/selinux.h        2006-09-13
13:37:05.000000000 -0400
+++ libselinux-1.30.28.ljk/include/selinux/selinux.h    2006-10-04
11:37:44.000000000 -0400
@@ -444,6 +444,10 @@ extern "C" {
        extern int selinux_raw_to_trans_context(security_context_t raw,
                                                security_context_t * transp);

+/* Enable/disable the translation of contexts for the calling process.
+   0 means disabled */
+       extern void selinux_set_translation(int value);
+
 /* Get the SELinux username and level to use for a given Linux username.
    These values may then be passed into the get_ordered_context_list*
    and get_default_context* functions to obtain a context for the user.


--- mcstrans-0.1.8/src/mcstransd.c      2006-06-19 14:38:08.000000000 -0400
+++ mcstrans-0.1.8.ljk/src/mcstransd.c  2006-10-04 11:40:00.000000000 -0400
@@ -17,6 +17,9 @@
 #include <sys/types.h>
 #include <sys/capability.h>
 #include <sys/resource.h>
+#include <selinux/avc.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>

 #ifdef UNUSED
 #elif defined(__GNUC__)
@@ -71,22 +74,43 @@ static  __attribute__((noreturn)) void c
 }

 /*
+ * Check to see if the subject requesting the translation
+ * is cleared to see the translation.
+ * Returns: 0 on success (allowed), 1 on failure (denied).
+ */
+static int
+cleared_to_translate(char *in, char *pcon)
+{
+
+       security_id_t           ssid,tsid; /* SELinux SIDS                  */
+       int     retval;
+
+       avc_init(SETRANSD_PROGNAME, NULL, NULL, NULL, NULL);
+       if (avc_context_to_sid(pcon, &ssid) != 0)
+               return 1;
+       if (avc_context_to_sid(in, &tsid) != 0)
+               return 1;
+       retval = avc_has_perm(ssid, tsid, SECCLASS_FILE, FILE__GETATTR,
+                       NULL, NULL);
+       if (retval == 0)
+               return 0;
+       return 1;
+}
+
+/*
  * Convert raw label portion of a security context to translated label
  * Returns:  0 on success, 1 on failure
  */
 static int


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
