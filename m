Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308875;
	b=T7WpYgmSNfHV3nJuD73OthiODnj/y7vhezm0ACFOm1pJ9zqTokCOZSg3frq17YcRiOQd
	 qvpz+IVA0aJwu2vcOrt1TeYtf5QRleYMXplYin9q/NDzWn7YNBOopRhU+GEZtTDz3HtDm
	 2mKyf4ot+vluSLbyRnedwYoDfRTpuP+TYy+4fCKxJxBKKNhYRZ8yrtNc0LWi+2z7hcXyf
	 jiEUoGt2klOooHPVnlzDjPInTKnprlewsm8812owkuJwAu9iSUszhTXRODhf/UQuL9A/T
	 prmQviHgLRfHs+DphsjnOso7N2yuP233Bagy+JqAwxB75DhZK+owM4dGSKU2KgzT8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308875;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vSamUlcNjPhn05ytFIe84Fz0BNLhKqmjBacbw4CZTCc=;
	b=tToghAHRGZ8Lbzfbi2EibHezhaWO/wHP0mpxngg29yeerkgHwmO27ravEGJ0+VOsetEJ
	 8stAzxRZxEMD132qL7QKMEqkSllFwYeGF40GjYrdt3oGfX810M9ohUVeFzUYD1zhWoiuW
	 Drg7iavNO+6WsCSrISANAXINh0DebcQONzKGZffTkC/GPw37xyOGjS1Qa5+ny31XAVn11
	 eFhWLbK8QCh7ZsOKIUlZaSaW5w4PIYTUarWVe/l0LUJxPTnA/8M94a/VXf5XxMVcull9P
	 8RyL0ozjUot9dWJIvaibkURKlOcXAu5qqj8ET59eLtxMOwAJPgHADQz8XBjKCSces2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b="Wu2W/UXV";
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54C606A321
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC54C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Wu2W/UXV
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308873;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSamUlcNjPhn05ytFIe84Fz0BNLhKqmjBacbw4CZTCc=;
	b=Wu2W/UXVQvPOihezatu7YVxnh4VMmzUrysx7id6s0ZTdwKAXuW3MoXHEXV+Qbll1uEuIsf
	QOhWhyLwiOFbkrnC+S2bFrp77J6g6ImV+3HWqUaqiYMjkld95vepijWH3010vpBW956vol
	FUBLbpHRqi5EWOAbc6nZEB87wyhgtT6PynytfHpnQQezxUiAhP/WdrgMbi5Abf81PBye/4
	3UocKsImCedflgP5j3vk50J53z3bbksa5QqPr4p6H74nI3gAtC3LUZwP1MDFxpXh7wPLh3
	80qpcGTiiI2ttQ9+6UYORW9GIygWdIDiqwMUFm0oQ7IH3p0Y7ODOYCscCeINXw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 5/6] libsepol/cil: do not allocate hash tables for unused symtabs
Date: Tue, 10 Nov 2026 12:07:37 +0100
Message-ID: <20261110110739.67209-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261110110739.67209-1-cgoettsche@seltendoof.de>
References: <20261110110739.67209-1-cgoettsche@seltendoof.de>
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

Every block, macro, in-statement and conditional block has an array of
19 symtabs, one for each kind of declaration, and almost all of them
stay empty. All of them except four of the symtabs of blocks are
created with a single bucket, which still costs two allocations each.
Policies making heavy use of macros and block inheritance create
hundreds of thousands of them, since the blocks and macros are copied.

Create the hash table of symtabs with a size of one on the first
insertion. The hashtab functions used for looking up, iterating over
and destroying symtabs already handle a missing table.

Compiling DSSP5 peaks at 175MB instead of 364MB of memory and takes
about 15% less time.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_symtab.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index 03322abe..31073e52 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -52,7 +52,7 @@ cil_symtab_error(const char *msg, ...)
 	exit(1);
 }
 
-void cil_symtab_init(symtab_t *symtab, unsigned int size)
+static void cil_symtab_create_table(symtab_t *symtab, unsigned int size)
 {
 	int rc = symtab_init(symtab, size);
 	if (rc != SEPOL_OK) {
@@ -60,6 +60,22 @@ void cil_symtab_init(symtab_t *symtab, unsigned int size)
 	}
 }
 
+void cil_symtab_init(symtab_t *symtab, unsigned int size)
+{
+	if (size <= 1) {
+		/*
+		 * Every block, macro, etc. has a symtab for each kind of
+		 * declaration and most of them are never used. Do not
+		 * allocate a minimal hash table until something is inserted.
+		 */
+		symtab->table = NULL;
+		symtab->nprim = 0;
+		return;
+	}
+
+	cil_symtab_create_table(symtab, size);
+}
+
 void cil_symtab_datum_init(struct cil_symtab_datum *datum)
 {
 	datum->name = NULL;
@@ -91,7 +107,13 @@ int cil_symtab_insert(symtab_t *symtab, hashtab_key_t key,
 		      struct cil_symtab_datum *datum,
 		      struct cil_tree_node *node)
 {
-	int rc = hashtab_insert(symtab->table, key, (hashtab_datum_t)datum);
+	int rc;
+
+	if (symtab->table == NULL) {
+		cil_symtab_create_table(symtab, 1);
+	}
+
+	rc = hashtab_insert(symtab->table, key, (hashtab_datum_t)datum);
 	if (rc == SEPOL_OK) {
 		datum->name = key;
 		datum->fqn = key;
-- 
2.55.0

