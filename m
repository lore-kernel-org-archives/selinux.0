Message-ID: <466991D1.2050005@tycho.nsa.gov>
Date: Fri, 08 Jun 2007 13:28:49 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 2/3] libselinux: class and permission mapping support (try
 3)
References: <4666D5E6.508@tycho.nsa.gov>	 <1181148038.17617.25.camel@moss-lions.epoch.ncsc.mil>	 <4666FE38.4060401@tycho.nsa.gov> <1181225909.7049.15.camel@localhost.localdomain>
In-Reply-To: <1181225909.7049.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes avc_reset() exit properly if the AVC
was not initialized.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 avc.c          |    5 +++++
 avc_internal.c |    1 +
 avc_internal.h |    1 +
 3 files changed, 7 insertions(+)


Index: libselinux/src/avc_internal.h
===================================================================
--- libselinux/src/avc_internal.h	(revision 2470)
+++ libselinux/src/avc_internal.h	(working copy)
@@ -71,6 +71,7 @@
 /* message prefix and enforcing mode*/
 #define AVC_PREFIX_SIZE 16
 extern char avc_prefix[AVC_PREFIX_SIZE] hidden;
+extern int avc_running hidden;
 extern int avc_enforcing hidden;
 
 /* user-supplied callback interface for avc */
Index: libselinux/src/avc_internal.c
===================================================================
--- libselinux/src/avc_internal.c	(revision 2470)
+++ libselinux/src/avc_internal.c	(working copy)
@@ -44,6 +44,7 @@
 
 /* message prefix string and avc enforcing mode */
 char avc_prefix[AVC_PREFIX_SIZE] = "uavc";
+int avc_running = 0;
 int avc_enforcing = 1;
 int avc_netlink_trouble = 0;
 
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2470)
+++ libselinux/src/avc.c	(working copy)
@@ -225,6 +225,7 @@
 		avc_netlink_thread = avc_create_thread(&avc_netlink_loop);
 		avc_netlink_trouble = 0;
 	}
+	avc_running = 1;
       out:
 	return rc;
 }
@@ -534,6 +535,9 @@
 	struct avc_node *node, *tmp;
 	errno = 0;
 
+	if (!avc_running)
+		return 0;
+
 	avc_get_lock(avc_lock);
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
@@ -609,6 +613,7 @@
 	avc_free_lock(avc_lock);
 	avc_free_lock(avc_log_lock);
 	avc_free(avc_audit_buf);
+	avc_running = 0;
 }
 
 /* ratelimit stuff put aside for now --EFW */



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
