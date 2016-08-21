Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7LHHlKn016346
 for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2016 13:17:47 -0400
Message-ID: <1471799849.2544.2.camel@trentalancia.net>
Subject: [PATCH v2] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
From: Guido Trentalancia <guido@trentalancia.net>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Sun, 21 Aug 2016 19:17:29 +0200
In-Reply-To: <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
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
 security/selinux/hooks.c            |    5 +++--
 security/selinux/include/classmap.h |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

--- linux-4.7.1-orig/security/selinux/hooks.c	2016-08-21 18:20:52.788066467 +0200
+++ linux-4.7.1/security/selinux/hooks.c	2016-08-21 18:23:48.603479911 +0200
@@ -1316,6 +1315,8 @@ static inline u16 socket_type_to_securit
 		return SECCLASS_KEY_SOCKET;
 	case PF_APPLETALK:
 		return SECCLASS_APPLETALK_SOCKET;
+	case PF_ALG:
+		return SECCLASS_ALG_SOCKET;
 	}
 
 	return SECCLASS_SOCKET;
--- linux-4.7.1-orig/security/selinux/include/classmap.h	2016-08-18 17:39:50.639133429 +0200
+++ linux-4.7.1/security/selinux/include/classmap.h	2016-08-21 18:30:00.306088371 +0200
@@ -144,6 +144,8 @@ struct security_class_mapping secclass_m
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "appletalk_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "alg_socket",
+	  { COMMON_SOCK_PERMS, "connectto", NULL } },
 	{ "packet",
 	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
 	{ "key",
