Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CE1F76C0
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240999; cv=none; b=U+3CAlngju66ypaucgyVUJohMqJhxZP0KLebGGkJTo+5AqpZHu/92uktjXNgTECOso/8qg6knYW8IICmy+wtYY3ZQlCsO/HioMCdGqHd9fbyUPogrG3dmVdM2bFECQ4kc8em7d4kJ5E92jdfelaKGHoeWi8+51efF7zUBaktJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240999; c=relaxed/simple;
	bh=CcJ6nmx7SJu5VKAjzPQ62qu5/41swdfpMtVKXg+fP9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hwGpzaWWlIgaLYltjSSJn9kV49fsYov6+c0ff6gLnJ/l7cAoBTduOGYDvrNX5Jk97CDXWMOeRP7oe9hyfiIinlF3FEg6IsBfDleyvE2diustLxIqg9LXuQF5OlnKZiWjkKG7HXSk/xl1msZhoir2Up+WrnpcuQiIaddIbZFUY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qkr9APqe; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qkr9APqe"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733240987;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X2rkTz6gx9fBIs6saI4gNW5hRi1B2H4db8/unC72DHw=;
	b=qkr9APqefhojU8MH1vaOtUoGOGpyPLt8vHH3573qGQ0booIUouoUYuhTmYWuvq+J/IweRe
	s+dNXakpVRpSZBIPEwUmm2EBWYIv7IUCtV6TPsjjjSoADCw9lcNDw7GZE869WC4BPChI32
	IRjqef6YFO6i8bc8IrWQQT1Bx/rg7S8fFGqyGL0vXml2D1z83/DlUzc8Vc5o0wQhZv5pNP
	TyH/GgJU9vgWvEEbsdosFQ+6/o/zTWzERP4kUhObTt6NQy8bU6Hkle27xnJR6mdkNLt9Jg
	3GtIWPk62VP3O64Tttx7ERgM+FNsfUYCk+CABba2g0Qnom6+i9k8UUZlUjjeLA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] libselinux/utils: drop reachable assert in sefcontext_compile
Date: Tue,  3 Dec 2024 16:49:42 +0100
Message-ID: <20241203154942.45669-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The two asserts following qsort(3) where useful during development to
ensure the comparison function and the corresponding pointer handling
were correct.  They however do not take into account an empty file
context definition file containing no definitions and thus `stab->nel`
being NULL.  Drop the two asserts.

Also return early to not depend on whether calloc(3) called with a size
of zero returns NULL or a special value.

Reported-by: Petr Lautrbach <lautrbach@redhat.com>
Closes: https://lore.kernel.org/selinux/87jzchqck5.fsf@redhat.com/
Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/sefcontext_compile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 23d31274..b3793e8e 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -188,6 +188,9 @@ static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
 	if (len != 1)
 		return -1;
 
+	if (stab->nel)
+		return 0;
+
 	/* sort entries by id */
 	sids = calloc(stab->nel, sizeof(*sids));
 	if (!sids)
@@ -203,8 +206,6 @@ static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
 	}
 	assert(index == stab->nel);
 	qsort(sids, stab->nel, sizeof(struct security_id), security_id_compare);
-	assert(sids[0].id == 1);
-	assert(sids[stab->nel - 1].id == stab->nel);
 
 	/* write raw contexts sorted by id */
 	for (uint32_t i = 0; i < stab->nel; i++) {
-- 
2.45.2

