Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QHEEOb026433
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 13:14:14 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7QHEALr012454
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 17:14:10 GMT
Subject: corrected sidtab locking patch
From: Jason Tang <jtang@tresys.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <430F4824.4090802@tresys.com>
References: <1125074025.5306.9.camel@localhost.localdomain>
	 <430F4824.4090802@tresys.com>
Content-Type: multipart/mixed; boundary="=-Lpn1iL+FmLdy7JaGS2iy"
Date: Fri, 26 Aug 2005 13:14:10 -0400
Message-Id: <1125076450.5306.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Lpn1iL+FmLdy7JaGS2iy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch allows a program to enable locking in
libsepol/sidtab.c.  By default sidtab.c does not lock the sidtab when
adding and removing entries; this causes problems for multi-threaded
programs using it.  Programs may set up function pointers to perform
locking as they see fit.


-- 
Jason Tang / jtang@tresys.com

--=-Lpn1iL+FmLdy7JaGS2iy
Content-Disposition: attachment; filename=patch-locking
Content-Type: text/x-patch; name=patch-locking; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN nsa/selinux-usr/libsepol/include/sepol/sidtab.h nsa-selinux-usr/libsepol/include/sepol/sidtab.h
--- nsa/selinux-usr/libsepol/include/sepol/sidtab.h	2005-07-13 15:42:37.000000000 -0400
+++ nsa-selinux-usr/libsepol/include/sepol/sidtab.h	2005-08-24 17:40:19.000000000 -0400
@@ -72,6 +72,11 @@ extern void sepol_sidtab_set(sidtab_t *d
 
 extern void sepol_sidtab_shutdown(sidtab_t *s);
 
+typedef void (* sepol_sidtab_lock_func)(sidtab_t *);
+extern void sepol_sidtab_set_init_func(sepol_sidtab_lock_func func);
+extern void sepol_sidtab_set_lock_func(sepol_sidtab_lock_func func);
+extern void sepol_sidtab_set_unlock_func(sepol_sidtab_lock_func func);
+
 #endif	/* _SIDTAB_H_ */
 
 /* FLASK */
diff -purN nsa/selinux-usr/libsepol/src/sidtab.c nsa-selinux-usr/libsepol/src/sidtab.c
--- nsa/selinux-usr/libsepol/src/sidtab.c	2005-05-13 15:53:31.000000000 -0400
+++ nsa-selinux-usr/libsepol/src/sidtab.c	2005-08-24 17:28:06.000000000 -0400
@@ -23,6 +23,14 @@
 #define SIDTAB_LOCK(s) 
 #define SIDTAB_UNLOCK(s)
 
+static void do_no_lock_func(sidtab_t *s __attribute__((unused))) {
+        /* as the name suggests, this function does not do anything */
+}
+
+static sepol_sidtab_lock_func INIT_SIDTAB_LOCK = do_no_lock_func;
+static sepol_sidtab_lock_func SIDTAB_LOCK = do_no_lock_func;
+static sepol_sidtab_lock_func SIDTAB_UNLOCK = do_no_lock_func;
+
 int sepol_sidtab_init(sidtab_t *s) 
 {
 	int i;
@@ -334,5 +342,17 @@ void sepol_sidtab_shutdown(sidtab_t *s)
 	SIDTAB_UNLOCK(s);
 }
 
+void sepol_sidtab_set_init_func(sepol_sidtab_lock_func func) {
+        INIT_SIDTAB_LOCK = func;
+}
+
+void sepol_sidtab_set_lock_func(sepol_sidtab_lock_func func) {
+        SIDTAB_LOCK = func;
+}
+
+void sepol_sidtab_set_unlock_func(sepol_sidtab_lock_func func) {
+        SIDTAB_UNLOCK = func;
+}
+
 /* FLASK */
 

--=-Lpn1iL+FmLdy7JaGS2iy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
