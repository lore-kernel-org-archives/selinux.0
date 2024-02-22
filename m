Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0717C6B
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646384; cv=none; b=BdaECnHWaO41Zvr3xYxycaPfk1w/xD2YFTu3S1kOyuwapY76EiP1XXiQOuhkt+D8NVZS5LE3+bngpD3doX/J88MUq3H5LC/Uf9M/tE7QWEHX1Ff1dZv0Uh54v+o6pssqZPla71kODTTZr8yTrdpS69xcI0aWNn1cJk/sjgZh0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646384; c=relaxed/simple;
	bh=yDE+tDI7cUEkdMPkALUTQfUiZZBC2in7MJZ29+gi/8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvYRMN9/cVZWCpw30D3iM5Zjtj59cbET04FAazu+k/PZGiO9zX2oC9nYswksRfISkT3cYti90nWQG3Ulk+ZQudH46UStwNxnYqCq6PiQbGqWZYx52KmVP3UDKt6ObS1fqXDxHRJc2uYd/Mo18cJWPbfTwB7LcS2Ni5Xd1WUgYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HheUP069; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HheUP069"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42c7f8588c5so1497271cf.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646381; x=1709251181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX3TfZuholLrNzzA3yxupVAoX8mKWN1ORkoMX1bdMBc=;
        b=HheUP069kkYupzWZhuN+eUdwNHtMVdOU3tB9v7lQ59qzWXIhwwnOKpHETYqy7Ggl6A
         2b7OnIBdK+oMw94VI2HN4bYeP5Jj1rOjpLHVze6ZEbQcEA2ntipgzF5lMPBWDVliRPVj
         ahCcm3Vy7nPYT4gflDfBaf8HH01mv+Ze+Hk48TwO8CrHogmFXDRVqsySr4tz5hMIp05a
         QSoPErCxNLLSbFKMpHZ2O+oviywK7kBLM9maoei4m3xJZSG9VOXOoXppqXZQHE9D/hrU
         VxlNQjcLQMED1mkI8MGMMKbefsbV1Aya2EH2Y6o2Ym1uCwGOtfLvLrIB46Z3fi4ESv1F
         NWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646381; x=1709251181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX3TfZuholLrNzzA3yxupVAoX8mKWN1ORkoMX1bdMBc=;
        b=JjZJZqHvSed06IGTUD8wivrFrDNaNTHEpOGoLy45wp2lEY1tLHCzIfbHD4rYmS7bH9
         0HDAstVLXhryQ2FB9YzgZOKkwwyCUcXZa+cs4ZhkVSDM+NstXdtBViI/oRCRpI45vQZs
         I5B1Rk05FqqLf3+40igj8gee6LmUz0ds/sG5fhrsQHWwIE2jSPb2ocVX475SMN2Pe/Pe
         4nfQheHpN2q2bfrIUKhK6cAbYmdy8INUO9lSZKSLNmx/dYeqMGl212g81bQYHiiuR6rN
         bznqrT5xEvr9W4DGwCmK1xSD71AaUxJ0XBAPc32S6VCGDtOoHDW0G3SbKbyhpEY7hICI
         3Fsw==
X-Gm-Message-State: AOJu0YyEmpEW0j0YZnNA9o3MX4vMYGGnPZvBapFVTWtOxWYFfgFajNSM
	3VgLLXoUr1jC0EnrqiVrUt6MVg8DZS+73ANibRZWZ63K5DIT1A28FMImm/05OW0Xv4fKISrQJmg
	=
X-Google-Smtp-Source: AGHT+IFRC7vV/asmhEJXW8v6N6fk4MbdoF7zJeS0+BpeFj1wzsbk4h0qrpkycxMzcvCBUfyYb4SmTw==
X-Received: by 2002:ac8:5ac3:0:b0:42e:2721:13b2 with SMTP id d3-20020ac85ac3000000b0042e272113b2mr884438qtd.12.1708646381094;
        Thu, 22 Feb 2024 15:59:41 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id mw2-20020a05621433c200b0068f3291f860sm7477260qvb.95.2024.02.22.15.59.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:40 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 08/21] selinux: fix style issues in security/selinux/ss/ebitmap.h
