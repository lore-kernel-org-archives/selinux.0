Return-Path: <SRS0=5MQ6=4I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18733C11D0C
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B462467A
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CTMKwSSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgBTSKj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:10:39 -0500
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:26056 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbgBTSKj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Feb 2020 13:10:39 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200220181035.THBQ620.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 20 Feb 2020 18:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582222235; 
        bh=8V9pmsMZHHFLbe2Igb/6UEWhXR8b1mbxNiujEzGUtGI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=CTMKwSSM9nK3eaVqNBsspxxR9qP+v2dTz69BG7Xo6ZdH6SnE1ygtyVAg24fkUwNdilriW3D/DRd3255qv5pjohaH2Wdtw8x2E6ejci6r8zHA2T2LKNYssGwZSjP7jlFx2lY+yAe7YdaHPi17YZ2QvuleG/bPFx/ORQWe0Rr6ZnZtcV5Sm4OwCWdQeIlx0Ge6PdYbL0ZNO7ckO3x8fWMHISMR5D6tMOosi5fMC1yNa1Eh6vhDQwpBJu58jUWreCab+7nmmggCrqz/a8FXUMYWPb4B+JsFZN5XgjVa8Py3F5uii1c4yal/c+1wFwf8VBrxCzZmyADQmVVUURtAgjYC5g==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.134.4.49]
X-OWM-Source-IP: 86.134.4.49 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdegrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdegrdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.49) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A181A026A5EBC; Thu, 20 Feb 2020 18:10:35 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     dhowells@redhat.com
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov, paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] selinux: Add support for new key permissions
Date:   Thu, 20 Feb 2020 18:10:31 +0000
Message-Id: <20200220181031.156674-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220181031.156674-1-richard_c_haines@btinternet.com>
References: <20200220181031.156674-1-richard_c_haines@btinternet.com>
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
setattr	kernel < current version: Change permissions on a keyring.
	kernel >= current version: Set owner, group, ACL.
inval	Invalidate key.
revoke	Revoke key.
join	Join keyring as session.
clear	Clear a keyring.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 security/selinux/hooks.c            | 123 ++++++++++++++++------------
 security/selinux/include/security.h |  10 +--
 security/selinux/ss/services.c      |   4 +-
 3 files changed, 76 insertions(+), 61 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 46a8f3e7d..af179442c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6538,8 +6538,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
