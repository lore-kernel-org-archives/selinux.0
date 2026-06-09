Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0648B373
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027203; cv=none; b=KmnXeQOsSpv/11gByH/dqfqiT6FPCcCisKm0V950TZuA1gxCnJ02RX4o1FdnRyqshsw9uYZ57k3/4wG4pGdGcPpSM1t4A45lGc2oEmNtVOHvWS4T43gKc5i0Cw75KVNePlJHgzytDqG/fJ0i4gnaG9rthpr+O+8qty7MvlHnJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027203; c=relaxed/simple;
	bh=7W2BveE1y6dr8N36wXjlCfkEUzQiMmopPL10URnTZbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTdq+hPUn48iBczWmdU+1GjCrBH4Wfe4QqwXYXhjmgs+KPCv15uZEHp77yWCWgQ1pGB5oMimeGt/LSiiCH1Xu5On1Ir2OFqkXFBShJoRDynepQeqOTrMJOM40L9ry3qECgQSL44ggpqEx/fK+vwisAPH9pIyp2nwLCIT/Ngmhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cip2ESLl; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cip2ESLl"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91563382bcfso671107885a.0
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027201; x=1781632001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oD4Jn7x4beZo8q5qGSYzIwoq92AXi/l0aD3ejqYlZm4=;
        b=Cip2ESLl9ki0DJNSO5LVA5p+rQiiM5BPn6OWIibhh05OBOJTC3kobWGpAD2H7iFjs3
         KRPbM3BC4bbDP02+KAyMMJCponG1JeOUyNbXZHatcHEt7Ndg/CRADqRau8Q8fP104e1X
         G0Py7r/ucuyZMGPd3EXFbPGpjeMZq1qSP48rqtRdqT6NA7+SS0Mu0ZhkWRfheSMBRuUi
         pEWFaSccaDiLpJLUEYH6vEsu06PuqBS5/3nAuCNyLTJmWRkEsymXeoFXTFp6kirxIVjx
         WPA4GuXvzspZ7ALtDQhr0LZco4hEbxjZEiG2q61AHSPa/kmmNzF5O+bKWCQ1zh7sCPUT
         giBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027201; x=1781632001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4Jn7x4beZo8q5qGSYzIwoq92AXi/l0aD3ejqYlZm4=;
        b=XrCm9CdGzOmzi91Z7TmcgH0Ape/SNyrbxKyudur12jUssJeQimXOW1RRShg29PzhO2
         SWWcZ9MO07ftdO8DttPnzgO7Dge8gF/+EXNB121Mp1NUn+cL/iM+GKMseDoA62vfQtHk
         srscuYdnzYWElTuCFxbQMfPjUp5qziEnwgyI52sSuw7OfVottItoCLwmm43fHBZ/KwZk
         vlgoBTZTMMr1YXzu02HZIGlP+BWy14cSsQiktrsXH2rqiwjvnNQp5da/BoonD6EYBmSA
         iAgWabDBmZeMeNxY/D06fxNt0MTJRwx4t2YHz2n6th7fG8SVSqeYn34t5W36cFJMK+DP
         fu7g==
X-Gm-Message-State: AOJu0Yyane0Mc5qVswt4V5e8YZJv9NMNKsFk2agWxJ5O7RET7C+9OWVa
	q8JJoug8Plf9DyO4nDyHH0nmMJ/gSsoqvr8fjxMaq32I6WRlubyclzqYoAePyg==
X-Gm-Gg: Acq92OEt8fEFO/ajQhNta+irMIa7UPsHlNSBKo+m91VHFVHoQpIywLcMf7eCYjPakGg
	8GYstPam7pQwy8wVI6tKsN1DF5u+wDRLaCf7m64dKuWD6ImQQAxGAm9ndJKp0Y4A9MMXHDeVKQo
	GUQVTGCSXkhmXBydMNFjrF6o6hBISnvx4DQbu+CYRyUCxIY15ro/JfPpr0D9d6SoHlhj1nOaVs1
	YKfVR8JtRsXX+QM/3R6TdvEwNYmSYYROTOam54VVgqp3Ukj1A93gyL/7ggGF4MXst7gaBE2iuAZ
	9bKWV3Ap9hz8AOlH2iG7/dJzaqxDSwQ1BQlpQ2xvqptlbSTeSlOTjRJD+oIXpXtANi7e1q3csl3
	OkRGnnWT8Fhf600kJHWKcMgG14Avn/CwRqljDXlTea6okHnxuIcWORfAzvzm74L/Sn41Rjv/oCj
	QkJIVOY0IEquBoaXMHh2bOnn2ECTmFCqDjm0Oa1vH9Yz//rnLXqRQZ5OGerYpZ0xV5SnO63UCYL
	d50K+gL1+Jvcb8gVwz8lYwt1rXYIWfNaZVK2Q==
X-Received: by 2002:a05:620a:40cf:b0:915:79c8:ec92 with SMTP id af79cd13be357-915a9da95f9mr3417972585a.37.1781027200850;
        Tue, 09 Jun 2026 10:46:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381560sm2213981985a.28.2026.06.09.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:46:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	=?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <cristian@rodriguez.im>
Subject: [PATCH v2] libselinux: Do not clobber errno of the world
Date: Tue,  9 Jun 2026 13:44:55 -0400
Message-ID: <20260609174454.6637-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cristian Rodríguez <cristian@rodriguez.im>

libselinux clobbers errno of all consumers (systemd, sshd you name it)
because its constructors do not properly save and restore errno.
The following program demonstrates it.

int main(void)
{
        assert(errno == 0);
	/* Just a test, it doesn't matter already clobbered */
        if(is_selinux_enabled() < 0) {
                perror("not enabled");
                return 1;
        }
}

if any function sets errno, it is not switched back to the original
value and standards DO NOT require errno to the set to zero before
entering main

Signed-off-by: Cristian Rodríguez <cristian@rodriguez.im>
---
v2 drops the extraneous saved_errno < 0 guard and drops the
extraenous __selinux prefix of _saved_errno.

 libselinux/src/init.c             | 1 +
 libselinux/src/selinux_internal.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 499e4e44..abed3088 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
 static void init_lib(void) __attribute__((constructor));
 static void init_lib(void)
 {
+	SELINUX_PROTECT_ERRNO;
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
 #ifndef ANDROID
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 6089463d..39d57bd8 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -147,4 +147,12 @@ static inline void fclose_errno_safe(FILE *stream)
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
 
+static inline void selinux_reset_errno(int *saved_errno)
+{
+        errno = *saved_errno;
+}
+
+#define SELINUX_PROTECT_ERRNO __attribute__((__cleanup__(selinux_reset_errno))) \
+                         __attribute__((__unused__)) int _saved_errno = errno
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.54.0

