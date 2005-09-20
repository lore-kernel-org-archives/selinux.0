Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8KKfiNs003132
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 16:41:44 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8KKbXqi000149
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 20:37:33 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8KKbdFC010482
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 16:37:39 -0400 (EDT)
Message-ID: <433074D8.3030507@cornell.edu>
Date: Tue, 20 Sep 2005 16:45:12 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Fix memory leaks
References: <432FBD08.2050903@cornell.edu>
In-Reply-To: <432FBD08.2050903@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050106000903080207000700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050106000903080207000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch applies on top of the sepol patch (or at least..I 
hope it does - might complain about whitespace). It fixes memory leaks 
noticed by Steven Smalley, and removes the prototypes of two functions 
that are only used internally (there's a lot more, but this gets rid of 
two of them).


--------------050106000903080207000700
Content-Type: text/x-patch;
 name="libsepol.fix.memory_leaks2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix.memory_leaks2.diff"

diff -Naur libsepol.new/include/sepol/interfaces.h libsepol/include/sepol/interfaces.h
--- libsepol.new/include/sepol/interfaces.h	2005-09-20 02:55:29.000000000 -0400
+++ libsepol/include/sepol/interfaces.h	2005-09-20 16:34:11.000000000 -0400
@@ -5,13 +5,6 @@
 #include <sepol/iface_record.h>
 #include <stddef.h>
 
-/* Create a low level interface structure from
- * a high level representation */
-extern int sepol_iface_struct_create(
-	policydb_t* policydb,
-	ocontext_t** iface,
-	sepol_iface_t data);
-
 /* Get the current context mapping for this interface */
 extern int sepol_iface_get_context(
 	policydb_t* policydb,
diff -Naur libsepol.new/include/sepol/ports.h libsepol/include/sepol/ports.h
--- libsepol.new/include/sepol/ports.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol/include/sepol/ports.h	2005-09-20 16:34:18.000000000 -0400
@@ -5,12 +5,6 @@
 #include <sepol/port_record.h>
 #include <stddef.h>
 
-/* Create a port structure from high level representation */
-extern int sepol_port_struct_create(
-	policydb_t* policydb,
-	ocontext_t** port,
-	sepol_port_t data);
-
 /* Get the current context mapping
  * for this port. Returns 1 if no match, -1 on error, 0 on
  * success. The returned data is allocated on the heap */
diff -Naur libsepol.new/src/booleans.c libsepol/src/booleans.c
--- libsepol.new/src/booleans.c	2005-09-20 16:39:34.000000000 -0400
+++ libsepol/src/booleans.c	2005-09-20 16:39:24.000000000 -0400
@@ -33,6 +33,8 @@
 		DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n", value, name);
 		goto err;
 	}
+
+	free(name);
 	datum->state = value;
 	return STATUS_SUCCESS;
 
diff -Naur libsepol.new/src/interfaces.c libsepol/src/interfaces.c
--- libsepol.new/src/interfaces.c	2005-09-20 02:55:29.000000000 -0400
+++ libsepol/src/interfaces.c	2005-09-20 16:33:11.000000000 -0400
@@ -51,6 +51,7 @@
 	DEBUG(__FUNCTION__, "out of memory\n");
 
 	err:
+	free(tmp_iface->u.name);
 	free(tmp_iface);
 	DEBUG(__FUNCTION__, "error creating interface structure\n");
 	return STATUS_ERR;
@@ -126,6 +127,7 @@
 
 	err:
 	DEBUG(__FUNCTION__, "error while loading interface %s\n", name);
+	free(iface->u.name);
 	free(iface);
 	return STATUS_ERR;
 }
diff -Naur libsepol.new/src/users.c libsepol/src/users.c
--- libsepol.new/src/users.c	2005-09-20 16:39:50.000000000 -0400
+++ libsepol/src/users.c	2005-09-20 16:39:06.000000000 -0400
@@ -102,6 +102,7 @@
 	if (sepol_user_load(policydb, user) < 0) 
 		goto err;
 
+	free(name);
 	return STATUS_SUCCESS;
 
 	omem:

--------------050106000903080207000700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