-	unsigned int key_perm = 0, switch_perm = 0;
-	int bit = 1, count = KEY_NEED_ALL;
+	unsigned int key_perm = 0;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
@@ -6549,60 +6548,73 @@ static int selinux_key_permission(key_ref_t key_ref,
 		return 0;
 
 	if (selinux_policycap_key_perms()) {
-		while (count) {
-			switch_perm = bit & perm;
-			switch (switch_perm) {
-			case KEY_NEED_VIEW:
-				key_perm |= KEY__VIEW;
-				break;
-			case KEY_NEED_READ:
-				key_perm |= KEY__READ;
-				break;
-			case KEY_NEED_WRITE:
-				key_perm |= KEY__WRITE;
-				break;
-			case KEY_NEED_SEARCH:
-				key_perm |= KEY__SEARCH;
-				break;
-			case KEY_NEED_LINK:
-				key_perm |= KEY__LINK;
-				break;
-			case KEY_NEED_SETSEC:
-				key_perm |= KEY__SETATTR;
-				break;
-			case KEY_NEED_INVAL:
-				key_perm |= KEY__INVAL;
-				break;
-			case KEY_NEED_REVOKE:
-				key_perm |= KEY__REVOKE;
-				break;
-			case KEY_NEED_JOIN:
-			case KEY_NEED_PARENT_JOIN:
-				key_perm |= KEY__JOIN;
-				break;
-			case KEY_NEED_CLEAR:
-				key_perm |= KEY__CLEAR;
-				break;
-			}
-			bit <<= 1;
-			count >>= 1;
+		switch (perm) {
+		case KEY_NEED_VIEW:
+			key_perm = KEY__VIEW;
+			break;
+		case KEY_NEED_READ:
+			key_perm = KEY__READ;
+			break;
+		case KEY_NEED_WRITE:
+			key_perm = KEY__WRITE;
+			break;
+		case KEY_NEED_SEARCH:
+			key_perm = KEY__SEARCH;
+			break;
+		case KEY_NEED_LINK:
+			key_perm = KEY__LINK;
+			break;
+		case KEY_NEED_SETSEC:
+			key_perm = KEY__SETATTR;
+			break;
+		case KEY_NEED_INVAL:
+			key_perm = KEY__INVAL;
+			break;
+		case KEY_NEED_REVOKE:
+			key_perm = KEY__REVOKE;
+			break;
+		case KEY_NEED_JOIN:
+		case KEY_NEED_PARENT_JOIN:
+			key_perm = KEY__JOIN;
+			break;
+		case KEY_NEED_CLEAR:
+			key_perm = KEY__CLEAR;
+			break;
+		default:
+			pr_err("BUG pcap = 1 entry_perm: 0x%04x\n", perm);
+			BUG();
+			break;
 		}
 	} else {
-		key_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
-				   KEY_NEED_WRITE | KEY_NEED_SEARCH |
-				   KEY_NEED_LINK);
-		if (perm & KEY_NEED_PARENT_JOIN)
-			key_perm |= KEY_NEED_LINK;
-		if (perm & KEY_NEED_SETSEC)
-			key_perm |= OLD_KEY_NEED_SETATTR;
-		if (perm & KEY_NEED_INVAL)
-			key_perm |= KEY_NEED_SEARCH;
-		if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
-			key_perm |= KEY_NEED_WRITE;
-		if (perm & KEY_NEED_JOIN)
-			key_perm |= KEY_NEED_SEARCH;
-		if (perm & KEY_NEED_CLEAR)
-			key_perm |= KEY_NEED_WRITE;
+		switch (perm) {
+		case KEY_NEED_VIEW:
+			key_perm = KEY_NEED_VIEW;
+			break;
+		case KEY_NEED_READ:
+			key_perm = KEY_NEED_READ;
+			break;
+		case KEY_NEED_WRITE:
+		case KEY_NEED_REVOKE:
+		case KEY_NEED_CLEAR:
+			key_perm = KEY_NEED_WRITE;
+			break;
+		case KEY_NEED_SEARCH:
+		case KEY_NEED_INVAL:
+		case KEY_NEED_JOIN:
+			key_perm = KEY_NEED_SEARCH;
+			break;
+		case KEY_NEED_LINK:
+		case KEY_NEED_PARENT_JOIN:
+			key_perm = KEY_NEED_LINK;
+			break;
+		case KEY_NEED_SETSEC:
+			key_perm = OLD_KEY_NEED_SETATTR;
+			break;
+		default:
+			pr_err("BUG pcap = 0 entry_perm: 0x%04x\n", perm);
+			BUG();
+			break;
+		}
 	}
 
 	sid = cred_sid(cred);
@@ -6610,6 +6622,9 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
+	pr_info("entry_perm: 0x%04x exit_perm: 0x%04x\n",
+	       perm, key_perm);
+
 	return avc_has_perm(&selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, key_perm, NULL);
 }
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cba9610b8..c0998e79d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,8 +79,8 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
-	POLICYDB_CAPABILITY_KEYPERMS,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_KEYPERMS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -215,18 +215,18 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
-static inline bool selinux_policycap_key_perms(void)
+static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
+	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
 }
 
-static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
+static inline bool selinux_policycap_key_perms(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
+	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
 }
 
 int security_mls_enabled(struct selinux_state *state);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d4a05f34d..6efc86c47 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,8 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"always_check_network",
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
-	"key_perms",
-	"genfs_seclabel_symlinks"
+	"genfs_seclabel_symlinks",
+	"key_perms"
 };
 
 static struct selinux_ss selinux_ss;
-- 
2.24.1

