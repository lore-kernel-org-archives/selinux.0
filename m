Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NEFidi029226
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 10:15:49 -0400
Message-ID: <1471961693.30659.7.camel@trentalancia.net>
Subject: [PATCH v5] Classify AF_ALG sockets
From: Guido Trentalancia <guido@trentalancia.net>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 23 Aug 2016 16:14:53 +0200
In-Reply-To: <1471899875.19333.3.camel@trentalancia.net>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Modify the SELinux kernel code so that it is able to classify sockets with
the new AF_ALG namespace (used for the user-space interface to the kernel
Crypto API).

A companion patch has been created for the Reference Policy and it will be
posted to its mailing list, once this patch is merged.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 security/selinux/hooks.c            |    5 +++++
 security/selinux/include/classmap.h |    2 ++
 security/selinux/include/security.h |    2 ++
 security/selinux/selinuxfs.c        |    3 ++-
 security/selinux/ss/services.c      |    6 +++++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff -pru linux-4.7.2-orig/security/selinux/hooks.c linux-4.7.2/security/selinux/hooks.c
--- linux-4.7.2-orig/security/selinux/hooks.c	2016-08-22 22:31:27.737767819 +0200
+++ linux-4.7.2/security/selinux/hooks.c	2016-08-22 22:40:29.102526024 +0200
@@ -1315,6 +1315,11 @@ static inline u16 socket_type_to_securit
 		return SECCLASS_KEY_SOCKET;
 	case PF_APPLETALK:
 		return SECCLASS_APPLETALK_SOCKET;
+	case PF_ALG:
+		if (selinux_policycap_algsocket)
+			return SECCLASS_ALG_SOCKET;
+		else
+			return SECCLASS_SOCKET;
 	}
 
 	return SECCLASS_SOCKET;
diff -pru linux-4.7.2-orig/security/selinux/include/classmap.h linux-4.7.2/security/selinux/include/classmap.h
--- linux-4.7.2-orig/security/selinux/include/classmap.h	2016-08-22 22:31:27.754768030 +0200
+++ linux-4.7.2/security/selinux/include/classmap.h	2016-08-22 22:32:14.795355585 +0200
@@ -144,6 +144,8 @@ struct security_class_mapping secclass_m
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "appletalk_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "alg_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ "packet",
 	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
 	{ "key",
diff -pru linux-4.7.2-orig/security/selinux/include/security.h linux-4.7.2/security/selinux/include/security.h
--- linux-4.7.2-orig/security/selinux/include/security.h	2016-03-14 05:28:54.000000000 +0100
+++ linux-4.7.2/security/selinux/include/security.h	2016-08-22 22:53:57.911660238 +0200
@@ -75,6 +75,7 @@ enum {
 	POLICYDB_CAPABILITY_OPENPERM,
 	POLICYDB_CAPABILITY_REDHAT1,
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
+	POLICYDB_CAPABILITY_ALGSOCKET,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -82,6 +83,7 @@ enum {
 extern int selinux_policycap_netpeer;
 extern int selinux_policycap_openperm;
 extern int selinux_policycap_alwaysnetwork;
+extern int selinux_policycap_algsocket;
 
 /*
  * type_datum properties
diff -pru linux-4.7.2-orig/security/selinux/selinuxfs.c linux-4.7.2/security/selinux/selinuxfs.c
--- linux-4.7.2-orig/security/selinux/selinuxfs.c	2016-03-14 05:28:54.000000000 +0100
+++ linux-4.7.2/security/selinux/selinuxfs.c	2016-08-23 14:19:43.945217071 +0200
@@ -46,7 +46,8 @@ static char *policycap_names[] = {
 	"network_peer_controls",
 	"open_perms",
 	"redhat1",
-	"always_check_network"
+	"always_check_network",
+	"alg_socket"
 };
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
diff -pru linux-4.7.2-orig/security/selinux/ss/services.c linux-4.7.2/security/selinux/ss/services.c
--- linux-4.7.2-orig/security/selinux/ss/services.c	2016-08-05 21:27:22.275588616 +0200
+++ linux-4.7.2/security/selinux/ss/services.c	2016-08-23 14:33:19.111185535 +0200
@@ -26,9 +26,10 @@
  *
  *  Added support for bounds domain and audit messaged on masked permissions
  *
- * Updated: Guido Trentalancia <guido@trentalancia.com>
+ * Updated: Guido Trentalancia <guido@trentalancia.net>
  *
  *  Added support for runtime switching of the policy type
+ *  Added support for classifying the AF_ALG sockets (Crypto API)
  *
  * Copyright (C) 2008, 2009 NEC Corporation
  * Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
@@ -73,6 +74,7 @@
 int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
 int selinux_policycap_alwaysnetwork;
+int selinux_policycap_algsocket;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
@@ -2016,6 +2018,8 @@ static void security_load_policycaps(voi
 						  POLICYDB_CAPABILITY_OPENPERM);
 	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
+	selinux_policycap_algsocket = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_ALGSOCKET);
 }
 
 static int security_preserve_bools(struct policydb *p);
