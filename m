Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TL1rgA004180
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 17:01:55 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TKt0hF029656
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 20:55:00 GMT
Subject: Re: [ libsemanage ] Key extract function
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1122665303.28860.30.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
	 <1122665303.28860.30.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed; boundary="=-9pG7WR1FNIY11lBFBo4p"
Date: Fri, 29 Jul 2005 16:53:06 -0400
Message-Id: <1122670387.28860.43.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9pG7WR1FNIY11lBFBo4p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch implements the key extract function.
The key is basically the part of the record that uniquely identifies
it in a collection of the same records. This introduces the
concept of a record collection in libsepol, which may be
the wrong place for it, but I think for now it should stay there.

This patch provides a way to obtain the key given the data structure.

The key is part of the data structure, which may seem unnecessarily
redundant, but I think it's the right interface - we may choose to
change this behavior in the future, and it just seems wrong to pass
a data structure partially filled as the key to functions like
query() or destroy() (in semanage).

======

Note that the port key will create problems - I might need to change 
that, because the same key can match many different records, 
which breaks the definition of a key, and causes chaos in 
the libsemanage processing layer. I think for now leave it as is, 
and we'll fix it later if necessary - I am not entirely 
clear how libsemanage will work in order to select a proper key.

--=-9pG7WR1FNIY11lBFBo4p
Content-Disposition: attachment; filename=libsemanage-1-key_extract.diff
Content-Type: text/x-patch; name=libsemanage-1-key_extract.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsemanage.work/include/semanage/port_record.h libsemanage-1-key_extract/include/semanage/port_record.h
--- libsemanage.work/include/semanage/port_record.h	2005-07-29 16:43:38.000000000 -0400
+++ libsemanage-1-key_extract/include/semanage/port_record.h	2005-07-29 16:43:08.000000000 -0400
@@ -20,8 +20,15 @@ int semanage_port_compare(semanage_port_
 static inline
 int semanage_port_key_create(
 	int low, int high, int proto, 
-	semanage_port_key_t* key) {
-	return sepol_port_key_create(low, high, proto, key);
+	semanage_port_key_t* key_ptr) {
+	return sepol_port_key_create(low, high, proto, key_ptr);
+}
+
+static inline
+int semanage_port_key_extract(
+	semanage_port_t port,
+	semanage_port_key_t* key_ptr) {
+	return sepol_port_key_extract(port, key_ptr);
 }
 
 static inline
diff -p -aru libsemanage.work/include/semanage/user_record.h libsemanage-1-key_extract/include/semanage/user_record.h
--- libsemanage.work/include/semanage/user_record.h	2005-07-29 16:43:38.000000000 -0400
+++ libsemanage-1-key_extract/include/semanage/user_record.h	2005-07-29 16:43:11.000000000 -0400
@@ -12,6 +12,11 @@ int semanage_user_key_create(const char*
 	return sepol_user_key_create(name, key);
 }
 
+static inline
+int semanage_user_key_extract(semanage_user_t user, semanage_user_key_t* key) {
+	return sepol_user_key_extract(user, key);
+}
+
 static inline 
 void semanage_user_key_free(semanage_user_key_t key) {
 	sepol_user_key_free(key);

--=-9pG7WR1FNIY11lBFBo4p
Content-Disposition: attachment; filename=libsepol-1-key_extract.diff
Content-Type: text/x-patch; name=libsepol-1-key_extract.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/include/sepol/port_record.h libsepol-1-key_extract/include/sepol/port_record.h
--- libsepol.work/include/sepol/port_record.h	2005-07-29 16:43:37.000000000 -0400
+++ libsepol-1-key_extract/include/sepol/port_record.h	2005-07-29 16:30:25.000000000 -0400
@@ -18,7 +18,11 @@ extern int sepol_port_compare(
 
 extern int sepol_port_key_create(
 	int low, int high, int proto,
-	sepol_port_key_t* key);
+	sepol_port_key_t* key_ptr);
+
+extern int sepol_port_key_extract(
+	sepol_port_t port, 
+	sepol_port_key_t* key_ptr);
 
 extern void sepol_port_key_free(
 	sepol_port_key_t key);
diff -p -aru libsepol.work/include/sepol/user_record.h libsepol-1-key_extract/include/sepol/user_record.h
--- libsepol.work/include/sepol/user_record.h	2005-07-29 16:43:37.000000000 -0400
+++ libsepol-1-key_extract/include/sepol/user_record.h	2005-07-29 16:30:29.000000000 -0400
@@ -11,6 +11,10 @@ extern int sepol_user_key_create(
 	const char* name,
 	sepol_user_key_t* key);
 
+extern int sepol_user_key_extract(
+	sepol_user_t user,
+	sepol_user_key_t* key_ptr);
+
 extern void sepol_user_key_free(
 	sepol_user_key_t key);
 
diff -p -aru libsepol.work/src/port_record.c libsepol-1-key_extract/src/port_record.c
--- libsepol.work/src/port_record.c	2005-07-29 16:43:37.000000000 -0400
+++ libsepol-1-key_extract/src/port_record.c	2005-07-29 16:30:42.000000000 -0400
@@ -46,6 +46,18 @@ int sepol_port_key_create(
 	return STATUS_SUCCESS;
 }
 
+int sepol_port_key_extract(sepol_port_t port, sepol_port_key_t* key_ptr) {
+	if (sepol_port_key_create(
+		port->low, port->high, port->proto, key_ptr) < 0) {
+		DEBUG(__FUNCTION__, "could not extract key from "
+			"port %s %d:%d\n", sepol_port_get_proto_str(port),
+			port->low, port->high);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
 void sepol_port_key_free(sepol_port_key_t key) {
 	free(key);
 }
diff -p -aru libsepol.work/src/user_record.c libsepol-1-key_extract/src/user_record.c
--- libsepol.work/src/user_record.c	2005-07-29 16:43:37.000000000 -0400
+++ libsepol-1-key_extract/src/user_record.c	2005-07-29 16:30:39.000000000 -0400
@@ -47,6 +47,16 @@ int sepol_user_key_create(
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
+}
+
+int sepol_user_key_extract(sepol_user_t user, sepol_user_key_t* key_ptr) {
+	if (sepol_user_key_create(user->name, key_ptr) < 0) {
+		DEBUG(__FUNCTION__, "could not extract key from user %s\n",
+			user->name);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
 }	
 
 void sepol_user_key_free(sepol_user_key_t key) {

--=-9pG7WR1FNIY11lBFBo4p--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
