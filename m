Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57De99I013848
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 09:40:09 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l57De8WW000612
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 13:40:08 GMT
Subject: [PATCH 1/5] libselinux: rename existing name<->value functions for
	compat
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:38:49 -0400
Message-Id: <1181223529.6578.81.camel@sgc.columbia.tresys.com>
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
 
@@ -164,7 +164,7 @@ security_class_t string_to_security_clas
 	return 0;
 }
 
-access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
+static access_vector_t string_to_av_perm_compat(security_class_t tclass, const char *s)
 {
 	const uint16_t *common_pts_idx = 0;
 	access_vector_t perm, common_base = 0;
@@ -202,7 +202,7 @@ access_vector_t string_to_av_perm(securi
 	return 0;
 }
 
-const char *security_class_to_string(security_class_t tclass)
+static const char *security_class_to_string_compat(security_class_t tclass)
 {
 	if (tclass > 0 && tclass < NCLASSES)
 		return class_to_string_data.str + class_to_string[tclass];
@@ -211,7 +211,7 @@ const char *security_class_to_string(sec
 	return NULL;
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
