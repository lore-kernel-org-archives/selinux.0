Subject: [PATCH] sepol, write.c policy version
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-dhI66z5XMBnemhDkeo6K"
Date: Thu, 22 Sep 2005 16:56:47 -0400
Message-Id: <1127422608.21806.49.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dhI66z5XMBnemhDkeo6K
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Make version comparisons correctly compare kernel policies with kernel
versions and module policies with module versions.

Joshua Brindle

--=-dhI66z5XMBnemhDkeo6K
Content-Disposition: attachment; filename=12-sepol-write-version.patch
Content-Type: text/x-patch; name=12-sepol-write-version.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/write.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/write.c	2005-09-21 11:27:28.000000000 -0400
@@ -51,11 +51,11 @@ static int avrule_write_list(avrule_t *a
 
 int sepol_set_policyvers(unsigned int type, unsigned int version)
 {
-	if (type == POLICY_KERN || type == POLICY_BASE) {
+        if (type == POLICY_KERN) {
 		if (version < POLICYDB_VERSION_MIN || version > POLICYDB_VERSION_MAX)
 			return -EINVAL;
 	}
-        else if (type == POLICY_MOD) {
+        else if (type == POLICY_BASE || type == POLICY_MOD) {
                 if (version < MOD_POLICYDB_VERSION_MIN ||
                     version > MOD_POLICYDB_VERSION_MAX) {
                         return -EINVAL;

--=-dhI66z5XMBnemhDkeo6K--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
