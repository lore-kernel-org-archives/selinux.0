Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15401C84BB
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149760; cv=none; b=IhA3Pj54ejOHoLk7pnvKf8XlZ4dLSV9DKFDdHrCdcPfE5aRd7eg+T/8JNpy7JRYa+0lTTQMmLiVhYAfDnSE50/L7pHAiNgLCeRZMfra769zUS2rNprcW2kk0tjpM0ahn27rigkXF7f7Xbe9Nz9+CixjOE58+zkRqGpcGbqIKUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149760; c=relaxed/simple;
	bh=zg0AT5XcbukE4edU3+lLvDbfLHHFjpVsCp/fCm31Md8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8NQsBcPMA2dSiXGVjr2BSBasnjL5UwKz7djPqom7pB+zFd/e+iN87nxKegiZbqAuE1gySyCBt+6qq5PKeMM2k59sYrjh455Zo9tpaJbpB8kr1W7JaR03VBhCljrazVvcxpXbu+K/53Tqvfc5cwrBP2hri0Ec8HhzjLuLvTOJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbI2XW6T; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbI2XW6T"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91587626ae1so551046285a.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149758; x=1782754558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwNlP1HYRl1fb06BTjjhlzLXXeG3THy0XLGThlekJ5Q=;
        b=BbI2XW6T9JhAgclbGF4929Z2i9VNqTDl1PqvYr0a9l0W/pRyJT/WobPDJdHD0k8jB3
         twof/5u8sprQOEHBfsJ23taGATkBG7LMjjb8yOGCJut8iBZ83dIBj7cvRm5r1wGQXkaV
         XdxwscnpxB7IVz9L/vObppbxhyiLsPOeeatFhtFDc6SA7cZEJVaewhUeZFwDRdpUG9en
         8Gt+NnGp8EYIxEl/MAZIGRqkpc4Z+4EnkD9kcV7Cwqb8Jch76oBS0rGf5VbQPxELTnSL
         a1vqmTpdJz7aF8GkmISNTbOgKzy3xnxK7r2T/wmEz6TgWq547FWDFpafXFNpcoT9V+eo
         p1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149758; x=1782754558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwNlP1HYRl1fb06BTjjhlzLXXeG3THy0XLGThlekJ5Q=;
        b=hMr0ibiAk6PZFY75ZRwE391YGcVDHUBWepvHWqW31cONA+nDB8qiGqW4Gf6OO/epzS
         ueTUWSDQSjRgLooYy/J4ZepSCA96dPsvy0SUWyUH5orLu88wXYJzLo4/QGMvndSKC+CQ
         GR1SSkHcbK+C7SPS8x/reXBsfixkbiwBRggesCxPbZcOr2MJMI5Nrv+8LufgKVeqoUD4
         y5R+4w3eKdXzJ4co5U8uuEnRvDrsce4cCxsog+2NFjDEN/XF3ukapX/YAIkDTbkYFafb
         MjJc9e42sY0hrLcHptRSbwaowgOZz8c99aB36oxH1vOxAlaRKtEZ00CRFKLtuIqEAkyH
         pw+w==
X-Gm-Message-State: AOJu0YwA+40QRXjL9wpM5F8h2kSVzV0ENZQinX4H2YC6MNjVVpRpEir1
	HQbUkCM+0ZWlmuE9ozhXJRi4qCERfZmpmRr91Dhvnd3ydxZrfhXkt90W4774WQ==
X-Gm-Gg: AfdE7cnJ0ElHG2PxPAhaK2eP6RUsJBj9g24UciRMok3poifqQgfOZrcp1FsWRG6jQTQ
	XFQdTh/oBZpVyIY6756cIeDBIJS+gb6JYXN+SmkqiN1PVnmZz26SyXDIMY3SXio7LTHxrGfpOJ6
	NbrcfC+Le0tQOvt85HEhFIqM5Ek86Rver+LrcY6XeNrzG206gGxUDuaqzsqj/27520zZHi2He3I
	QX63eC+zADmju6gxRMKrrFjmHQ31iz6JqJadqDGvbvvBIuxUK6xXbjbDMspvXdQOzw0sogJ90ye
	4/+CDQBozp1Ee5E0mQZakTKLSX6IcPLyl+/nz62Ww7pTmaaDzwbXDOqyyZIlVH4seuFk9Pb8rwX
	hJJkDMMNWW1DfETBtCUgvacPndnfjzfQurZ0AB3rOKXajZ8mOGl9JEVMB3RzhgoujxNENafPLSy
	IkFBQV78uG0vnLPbMVVaVFzESkjW2ofdFyyS2QytzqgOosjA==
X-Received: by 2002:a05:620a:2703:b0:915:b852:4363 with SMTP id af79cd13be357-9208f15ddcfmr2335881985a.3.1782149757546;
        Mon, 22 Jun 2026 10:35:57 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:35:56 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6 v3] libselinux: Add overflow checks
Date: Mon, 22 Jun 2026 13:35:36 -0400
Message-ID: <20260622173541.174998-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow an array or buffer, but it
is possible for this multiplication to overflow.

Use the __builtin_smul_overflow() function that will do the
multiplication while checking for overflow.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Use __built_smul_overflow()

 libselinux/src/matchpathcon.c | 6 +++++-
 libselinux/src/seusers.c      | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..80de61a0 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -117,7 +117,11 @@ static int add_array_elt(char *con)
 	char **tmp;
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
-			con_array_size *= 2;
+			if (__builtin_smul_overflow(con_array_size, 2,
+						    &con_array_size)) {
+				free_array_elts();
+				return -1;
+			}
 			tmp = (char **)reallocarray(con_array, con_array_size,
 						    sizeof(char *));
 			if (!tmp) {
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e4a844df..310b1e7c 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -114,9 +114,9 @@ static gid_t get_default_gid(const char *name)
 			break;
 
 		rc = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-		if (rc == ERANGE && rbuflen < LONG_MAX / 2) {
+		if (rc == ERANGE &&
+		    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 			free(rbuf);
-			rbuflen *= 2;
 			continue;
 		}
 		if (rc == 0 && pwent)
-- 
2.54.0

