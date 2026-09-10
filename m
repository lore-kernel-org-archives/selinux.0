Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78048EC7A
	for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046679; cv=none; b=W3jmc09eqevUVsVpko7bQUlsqfihXePSVzLJ1B9GKB5MfdHjMqyTszd52ItdelEeGOR0o18R6De3nPkDxJAxk4SmIwtz/+pNzMTh3Fi9B2BhnITmv8ifKpEueVOKOGMKoovZWZLjMaGV+U7M60J91KGOPN6aTt4tUxUEXZhz6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046679; c=relaxed/simple;
	bh=UJVCFuI0uQhpHuGDLhwxzuISjR32HwM1m1xA3ZrqB5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Itcz4ZMeQve20yWF/yNCg1WTtfTMSKoEtng2qtOHgI3ETtP9X2lB+SlKyBsSNHiVIQv0s2sSyDn3tPsYNYMVxhZESZc/IwRBVJAQp91PUihLzTyxcuW1UWJjfqXp9GuXDlJgNOTh6FSNOZ4rUfura/vD1Q1fpf8K1NvlYzm472I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntM4nhsc; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntM4nhsc"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb0so216165885a.3
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789046676; x=1789651476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2gMm2ZlTNVwawkoq49lgazQacgv9uXiR3dxqrmdLxpU=;
        b=ntM4nhsc2BFwJbgF19NejGzti6ks1heCgBEznvlBWMOrDByyeeQWpkCd5yvQFFQLEI
         u1xLr9szK14q67z5cHqLRh4a0NUB+BplmZlBNjTzgFF4MAAkRPjrtkGEcxpfh/a842IC
         pdyi8Uhp2HnLRCxJjLHa3iMGP9hNQDJ+4IKYcrCFfwKuHdwdrxX3VU0pvaXG5qBpUf4z
         HkJP3/Ws4H0hqZIN8E2o8IDZH4vPjFBxkqGv5sSou9FbjkMQ3tOjdDFfJftQZGosBmL0
         9dYvoT9vx9qaDcfhoVmqMm3zudjKwI6vMmHs+di8Hib5xIDPNAdW4hBGegxqkqOO1B0v
         GQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789046676; x=1789651476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gMm2ZlTNVwawkoq49lgazQacgv9uXiR3dxqrmdLxpU=;
        b=SV7AgvMCjt7QF5tGpUsZCqq+V3Yv3D+PlG9r5Q/INaW4N6jYgIdMK6AnPNXTG9iK18
         DbrPCiM/tSnra85Gc2xGybRpkTEdf+AZSdn1k9gsi03VypfDTRaunV0gXDX7dXBWczQB
         EYwmuVzT+ID9o+4wLacbuxgtfWWC9LcYRf4Y7j/E/xjGyZ5O1WcFUfSj8P4sJQvaWc4Q
         TXp8kP5brhatazHYz/WQ/TIHkoGwrjJEkUvUoktWrWIrjvOgOn30/z0TKzcsPEfrxC5V
         Ea9DYReAwG60OxRH5NQGEnlL9MTAaQUmeSqLGzw/yqbxrqkj1LdA05/vNsUhvqCtajLj
         ATNg==
X-Gm-Message-State: AFuF++nmXrxi2iqO3yyro3G4qEvYdnWsfaw+kQB4Vn4WCnS5OTyxlenu
	6/2n6IYlJzzWxS7u8gh/CXczIRtZyuo23FYfKz2XNgUrRATMojqEQLSN5eRRdA==
X-Gm-Gg: AYBFou3KBM27gs4d4F2HHiH5q/MP946VzxwKjF8B9qgnLwv5czDMHjr66RNW5uHDLCK
	7I2rQlGduTpny/MZlScb6fS0LIvGpO1/eBKIf6TaQzmehMQhlWexV0E5DWPKRvgzDE4DCODTFza
	ocr57Y3uyXBa/l86FmSWHXtlEqbh7SYw0apqGIgqCwAMTVbr+5fOkHx2cDBWzqXhcKRoOD3HkQa
	9nuHnpH09ljCGajGdg3QgapB4SD+NajKWMmQM/6r4x30WH199btvR2gvZYeBV3vrHP1iZWaPBUV
	zkmUS3QYZglRt3Q2RoCX/XuQdtMFVp06wgnXc3iSuYlN7omlgYYFJpm69WWL9xj1DnIB1N26f79
	spS4rjsmLWVIdjwL8lcvT098ANADOpwdPfPb1+fuHFjaxlrYLKAB4UGzx7SR6q+SndRr/KbnKC9
	G7k3boknDtsE5G5gaewDUCLWrrNgAUtQvvDDZVoef2wKIsWVC6VilX2NFItn0OOMq8wSMy6qO0k
	BcN9FxZMQAxIXvY77O2v6opBH1eMTTSOnMD7XVZZL+c0bBS9pJi3WUS19oujOIOzYPvENA3PhsE
	2RK98d8q/6Y=
X-Received: by 2002:a05:620a:179f:b0:939:6df7:5e0f with SMTP id af79cd13be357-939c9535414mr1688792685a.51.1789046676091;
        Thu, 10 Sep 2026 06:24:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939cb4317bbsm477107785a.14.2026.09.10.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:24:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: restore basic validation for path/component names
Date: Thu, 10 Sep 2026 09:24:21 -0400
Message-ID: <20260910132421.40144-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2360a8a12b99 ("libsepol: do not reject control characters in
pathnames") dropped the validate_string_field() calls for
path/component names because validate_string_field() prohibits control
characters which are legal in pathnames. Commit 069ccd7a497b
("libsepol: validate genfs_seclabel_wildcard paths") restored basic
validation for genfscon paths by checking that they are not NULL or
the empty string as well as further validating that they end in a
wildcard ("*") if the genfs_seclabel_wildcard policy capability is
enabled. Restore basic validation for the other two path/component
names to ensure that they also are not NULL or the empty string.
Further path and component name validation is of course possible but
if we added it, we would want to make it consistently enforced by the
compiler frontends as well.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 8fe168f6..5b14b244 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1521,6 +1521,8 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d,
 		goto bad;
 	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
 		goto bad;
+	if (!ftk->name || !ftk->name[0])
+		goto bad;
 	if (!ftd)
 		goto bad;
 	for (; ftd; ftd = ftd->next) {
@@ -1880,6 +1882,8 @@ validate_filename_trans_rules(sepol_handle_t *handle,
 			goto bad;
 		if (validate_simpletype(filename_trans->otype, p, flavors))
 			goto bad;
+		if (!filename_trans->name || !filename_trans->name[0])
+			goto bad;
 
 		/* currently only the RULE_SELF flag can be set */
 		switch (filename_trans->flags) {
-- 
2.55.0

