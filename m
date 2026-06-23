Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB82609EE
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229791; cv=none; b=kKZhNziO0qiauLZO54iz4dKe+TRJ+798EQTJ8WdQoaCotF5goQaC5tY8O+RkWNL2/wZSMSh/IlorC6X+a4Rv4ue9u7YaqeEJzlJpDmmewuhslIXDXe1qnslibwqMX+8whlhRhw3XxGedu7y4BRB42mkMYZjZRoRVWhDAtJXRX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229791; c=relaxed/simple;
	bh=aQC4xow5uYg3GgEZI7ZIEdf8kncolm3zhq1ooTqXH4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW3uq1O94zeYrgDjlGARSiaHj7zWyA0nxvEr1eqKfQDMCBbiQFmVKQJXWZ8Xj3leowngtP67qIPrKIiEryBT/Zdz085APmzifwaxV3T3k6e3QdJIEDCNjKy9gpBKXlaFG7qdSUQkNcIgRGsKXL+iIEkvwQitK6fCOxlsNEpK4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBuexIk5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBuexIk5"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fdb04d774aso970167b3.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229789; x=1782834589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R24AFOmG9chiEn6YssJYWxMogIEGjAHn8ySaTo0zOk=;
        b=hBuexIk5FlrxOsQHDI3NxqzxRaLWmNuQjCK0tyx8x6w2ztaMHi3ML8GfTMM5URGnPP
         j0iYgktCY7fXhWRWcbaFdxkYFxjWGJEgISocnlmDKWyPrEHMAr6p0/Ja60q1FW3/DJaC
         1LeSVaFmLwuYA2RtJ48ChmmbRF5QMRaiYnAB+4pBXg7Da5ejWC8hRc12Obbya22Ku9KM
         XJgYr8LS8x+xiPfcu2l0hBy+eZzhL5NZ/pK+D8Rh6A1n4Cg7TktgwwhDmS56dvFVsjwV
         HzvtQlZhk4fneBhVovA7dnYXCkf6HGd7E2+JB2DECljaqgdGZC0n0SqOE1Wewfr0IBY8
         I8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229789; x=1782834589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6R24AFOmG9chiEn6YssJYWxMogIEGjAHn8ySaTo0zOk=;
        b=EtMbNivhV4QsvtHM5anWWxcUDkUSSnSfuqwD1ACbQOTi51hhX5wUEXgkzQl51Vn0Kr
         ybfEt6TE8zyGWkNNFscEvwGJzeUP0EDnv++OFz3KfnY+GwtA4bc3IfHJTbMnLj8rB0l7
         BYtDsB9QCqr+qBgLiGciZfAIMC0nmB2sQc1NC9eglL5Nk4OjyObzNvJ0JLTCq+hKKqMB
         /qewn1s0up9fGQpXKI4+GSW1y2vj8E3vI/IgI352zVWPD41U0m8/T5uDR6vb8jMiU9yw
         4G3qyqdRP6/UwEa6fx+piFpahgt71ZiPi76KO/w6TRbpFYl/GnVlMN9A+ZBuqXmVPyEY
         UzVg==
X-Gm-Message-State: AOJu0YyIpqBUtt4ZEIq6rtFc+kIc0bnUgSBMLdMLNPwh+HXkCwaCFnM6
	z/LBFr7+jHjhKQzIpyfnqY/nMMwAFnyv2+YJFeWtegvthY5+Ds4WKanHaZ24MQ==
X-Gm-Gg: AfdE7ckRAZm5bdypXR6IcWbXmuYF4LFX7tvs3ln+ogGHuRTNm04fXmsQB8TQXk35521
	QTJekq6teUOAgTkaZuejH/W1pozvAImOEfcCftKOA1wB4FRChqLcECUbkMGeJLs/hMnMwZFooB0
	ex6hc2Qli0m7e3PHChhzpMa1w3bQh6u5NG/dXaP54zFBPw6eqRJnV5OywsUt+H+bwb0q62AmaDP
	4+8M5jQK0xkGvaYFDll/pkfA2UmG3ZvDwZFwLZiCSRXbJT/tqlMzh91kUfpVDpnTOnYr2YkwN3U
	C1qM3UD6hJ/0GM+N3gBzFogjZN3hMGyme+1iNdzMLb7qw4gEFYpJd5vXye6bX3l/QJuTWGbGwgR
	vUAIti9Kqxa8uHQgeCM9rCgzfLgQJXQ6lstTMRjt1rAiTWzdtTkgmh8WI2v6srmXmXdqFNOKZha
	sYfboUdAEtdjvP+eH+bXzks4DyRgI6yDnJkpc=
X-Received: by 2002:a05:690c:e36a:b0:7ff:1000:9c1a with SMTP id 00721157ae682-80266163257mr185054977b3.26.1782229789187;
        Tue, 23 Jun 2026 08:49:49 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:48 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6 v4] libsemanage: Add overflow checks
Date: Tue, 23 Jun 2026 11:49:33 -0400
Message-ID: <20260623154937.16913-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623154937.16913-1-jwcart2@gmail.com>
References: <20260623154937.16913-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow a buffer, but it is
possible for this multiplication to overflow.

Use the __builtin_mul_overflow() family of functions that will
do the multiplication while checking for overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: No changes

 libsemanage/src/direct_api.c    |  7 +++++--
 libsemanage/src/genhomedircon.c | 11 +++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9572dbf0..b87b87e7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -588,8 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
 			char *tmp;
-
-			max_len *= 2;
+			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
+				ERR(sh, "Overflow");
+				free(data_read);
+				return -1;
+			}
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
 				ERR(sh, "Failed to realloc, out of memory.");
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ce7ea167..f04fc127 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1090,9 +1090,9 @@ retry:
 		goto cleanup;
 
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+	if (retval == ERANGE &&
+	    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 		free(rbuf);
-		rbuflen *= 2;
 		goto retry;
 	}
 	if (retval != 0 || pwent == NULL) {
@@ -1171,11 +1171,10 @@ static int get_group_users(genhomedircon_settings_t *s,
 				    &group)) != 0 &&
 	       errno == ERANGE) {
 		char *new_grbuf;
-		grbuflen *= 2;
-		if (grbuflen < 0)
-			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
-			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+		if (__builtin_smull_overflow(grbuflen, 2, &grbuflen)) {
+			ERR(s->h_semanage, "Overflow");
 			goto cleanup;
+		}
 		new_grbuf = realloc(grbuf, grbuflen);
 		if (new_grbuf == NULL)
 			goto cleanup;
-- 
2.54.0

