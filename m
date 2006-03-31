Message-ID: <442D70FC.20404@cornell.edu>
Date: Fri, 31 Mar 2006 13:12:12 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: [SEPOL] Fix leak of optional package sections
Content-Type: multipart/mixed;
 boundary="------------030408070001030409030009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030408070001030409030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sometimes it pays off to wait 5+ minutes for valgrind to process the 
semanage strict commit :)

--------------030408070001030409030009
Content-Type: text/x-patch;
 name="libsepol.optionals_leak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.optionals_leak.diff"

diff -Naurp --exclude-from excludes old/libsepol/src/module.c new/libsepol/src/module.c
--- old/libsepol/src/module.c	2006-03-29 14:34:12.000000000 -0500
+++ new/libsepol/src/module.c	2006-03-31 13:02:23.000000000 -0500
@@ -112,12 +112,14 @@ hidden_def(sepol_module_package_create)
  * the pointer itself.  Does nothing if p is NULL.
  */
 void sepol_module_package_free(sepol_module_package_t *p) {
-        if (p == NULL) {
-                return;
-        }
-        sepol_policydb_free(p->policy);
-        free(p->file_contexts);
-        free(p);
+	if (p == NULL)
+		return;
+
+	sepol_policydb_free(p->policy);
+	free(p->file_contexts);
+	free(p->seusers);
+	free(p->user_extra);
+	free(p);
 }
 hidden_def(sepol_module_package_free)
 

--------------030408070001030409030009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
