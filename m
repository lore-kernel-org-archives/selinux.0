Message-ID: <43F354A3.6000203@cornell.edu>
Date: Wed, 15 Feb 2006 11:19:47 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Bugfix patch
Content-Type: multipart/mixed;
 boundary="------------080506080406000703020304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080506080406000703020304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix bugs in recent patches (and some additional ones).
I need to be more careful.... the tests will pass usually, since I don't 
have any local customizations.



--------------080506080406000703020304
Content-Type: text/x-patch;
 name="semanage.sepol.utils.bugfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.sepol.utils.bugfix.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-02-14 23:07:09.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-02-15 11:10:23.000000000 -0500
@@ -102,8 +102,8 @@ static const char *semanage_sandbox_path
 	"/booleans.local",
 	"/file_contexts.local",
 	"/seusers",
-	"/users_extra.local",
 	"/users.local",
+	"/users_extra.local",
 	"/seusers.final",
 	"/users_extra",
 };
diff -Naurp --exclude-from excludes old/libsepol/src/nodes.c new/libsepol/src/nodes.c
--- old/libsepol/src/nodes.c	2006-02-14 23:07:16.000000000 -0500
+++ new/libsepol/src/nodes.c	2006-02-15 11:13:01.000000000 -0500
@@ -300,7 +300,7 @@ int sepol_node_modify(
 	const sepol_node_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t *c, *head, *prev = NULL, *node = NULL;
+	ocontext_t *node = NULL;
 
 	int proto;
 	const char *addr, *mask;
diff -Naurp --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-02-14 23:07:16.000000000 -0500
+++ new/libsepol/src/ports.c	2006-02-15 11:12:36.000000000 -0500
@@ -253,7 +253,7 @@ int sepol_port_modify(
 	const sepol_port_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t *c, *head, *prev = NULL, *port = NULL;
+	ocontext_t *port = NULL;
 
 	int low, high, proto;
 	const char* proto_str;
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-02-14 13:48:16.000000000 -0500
+++ new/policycoreutils/semanage/semanage	2006-02-15 11:15:44.000000000 -0500
@@ -41,6 +41,7 @@ Primary Options:\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
 	-m, --modify     Modify a OBJECT record NAME\n\
 	-l, --list       List the OBJECTS\n\n\
+\
 	-h, --help       Display this message\n\
 	-n, --noheading  Do not print heading when listing OBJECTS\n\n\
 \
@@ -51,8 +52,8 @@ Object-specific Options (see above):\n\
 		-d (directory) \n\
 		-c (character device) \n\
 		-b (block device) \n\
-		-d (directory) \n\
 		-s (socket) \n\
+		-l (symbolic link) \n\
 		-p (named pipe) \n\n\
 \
 	-p, --proto      Port protocol (tcp or udp)\n\
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-02-14 15:03:55.000000000 -0500
+++ new/policycoreutils/semanage/seobject.py	2006-02-15 11:15:17.000000000 -0500
@@ -863,6 +863,7 @@ class fcontextRecords(semanageRecords):
 		self.file_types["block device"] = SEMANAGE_FCONTEXT_BLOCK;
 		self.file_types["-s"] = SEMANAGE_FCONTEXT_SOCK;
 		self.file_types["socket"] = SEMANAGE_FCONTEXT_SOCK;
+		self.file_types["-l"] = SEMANAGE_FCONTEXT_LINK;
 		self.file_types["symbolic link"] = SEMANAGE_FCONTEXT_LINK;
 		self.file_types["-p"] = SEMANAGE_FCONTEXT_PIPE;
 		self.file_types["named pipe"] = SEMANAGE_FCONTEXT_PIPE;

--------------080506080406000703020304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
