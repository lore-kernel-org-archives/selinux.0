Message-ID: <43ADA74D.50405@cornell.edu>
Date: Sat, 24 Dec 2005 14:53:49 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [SEMANAGE(tool)] Do not attempt to delete in-policy users
Content-Type: multipart/mixed;
 boundary="------------070209000006040400070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070209000006040400070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch shows how to properly use the exists function on delete.

The libsemanage delete operation will succeed if you try to delete an 
object that does not exist (no action is taken), so the user is left 
wondering why the object wasn't deleted, but no error was displayed. The 
del_local function checks if the user exists "locally" - not in-policy. 
The same is true for all functions that end in _local. You can't delete 
in-policy objects at this time (you can only modify them). To support 
deletion of in-policy objects we have to track the user deletion 
requests in a file, and then apply those on every policy upgrade. This 
is possible, but it's not currently implemented - didn't think it was a 
wanted feature.






--------------070209000006040400070001
Content-Type: text/x-patch;
 name="semanage.exists_test.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.exists_test.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2005-11-29 10:55:01.000000000 -0500
+++ new/policycoreutils/semanage/semanage	2005-12-24 14:32:50.000000000 -0500
@@ -137,9 +137,12 @@ class seluserRecords:
 		
 	def delete(self, name):
 		(rc,k)=semanage_user_key_create(self.sh, name)
+		(rc,exists_local)= semanage_user_exists_local(self.sh, k)
 		(rc,exists)= semanage_user_exists(self.sh, k)
 		if not exists:
 			raise ValueError("user %s is not defined" % name)
+		if not exists_local:
+			raise ValueError("user %s is built into policy, and cannot be deleted" % name)
 		semanage_begin_transaction(self.sh)
 		semanage_user_del_local(self.sh, k)
 		if semanage_commit(self.sh) != 0:

--------------070209000006040400070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
