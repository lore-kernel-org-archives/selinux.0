Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343351B6D08
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685176; cv=none; b=fXjZKdW7slAibVm1p6ahc9z9z6bnLdzfo8LW2+2IrNouWQz5L70p4drmF0zojr/RQAzJTbb92o5j92Ucbs5mXg6eJ3ugO5pLaAu3aNcmykix0sV4uMk5a57mMXMtUnQCSZlsfu4lgL9bG1R5al12XtORJVuG7p2mD/mCi29KtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685176; c=relaxed/simple;
	bh=WomOiv3xHwndXlZuK6bg2Wqnew+H9Hq7LwVoS1s2A90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8MyRpkDbc+CFZTimDwsQMFrAjY231jv3r1/syFd4Ze5txiJX/gkN6ofJSCziLzqK3j/Uk8DS0PjBYeulyGRpHNutltp6sQxpfD/Jio/W6EnmvUi1nCaabvWkreQVO9+VC3SiQNaMp7X6gU/s9FldPb0eVeXDIS7AgdpsP4RWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXnEqfZN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXnEqfZN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5178a42caa3so20537251cf.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685174; x=1781289974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX/Zi39PFRTGJS+stHPz51nDsEU8iYBnKPTMBztRP4k=;
        b=NXnEqfZNahJ63xJVLRcwntMZ1kgNdUNgPk9t7pZkl2hUB0y3MVaBj1nTxmtBLdQESn
         5Z0Gxg6yxnNoZmNgOh9flLVTl7WCl/SxhDHmwVghEDV33AiynBHpBfwn50eQukcelqQx
         7UGDl7EeZ3P2tLkspyj1dnIL+6VBF2PB+LVk3a2lWNm7Hi/3S4gmtSrZQWAXyS+OKuHb
         MaYIw0lmfGlUdJQrefTeH00tTh1/ndJ7/YXplKmGu/9HW4mWCYR0KOaStzsmDBo1spGP
         i7UsE1fULCF/s/4+xiXcNgylpJKg/TTxAmlzmr+CrPtsTst4XOZufZzfqJ1iE25ggoPJ
         PdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685174; x=1781289974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX/Zi39PFRTGJS+stHPz51nDsEU8iYBnKPTMBztRP4k=;
        b=QBwEVraGJDO+17rEXcelYm0CD2/cp6A2Rxp63IiRB4ycu66POrwJGDYMxOXaQ1NzRD
         /VpAv6eL5S8RhACFCQtzSnT86ePUmvPOFVBmttl8ZMh8FUsL1YaLR7GDpf3fAN+IymX/
         EhAJO8/EH9HgrI0z64cIyMc6v1ZNxLTJ7utkyJPoe1lYZmOBTMzAVbiUIvMH97QLYQtG
         Vmtac4MxvbGIycCkoz4MRQkcN3B8AsCQ5YdpTDtART8CNw4wYmC6WUPhOurmZzoPX+WD
         MPPTsY8raQ5JS+fXXvNdNubJgr6pzrWfnkiSk4CjBHHS4gbnBNPYOeICIfNk6JFIHVbO
         dKhQ==
X-Gm-Message-State: AOJu0YzCQqgfMmn4JDwb7z69Z85xKlZ8RQq53m6v7ZzIono9nGTEj/xm
	d97LDxmWYHkXyKbRdnt2N3YZVW4aCjmeqrUvbX87uJhtJrDVdonm8N3H+st9VA==
X-Gm-Gg: Acq92OHgpcUY/KsIDChAuDPr92juKPhsBNGFObkPZrvHMN0ZtMBf+2hc/xjUn6G6K0b
	/48b4IqlQQCmsAzYT5HmmCkZA8edAOsM2apedY6BogEAMkGwBgKAdcefloIqNYCuZrTvMSs+qZ5
	sFkWWqd85nvBo4Glu9DelpzjFo1bEWVkWDkawKneU4oYhQai5399AKXnOLa8WUZNyWc/o8eSKcF
	+jScbUsi/VEAEse5EB/LIjuh2DFbc5qjKA5x90PWR3Cqo98WUxsgmmFYWTE3POHZd3+4eTyev/M
	FAdOUZDaf40QnrG2nISkeAeMUj3K3HcMkPSL+xXtPDfw+LqOPMGGGHkz4wLbkbk+lwQEwjTRDP/
	ZnVQRenF4E3anVB+K6cBBOijlYLQqnPHwsgSX26BUVuE4wzuYilKt7d8X/zY89JQQG6jECmvdKR
	yt6lvKIKwfLKOg9hEwcAzej/Gjs+XA8slKP3e4fRmFxMW6+HhwLQBtW0QU7M9tl30VFqdh6r1gJ
	ozAjrsey0KNllHeN3W5ccRLsuolQ3tFmiDgRQ==
X-Received: by 2002:a05:622a:1f8d:b0:50b:2542:e16f with SMTP id d75a77b69052e-517987a918fmr51014281cf.15.1780685174139;
        Fri, 05 Jun 2026 11:46:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da6f41sm83771451cf.22.2026.06.05.11.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:46:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	=?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <cristian@rodriguez.im>
Subject: [PATCH] libselinux: Do not clobber errno of the world
Date: Fri,  5 Jun 2026 14:45:58 -0400
Message-ID: <20260605184558.280873-1-stephen.smalley.work@gmail.com>
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

Fixes: https://github.com/SELinuxProject/selinux/pull/445
Signed-off-by: Cristian Rodríguez <cristian@rodriguez.im>
---
 libselinux/src/init.c             | 1 +
 libselinux/src/selinux_internal.h | 9 +++++++++
 2 files changed, 10 insertions(+)

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
index 6089463d..ff191c76 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
 
+static inline void selinux_reset_errno(int *saved_errno) {
+        if (*saved_errno < 0)
+                return;
+
+        errno = *saved_errno;
+}
+
+#define SELINUX_PROTECT_ERRNO __attribute__((__cleanup__(selinux_reset_errno))) \
+                         __attribute__((__unused__)) int __selinux_saved_errno = errno
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.54.0

