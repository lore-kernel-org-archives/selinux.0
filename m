Message-ID: <43ABDD8E.7030800@cornell.edu>
Date: Fri, 23 Dec 2005 06:20:46 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Active dbase: missed handle.h changes
Content-Type: multipart/mixed;
 boundary="------------040500000302050402070503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040500000302050402070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I need to work on reducing my exclusion list...

--------------040500000302050402070503
Content-Type: text/x-patch;
 name="libsemanage5.1.active_handle.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage5.1.active_handle.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/handle.h new/libsemanage/src/handle.h
--- old/libsemanage/src/handle.h	2005-11-09 09:52:55.000000000 -0500
+++ new/libsemanage/src/handle.h	2005-12-23 06:13:45.000000000 -0500
@@ -76,7 +76,7 @@ struct semanage_handle {
 	struct semanage_policy_table* funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      9
+#define DBASE_COUNT      10
 
 #define DBASE_LOCAL_USERS       0
 #define DBASE_LOCAL_PORTS       1
@@ -88,6 +88,8 @@ struct semanage_handle {
 #define DBASE_POLICY_PORTS      6
 #define DBASE_POLICY_INTERFACES 7
 #define DBASE_POLICY_BOOLEANS   8
+
+#define DBASE_ACTIVE_BOOLEANS   9
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -136,5 +138,10 @@ dbase_config_t* semanage_bool_dbase_poli
 	return &handle->dbase[DBASE_POLICY_BOOLEANS];
 }
 
+static inline
+dbase_config_t* semanage_bool_dbase_active(semanage_handle_t* handle) {
+	return &handle->dbase[DBASE_ACTIVE_BOOLEANS];
+}
+
 #endif
 

--------------040500000302050402070503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
