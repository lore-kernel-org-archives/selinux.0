Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56JCBaq029007
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 15:12:11 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l56JC7MD007616
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:12:10 GMT
Subject: [PATCH 1/5] libselinux: rename existing name<->value functions for
	compat
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 19:10:51 +0000
Message-Id: <1181157051.6578.36.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rename existing object class and av perm value->string and string->value functions
to internal compatibility functions.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/stringrep.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
+++ selinux-obj-class-discovery/libselinux/src/stringrep.c
@@ -144,7 +144,7 @@ static const struct av_inherit {
 #define NCLASSES ARRAY_SIZE(class_to_string)
 #define NVECTORS ARRAY_SIZE(av_perm_to_string)
 
-security_class_t string_to_security_class(const char *s)
+static security_class_t string_to_security_class_compat(const char *s)
 {
 	unsigned int val;
 
@@ -163,7 +163,7 @@ security_class_t string_to_security_clas
 	return 0;
 }
 
-access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
+static access_vector_t string_to_av_perm_compat(security_class_t tclass, const char *s)
 {
 	const uint16_t *common_pts_idx = 0;
 	access_vector_t perm, common_base = 0;
@@ -200,13 +200,13 @@ access_vector_t string_to_av_perm(securi
 	return 0;
 }
 
-const char *security_class_to_string(security_class_t tclass)
+static const char *security_class_to_string_compat(security_class_t tclass)
 {
 	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
 	return class_to_string_data.str + class_to_string[tclass];
 }
 
-const char *security_av_perm_to_string(security_class_t tclass,
+static const char *security_av_perm_to_string_compat(security_class_t tclass,
 				       access_vector_t av)
 {
 	const uint16_t *common_pts_idx = 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
