Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8842C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7284121582
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="RLGnhR0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBCOOD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:14:03 -0500
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:52900 "EHLO
        re-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727066AbgBCOOD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 09:14:03 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-040.btinternet.com with ESMTP
          id <20200203141359.RCPO25673.re-prd-fep-040.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 3 Feb 2020 14:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580739239; 
        bh=o6kP+g8RBwUp8ZxW4AyeVPENYCg9Hb6kEpEHgfQ3he0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=RLGnhR0BJx5ZnHUJe5l1uyUHibSBbuAoCJctIOrtFdWPqXIKpag3HXKB2trDqN1dOfzSi7bCC0DODX8v1iwCRHblX0Qp9+A+b5Xhamvqqc0L284e+4JQoUsxeSvT53XDUSRI+1hc5YpW5dcNsL7ZoqSZ4iPERCaduarIgNSs7u1YXErF6QFOClKOzH+DrDNgM/YOv2ToIBftiA/LO/LDNWgYGQF6rEOybsz4pv3F6LKBtAtKUFI4Rbn/3UTYEU/b/st08p/XZ7lpVeL1ct8wTYcJkNZpVAQxdSWFhFPKSZQ+Tf61C6f7ssVruEX8dx4M3L2Tdz8MFFpDjX3pruS4XA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.51.79.157]
X-OWM-Source-IP: 31.51.79.157 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrhedurdejledrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrjeelrdduheejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.79.157) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D093E2FDD; Mon, 3 Feb 2020 14:13:59 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, paul@paul-moore.com, dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: security/selinux: Add support for new key permissions
Date:   Mon,  3 Feb 2020 14:13:43 +0000
Message-Id: <20200203141343.29133-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new 'key_perms' policy capability and support for the additional
key permissions: inval, revoke, join, clear

Also fixes JOIN -> LINK permission translation when policy
capability 'keys_perms' = 0;

The current "setattr" perm name remains and is used for KEY_NEED_SETSEC.
This gives the following permissions for the 'key' class:

create	Create a key or keyring.
view	View attributes.
read	Read contents.
write	Update or modify.
search	Search (keyring) or find (key).
link	Link a key into the keyring.
setattr	kernel < 5.X Change permissions on a keyring.
	kernel >= 5.X Set owner, group, ACL.
inval	Invalidate key.
revoke	Revoke key.
join	Join keyring as session.
clear	Clear a keyring.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/key.h                 |  3 +-
 security/keys/keyctl.c              |  3 +-
 security/selinux/hooks.c            | 73 ++++++++++++++++++++++++++++++-------
 security/selinux/include/classmap.h |  2 +-
 security/selinux/include/security.h |  8 ++++
 security/selinux/ss/services.c      |  3 +-
 6 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 24c69457783f..ddfc0709569b 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -435,7 +435,8 @@ extern void key_free_user_ns(struct user_namespace *);
 #define	KEY_NEED_REVOKE	0x080	/* Require permission to revoke key */
 #define	KEY_NEED_JOIN	0x100	/* Require permission to join keyring as session */
 #define	KEY_NEED_CLEAR	0x200	/* Require permission to clear a keyring */
-#define KEY_NEED_ALL	0x3ff
+#define KEY_NEED_PARENT_JOIN 0x400 /* Require permission to impose keyring on parent */
+#define KEY_NEED_ALL	0x7ff
 
 #define OLD_KEY_NEED_SETATTR 0x20 /* Used to be Require permission to change attributes */
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index a0c97d4d8251..65e1c0c3feb1 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1592,7 +1592,8 @@ long keyctl_session_to_parent(void)
 	struct cred *cred;
 	int ret;
 
