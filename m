Message-ID: <434E6B66.2000501@cornell.edu>
Date: Thu, 13 Oct 2005 10:12:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] [ SEMANAGE ] Debug v3, some database things
References: <434CC592.70001@cornell.edu>	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>	 <434D35B1.7060409@cornell.edu>	 <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>	 <434D3D33.90104@cornell.edu> <434E38C2.9030602@cornell.edu>	 <434E3D75.8060009@cornell.edu> <1129206873.26188.99.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129206873.26188.99.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050208000007050301050902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050208000007050301050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Wrap the definition with 
> do {
>
> } while (0)
>
> and you'll be fine.
>
> That's a widely used trick in the kernel.
>   
Allright, attached fix patch applies on top of the other one.



--------------050208000007050301050902
Content-Type: text/x-patch;
 name="resync.fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resync.fix.diff"

diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/database_direct.c new/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-13 10:05:46.000000000 -0400
+++ new/libsemanage/src/database_direct.c	2005-10-13 10:08:32.000000000 -0400
@@ -263,6 +263,7 @@
 	dbase_direct_t* dbase) {
 
 	dbase->attached = 0;
+	handle = NULL;
 }
 
 static int dbase_direct_add (
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsemanage/src/debug.h new/libsemanage/src/debug.h
--- old/libsemanage/src/debug.h	2005-10-13 10:05:46.000000000 -0400
+++ new/libsemanage/src/debug.h	2005-10-13 10:08:07.000000000 -0400
@@ -32,18 +32,18 @@
 #define STATUS_NODATA 1
 
 #define msg_write(handle_arg, level_arg,                   \
-	          channel_arg, func_arg, ...) {            \
+	          channel_arg, func_arg, ...) do {         \
+	                                                   \
+        if ((handle_arg)->msg_callback) {                  \
+                (handle_arg)->msg_fname = func_arg;        \
+                (handle_arg)->msg_channel = channel_arg;   \
+                (handle_arg)->msg_level = level_arg;       \
                                                            \
-        if (handle_arg->msg_callback) {                    \
-                handle_arg->msg_fname = func_arg;          \
-                handle_arg->msg_channel = channel_arg;     \
-                handle_arg->msg_level = level_arg;         \
-                                                           \
-                handle_arg->msg_callback(                  \
-                        handle_arg->msg_callback_arg,      \
+                (handle_arg)->msg_callback(                \
+                        (handle_arg)->msg_callback_arg,    \
                         handle_arg, __VA_ARGS__);          \
         }                                                  \
-}
+} while(0)
 
 #define ERR(handle, ...) \
 	msg_write(handle, SEMANAGE_MSG_ERR, "libsemanage", \
diff -Naur --exclude CVS --exclude VERSION --exclude ChangeLog old/libsepol/src/debug.h new/libsepol/src/debug.h
--- old/libsepol/src/debug.h	2005-10-13 10:05:46.000000000 -0400
+++ new/libsepol/src/debug.h	2005-10-13 10:09:55.000000000 -0400
@@ -10,18 +10,18 @@
 #define STATUS_NODATA 1
 
 #define msg_write(handle_arg, level_arg,                   \
-		  channel_arg, func_arg, ...) {            \
+		  channel_arg, func_arg, ...) do {         \
                                                            \
-        if (handle_arg->msg_callback) {                    \
-                handle_arg->msg_fname = func_arg;          \
-                handle_arg->msg_channel = channel_arg;     \
-                handle_arg->msg_level = level_arg;         \
+        if ((handle_arg)->msg_callback) {                  \
+                (handle_arg)->msg_fname = func_arg;        \
+                (handle_arg)->msg_channel = channel_arg;   \
+                (handle_arg)->msg_level = level_arg;       \
                                                            \
-                handle_arg->msg_callback(                  \
-                        handle_arg->msg_callback_arg,      \
+                (handle_arg)->msg_callback(                \
+                        (handle_arg)->msg_callback_arg,    \
                         handle_arg, __VA_ARGS__);          \
         }                                                  \
-}
+} while(0)
 
 #define ERR(handle, ...) \
 	msg_write(handle, SEPOL_MSG_ERR, "libsepol", \
@@ -48,7 +48,7 @@
 extern struct sepol_handle sepol_compat_handle;
 
 #define DEBUG(fname, ...) \
-	msg_write((&sepol_compat_handle), SEPOL_MSG_ERR, "libsepol", \
+	msg_write(&sepol_compat_handle, SEPOL_MSG_ERR, "libsepol", \
 	fname, __VA_ARGS__)
 /* End deprecated */
 

--------------050208000007050301050902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
