Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3B3E6381
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488489; cv=none; b=Ds2cCkamlYqLcUsY74ucACDJVsWTUdgRbu6CG/nEANMM4Q8eAA+c2znJMUehPNbtju2LZVVeCp4yqhOZz+9zqgtq88jRfDBK7qleQaSTW0jxejIORTJyj4BJJ/DjTkJdraN5/HT5Re0U9KsQoWuyN3fitstQDPVO9nwd6h46WLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488489; c=relaxed/simple;
	bh=o9TYWB5keZ54P16PTUOXFhmUzogutickXKN5a0IPAQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6ObB9KYhMsNN9OmyT8X3rQVq/GHOt2f/sye4UTHdSNNDUTp16fmvwP0Xpvoy+RBE03BM/gWvENGsvh4IsS2ShZqroMroXMj/Efb1tZkzmaCQUBJtrMxfUHdkpFwBUVLjVWoDtibc7/CEoYNrmWozsZ1/zrJoYiQ97+2JToHZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDmkuOHJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDmkuOHJ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93a0fb2f9efso77364085a.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488487; x=1790093287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VcV5yWZFRhIp6J+hvAucLAMrQZgz5vrlStfxf9MgG2I=;
        b=ZDmkuOHJUaNdzF7vzzz5t0oZvjyWvfmikpErhDJftgaH9o7osuql0cnKFWK+gzaq3B
         XICXIEfsT0SPRTJtT1NV5ctSWa2d0aObpsgBfyX33m0ODQxM44a2bAL8QdcJUWlbYOUF
         fKcW3Oh1vepkBE2qr8KeVXwAOpqDZp0nbRjStyw8jyOAna7Ud84myH+PK99HTieE+rdz
         khiVgCeZRq4DLbDZWkmdFfAsmxdd2eOjelfJDCmcKlG6AA/Hw2aJU+e4LKNMPsWaaNN/
         XX7IsKWKmNEyarc9pjxTeD/3gazTCCIZIYZgQ2/HwGLf1OioOTgQ7AfLIqonKLPa8jwe
         0OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488487; x=1790093287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VcV5yWZFRhIp6J+hvAucLAMrQZgz5vrlStfxf9MgG2I=;
        b=gh3qHbkhZP0IQ1dk7JP7z0URcGeWx/iXGQSsnyRi6tJkX7hEV6knxiJFr1D7RCsedR
         s9TeOYJXBbLP/ki1R3qVsnDWViTMwjVZY9j/1Hx31AjUy85T0mXkuvvH7hMqdntaMT6q
         LtD4CLqbPREVFQW0axWRFT4Si7rjBHuma1vJJJBqAdg1g9D3fTXSiEXWlyi56ngm228V
         345WH0cZGYsuyVNZ6y9vgEdxs/xp8Y8eAtQ5q+CmTJ4vSj4yuGmRhGUKitQxxBj40LsR
         pnVWtSKU0Kqe/9pcB4aA0CI5YOYL0MvG7DmMJeE4GpO9mnK2PKoZUHtnKdWbyQzmW5y6
         Yo/g==
X-Gm-Message-State: AFuF++l5V8ByIppZNzhfAt4xOTmUHyjCiJ+ao/CIfUebrIKTAzb6ash+
	B3yVaxNMk9Xu/HDrm0uj23qvP9H42evf7yE/drLAhVsu/O4ERK8PQX0ctUqGog==
X-Gm-Gg: AYBFou1x5s3ZOO+/ZXz/aigqRdVwlW1iAZAViIqW1QX0G32x5FLyHLwd/bKVo5aHT0q
	L34KMcwkC3NEL9EQmy4JeyEAtr6tG9jQRr3wU2tfHqKIL1AYxpcnix0waEjAcNOPDaQ2a8DCGFI
	/pKWQ6OvfyohQyR/r+Novhs+G869ifpX7+aMbW4Vv0YNcmd3UxVHwpK9lZEzhJd3xENW59lwWmb
	ODuaD+Bb+MPMxW0flfAHWc10wZhmMmky+3pb01vHv+4r+xc7XS5QUzsgI5PxwaW5TmqVIxLeiW6
	mT3+k4fBq8a7QRkAWvmLtwwDz3NZmQR3b43iXxZr9Q1YFSOpmXZ7KazbP0gd3EkMi6pZ7G0hIG6
	w4RMd87JmomzSIrB8d3bSda7f4jP+gnhZ/Fz4sCMh+n4Yvsxrx04H8Tag0yOx6Ow3UBaYm0kLBA
	lvNwHY22FwpX/MdNlCzGO+9mHR+3+XKg4BJ6p5K3UJTPCq3C9sr3Y1BfAt3ThJyF2ltxqfd2CB/
	wy0dwj5gC380CQLIwR7hJ4+Fjn6xRwwu04qhiyCl7LayopQnMx6irDUEr4FwQi5W8n3t86Q0rg=
X-Received: by 2002:a05:620a:2909:b0:939:af12:f5a0 with SMTP id af79cd13be357-93a346fa5d6mr590132585a.23.1789488486623;
        Tue, 15 Sep 2026 09:08:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c885sm1961696d6.21.2026.09.15.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:08:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/4] libsepol,checkpolicy: reject out-of-range pirqcon values
Date: Tue, 15 Sep 2026 12:07:37 -0400
Message-ID: <20260915160738.46723-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
References: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocontext_t stores u.pirq as uint16_t, matching the Xen Flask security
server, but the on-disk field is 32 bits and both policy compilers
accept a full 32-bit integer for pirqcon. A source policy with
"pirqcon 65537" is silently emitted as pirq 1, and reading a crafted
Xen policy binary with a 32-bit pirq truncates likewise.

Bound the value to UINT16_MAX in the binary reader and in both
compilers before the narrowing store, mirroring the OCON_IBPKEY /
OCON_IBENDPORT pattern.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/policy_define.c      |  5 +++++
 libsepol/cil/src/cil_build_ast.c |  6 ++++++
 libsepol/src/policydb.c          | 10 +++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 726060c7..fbacdaf4 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4923,6 +4923,11 @@ int define_pirq_context(unsigned int pirq)
 		return 0;
 	}
 
+	if (pirq > 0xffff) {
+		yyerror2("pirq %u out of range", pirq);
+		return -1;
+	}
+
 	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index e4f6af7b..4cc9ccf1 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4859,6 +4859,12 @@ int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current,
 		goto exit;
 	}
 
+	if (pirqcon->pirq > 0xffff) {
+		cil_log(CIL_ERR, "Invalid pirq %u\n", pirqcon->pirq);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	if (parse_current->next->next->cl_head == NULL) {
 		pirqcon->context_str = parse_current->next->next->data;
 	} else {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6a9254f3..60707fb4 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2571,15 +2571,23 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 							      fp))
 					return -1;
 				break;
-			case OCON_XEN_PIRQ:
+			case OCON_XEN_PIRQ: {
+				uint32_t pirq;
+
 				rc = next_entry(buf, fp, sizeof(uint32_t));
 				if (rc < 0)
 					return -1;
+
+				pirq = le32_to_cpu(buf[0]);
+				if (pirq > UINT16_MAX)
+					return -1;
+				c->u.pirq = pirq;
 				c->u.pirq = le32_to_cpu(buf[0]);
 				if (context_read_and_validate(&c->context[0], p,
 							      fp))
 					return -1;
 				break;
+			}
 			case OCON_XEN_IOPORT:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 				if (rc < 0)
-- 
2.55.0

