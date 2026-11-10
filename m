Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308875;
	b=PNUvIKB+dJ5Jbbq6TT/NL0smrSnz7r/Z/ovXuxb8jRa1fovm9C5H1LIeFFs3Dj8Od9PD
	 kHGI8Yq9homEMz0B6DU1EiQmmu09h+IVcOakq9bMBPwPM3/wBY9CQY463mB1TxhCGFBh4
	 Ld6sd/r8oeK7ONAoBK2ERZhxd2JH1Q/2o/A+AxtOLQkN0Ty0xO94gQmvDxE/dvpO00Erq
	 4aNaDFYerzbTUzg+R4hoUKmsHWmgZNfFJ2Nc6CjkBMyf//Du2Mn22Sfi+R5hRZlKnrjKk
	 CVTuSDbMTmns9qccMhJiXDru8M/R0m218Auuw4Fldsy4MrjRBkErbTcPerWlLrcn5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308875;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jeCKayLYrFSuvsH2wwmAKPLxK7o56oV283deB0oW6QA=;
	b=qnbZ58sY7Kpco2DlIQuFzkJAITuPQrWuUooonfCCl2nm+lFO5dpd2FFN1A3ocv2MpiZd
	 GZzRHndAgORhYcxXMA9LfUqZZRYlbU9ym9Fu1gBtOBixRnACwu3vb7JVU3AiDOLtrO8b+
	 nYFmnYnxDG8SXUEVSfiWDRA10+o9GXmzp1CKoX8zmW2fHcJ1gy/cXkFD3iw/X5CG/P3VG
	 ZvImnTitVuD4Xa13/MCh+cxLOhVR/kLzrby7ID7/2gEjHlIRtwXPr+olWFdOZAaoCZ5j7
	 oRawcUpN+7CwrU5PhRpsvwKlmZqfUUYt4tBPFyDRGwv0z9Auy8jUI5CQrmc0jxq0iVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=kWumPXYq;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D8606A325
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5D8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=kWumPXYq
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308872;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jeCKayLYrFSuvsH2wwmAKPLxK7o56oV283deB0oW6QA=;
	b=kWumPXYqqNXCXNJP20iBHFR2/NUgceL+eOM8Ol1HvmyZ6EYKEuI3wavw19r6HziMN7/zi7
	vZfemxIYIyoZyPd626SiuC8zsvQhr3FjHCRtQeQJa2n6g0lzvJVuzyVkKfLNpFPScNhoaS
	QeAMKUw9ROAoQ91iKXmJNYUSz86wGDPhvXiiC1r3vKHTw/wfv4hpGS+lqbG5GG0SO3oFay
	6b9gw+zBifAsNHdAMF9X7hvNgyescTqpjj5FkCEM6053ANGLqFMpCSiP9u5jY2BhN9xPG+
	sNP97M6v20G5yHbbzq5lXUyIcWCuWHOag1WGsK79AvrIAzTKNAjmtzyxDvinUg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 2/6] libsepol: skip the conditional lists without matching rules for neverallowx
Date: Tue, 10 Nov 2026 12:07:34 +0100
Message-ID: <20261110110739.67209-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

For every allow rule matching a neverallowx rule
check_assertion_extended_permissions_avtab() iterates over all
combinations of the attributes of the source and the target type and
for each of them scans every rule of every conditional list for one
with the same source, target and class.

All rules of the conditional lists are part of the conditional avtab,
which check_assertion() already relies on for checking them. Look up
the key there first and skip the scan if there is no conditional rule
for it, which is the common case.

Compiling a policy with about 1000 conditional rules and 64
neverallowx rules with secilc takes 1.1s instead of 1.5s.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/assertion.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 94172e5a..9572a5c4 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -172,6 +172,20 @@ static bool match_node_key(const struct avtab_node *node,
 	       node->key.target_class == key->target_class;
 }
 
+/*
+ * Whether there is any conditional rule for the source type, target type and
+ * class of the key. All rules of the conditional lists are part of the
+ * conditional avtab, so this permits to skip searching the lists.
+ */
+static bool has_cond_rules(policydb_t *p, const avtab_key_t *key)
+{
+	avtab_key_t tmp_key = *key;
+
+	tmp_key.specified = AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS;
+
+	return avtab_search_node(&p->te_cond_avtab, &tmp_key) != NULL;
+}
+
 /* Same scenarios of interest as check_assertion_extended_permissions */
 static int report_assertion_extended_permissions(
 	sepol_handle_t *handle, policydb_t *p, const avrule_t *narule,
@@ -574,6 +588,9 @@ static bool check_assertion_extended_permissions_avtab(
 					return true;
 			}
 
+			if (!has_cond_rules(p, &tmp_key))
+				continue;
+
 			for (const cond_list_t *cl = p->cond_list; cl;
 			     cl = cl->next) {
 				bool found_true_base = false,
-- 
2.55.0

