Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CL5f3026262
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:21:05 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E24375646C6
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:19:55 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:23 +0200
Message-Id: <20170903121928.24024-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/6] libsepol: use IN6ADDR_ANY_INIT to initialize
 IPv6 addresses
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling libsepol with clang and some warning flags, the compiler
complains about the way IPv6 addresses are initialized:

    kernel_to_cil.c:2795:35: error: suggest braces around initialization
    of subobject [-Werror,-Wmissing-braces]
            struct in6_addr subnet_prefix = {0};
                                             ^
                                             {}

When replacing the initializer as suggested, gcc 4.8.4 complains:

    kernel_to_cil.c: In function ‘write_selinux_ibpkey_rules_to_cil’:
    kernel_to_cil.c:2795:9: error: missing initializer for field
    ‘__in6_u’ of ‘struct in6_addr’ [-Werror=missing-field-initializers]
      struct in6_addr subnet_prefix = {};
             ^

Thankfully netinet/in.h provides a macro to initialize struct in6_addr
variables:

    #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }

Both clang and gcc no longer report warnings when using this macro.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_cil.c  | 2 +-
 libsepol/src/kernel_to_conf.c | 2 +-
 libsepol/src/module_to_cil.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index f1905a958ec0..0055c2386695 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2788,7 +2788,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	struct ocontext *ibpkeycon;
 	char subnet_prefix_str[INET6_ADDRSTRLEN];
-	struct in6_addr subnet_prefix = {0};
+	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
 	uint16_t low;
 	uint16_t high;
 	char low_high_str[44]; /* 2^64 <= 20 digits so "(low high)" <= 44 chars */
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a74873f01687..95aa92fc8c26 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2649,7 +2649,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	struct ocontext *ibpkeycon;
 	char subnet_prefix_str[INET6_ADDRSTRLEN];
-	struct in6_addr subnet_prefix = {0};
+	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
 	uint16_t low;
 	uint16_t high;
 	char low_high_str[44]; /* 2^64 <= 20 digits so "low-high" <= 44 chars */
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 619a48f8c7b6..15b58a7aacee 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2687,7 +2687,7 @@ static int ocontext_selinux_ibpkey_to_cil(struct policydb *pdb,
 	int rc = -1;
 	struct ocontext *ibpkeycon;
 	char subnet_prefix_str[INET6_ADDRSTRLEN];
-	struct in6_addr subnet_prefix = {0};
+	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
 	uint16_t high;
 	uint16_t low;
 
-- 
2.14.1
