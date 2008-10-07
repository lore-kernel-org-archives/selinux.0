Message-ID: <48EB2FA2.9090104@ak.jp.nec.com>
Date: Tue, 07 Oct 2008 18:45:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        ewalsh@tycho.nsa.gov
Subject: permissive domain interface (Re: typebounds lookup from userspace)
References: <48D3B220.1060903@manicmethod.com> <48EB0B75.1030108@ak.jp.nec.com>
In-Reply-To: <48EB0B75.1030108@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------070602030603050704040306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070602030603050704040306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> If "/selinux/access" can return the 6th value to show whether the given 
> query should be handled as permissive domain or not, it helps userspace
 > object managers.

I tried to make a patch as a proof of concept, like:

[root@saba ~]# semanage permissive -a staff_t
[kaigai@saba php-5.2.6]$ ./sapi/cli/php -r    \
'$scontext = "staff_u:staff_r:staff_t";
  $tcontext = "system_u:object_r:etc_t";
  $tclass = selinux_string_to_class("file");

  $avd = selinux_compute_av($scontext, $tcontext, $tclass);
  var_dump($avd);'

array(6) {
   ["allowed"]=>
   int(139347)
   ["decided"]=>
   int(-1)
   ["auditallow"]=>
   int(0)
   ["auditdeny"]=>
   int(-17)
   ["seqno"]=>
   int(2)
   ["permissive"]=>
   bool(true)
}      ^^^^

[kaigai@saba php-5.2.6]$ ./sapi/cli/php -r    \
'$scontext = "user_u:user_r:user_t";
  $tcontext = "system_u:object_r:etc_t";
  $tclass = selinux_string_to_class("file");

  $avd = selinux_compute_av($scontext, $tcontext, $tclass);
  var_dump($avd);'
array(6) {
   ["allowed"]=>
   int(139347)
   ["decided"]=>
   int(-1)
   ["auditallow"]=>
   int(0)
   ["auditdeny"]=>
   int(-17)
   ["seqno"]=>
   int(2)
   ["permissive"]=>
   bool(false)
}      ^^^^^
----

This patch also improves atomicity between av_decision and "permissive domain"
property at avc_has_perm_noaudit(). It should be checked within same critical
section protected by policy_rwlock in strictly, but the current implementation
has a theoretical possibility that a new policy is loaded between
security_compute_av() and security_permissive_sid(). :-)

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070602030603050704040306
Content-Type: text/x-patch;
 name="permissive-domain-interface-libselinux.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="permissive-domain-interface-libselinux.1.patch"

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2950)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -130,8 +130,11 @@
 	access_vector_t auditallow;
 	access_vector_t auditdeny;
 	unsigned int seqno;
+	unsigned int flags;
 };
 
+#define SELINUX_AV_FLAGS_PERMISSIVE		0x0001
+
 /* Structure for passing options, used by AVC and label subsystems */
 struct selinux_opt {
 	int type;
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2950)
+++ libselinux/src/avc.c	(working copy)
@@ -855,11 +855,12 @@
 	denied = requested & ~(ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (avc_enforcing) {
+		if (!avc_enforcing || (ae->avd.flags & SELINUX_AV_FLAGS_PERMISSIVE))
+			ae->avd.allowed |= requested;
+		else {
 			errno = EACCES;
 			rc = -1;
-		} else
-			ae->avd.allowed |= requested;
+		}
 	}
 
       out:
@@ -873,7 +874,7 @@
 		 security_class_t tclass, access_vector_t requested,
 		 struct avc_entry_ref *aeref, void *auditdata)
 {
-	struct av_decision avd = { 0, 0, 0, 0, 0 };
+	struct av_decision avd = { 0, 0, 0, 0, 0, 0 };
 	int errsave, rc;
 
 	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
Index: libselinux/src/compute_av.c
===================================================================
--- libselinux/src/compute_av.c	(revision 2950)
+++ libselinux/src/compute_av.c	(working copy)
@@ -49,9 +49,13 @@
 	if (ret < 0)
 		goto out2;
 
-	if (sscanf(buf, "%x %x %x %x %u", &avd->allowed,
-		   &avd->decided, &avd->auditallow, &avd->auditdeny,
-		   &avd->seqno) != 5) {
+	ret = sscanf(buf, "%x %x %x %x %u %x",
+		     &avd->allowed, &avd->decided,
+		     &avd->auditallow, &avd->auditdeny,
+		     &avd->seqno, &avd->flags);
+	if (ret == 5)
+		avd->flags = 0;
+	else if (ret < 5 || ret > 6) {
 		ret = -1;
 		goto out2;
 	}

--------------070602030603050704040306
Content-Type: text/x-patch;
 name="permissive-domain-interface-kernel.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="permissive-domain-interface-kernel.1.patch"

 security/selinux/avc.c              |    2 +-
 security/selinux/include/security.h |    3 ++-
 security/selinux/selinuxfs.c        |    4 ++--
 security/selinux/ss/services.c      |   30 +++++-------------------------
 4 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cb30c7e..0a8e3e1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -904,7 +904,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	if (denied) {
 		if (flags & AVC_STRICT)
 			rc = -EACCES;
-		else if (!selinux_enforcing || security_permissive_sid(ssid))
+		else if (!selinux_enforcing || (p_ae->avd.flags & AV_FLAGS_PERMISSIVE))
 			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
 					tsid, tclass);
 		else
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7244737..3f3ebd2 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -84,9 +84,10 @@ struct av_decision {
 	u32 auditallow;
 	u32 auditdeny;
 	u32 seqno;
+	u32 flags;
 };
 
-int security_permissive_sid(u32 sid);
+#define AV_FLAGS_PERMISSIVE	0x0001
 
 int security_compute_av(u32 ssid, u32 tsid,
 	u16 tclass, u32 requested,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 69c9dcc..17360c9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -589,10 +589,10 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 		goto out2;
 
 	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
-			  "%x %x %x %x %u",
+			  "%x %x %x %x %u %x",
 			  avd.allowed, avd.decided,
 			  avd.auditallow, avd.auditdeny,
-			  avd.seqno);
+			  avd.seqno, avd.flags);
 out2:
 	kfree(tcon);
 out:
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ab0cc0c..a815cfa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -411,6 +411,7 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
+	avd->flags = 0;
 
 	/*
 	 * Check for all the invalid cases.
@@ -529,31 +530,6 @@ inval_class:
 	return 0;
 }
 
-/*
- * Given a sid find if the type has the permissive flag set
- */
-int security_permissive_sid(u32 sid)
-{
-	struct context *context;
-	u32 type;
-	int rc;
-
-	read_lock(&policy_rwlock);
-
-	context = sidtab_search(&sidtab, sid);
-	BUG_ON(!context);
-
-	type = context->type;
-	/*
-	 * we are intentionally using type here, not type-1, the 0th bit may
-	 * someday indicate that we are globally setting permissive in policy.
-	 */
-	rc = ebitmap_get_bit(&policydb.permissive_map, type);
-
-	read_unlock(&policy_rwlock);
-	return rc;
-}
-
 static int security_validtrans_handle_fail(struct context *ocontext,
 					   struct context *ncontext,
 					   struct context *tcontext,
@@ -769,6 +745,10 @@ int security_compute_av(u32 ssid,
 
 	rc = context_struct_compute_av(scontext, tcontext, tclass,
 				       requested, avd);
+
+	/* check permissive domain */
+	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
+		avd->flags |= AV_FLAGS_PERMISSIVE;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;

--------------070602030603050704040306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
