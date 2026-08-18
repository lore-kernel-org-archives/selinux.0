Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4D3164B4
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080938; cv=none; b=sA1faN7UgCvjanvJTF5tLkb9TwD32Lr9vW2HZ3Sf4yJyVsVnvo2wvIKjbuwg0QfraFuCBEEiDtySjrTwxcL6bGE67ckjYsu140Iaybarco5/qx6TKe4qzqxCnXfvXdbKeXsub1Lx2Qd1i2Cx+5u00OPVjoYbstjW/LRkuSr7ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080938; c=relaxed/simple;
	bh=eDCBFWarbXS8OlzoDMBxBV6OrzOYu/9OA9aYub/xWKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j++WwZLqTQZONBMB7jig53ci/se39/IZ0A0uQXLbOyJYLWJyucxaX36D+Q5lNDm/0Gk9wtUISBhNpwh+XdedrncC4e1/lzycSq1m5bV1aEGI4F51MoG/p2GljEtCkpnRISw/Jl++DwPEFX16h/hB3I/aXHGpp8uo2zaEaU5QSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHS3ZVoR; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHS3ZVoR"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90a80860d35so3324036d6.2
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080936; x=1787685736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=snycSIc4gih+GG7UcWARiHR7GPBPRmnJmxmMxrOAoq8=;
        b=FHS3ZVoRpo4pGCfaPLAlNmJ1+HxqY4rr2ftCkyIWBHjGhFGnqR18ssF+CmVHHEI07+
         F/VmMiue3RQ/+FCsl4PiSCk+rJHtkKpTJgWrk9SWayNvmxaZici+jhisWWTdMCl82tVM
         ovXWHFhY3nNVY9x2zFpYBgyLYWRxvB2p65Vmpa1WgbJDZzsxwx1bM/wc12Yr4dSP0qSV
         3YnQBBlJCeLEZkRhr77Q84qXWZ1h2qDPjm3zKrGY6RPGIpl5A1CqU7o4gtB9HGoKhpDW
         M5waNRWLhZVhDW20s7PLSXy4ETpj7OvkCl7AzJX2t1gncoaOJhWQ+GTu9+kTWnftJdMH
         lykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080936; x=1787685736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snycSIc4gih+GG7UcWARiHR7GPBPRmnJmxmMxrOAoq8=;
        b=IkQFj2XoB8tcDd7bSEB5ccG8BDAKHR6JDqylNQDP1HbEVg0U1ugfRiUERfK8xh7Xib
         Nt6sKdYUhxufTrWdRUTjDOehmoJvRkBtAAGBk8bWL0dWJ1GDq53qSrTRgkwJhhWeEdpx
         6+Yc40HlnIcnhpL5zoqrRdYhTGW0Si0tOT2kp86bOtZRkmVCHgI6yG1K5lHpNWLFA/a4
         RYll83ctuLRs+hUdOeVvsTBWW2KoF0J8FMSjeL6S3rh0yBWQDD9G2/q0x5kw1K4yo+4N
         NGE2zzbhl1xCYlbKGAOGgGFNNoy4OjwtcZpUYJwqw1oBsMIdr1hn+A7jTUHCa4BdtHcf
         ZPzQ==
X-Gm-Message-State: AOJu0Yxi3EIx2RwmprwTUqlw86OxvoLpvVsuQwtA6rCfySt3+xzqK9TI
	KUuK+CzjdvJI/QQsgzdFn3lycGDhnAfjBTkLkOroMWpS+n2Q2g9dfvjPOGDDXQ==
X-Gm-Gg: AR+sD118UKo7kk/U+GtKI4+56u6in2dgJ9R4c8oo6jT6M6zuqm2N3eALyjqJFwYF4nY
	XrijXwBGrcNU0imdrA9YvyNc6Kr4jTwho7r7N52Z0RxdfZZLg68pWVobWayLSOPUOWJqdseb//L
	S94MsQdo+r2lPHuJmHwb2+vogjNiVqO41ctDSXoDABVLun7+bb94M1YHSMsHYdhcDRVt49HxW5c
	1gKN9U1LDG+enqqKb/LGCTxPaZ0zmPlKcf7s5lF09+bX4bDVkLjKhAS4eSCX3pKErpAl99lC7dI
	cyTIB0Zg7HQ2BGav7gnelfhIlOygQicsuSbTaOh30/f2eirLYvcIjrw1DfuY3dti9xOLP8XA9n+
	QOiFxcy2hvxVOgkvWQpL068ukT5UKoBoU61+E3lDtaw3SaGINC++cNSaUPLW5ZSpvYQnwBsH+p+
	QsTuQcKn7JVoxLFs8iexMGnlRgimRF+kQ7httgv3Vq0WynVyRly2y9dEt0yMLNJA9U9s9eFYRyS
	MU6/nQViQo=
X-Received: by 2002:a05:6214:498f:b0:900:6ec7:19d9 with SMTP id 6a1803df08f44-90c5bfb807emr12319036d6.3.1787080935879;
        Tue, 18 Aug 2026 12:22:15 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45934adbsm39124816d6.31.2026.08.18.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:22:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check all the permissions in sepol_check_access()
Date: Tue, 18 Aug 2026 15:22:03 -0400
Message-ID: <20260818192203.60432-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sepol_check_access() takes five arguments: a path to
a policy, a source context string, a target context string, a
security class string, and a comma-separated list of permissions.
It calls functions to turn all the strings into structs that can
be passed to sepol_compute_av_reason_buffer(). Unfortunately, as
each permission in the permission list is converted to an access
vector, the previous access vector value is overwritten, so only
the last permisison is used in the access check.

Use a temporary access vector when converting each permission
string to an access vector and "or" it to the final access
vector before processing the next permission string.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/utils/sepol_check_access.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_check_access.c
index fb3b7edd..e80d6464 100644
--- a/libsepol/utils/sepol_check_access.c
+++ b/libsepol/utils/sepol_check_access.c
@@ -12,7 +12,7 @@ int main(int argc, char *argv[])
 	sepol_security_id_t ssid, tsid;
 	sepol_security_class_t tclass;
 	const char *permlist;
-	sepol_access_vector_t av;
+	sepol_access_vector_t av = 0;
 	struct sepol_av_decision avd;
 	unsigned int reason;
 	char *reason_buf;
@@ -58,6 +58,7 @@ int main(int argc, char *argv[])
 		char *tmp = NULL;
 		const char *perm;
 		const char *delim = strchr(permlist, ',');
+		sepol_access_vector_t perm_av;
 
 		if (delim) {
 			tmp = strndup(permlist, delim - permlist);
@@ -71,7 +72,7 @@ int main(int argc, char *argv[])
 
 		perm = tmp ? tmp : permlist;
 
-		if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
+		if (sepol_string_to_av_perm(tclass, perm, &perm_av) < 0) {
 			fprintf(stderr,
 				"Invalid permission %s for security class %s:  %s\n",
 				perm, argv[4], strerror(errno));
@@ -79,6 +80,8 @@ int main(int argc, char *argv[])
 			return 1;
 		}
 
+		av |= perm_av;
+
 		free(tmp);
 
 		permlist = strchr(permlist, ',');
-- 
2.55.0

