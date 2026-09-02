Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538336494C
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357816; cv=none; b=DWIdz6CoO6p1JRIT/V1x/YN2eoJj1mkJeERnNAPx/T1h3ld0oKa6BGqlBVOhGHFpPiY+ieED//0Bt1vajk7WzYss2EAu9cmydb4+GBctrjJ6I/Ka3oNz8yN+mKyoXp/8wl2ww0BBLsDT/Nf+n/lva4EweRNEb8q481rVxUWhhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357816; c=relaxed/simple;
	bh=kFKyYHJXXS3bXDDyGziO2bl0xHCxt0MRzloAcdHL3t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCE/9m2QbRZbEzzAWprOW7R1zRM7brvZszHG8+Bzcq+SCQUNxLXtkJcGhw/QPFhidzavjqd5Gcin/XbOtNUcQudq5owAhUJx4ToAALmgHqBfmFu8U4k1YYh8158RLbRurWcRGJOrpvtHYPo8Dh4yeBzxUBMbLSZIAcD9XOe3Gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEqEx0r9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEqEx0r9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e9143643cso12431486d6.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357813; x=1788962613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j7l4QNWys2iYiMyo/cPiugfxje++Z/FpbbSTmVbcEKQ=;
        b=JEqEx0r9GA/+5jYg5uuKkCISNdLFnjvXf+X0dlx8Otk7q4Wrt48lTHFVhzhWZdusxj
         /sTCJU3CEwe9uUjOQ9wyym8XZCcLtaAPkZ+ZGp64N+qrTifgxHcjT6QslEPIEKbzA3yL
         cpDhsz43Co55bqWYnkr+ielMGAGdCQDt/tAGHSBwZZO+FQXhvn4+V75zuOyScoqA5sYh
         hrA1AKDA8Sf1yA/+d1V/11tTWrc6G6eDXIbT/N7sinpYBUKEGAyjPjt960krgpsaa3sd
         LnU+QFZOraH993dVZ7oII5nQo6/MoZsbR92xiKOfCU+7EuU1R8//jtTUlzmM1gVeNyXO
         dnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357813; x=1788962613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j7l4QNWys2iYiMyo/cPiugfxje++Z/FpbbSTmVbcEKQ=;
        b=qytEMuLTkRoJD9iMRcRoOiBptr6DgPTGbVEMdLAA86K85Jv+KcIipcOWblJ8XlhbKJ
         lGCoaIuqVl/CiNy04oJIhoAO4MzO97UG6P0ezLBfm2O3Wbf4XJqPC1fQnwHpQSv+SQWO
         o/9H1xAZk+EgMelv7r0eHHLnZw7MctsgdsBZbfxP+qxZGOlvHH7vg+chYTZTXSF0PXUm
         De3C7oY3eqegpY2nQHZTa+ocyoQXw26zVp2NcewWtTJs36vyjA96FXO79ZBbwwhxme/w
         n52D2QNgXbrAow2lK2CX0DZeoHn9zH1eV/xGQpX7JK1Dj2tB6IKCIDVR10LGKtTGGl+4
         K/aQ==
X-Gm-Message-State: AFuF++l+aInv2EXSzEf5yn9H5HvL35xwpLK1rumoEQbIz2XWTOzkaD/M
	vvlZ4iJJjKfoP4KXmxcFjZSMI8r9gyIiq+HCZf3m+ihQNhULT9Wml00X2OJh8w==
X-Gm-Gg: AYBFou3IYf9RSB6QoN+AxI7kncRx8EC11xSwQNBxOHVKyMiTqOeavamwvdpiGFH5u/X
	C+mu8brh0elubGK0poQGXxRvCU1jtdc5a1DOhPqUv6kzsmHHXUseJrQovDJ6BFqswF3S89Fc+nn
	S9ay2/9L4/5MIiEtXKSbJr7q2CjfvGRxzJ9QP4hyiQH1uSGBwUVo265zJloEQSGdDxpXM+VNlR1
	UHJ76Unu20TyFY63a8e2AjwQ47TS1AVWnJtUPBqoWssfDzC9C5stCg9jtStJrFjvgujvwPER4qG
	EjK+djqj89zTJqpBnV9bYHdTv2mPVHTedlaEaTZups/hyWT4t6ei4EYEOfe0gzFFF7Afqda6ErP
	wCKCCgLWeyAHWVKp5FZrU28OmOGiKUGj4oaDkZBfzhlIFMAgPioHzl25mc/F4lib4w1xiN3zRz6
	d0QTBbL2aGNcw0GHIdNgF33gQEkZTZZeRR42gn3vFDTmZc+yjVwOkvRrrVnZna5W4uWXegvto+Q
	HY3bQtnsxRQyrRSjXp9KLkKU9KZlPK8X3mHBGCuaPcQ6/xy/ABv2NLJJidkutgN
X-Received: by 2002:ad4:5cc9:0:b0:90e:8424:4068 with SMTP id 6a1803df08f44-90eca39df2amr67773026d6.24.1788357812978;
        Wed, 02 Sep 2026 07:03:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 5/9] libsemanage: create the writable store skeleton on first transaction
Date: Wed,  2 Sep 2026 10:02:07 -0400
Message-ID: <20260902140211.53084-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule calls semanage_set_create_store(1) so the writable store is
populated at connect time, but semanage does not, so a fresh system
with only a ro-store-root the first 'semanage <object> -a' fails at
the transaction-lock or the sandbox copy.

Any transaction needs the writable skeleton so create it at the top of
semanage_direct_begintrans() rather than depending on the caller.
semanage_create_store() is idempotent so semodule is unaffected.

After this the sandbox copies an empty active/ (just modules/) the
missing computed-file check in semanage_direct_commit() forces a full
rebuild, list_all()/get_cil_paths() draw the module set from the
read-only roots, and commit_sandbox() renames the freshly-created
active/ to previous/ before installing the new one.

Read-only callers that never begin a transaction still need the
read lock; that is handled separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a930dac1..547c2975 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -405,6 +405,19 @@ static int semanage_direct_disconnect(semanage_handle_t *sh)
 
 static int semanage_direct_begintrans(semanage_handle_t *sh)
 {
+	/*
+	 * A caller that never calls semanage_set_create_store()
+	 * may be running against a fresh writable store that has
+	 * no active/ tree yet. Any transaction needs a writable
+	 * skeleton - <root>/type>/, active/, active/modules/ and
+	 * the read lock- so create it here rather than failing at
+	 * the trans-lock open or the sandbox copy.
+	 * semanage_create_store() is idempotent.
+	 */
+	if (semanage_create_store(sh, 1) < 0) {
+		return -1;
+	}
+
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
-- 
2.55.0

