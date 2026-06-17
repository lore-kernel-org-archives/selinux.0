Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35C3AF674
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726226; cv=none; b=alxiEkSAhByo0gd1j69QznyoDxbRDzxFiRgBNtRr3BHL+79Bzgy/DRaG14ZAErqwS1Fvla5uiQSpqkpE/76XLpyBvuEvU2K0IH4kLoa96YrRY6rZTil0tNgsNAEyQLSMSoDT89L4qalPU5l78KkUsghQ9/uCLE45Ha7yHKQFplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726226; c=relaxed/simple;
	bh=hRmys7ozAJbaG4oW8TVISyCgG4/xFtMmBPlRZ7lAiag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFOpWTuRx7KR/82CFb9nQmhZxBN7xLw4gzmvl3yEVpXEXaG/rnIhVfQw1VSqxc6lQwvWAk0JWZ1AifOTm9RHg04qz4/Ubbo6h3827hNmnEoJgSwn/eqawPooXVekvsgOniPF96EtnquRiXz2DK5g4LHF99lfSZUIaoHoeC2LCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCq/dKOb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCq/dKOb"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176d4c14f5so1205391cf.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726219; x=1782331019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t7ZPIcU2SW1cZH2FAuprkZ3ceokr9aGETj9nPBqu5k=;
        b=QCq/dKObUfhwS53k96t/uRR7DnfM1es61rp/liorT35hHBArvGHP4fuDxqOWUwkqRM
         UPcPI44nWBVXfirouqWaPxgZR+zbRSKFpI2OBTSmJevMPlue3mWveYH7Gw6V2E/46goq
         X6pVfK1EEGbwhSnoZgL0qpu9pewnT83rRjLzGCL6DSe76ZHbuKqmKfjPQzpl+ybmfhl7
         3zsfgAgVQ4ce1n1rYDaSEv6xLeABBSJTcU84y6hvQEsb+b/+XWSFgIlHlGIGaIQQgiJe
         u37TY0deMNwXD9Z9GHGmpfCw+zCkSC2KjgxqJm95NvR+DMiRq1SmPyAO9gpQFeD4yzlQ
         nDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726219; x=1782331019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3t7ZPIcU2SW1cZH2FAuprkZ3ceokr9aGETj9nPBqu5k=;
        b=Q4mpazIb9/hKJfRwsgoAvFKn5WOILT294ykB1jSwEVqiXHykVvF8s9RLhBVy5v1e7o
         Ta9f2GYAXj1pY5yvMembH4/V9M8oxBerMhNTN/v3Jkku9/6rM8j+FcSzguMkHWe8GL27
         r7eUOytuVYAbQ4N2vh+YjTbzTMtk5lcqImSKf7s7QHn3td2hwIIyaoJ82xWn/rXFi53p
         WElTyb+8hRIJLpprEejuEKM1xFzy1K8Se8yoPVUkwKRcBzM6E6CZDJ4Nh7Ys7QRbzGZ0
         8Vlww5GPrG7aY++80og7tpSq+1g3/yhmgMktWjmLdme7D0+iJOnprGbgxAG5QfSJjXmt
         Zu1A==
X-Gm-Message-State: AOJu0YxLdopPSl4Fb+6R3Mm/+gyzFl+eh6+4QCfZLSBAm+d+KXQC2xO/
	whCpjv1V455KlfgW8E5rELhoG7AaIs1yLIAD/l7FpNOdnaeCSjs7OO/pbSCTUg==
X-Gm-Gg: Acq92OEyI2g9tN0NZ5NRBmXHYmaE+harYCte2uBY2+0ZkJQb4pkLXGB+JJOaRD6vHmO
	BRdg8RoUg788jupQFUN2sXRFjq/RGb1H4QKVpoYyv8mEf2nB2uova8t2a7a3dGW5yTC6dvDt3MM
	CL8xFAT9g1g+Z6NE8qmz93l8rVt7GNvXfDkdJq5YMeUes+RqH0pMjW7sVTul4AXSGyDG/K9ZHmv
	78UZUe/1vRlawRbgkC4ubZ7CmvSOgUetlwmGFjfLTjFVFjqx9FEcYz8hI6znmBarzcbMn/Y+Hp0
	BiksDssMulDrO1eSPtNREXDSEYFYBk9fpvg+A4ggOg0DkM6EdQho/x8Y8cyEcxpUZF0oirhBljt
	oUFVgDOzf5CBw3pYMqfbfnuyQf8ty3zERC71WOTeorDWhxwt69UfB3C85oPjpyBIenvgTLR7OqP
	87k0PbIviQutkkjWG3iYCGkwKFHdWvk9DasO8=
X-Received: by 2002:ac8:7c51:0:b0:517:895f:1935 with SMTP id d75a77b69052e-519a8ca2701mr78791641cf.13.1781726219614;
        Wed, 17 Jun 2026 12:56:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79c5absm171767341cf.18.2026.06.17.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:56:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4 v2] libsemanage: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 15:56:43 -0400
Message-ID: <20260617195645.96604-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617195645.96604-1-jwcart2@gmail.com>
References: <20260617195645.96604-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common idiom to grow a list or buffer is to use "len *= 2", but
it is possible for the multiplication to wrap on overflow. This
would result in the new len being smaller than the old len and
could lead to problems.

Add checks to prevent doing the multiplication if it would wrap.
The multiplication can always be done if len <= MAX / 2 and
should not be done if len > MAX / 2.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/src/direct_api.c    |  6 +++++-
 libsemanage/src/genhomedircon.c | 10 +++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9572dbf0..54803515 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -588,7 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
 			char *tmp;
-
+			if (max_len > SIZE_MAX / 2) {
+				ERR(sh, "Too much data");
+				free(data_read);
+				return -1;
+			}
 			max_len *= 2;
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ce7ea167..8dc2cb56 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1090,7 +1090,7 @@ retry:
 		goto cleanup;
 
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+	if (retval == ERANGE && rbuflen <= LONG_MAX / 2) {
 		free(rbuf);
 		rbuflen *= 2;
 		goto retry;
@@ -1171,11 +1171,11 @@ static int get_group_users(genhomedircon_settings_t *s,
 				    &group)) != 0 &&
 	       errno == ERANGE) {
 		char *new_grbuf;
-		grbuflen *= 2;
-		if (grbuflen < 0)
-			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
-			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+		if (grbuflen > LONG_MAX / 2) {
+			ERR(s->h_semanage, "Member list too long");
 			goto cleanup;
+		}
+		grbuflen *= 2;
 		new_grbuf = realloc(grbuf, grbuflen);
 		if (new_grbuf == NULL)
 			goto cleanup;
-- 
2.54.0

