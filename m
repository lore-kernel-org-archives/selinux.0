Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA261AB6C9
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241297; cv=none; b=HAK1gamwqmdZ0Emrf6fZ4QOGNSqW+hzgP/eSp+0rWgC8O1wIZa7ENnZMx9rwQ91FuaOM0O027EV7laN/O/nHBDpc7dtgzmDXLcpiWMLzZuDgeSrIpB1+0axYeqsLd0U4C9GuUj43WiC7CZoS3FJNenKpHdnjdgCJmZHzVM4KbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241297; c=relaxed/simple;
	bh=RaZ6VUbwNbq0ophyxKoH/5HQVvd7asbZwinvAZxoccc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mwFz1UH9Qu5rIG7i/CL1r/yUlYDjDU6I/BPBitB5gPn+QP4kRjpd/Jonv2knu3cOJ9sMqCZWX0dIrHVFzL+Iflry2nv1u64JvDuKBfXuOUw0xcPlWTNIDsVUJJhv6oeZTupUrASC51YYek1IeRp2lRol3GxtOOP4p5yT8p1aU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EagTjRx1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EagTjRx1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733241291;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Lp2UAomghlvdT8D6tawx3ymNqj4lJ3Mh+MFloBbA3Mg=;
	b=EagTjRx150zbzXjWZMJb96doDV1cshKFDqsX9ORp5UBxPdS15x1cK2p/+0Gb1JqBQVViJx
	HG1OXO7B/LquPPgrqrqQqpopeUmk0hnkYDgZRNO4vZZUphb80xdbSayWpwRJFkrjuzJiuc
	+dC5Tg4ocKXtxZHEo8AoDBDVXkWa7RRxqwlBd6nXK2ehk3uu80BeRaQYEuKHTdb4Q/EQ65
	fUK5mnBA66IFt834AJFlwr5Iy+W3d61/49+9WEwceuyr5XSmC75tvDLJ8aJtnj47UYnSIU
	UaRa4gtImovbDY1ATp9k0UuohdpRHgEIOH0soJ3hDM9NukY6hK0hvJhmDDcipg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] libselinux/utils: drop reachable assert in sefcontext_compile
Date: Tue,  3 Dec 2024 16:54:48 +0100
Message-ID: <20241203155448.48237-1-cgoettsche@seltendoof.de>
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
v2: fix condition from not zero to equal to zero
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/sefcontext_compile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 23d31274..e5da51ea 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -188,6 +188,9 @@ static int write_sidtab(FILE *bin_file, const struct sidtab *stab)
 	if (len != 1)
 		return -1;
 
+	if (stab->nel == 0)
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