Date: Thu, 22 Feb 2024 18:52:26 -0500
Message-ID: <20240222235708.386652-31-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4146; i=paul@paul-moore.com; h=from:subject; bh=yDE+tDI7cUEkdMPkALUTQfUiZZBC2in7MJZ29+gi/8w=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+AW3YBoiiEl/IPWz7zwKDwKUeZFLntqz7BH 4lpxKPO+WuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffgAAKCRDqIPLalzeJ c26sEACdyY5P+MHb/gcZpNrjfhdB+xCSNd8l3kX1HGpkBJzxSJJXbSKdZm/QS4a48T5N8xi+LG+ 8JAysNn2wKptULWu5qEEgrbNTGF8/bA3X9mq4G9crlG9i05+WrDOiWgkdjui8eXa8YBXPjoV8Rn Bg1fYt91+sIFs5kZnnkCh4c3KGVwsBj06bvEC0TNDZaPJRisZZddqq32oSeCBa/NAOD1GNg9wZp Hkw5aoJM0CsT8q6nJ8OVV2ounAsIWY4NSM4mPxjFZyMg2LcqkNXyJKwtsApFM6ESPJN21+hSxOb HYPmjcxMSKAR1gNEmTcv7RyVje4JMAlNUE5Qb2EpOSPQSiRoLHgqjx94FnrLWhVlG7gMRT2OojS V5Y8wsafmlmYpaxqUZ6YEBbRNnSMp7hj/loGbuC3++MldKywJjg6aBMtabrFwr6KIp2GZJkKhp9 LLcMVg9UPuwXMuGcqLWnBpgnX3XEWZ78K0p612kgJcg+ZW/LA8RG5lhfvl6rpmcpFRiZdehj14k odXRtpuHT61E71991Akqt2kp8Jij06dpI66w3kpOGFzWbcQjPeSPZqGRcWivIcOG72175WlJuoO YvffZGibMysFD6d/JbM5U55iJFRrfO8ILRzdUxTp3GV43AXk5+sQYPy3+ta53EqIapIZtweW7y/ 8icaky+1X/HmMlw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/ebitmap.h | 42 +++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e3c807cfad90..02798b35eecc 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -12,23 +12,25 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_EBITMAP_H_
 #define _SS_EBITMAP_H_
 
 #include <net/netlabel.h>
 
 #ifdef CONFIG_64BIT
-#define	EBITMAP_NODE_SIZE	64
+#define EBITMAP_NODE_SIZE 64
 #else
-#define	EBITMAP_NODE_SIZE	32
+#define EBITMAP_NODE_SIZE 32
 #endif
 
-#define EBITMAP_UNIT_NUMS	((EBITMAP_NODE_SIZE-sizeof(void *)-sizeof(u32))\
-					/ sizeof(unsigned long))
-#define EBITMAP_UNIT_SIZE	BITS_PER_LONG
-#define EBITMAP_SIZE		(EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
-#define EBITMAP_BIT		1ULL
-#define EBITMAP_SHIFT_UNIT_SIZE(x)					\
+#define EBITMAP_UNIT_NUMS                                     \
+	((EBITMAP_NODE_SIZE - sizeof(void *) - sizeof(u32)) / \
+	 sizeof(unsigned long))
+#define EBITMAP_UNIT_SIZE BITS_PER_LONG
+#define EBITMAP_SIZE	  (EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
+#define EBITMAP_BIT	  1ULL
+#define EBITMAP_SHIFT_UNIT_SIZE(x) \
 	(((x) >> EBITMAP_UNIT_SIZE / 2) >> EBITMAP_UNIT_SIZE / 2)
 
 struct ebitmap_node {
@@ -38,8 +40,8 @@ struct ebitmap_node {
 };
 
 struct ebitmap {
-	struct ebitmap_node *node;	/* first node in the bitmap */
-	u32 highbit;	/* highest position in the total bitmap */
+	struct ebitmap_node *node; /* first node in the bitmap */
+	u32 highbit; /* highest position in the total bitmap */
 };
 
 #define ebitmap_length(e) ((e)->highbit)
@@ -80,9 +82,9 @@ static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
 	return ebitmap_length(e);
 }
 
-#define EBITMAP_NODE_INDEX(node, bit)	\
+#define EBITMAP_NODE_INDEX(node, bit) \
 	(((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
-#define EBITMAP_NODE_OFFSET(node, bit)	\
+#define EBITMAP_NODE_OFFSET(node, bit) \
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
 static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
@@ -117,15 +119,17 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
 }
 
-#define ebitmap_for_each_positive_bit(e, n, bit)	\
-	for ((bit) = ebitmap_start_positive(e, &(n));	\
-	     (bit) < ebitmap_length(e);			\
-	     (bit) = ebitmap_next_positive(e, &(n), bit))	\
+#define ebitmap_for_each_positive_bit(e, n, bit)      \
+	for ((bit) = ebitmap_start_positive(e, &(n)); \
+	     (bit) < ebitmap_length(e);               \
+	     (bit) = ebitmap_next_positive(e, &(n), bit))
 
 int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src);
-int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2);
-int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit);
+int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
+		const struct ebitmap *e2);
+int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
+		     u32 last_e2bit);
 int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
@@ -151,4 +155,4 @@ static inline int ebitmap_netlbl_import(struct ebitmap *ebmap,
 }
 #endif
 
-#endif	/* _SS_EBITMAP_H_ */
+#endif /* _SS_EBITMAP_H_ */
-- 
2.43.2

