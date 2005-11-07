Subject: [PATCH] semanage - rename instead of copy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-GXAw1pLqkoOYmCFophPS"
Date: Mon, 07 Nov 2005 16:25:34 -0500
Message-Id: <1131398734.21419.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GXAw1pLqkoOYmCFophPS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached patch makes libsemanage copy file to a temporary file and then
rename() instead of copying directly to the target. This is necessary so
that an install failure doesn't leave a corrupt binary policy on the
system.

Joshua

--=-GXAw1pLqkoOYmCFophPS
Content-Disposition: attachment; filename=1-rename-files.diff
Content-Type: text/x-patch; name=1-rename-files.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-11-07 11:52:28.000000000 -0500
+++ libsemanage/src/semanage_store.c	2005-11-07 16:06:04.000000000 -0500
@@ -305,12 +305,18 @@ static int semanage_filename_select(cons
  * overwrite it.  Returns 0 on success, -1 on error. */
 static int semanage_copy_file(const char *src, const char *dst) {
 	int in, out, retval = 0, amount_read;
+	char tmp[PATH_MAX] = {};
 	char buf[4192];
 
 	if ((in = open(src, O_RDONLY)) == -1) {
 		return -1;
 	}
-	if ((out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
+	
+	snprintf(tmp, PATH_MAX, "%s.tmp", dst);
+	if (!tmp)
+		return -1;
+
+	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		close(in);
 		return -1;
 	}
@@ -324,6 +330,10 @@ static int semanage_copy_file(const char
 		retval = -1;
 	close(in);
 	close(out);
+
+	if (rename(tmp, dst) == -1)
+		return -1;
+
 	return retval;
 }
 

--=-GXAw1pLqkoOYmCFophPS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
