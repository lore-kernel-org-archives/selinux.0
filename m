Message-ID: <47AB8957.30601@tycho.nsa.gov>
Date: Thu, 07 Feb 2008 17:42:31 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: avc_compute_member convenience function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc_compute_member function, same as security_compute_member but takes 
userspace AVC SID's.  Includes man page.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/avc.h         |   18 ++++++++++++++++++
 man/man3/avc_compute_create.3 |   16 +++++++++++++---
 man/man3/avc_compute_member.3 |    1 +
 src/avc.c                     |   25 +++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 3 deletions(-)


Index: libselinux/include/selinux/avc.h
===================================================================
--- libselinux/include/selinux/avc.h	(revision 2793)
+++ libselinux/include/selinux/avc.h	(working copy)
@@ -322,6 +322,24 @@
 		       security_id_t tsid,
 		       security_class_t tclass, security_id_t * newsid);
 
+/**
+ * avc_compute_member - Compute SID for polyinstantation.
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @newsid: pointer to SID reference
+ *
+ * Call the security server to obtain a context for labeling an
+ * object instance.  Look up the context in the SID table, making
+ * a new entry if not found.  Increment the reference counter
+ * for the SID.  Store a pointer to the SID structure into the
+ * memory referenced by @newsid, returning %0 on success or -%1 on
+ * error with @errno set.  
+ */
+int avc_compute_member(security_id_t ssid,
+		       security_id_t tsid,
+		       security_class_t tclass, security_id_t * newsid);
+
 /* 
  * security event callback facility
  */
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2793)
+++ libselinux/src/avc.c	(working copy)
@@ -906,6 +906,31 @@
 	return rc;
 }
 
+int avc_compute_member(security_id_t ssid,  security_id_t tsid,
+		       security_class_t tclass, security_id_t *newsid)
+{
+	int rc;
+	*newsid = NULL;
+	avc_get_lock(avc_lock);
+	if (ssid->refcnt > 0 && tsid->refcnt > 0) {
+		security_context_t ctx = NULL;
+		rc = security_compute_member_raw(ssid->ctx, tsid->ctx, tclass,
+						 &ctx);
+		if (rc)
+			goto out;
+		rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
+		if (!rc)
+			(*newsid)->refcnt++;
+		freecon(ctx);
+	} else {
+		errno = EINVAL;	/* bad reference count */
+		rc = -1;
+	}
+out:
+	avc_release_lock(avc_lock);
+	return rc;
+}
+
 int avc_add_callback(int (*callback) (uint32_t event, security_id_t ssid,
 				      security_id_t tsid,
 				      security_class_t tclass,
Index: libselinux/man/man3/avc_compute_create.3
===================================================================
--- libselinux/man/man3/avc_compute_create.3	(revision 2793)
+++ libselinux/man/man3/avc_compute_create.3	(working copy)
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
 .TH "avc_compute_create" "3" "30 Mar 2007" "" "SELinux API documentation"
 .SH "NAME"
-avc_compute_create \- obtain SELinux label for new object.
+avc_compute_create, avc_compute_member \- obtain SELinux label for new object.
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 
@@ -12,15 +12,25 @@
 .BI "int avc_compute_create(security_id_t " ssid ", security_id_t " tsid ,
 .in +\w'int avc_compute_create('u
 .BI "security_class_t " tclass ", security_id_t *" newsid ");"
+.sp
 .in
+.BI "int avc_compute_member(security_id_t " ssid ", security_id_t " tsid ,
+.in +\w'int avc_compute_member('u
+.BI "security_class_t " tclass ", security_id_t *" newsid ");"
+.in
 .SH "DESCRIPTION"
 .B avc_compute_create
 is used to compute a SID to use for labeling a new object in a particular class based on a SID pair.  This call is identical to
 .BR security_compute_create ,
 but does not require converting from userspace SID's to contexts and back again.
 
-.B avc_compute_create
-returns a SID for the computed context in the memory referenced by
+.B avc_compute_member
+is used to compute a SID to use for labeling a polyinstantiated object instance of a particular class based on a SID pair.  This call is identical to
+.BR security_compute_member ,
+but does not require converting from userspace SID's to contexts and back again.
+
+These functions
+return a SID for the computed context in the memory referenced by
 .IR sid ,
 incrementing its reference count by 1.
 
Index: libselinux/man/man3/avc_compute_member.3
===================================================================
--- libselinux/man/man3/avc_compute_member.3	(revision 0)
+++ libselinux/man/man3/avc_compute_member.3	(revision 0)
@@ -0,0 +1 @@
+.so man3/avc_compute_create.3

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
