Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UHmrfN028013
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:48:53 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UHmqnf012421
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 17:48:52 GMT
Received: from [144.51.25.7] (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2UHmqn1010173
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:48:52 -0400
Message-ID: <460D4D84.6040307@tycho.nsa.gov>
Date: Fri, 30 Mar 2007 13:48:52 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libselinux: string and compute_create functions
References: <460D495B.3060000@tycho.nsa.gov>
In-Reply-To: <460D495B.3060000@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc_compute_create function, same as security_compute_create but
takes userspace AVC SID's.

--
 include/selinux/avc.h |   19 +++++++++++++++++++
 src/avc.c             |   25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

--
Index: src/avc.c
===================================================================
--- src/avc.c	(revision 2307)
+++ src/avc.c	(working copy)
@@ -1006,6 +1006,31 @@
 	return rc;
 }
 
+int avc_compute_create(security_id_t ssid,  security_id_t tsid,
+		       security_class_t tclass, security_id_t *newsid)
+{
+	int rc;
+	*ctx = NULL;
+	avc_get_lock(avc_lock);
+	if (ssid->refcnt > 0 && tsid->refcnt > 0) {
+		security_context_t ctx;
+		rc = security_compute_create_raw(ssid->ctx, tsid->ctx, tclass,
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
Index: include/selinux/avc.h
===================================================================
--- include/selinux/avc.h	(revision 2307)
+++ include/selinux/avc.h	(working copy)
@@ -274,6 +274,25 @@
 		       security_class_t tclass, access_vector_t requested,
 		       struct av_decision *avd, int result, void *auditdata);
 
+/**
+ * avc_compute_create - Compute SID for labeling a new object.
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @newsid: pointer to SID reference
+ *
+ * Call the security server to obtain a context for labeling a
+ * new object.  Look up the context in the SID table, making
+ * a new entry if not found.  Increment the reference counter
+ * for the SID.  Store a pointer to the SID structure into the
+ * memory referenced by @newsid, returning %0 on success or -%1 on
+ * error with @errno set.  
+ */
+	int avc_compute_create(security_id_t ssid,
+			       security_id_t tsid,
+			       security_class_t tclass,
+			       security_id_t *newsid);
+
 /* 
  * security event callback facility
  */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
