Message-ID: <43ADBD89.9080900@cornell.edu>
Date: Sat, 24 Dec 2005 16:28:41 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [SEMANAGE(tool)] Further exists/query bugfixes
Content-Type: multipart/mixed;
 boundary="------------020301080501040806040609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020301080501040806040609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- do not rely on query failure to check if a user exists - should use 
exist function instead
(especially since the rc value is now not 0, and returns commit numbers 
on success).

- Initialize level/range to "", not s0, in order for modify() to 
correctly detect that the user didn't enter anything
(because it tests if serange == "", which it doesn't)

Note: I notice the rc value isn't checked in 95% of the semanage 
functions being called.
Note2: The list function needs to be re-written somehow... not entirely 
sure how. Delete function needs more work.

First, there should be an indication somewhere whether a record is build 
into policy, or locally added, so the user will realize what he/she can 
do with the record. Second, consider the following scenario, which 
causes total confusion: (1) call list users, (2) call modify on root 
(built-in), (3) call list users, (4) call delete root, (5) call list users.

Here's what happens:
1) lists all local users + builtin users (like root)
2) modify will succeed, because you can modify in-policy records by 
writing a local record that overrides them
3) list will now show the modifications (and not show the original)
4) delete WILL succeed. Consider the checks I put in:
    Does the user exist: yes
    Does the user exist locally: yes
    In this case, the effect of delete is to delete the local 
modifications to the root user, but the in-policy copy remains behind.
5) now list shows the original root user

All of those problems are related to the fact that we're stacking local 
modifications on top of policy. Libsemanage provides info about the 
local data, and the end result (does not provide info about policy 
alone). Semnage (the tool) provides info only about the end result, and 
shows neither policy alone, nor local modifications alone.

--------------020301080501040806040609
Content-Type: text/x-patch;
 name="semanage2.query_exists_bugfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage2.query_exists_bugfixes.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2005-12-24 15:24:02.000000000 -0500
+++ new/policycoreutils/semanage/semanage	2005-12-24 15:58:45.000000000 -0500
@@ -50,9 +50,10 @@ class loginRecords:
 
 	def modify(self, name, sename="", serange=""):
 		(rc,k)=semanage_seuser_key_create(self.sh, name)
-		(rc,u)= semanage_seuser_query(self.sh, k)
-		if rc !=0 :
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if not exists:
 			raise ValueError("SELinux user %s mapping is not defined." % name)
+		(rc,u)= semanage_seuser_query(self.sh, k)
 		if sename == "" and serange=="":
 			raise ValueError("Requires, seuser or serange")
 		if serange != "":
@@ -68,7 +69,7 @@ class loginRecords:
 	def delete(self, name):
 		(rc,k)=semanage_seuser_key_create(self.sh, name)
 		(rc,exists)= semanage_seuser_exists(self.sh, k)
-		if rc !=0 :
+		if not exists:
 			raise ValueError("SELinux user %s mapping is not defined." % name)
 		semanage_begin_transaction(self.sh)
 		semanage_seuser_del(self.sh, k)
@@ -117,8 +118,6 @@ class seluserRecords:
 		if not exists:
 			raise ValueError("user %s is not defined" % name)
 		(rc,u)= semanage_user_query(self.sh, k)
-		if rc !=0 :
-			raise ValueError("User %s is not defined." % name)
 		if len(roles) == 0  and serange=="" and selevel=="":
 			raise ValueError("Requires, roles, level  or range")
 		if serange != "":
@@ -133,7 +132,6 @@ class seluserRecords:
 		semanage_user_modify_local(self.sh, k, u)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to modify SELinux user")
-
 		
 	def delete(self, name):
 		(rc,k)=semanage_user_key_create(self.sh, name)
@@ -251,8 +249,8 @@ semanage port [-admth] SELINUX_PORT_NAME
 		objectlist=("login", "user", "port")
 		input=sys.stdin
 		output=sys.stdout
-		serange="s0"
-		selevel="s0"
+		serange=""
+		selevel=""
 		roles=""
 		seuser=""
 		type=""

--------------020301080501040806040609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
