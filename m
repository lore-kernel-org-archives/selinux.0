Message-ID: <791924EBDA572C4FA970D4A94AA95DA309E3DB@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@tcs-sec.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson
	 <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: RE: [patch] policydb - MLS
Date: Tue, 2 Mar 2004 17:19:41 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C400A4.7512F630"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C400A4.7512F630
Content-Type: text/plain;
	charset="iso-8859-1"


Please disregard the earlier patch. 

These new patches will fix the problem and provide compatibility to
policy15-mls files.

-Chad

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Tuesday, March 02, 2004 1:48 PM
To: Chad Hanson
Cc: SE Linux (E-mail)
Subject: Re: [patch] policydb - MLS


On Tue, 2004-03-02 at 14:29, Chad Hanson wrote:
> I have attached a patch to checkpolicy and the kernel to allow MLS to work
> correctly with new conditional policy extensions. The problem is an
ordering

- (nit) The first attachment was the entire file, not a patch.
- (nit) Please generate patches in unified format, i.e. diff -u.
- Won't this change break the compatibility code that allows loading of
policy.15 files?  Instead of dropping the bools symtab when loading a
policy.15 file, it will end up dropping the cats symtab with your patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


------_=_NextPart_000_01C400A4.7512F630
Content-Type: application/octet-stream;
	name="checkpolicy.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="checkpolicy.diff"

diff -ur -x CVS checkpolicy/mls.h checkpolicy-fix/mls.h=0A=
--- checkpolicy/mls.h	2004-03-02 14:16:58.000000000 -0600=0A=
+++ checkpolicy-fix/mls.h	2004-03-02 15:15:13.000000000 -0600=0A=
@@ -55,12 +55,12 @@=0A=
 =0A=
 #define mls_end_user_ranges } } =0A=
 =0A=
-#define mls_symtab_names , "levels", "categories"=0A=
-#define mls_symtab_sizes , 16, 16=0A=
-#define mls_index_f ,sens_index, cat_index=0A=
-#define mls_destroy_f ,sens_destroy, cat_destroy=0A=
-#define mls_read_f ,sens_read, cat_read=0A=
-#define mls_write_f ,sens_write, cat_write=0A=
+#define mls_symtab_names  "levels", "categories",=0A=
+#define mls_symtab_sizes  16, 16,=0A=
+#define mls_index_f sens_index, cat_index,=0A=
+#define mls_destroy_f sens_destroy, cat_destroy,=0A=
+#define mls_read_f sens_read, cat_read,=0A=
+#define mls_write_f sens_write, cat_write,=0A=
 #define mls_policydb_index_others(p) printk(", %d levels", =
p->nlevels);=0A=
 =0A=
 #define mls_set_config(config) config |=3D POLICYDB_CONFIG_MLS=0A=
diff -ur -x CVS checkpolicy/policydb.c checkpolicy-fix/policydb.c=0A=
--- checkpolicy/policydb.c	2004-03-02 14:16:58.000000000 -0600=0A=
+++ checkpolicy-fix/policydb.c	2004-03-02 15:14:00.000000000 -0600=0A=
@@ -40,8 +40,8 @@=0A=
 	16,=0A=
 	512,=0A=
 	128,=0A=
-	16=0A=
 	mls_symtab_sizes=0A=
