Subject: [patch 2/2] libselinux: add support for getting contexts for
	kernel initial SIDs from selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 15:37:27 -0400
Message-Id: <1175888247.25329.85.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to libselinux to get a userspace SID for a kernel initial
security identifier specified by name from the selinuxfs interface.  It
is a convenience function that calls security_get_initial_context_raw()
and avc_context_to_sid_raw().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---

 include/selinux/avc.h              |   11 +++++++++++
 man/man3/avc_context_to_sid.3      |    7 ++++++-
 man/man3/avc_get_initial_context.3 |    1 +
 src/avc.c                          |   15 +++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

Index: libselinux/include/selinux/avc.h
===================================================================
--- libselinux/include/selinux/avc.h	(revision 2318)
+++ libselinux/include/selinux/avc.h	(working copy)
@@ -78,6 +78,17 @@
  */
 	int sidput(security_id_t sid);
 
+/**
+ * avc_get_initial_sid - get SID for an initial kernel security
identifier
+ * @name: input name of initial kernel security identifier
+ * @sid: pointer to a SID reference
+ *
+ * Get the context for an initial kernel security identifier specified
by 
+ * @name using security_get_initial_context() and then call 
+ * avc_context_to_sid() to get the corresponding SID.
+ */
+	int avc_get_initial_sid(const char * name, security_id_t * sid);
+
 /*
  * AVC entry
  */
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2318)
+++ libselinux/src/avc.c	(working copy)
@@ -278,6 +278,21 @@
 	return rc;
 }
 
+int avc_get_initial_sid(const char * name, security_id_t * sid)
+{
+	int rc;
+	security_context_t con;
+
+	rc = security_get_initial_context_raw(name, &con);
+	if (rc < 0)
+		return rc;
+	rc = avc_context_to_sid_raw(con, sid);
+
+	freecon(con);
+
+	return rc;
+}
+
 int avc_init(const char *prefix,
 	     const struct avc_memory_callback *mem_cb,
 	     const struct avc_log_callback *log_cb,
Index: libselinux/man/man3/avc_get_initial_context.3
===================================================================
--- libselinux/man/man3/avc_get_initial_context.3	(revision 0)
+++ libselinux/man/man3/avc_get_initial_context.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/avc_context_to_sid.3
Index: libselinux/man/man3/avc_context_to_sid.3
===================================================================
--- libselinux/man/man3/avc_context_to_sid.3	(revision 2318)
+++ libselinux/man/man3/avc_context_to_sid.3	(working copy)
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@epoch.ncsc.mil) 2004
 .TH "avc_context_to_sid" "3" "27 May 2004" "" "SE Linux API
documentation"
 .SH "NAME"
-avc_context_to_sid, avc_sid_to_context, sidput, sidget \- obtain and
manipulate SELinux security ID's.
+avc_context_to_sid, avc_sid_to_context, sidput, sidget,
avc_get_initial_sid \- obtain and manipulate SELinux security ID's.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
@@ -16,6 +16,8 @@
 .BI "int sidget(security_id_t " sid ");"
 .sp
 .BI "int sidput(security_id_t " sid ");"
+.BI "int avc_get_initial_sid(const char *" name ", security_id_t *" sid
");"
+.sp
 .SH "DESCRIPTION"
 Security ID's (SID's) are reference-counted, opaque representations of
security contexts.  
 
@@ -45,6 +47,9 @@
 by 1.  If the count ever reaches zero, the SID becomes
 invalid and must not be used any further.
 
+.B avc_get_initial_sid
+returns a SID for the initial kernel security identifier specified by
name
+
 .SH "RETURN VALUE"
 .B sidget
 and

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
