Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n66EgJr8000651
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:42:19 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n66EgwhR025172
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:42:58 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n66EgIFF013479
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:42:18 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n66EgHON002190
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:42:17 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n66EgHJp004202
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 10:42:17 -0400
Message-ID: <4A520D47.4040708@redhat.com>
Date: Mon, 06 Jul 2009 10:42:15 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Patch 1/2] libsepol: method to check disable dontaudit flag.
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com>	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil> <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090000020607030100080700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090000020607030100080700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch adds the ability to check on the value of the disable_dontaudit flag in the sepol handle. In the past the only way to know the value of this was to directly read the values from the handle. The get function provides a setter-getter symmetry similar to other functions found in libsepol.

Signed-off-by: Christopher Pardy <cpardy@redhat.com>

---
 libsepol/include/sepol/handle.h |    6 ++++++
 libsepol/src/handle.c           |    6 ++++++
 libsepol/src/libsepol.map       |    1 +
 3 files changed, 13 insertions(+)


diff -urN selinux.orig/libsepol/include/sepol/handle.h selinux/libsepol/include/sepol/handle.h
--- selinux.orig/libsepol/include/sepol/handle.h	2009-07-01 21:05:26.823235749 -0400
+++ selinux/libsepol/include/sepol/handle.h	2009-07-01 21:08:33.277237031 -0400
@@ -7,6 +7,12 @@
 /* Create and return a sepol handle. */
 sepol_handle_t *sepol_handle_create(void);
 
+/* Get whether or not dontaudits will be disabled, same values as
+ * specified by disable dont audit. This value reflects the state
+ * your system will be set to upon commit, not nessesarily it's
+ * current state.*/
+int sepol_get_disable_dontaudit(sepol_handle_t * sh);
+
 /* Set whether or not to disable dontaudits, 0 is default and does 
  * not disable dontaudits, 1 disables them */
 void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit);
diff -urN selinux.orig/libsepol/src/handle.c selinux/libsepol/src/handle.c
--- selinux.orig/libsepol/src/handle.c	2009-07-01 21:05:26.854236864 -0400
+++ selinux/libsepol/src/handle.c	2009-07-01 21:07:15.532236991 -0400
@@ -21,6 +21,12 @@
 	return sh;
 }
 
+int sepol_get_disable_dontaudit(sepol_handle_t *sh)
+{
+	assert(sh !=NULL);
+	return sh->disable_dontaudit;
+}
+
 void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh !=NULL);
diff -urN selinux.orig/libsepol/src/libsepol.map selinux/libsepol/src/libsepol.map
--- selinux.orig/libsepol/src/libsepol.map	2009-07-01 21:05:26.848236011 -0400
+++ selinux/libsepol/src/libsepol.map	2009-07-01 21:07:45.948485729 -0400
@@ -12,6 +12,7 @@
 	sepol_policydb_*; sepol_set_policydb_from_file; 
 	sepol_policy_kern_*;
 	sepol_policy_file_*;
+	sepol_get_disable_dontaudit;
 	sepol_set_disable_dontaudit;
 	sepol_set_expand_consume_base;
   local: *;

--------------090000020607030100080700
Content-Type: text/plain;
 name="selinux.patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch1"

diff -urN selinux.orig/libsepol/include/sepol/handle.h selinux/libsepol/include/sepol/handle.h
--- selinux.orig/libsepol/include/sepol/handle.h	2009-07-01 21:05:26.823235749 -0400
+++ selinux/libsepol/include/sepol/handle.h	2009-07-01 21:08:33.277237031 -0400
@@ -7,6 +7,12 @@
 /* Create and return a sepol handle. */
 sepol_handle_t *sepol_handle_create(void);
 
+/* Get whether or not dontaudits will be disabled, same values as
+ * specified by disable dont audit. This value reflects the state
+ * your system will be set to upon commit, not nessesarily it's
+ * current state.*/
+int sepol_get_disable_dontaudit(sepol_handle_t * sh);
+
 /* Set whether or not to disable dontaudits, 0 is default and does 
  * not disable dontaudits, 1 disables them */
 void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit);
diff -urN selinux.orig/libsepol/src/handle.c selinux/libsepol/src/handle.c
--- selinux.orig/libsepol/src/handle.c	2009-07-01 21:05:26.854236864 -0400
+++ selinux/libsepol/src/handle.c	2009-07-01 21:07:15.532236991 -0400
@@ -21,6 +21,12 @@
 	return sh;
 }
 
+int sepol_get_disable_dontaudit(sepol_handle_t *sh)
+{
+	assert(sh !=NULL);
+	return sh->disable_dontaudit;
+}
+
 void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh !=NULL);
diff -urN selinux.orig/libsepol/src/libsepol.map selinux/libsepol/src/libsepol.map
--- selinux.orig/libsepol/src/libsepol.map	2009-07-01 21:05:26.848236011 -0400
+++ selinux/libsepol/src/libsepol.map	2009-07-01 21:07:45.948485729 -0400
@@ -12,6 +12,7 @@
 	sepol_policydb_*; sepol_set_policydb_from_file; 
 	sepol_policy_kern_*;
 	sepol_policy_file_*;
+	sepol_get_disable_dontaudit;
 	sepol_set_disable_dontaudit;
 	sepol_set_expand_consume_base;
   local: *;

--------------090000020607030100080700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