-	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_JOIN);
+	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
+				    KEY_NEED_PARENT_JOIN);
 	if (IS_ERR(keyring_r))
 		return PTR_ERR(keyring_r);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c8db5235b01f..a499bd7d9777 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6556,7 +6556,8 @@ static int selinux_key_permission(key_ref_t key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
-	unsigned oldstyle_perm;
+	unsigned int key_perm = 0, switch_perm = 0;
+	int bit = 1, count = KEY_NEED_ALL;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
@@ -6565,18 +6566,62 @@ static int selinux_key_permission(key_ref_t key_ref,
 	if (perm == 0)
 		return 0;
 
-	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
-				KEY_NEED_SEARCH | KEY_NEED_LINK);
-	if (perm & KEY_NEED_SETSEC)
-		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
-	if (perm & KEY_NEED_INVAL)
-		oldstyle_perm |= KEY_NEED_SEARCH;
-	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
-		oldstyle_perm |= KEY_NEED_WRITE;
-	if (perm & KEY_NEED_JOIN)
-		oldstyle_perm |= KEY_NEED_SEARCH;
-	if (perm & KEY_NEED_CLEAR)
-		oldstyle_perm |= KEY_NEED_WRITE;
+	if (selinux_policycap_key_perms()) {
+		while (count) {
+			switch_perm = bit & perm;
+			switch (switch_perm) {
+			case KEY_NEED_VIEW:
+				key_perm |= KEY__VIEW;
+				break;
+			case KEY_NEED_READ:
+				key_perm |= KEY__READ;
+				break;
+			case KEY_NEED_WRITE:
+				key_perm |= KEY__WRITE;
+				break;
+			case KEY_NEED_SEARCH:
+				key_perm |= KEY__SEARCH;
+				break;
+			case KEY_NEED_LINK:
+				key_perm |= KEY__LINK;
+				break;
+			case KEY_NEED_SETSEC:
+				key_perm |= KEY__SETATTR;
+				break;
+			case KEY_NEED_INVAL:
+				key_perm |= KEY__INVAL;
+				break;
+			case KEY_NEED_REVOKE:
+				key_perm |= KEY__REVOKE;
+				break;
+			case KEY_NEED_JOIN:
+			case KEY_NEED_PARENT_JOIN:
+				key_perm |= KEY__JOIN;
+				break;
+			case KEY_NEED_CLEAR:
+				key_perm |= KEY__CLEAR;
+				break;
+			}
+			bit <<= 1;
+			count >>= 1;
+		}
+	} else {
+		key_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
+				   KEY_NEED_WRITE | KEY_NEED_SEARCH |
+				   KEY_NEED_LINK);
+		if (perm & KEY_NEED_PARENT_JOIN)
+			key_perm |= KEY_NEED_LINK;
+		if (perm & KEY_NEED_SETSEC)
+			key_perm |= OLD_KEY_NEED_SETATTR;
+		if (perm & KEY_NEED_INVAL)
+			key_perm |= KEY_NEED_SEARCH;
+		if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
+			key_perm |= KEY_NEED_WRITE;
+		if (perm & KEY_NEED_JOIN)
+			key_perm |= KEY_NEED_SEARCH;
+		if (perm & KEY_NEED_CLEAR)
+			key_perm |= KEY_NEED_WRITE;
+	}
 
 	sid = cred_sid(cred);
 
@@ -6584,7 +6629,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	ksec = key->security;
 
 	return avc_has_perm(&selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY, oldstyle_perm, NULL);
+			    sid, ksec->sid, SECCLASS_KEY, key_perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 7db24855e12d..038374bef526 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -159,7 +159,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
 	{ "key",
 	  { "view", "read", "write", "search", "link", "setattr", "create",
-	    NULL } },
+	    "inval", "revoke", "join", "clear", NULL } },
 	{ "dccp_socket",
 	  { COMMON_SOCK_PERMS,
 	    "node_bind", "name_connect", NULL } },
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ae840634e3c7..6b264b6d9d31 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,6 +79,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_KEYPERMS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -178,6 +179,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
+static inline bool selinux_policycap_key_perms(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a5813c7629c1..b31dcd54cde9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"key_perms"
 };
 
 static struct selinux_ss selinux_ss;
-- 
cgit 1.2-0.3.lf.el7
