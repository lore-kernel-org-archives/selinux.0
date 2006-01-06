Message-ID: <43BE9B0D.409@cornell.edu>
Date: Fri, 06 Jan 2006 11:30:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fix fcontext comparator
Content-Type: multipart/mixed;
 boundary="------------050806000104050105050400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050806000104050105050400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The comparator for fcontext is wrong.
This should fix the problem Dan is having with the fcontext exists 
function - let me know if it works.




--------------050806000104050105050400
Content-Type: text/x-patch;
 name="libsemanage.fix_fcontext_comparator.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_fcontext_comparator.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-06 09:36:30.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2006-01-06 11:27:40.000000000 -0500
@@ -81,8 +81,18 @@ int semanage_fcontext_compare(
 	const semanage_fcontext_t* fcontext, 
 	const semanage_fcontext_key_t* key) {
 
-	return strcmp(fcontext->expr, key->expr) && 
-		(fcontext->type == key->type);
+	int rv = strcmp(fcontext->expr, key->expr);
+	if (rv != 0)
+		return rv;
+	else {
+		if (fcontext->type < key->type)	
+			return -1;
+	
+		else if (key->type < fcontext->type)
+			return 1;
+	
+		else return 0;
+	}
 }
 hidden_def(semanage_fcontext_compare)
 
@@ -90,8 +100,18 @@ int semanage_fcontext_compare2(
 	const semanage_fcontext_t* fcontext,
 	const semanage_fcontext_t* fcontext2) {
 
-	return strcmp(fcontext->expr, fcontext2->expr) &&
-		(fcontext->type == fcontext2->type);
+	int rv = strcmp(fcontext->expr, fcontext2->expr);
+	if (rv != 0)
+		return rv;
+	else {
+		if (fcontext->type < fcontext2->type)
+			return -1;
+
+		else if (fcontext2->type < fcontext->type)
+			return 1;
+
+		else return 0;
+	}
 }
 hidden_def(semanage_fcontext_compare2)
 

--------------050806000104050105050400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
