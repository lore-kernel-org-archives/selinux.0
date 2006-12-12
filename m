Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBC7bahQ010812
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 02:37:36 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBC7c6PF021850
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 07:38:07 GMT
Date: Tue, 12 Dec 2006 01:34:54 -0600
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH RFC 1/2] stricter MLS policy constraints
Message-ID: <20061212073454.GA30421@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061212072825.GA3362@w-m-p.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rename the "mlsfilewriteinrange" attribute with no functional changes.
The reason for the renaming is that this is an object attribute (like
"mlstrustedobject"), and it's confusing to use the naming scheme usually
used for subject attributes for it. It's currently only used for the
printer device object.

See 0/2 message for additional explanations.

Signed-off-by: Klaus Weidner <klaus@atsec.com>

 policy/mls                       |    2 +-
 policy/modules/kernel/devices.te |    2 +-
 policy/modules/kernel/mls.if     |    8 ++++----
 policy/modules/kernel/mls.te     |    4 +++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff -ur serefpolicy-2.4.6.rh/policy/mls serefpolicy-2.4.6.cleanup/policy/mls
--- serefpolicy-2.4.6.rh/policy/mls	2006-11-29 11:04:48.000000000 -0600
+++ serefpolicy-2.4.6.cleanup/policy/mls	2006-12-06 03:26:47.000000000 -0600
@@ -89,8 +89,8 @@
 mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
-	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t1 == mlsfilewrite ) or
+	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t2 == mlstrustedobject ));
 
 mlsconstrain dir { add_name remove_name reparent rmdir }
diff -ur serefpolicy-2.4.6.rh/policy/modules/kernel/devices.te serefpolicy-2.4.6.cleanup/policy/modules/kernel/devices.te
--- serefpolicy-2.4.6.rh/policy/modules/kernel/devices.te	2006-12-06 03:11:03.000000000 -0600
+++ serefpolicy-2.4.6.cleanup/policy/modules/kernel/devices.te	2006-12-06 03:28:00.000000000 -0600
@@ -125,7 +125,7 @@
 
 type printer_device_t;
 dev_node(printer_device_t)
-mls_file_write_within_range(printer_device_t)
+mls_file_writable_within_range(printer_device_t)
 
 #
 # random_device_t is the type of /dev/random
diff -ur serefpolicy-2.4.6.rh/policy/modules/kernel/mls.if serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.if
--- serefpolicy-2.4.6.rh/policy/modules/kernel/mls.if	2006-11-29 11:04:51.000000000 -0600
+++ serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.if	2006-12-06 03:28:11.000000000 -0600
@@ -100,16 +100,16 @@
 ## </summary>
 ## <param name="domain">
 ##	<summary>
-##	Domain allowed access.
+##	Object domain granting ranged access.
 ##	</summary>
 ## </param>
 #
-interface(`mls_file_write_within_range',`
+interface(`mls_file_writable_within_range',`
 	gen_require(`
-		attribute mlsfilewriteinrange;
+		attribute mlsrangedobject;
 	')
 
-	typeattribute $1 mlsfilewriteinrange;
+	typeattribute $1 mlsrangedobject;
 ')
 
 ########################################
diff -ur serefpolicy-2.4.6.rh/policy/modules/kernel/mls.te serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.te
--- serefpolicy-2.4.6.rh/policy/modules/kernel/mls.te	2006-11-29 11:04:51.000000000 -0600
+++ serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.te	2006-12-06 03:33:19.000000000 -0600
@@ -6,11 +6,11 @@
 # Declarations
 #
 
+# Subject attributes that give MLS override capabilities
 attribute mlsfileread;
 attribute mlsfilereadtoclr;
 attribute mlsfilewrite;
 attribute mlsfilewritetoclr;
-attribute mlsfilewriteinrange;
 attribute mlsfileupgrade;
 attribute mlsfiledowngrade;
 
@@ -43,6 +43,8 @@
 attribute mlsxwinwritecolormap;
 attribute mlsxwinwritexinput;
 
+# Object attributes that allow MLS overrides for access by all subjects
+attribute mlsrangedobject;
 attribute mlstrustedobject;
 
 attribute privrangetrans;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