+	16=0A=
 };=0A=
 =0A=
 /* =0A=
@@ -227,8 +227,8 @@=0A=
 	role_index,=0A=
 	type_index,=0A=
 	user_index,=0A=
-	cond_index_bool=0A=
 	mls_index_f=0A=
+	cond_index_bool=0A=
 };=0A=
 =0A=
 =0A=
@@ -431,8 +431,8 @@=0A=
 	role_destroy,=0A=
 	type_destroy,=0A=
 	user_destroy,=0A=
-	cond_destroy_bool=0A=
 	mls_destroy_f=0A=
+	cond_destroy_bool=0A=
 };=0A=
 =0A=
 =0A=
@@ -1012,8 +1012,8 @@=0A=
 	role_read,=0A=
 	type_read,=0A=
 	user_read,=0A=
-	cond_read_bool=0A=
 	mls_read_f=0A=
+	cond_read_bool=0A=
 };=0A=
 =0A=
 #define mls_config(x) \=0A=
diff -ur -x CVS checkpolicy/write.c checkpolicy-fix/write.c=0A=
--- checkpolicy/write.c	2004-03-02 14:16:58.000000000 -0600=0A=
+++ checkpolicy-fix/write.c	2004-03-02 14:16:13.000000000 -0600=0A=
@@ -688,8 +688,8 @@=0A=
 	role_write,=0A=
 	type_write,=0A=
 	user_write,=0A=
-	cond_write_bool=0A=
 	mls_write_f=0A=
+	cond_write_bool=0A=
 };=0A=
 =0A=
 =0A=

------_=_NextPart_000_01C400A4.7512F630
Content-Type: application/octet-stream;
	name="ss.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ss.diff"

diff -ur -x CVS ss/mls.h ss-fix/mls.h=0A=
--- ss/mls.h	2004-03-02 15:29:04.000000000 -0600=0A=
+++ ss-fix/mls.h	2004-03-02 15:07:28.000000000 -0600=0A=
@@ -51,12 +51,12 @@=0A=
 =0A=
 #define mls_end_user_ranges } }=0A=
 =0A=
-#define mls_symtab_names , "levels", "categories"=0A=
-#define mls_symtab_sizes , 16, 16=0A=
-#define mls_index_f ,sens_index, cat_index=0A=
-#define mls_destroy_f ,sens_destroy, cat_destroy=0A=
-#define mls_read_f ,sens_read, cat_read=0A=
-#define mls_write_f ,sens_write, cat_write=0A=
+#define mls_symtab_names  "levels", "categories",=0A=
+#define mls_symtab_sizes  16, 16,=0A=
+#define mls_index_f sens_index, cat_index,=0A=
+#define mls_destroy_f sens_destroy, cat_destroy,=0A=
+#define mls_read_f sens_read, cat_read,=0A=
+#define mls_write_f sens_write, cat_write,=0A=
 #define mls_policydb_index_others(p) printk(", %d levels", =
p->nlevels);=0A=
 =0A=
 #define mls_set_config(config) config |=3D POLICYDB_CONFIG_MLS=0A=
diff -ur -x CVS ss/policydb.c ss-fix/policydb.c=0A=
--- ss/policydb.c	2004-03-02 15:29:04.000000000 -0600=0A=
+++ ss-fix/policydb.c	2004-03-02 15:05:52.000000000 -0600=0A=
@@ -33,8 +33,8 @@=0A=
 	"roles",=0A=
 	"types",=0A=
 	"users",=0A=
-	"bools"=0A=
 	mls_symtab_names=0A=
+	"bools"=0A=
 };=0A=
 #endif=0A=
 =0A=
@@ -44,8 +44,8 @@=0A=
 	16,=0A=
 	512,=0A=
 	128,=0A=
-	16=0A=
 	mls_symtab_sizes=0A=
+	16=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -215,8 +215,8 @@=0A=
 	role_index,=0A=
 	type_index,=0A=
 	user_index,=0A=
-	cond_index_bool=0A=
 	mls_index_f=0A=
+	cond_index_bool=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -428,8 +428,8 @@=0A=
 	role_destroy,=0A=
 	type_destroy,=0A=
 	user_destroy,=0A=
-	cond_destroy_bool=0A=
 	mls_destroy_f=0A=
+	cond_destroy_bool=0A=
 };=0A=
 =0A=
 void ocontext_destroy(struct ocontext *c, int i)=0A=
@@ -1069,8 +1069,8 @@=0A=
 	role_read,=0A=
 	type_read,=0A=
 	user_read,=0A=
-	cond_read_bool=0A=
 	mls_read_f=0A=
+	cond_read_bool=0A=
 };=0A=
 =0A=
 #define mls_config(x) \=0A=

------_=_NextPart_000_01C400A4.7512F630--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
