Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACB37B407
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722561; cv=none; b=m2nLj5DbCSK/aVL6X7dYbsfWb5t0tbwNkgJsgVemVMMnzgDekyxeNlikQgxhDq5tRNlSqnBFchm4TvxdLPDEj2yDf3a+mqu5EJtkcejuDqSCcIgyjZhrRaJsmLhJ6pPd7EUXdVUEGgZ0sWIeXPCcEwd8eFTu6Ezqrpf1bXJ69EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722561; c=relaxed/simple;
	bh=hRmys7ozAJbaG4oW8TVISyCgG4/xFtMmBPlRZ7lAiag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzNhP0H9cKCgrsEhA93oH7h0u2HmoSYber9F9bpD0FACPc2q1mKJfJr51yNrphsohoLCTyw8yExzsxq65okr/7Kl6tNpMVLpkaAJc0iTz/bA401sUPAbsaWyMaOzqPW0zKzscWu6/Gp2gcJL0AOVlRmMUq6Jp3rQOB1rpbY5/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuuDdAok; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuuDdAok"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177945a22eso685871cf.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781722559; x=1782327359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t7ZPIcU2SW1cZH2FAuprkZ3ceokr9aGETj9nPBqu5k=;
        b=SuuDdAok9j1y9AZSM8ErZTCLrPRfgPgz6YEnZTZU/EW8wtp19DWFOrKaOErszT16n8
         Pc62lASm5slKJ1MyuRXLeecViWCmpbCG70ZjFs3qfFWoE4bUun2yRQaU6GZdbX1YzuH/
         5lAQIdgBbRviyZ4D5TKymFXyz6GFnWTCAQ9EGwuU6FagiWYl09WFK2v4UC+cXjnsJcpP
         dT8yvNWBnCTElC7CRyAioxxa5O1khgLLsPZ1tHTt3GjdBAQHkjXRauNXRfCDlk3OatMI
         Q4wBbMAxFjFaLY+2Ye4tRIcBKLb75MpPR4OzDONM+t4m7xcBaoDE4yvLq2gnAwlGO06h
         5OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781722559; x=1782327359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3t7ZPIcU2SW1cZH2FAuprkZ3ceokr9aGETj9nPBqu5k=;
        b=a9d52TpJzH16m/z+jEP2Q23tyD7UhLV7gntFYJ8Fm9Dq86Q7hap39D802z3whYLisk
         X+xLBfJqZj8jqUX9paWRY7DNUZysWUoeCFpi3z4JWaemgfSWE8kox7BRsxf58hQfysDF
         K184iBCrJmGHGsC9e76dA47GY2Dl3sN/kK3w2sdbSyoqpTp3/iZpPicrqKt8Jg1u1RIP
         PWiUZCE3zvucI5AnoknexLLYPHyUTZBMvTS7hqk/eghwI7Y8ec/8Qd6abSY08gV//NvK
         zH0ZDcz4ZUZ5wnpbke1FQ+2JsKygy8brBEsLGC1lIpsWqw7cUE0ZmLuSY13BHGuyhXBg
         fkiQ==
X-Gm-Message-State: AOJu0YySFb6BXkF9Dj/EptUuk8B8H9XIddbGnxUlHDcL9N5i8NH5qp2A
	IO9XOmX+4xEGUj1qy1uDahlYzt87BDdZVwO1aSjjylsgl2MslPuNEBkaY7ZNQg==
X-Gm-Gg: Acq92OGb28gYkCD9YdjSGEuErFxYUyIEoqZ4tLIqNK+/llIJoSpts8Hv5lx6gPHAoq/
	sRUzsCIxhQ2BZnKvSiy117aK3dkgamYNX+78JgLsfQl51Sq2uTmgpQ7Iag3UqnsA6wNzsXn211w
	qU48aGyCzYaTEI3wl/hvfE++Y9bJFA6i2qSZnkRqPNCLEIkTBd1zITwH5Gx/EBcMZynMg+Pqy9t
	7pqkjNOK0ooFQM7e1U1CUR+bKK376HFwKXYH7Zh8VzoJFSK3c9bGmx6bIDkew3hsKgmTQZMICY1
	p3m/5E/uRzRpcJn45Rc7WERhW5o0+SNHcOt9j/gvLt0ELq+vELGskHeJKTQ2K+9iMRAqMDTdpeL
	z7Bd1NiOXjwy3b0mWbMqCRIIvuzFkFKiL0MfJzfxLXjFfQ6fcE7KY5NIxvJQXI57uLrywejcnPZ
	pOTSaPjC7QlX/o3F/smvygeT3h+RY33Uu/f+1sOdmRR7Qc0w==
X-Received: by 2002:ac8:588e:0:b0:519:89f6:ff7 with SMTP id d75a77b69052e-519a8e2e062mr78748611cf.23.1781722559519;
        Wed, 17 Jun 2026 11:55:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm182953451cf.20.2026.06.17.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:55:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4] libsemanage: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 14:55:41 -0400
Message-ID: <20260617185543.91749-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617185543.91749-1-jwcart2@gmail.com>
References: <20260617185543.91749-1-jwcart2@gmail.com>
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

