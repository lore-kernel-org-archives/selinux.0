Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308876;
	b=2oPNp/PRjOacLw1NJEvRd7LwRoKiE4qzf0oK8TfKeCJd98t2sCir8WQSaUiZLkSH3X3z
	 nbDzjjoKG2PjvBmMP7zLdeRSjQkFYJGwRvl7EEt93EsQoCqvmcqOQoO+7Sm1tDrIDgvXK
	 Sb7+pTyX6fxcXVEH4iF9BFxQw7J1XZMjhYJKviT2XrAOgDNTsfCJo0dKYeeKm5XQZ726B
	 f+7BwQQ28XFg7EwcVceuVrLU5zTtx/JQVZpWLPjZ2x3dhYrL9JD3cNdZB+EK7v/K24i4O
	 htw0av5UIIDGieezqOeQjXqMrba8XY9I89z5mC2U33mLIsmzE2uwdvbbwvtQAqvbWXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308876;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IgqxaGyRMiICdlTuSXyTgh8QUOC7FBmbEsCs3jdeRMg=;
	b=inpXmWKowv6SO3b8eDDXiJgUL8cU9Nrd27w9er2EVaohD4KpZiHEG6TBxWNQ5/QwVLpH
	 mZcI0Uyk9ZFH9zR/GOFpsIdNlpGwS6D5vrJGx97pR6AE1aqey1XrO1T595IUCDpMhl9yM
	 rUGvNXQj7b/aXQzzIQKrxPBYQBNoJdIuisW2D1P10BWcyvZSeKZRHMfYgt9i03u5bz4XY
	 hFIA2tf5RPk7USqDYKQo4AcAmQ+ulow/6T9M6aj1o9vaedKkDQMm5QEniW75oELDobHnH
	 vshmaPoTEVZz4acZBgnc5d/Tc/bgCg6RtcKQ75xH9fRqtAF+f2AHqUpWB3yq6622wQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=qc6WHXKY;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC613606A326
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC613606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=qc6WHXKY
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308872;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgqxaGyRMiICdlTuSXyTgh8QUOC7FBmbEsCs3jdeRMg=;
	b=qc6WHXKYvgsDXboxp641F7mtEJu76bLDKbWFPr2nR/5pS3zYMqApuIX//BHJO/Is++woVF
	7ZUkTRYehYigJfU+dwF7pYyvsDycmXyBLpoxsBkopH8JwYfLTf3Jzb30wmjy8eVR4EP19I
	EWreY6qtNby+hUzJK4lzcitT36fLJ139V7gJA7T5npox61hnJ11I4jRGyIyOyZkqFzOtGj
	yGoB1kO+M8TqLJT74/ZnVh1m2wOLQhebYZLeBOR4O8ay2txe27XweBmMxyxgUwjwkWVhy8
	xfaXYQCe8wtaI+mT4rueZmInThoeWq/B98/XCVwdx9SYH0SRa4Hw2KiWHo2JOQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 3/6] libsepol/cil: avoid searching the ebitmap for each extended permission
Date: Tue, 10 Nov 2026 12:07:35 +0100
Message-ID: <20261110110739.67209-2-cgoettsche@seltendoof.de>
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

__cil_permx_bitmap_to_sepol_xperms_list() iterates over the set bits
of the extended permissions and tests for each of them whether the
following bit is set with ebitmap_get_bit(), which searches the
ebitmap from its first node. For rules covering large ranges, e.g.
neverallowx rules using a negated set, this is quadratic in the number
of nodes.

Test the following bit via the node of the iteration instead.

Compiling a policy with 64 neverallowx rules takes 0.7s instead of
1.1s.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index fbce5a2e..03178d9f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1910,6 +1910,23 @@ static char *__cil_xperm_kind_to_str(uint32_t xperm_kind)
 #define IOC_DRIV(x) (x >> 8)
 #define IOC_FUNC(x) (x & 0xff)
 
+/*
+ * Test the bit following bit, where node is the node containing bit.
+ * Avoids searching the ebitmap from its start as ebitmap_get_bit() does.
+ */
+static int __cil_ebitmap_next_bit_is_set(const ebitmap_node_t *node,
+					 unsigned int bit)
+{
+	bit++;
+	if (bit - node->startbit >= MAPSIZE) {
+		node = node->next;
+		if (node == NULL || node->startbit != bit) {
+			return 0;
+		}
+	}
+	return ebitmap_node_get_bit(node, bit);
+}
+
 static int
 __cil_permx_bitmap_to_sepol_xperms_list(uint32_t kind, ebitmap_t *xperms,
 					struct cil_list **xperms_list)
@@ -1932,7 +1949,8 @@ __cil_permx_bitmap_to_sepol_xperms_list(uint32_t kind, ebitmap_t *xperms,
 		}
 
 		// continue if the current bit isn't the end of the driver function or the next bit is set
-		if (IOC_FUNC(i) != 0xff && ebitmap_get_bit(xperms, i + 1)) {
+		if (IOC_FUNC(i) != 0xff &&
+		    __cil_ebitmap_next_bit_is_set(node, i)) {
 			continue;
 		}
 
-- 
2.55.0

