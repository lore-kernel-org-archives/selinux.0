Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NFLTaY006341
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 11:21:36 -0400
Message-ID: <1471965682.30659.22.camel@trentalancia.net>
Subject: [PATCH] Update libsepol to support the policy capability for AF_ALG
 sockets
From: Guido Trentalancia <guido@trentalancia.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 23 Aug 2016 17:21:22 +0200
In-Reply-To: <082767a3-acab-4d46-6195-06e35251d53e@tycho.nsa.gov>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
 <1471961693.30659.7.camel@trentalancia.net>
 <082767a3-acab-4d46-6195-06e35251d53e@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update libsepol with the new policy capability needed to classify
sockets in the AF_ALG namespace (Crypto API).

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 include/sepol/policydb/polcaps.h |    1 +
 src/polcaps.c                    |    1 +
 2 files changed, 2 insertions(+)

diff -pru libsepol-git-23082016/include/sepol/policydb/polcaps.h libsepol-git-23082016-alg_socket/include/sepol/policydb/polcaps.h
--- libsepol-git-23082016/include/sepol/policydb/polcaps.h	2016-08-23 17:08:58.690837319 +0200
+++ libsepol-git-23082016-alg_socket/include/sepol/policydb/polcaps.h	2016-08-23 17:13:52.794644956 +0200
@@ -11,6 +11,7 @@ enum {
 	POLICYDB_CAPABILITY_OPENPERM,
 	POLICYDB_CAPABILITY_REDHAT1, /* reserved for RH testing of ptrace_child */
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
+	POLICYDB_CAPABILITY_ALGSOCKET, /* Crypto API socket namespace */
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff -pru libsepol-git-23082016/src/polcaps.c libsepol-git-23082016-alg_socket/src/polcaps.c
--- libsepol-git-23082016/src/polcaps.c	2016-08-23 17:08:58.696837395 +0200
+++ libsepol-git-23082016-alg_socket/src/polcaps.c	2016-08-23 17:11:49.145026939 +0200
@@ -10,6 +10,7 @@ static const char *polcap_names[] = {
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
 	"redhat1",			/* POLICYDB_CAPABILITY_REDHAT1, aka ptrace_child */
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
+	"alg_socket",			/* POLICYDB_CAPABILITY_ALGSOCKET (Crypto API socket namespace) */
 	NULL
 };
 
