Message-ID: <43728384.3020508@cornell.edu>
Date: Wed, 09 Nov 2005 18:17:24 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Fix hidden declarations
Content-Type: multipart/mixed;
 boundary="------------010206080207010103010207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010206080207010103010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The hidden declarations are still a mystery to me. They are present in 
half the functions, and missing in the other half. I'm sure there's a 
reason for this, but since I don't quite understand the pattern, I'll 
leave them alone. There's no hidden declarations for _local.c, and 
_policy.c, and they are missing for some of the functions in _record.c.

This patch:

- removes the hidden proto for sepol_user_exists(), and 
sepol_seuser_iterate(), which make those functions invisible (no 
hidden_def, not sure if one should be added).

- changes two cases of hidden_proto in iface_record.c to hidden_def, 
because that just looks wrong.





--------------010206080207010103010207
Content-Type: text/x-patch;
 name="libsemanage.hidden_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.hidden_fix.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2005-11-09 18:05:51.000000000 -0500
@@ -115,14 +115,14 @@ int semanage_iface_clone(
 
 	return sepol_iface_clone(handle->sepolh, iface, iface_ptr);
 }
-hidden_proto(semanage_iface_clone)
+hidden_def(semanage_iface_clone)
 
 void semanage_iface_free(
 	semanage_iface_t* iface) {
 
 	sepol_iface_free(iface);
 }
-hidden_proto(semanage_iface_free)
+hidden_def(semanage_iface_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_IFACE_RTABLE = {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2005-11-09 18:04:27.000000000 -0500
@@ -9,7 +9,6 @@ hidden_proto(semanage_seuser_free)
 hidden_proto(semanage_seuser_get_mlsrange)
 hidden_proto(semanage_seuser_get_name)
 hidden_proto(semanage_seuser_get_sename)
-hidden_proto(semanage_seuser_iterate)
 hidden_proto(semanage_seuser_key_create)
 hidden_proto(semanage_seuser_key_extract)
 hidden_proto(semanage_seuser_key_free)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/user_internal.h new/libsemanage/src/user_internal.h
--- old/libsemanage/src/user_internal.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/user_internal.h	2005-11-09 18:04:11.000000000 -0500
@@ -7,7 +7,6 @@ hidden_proto(semanage_user_add_role)
 hidden_proto(semanage_user_clone)
 hidden_proto(semanage_user_compare)
 hidden_proto(semanage_user_create)
-hidden_proto(semanage_user_exists)
 hidden_proto(semanage_user_free)
 hidden_proto(semanage_user_get_defrole)
 hidden_proto(semanage_user_get_mlslevel)

--------------010206080207010103010207--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
