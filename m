Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394794D956F
	for <selinux@vger.kernel.org>; Fri,  9 Oct 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549417; cv=none; b=H20K7yPYsfMgt7MTDJWRl9dyaqLZvQpDAahsex0y3W4nDM4FW0K62VCo33izCe9GJukbSuh/Tvlsba8sBQiaBSNP/6vclYhP2K0H6mC8TiXWAfxHe42Rs1Iu3wuMb/enZRBMb8hxVBSSqT7bkJt9+LFwbPCHH8GGXTB6/CKz7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549417; c=relaxed/simple;
	bh=VlSGVWnbv0yKD/j7QdECTEwt9xlAqn3OwXYTLp04zHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WycVBL6dssr7+7mCb207s3aVIl/GN3nmpPXN0kBQt6XmZqNp0nip1XqhpES63QFKWQzKkE+9ZHt2J1j7AebtjOEWxAHulbcpNPQxgej6HCX6eIR8al5y/9vNC6U1BCOGtItrtIxsEBYsXPFYHjBvW7SZg6euohFzh5FiPMXkEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJx5MeOU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJx5MeOU"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5352a876d5aso46987641cf.1
        for <selinux@vger.kernel.org>; Fri, 09 Oct 2026 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549412; x=1792154212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnXTHk0FEmqbackOtPcCykGyY/eikPhQybY8iX0hKG0=;
        b=bJx5MeOUZvf8gooVsMcEIiKCOWhYGc0Ehf76JJr6/iC4lKedPZBMypsrjQXJtenXO1
         C+BiSbhvA1pcRhN3/49RNq45iiU8B5FqF2vb4q5D2n1accYKGrPazMLw8TmJ1swLeT4A
         1oFcq8wFl5Ixz5lzOle+9A1c+4OBZo+SB+L85qdABdiYpFzjRAvUXBaIg0K21oZdkoel
         omhA9dQB9Uui1Zw4FixSaiVVZHJAn6im/ooJL3YVIDbxeOoMbRrlk8B1cG3MKCaGMwAG
         kRQcZHNTUgYbKoTaP+kBnZe0XBKFx11npUXwCaCiSOprEZzthI9Rg9lm/6oWSwkMvxJ8
         se6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549412; x=1792154212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnXTHk0FEmqbackOtPcCykGyY/eikPhQybY8iX0hKG0=;
        b=IaW07q3RqUaaB+JEHbOIlqkEt5jBzkQqia2pCibP65L+LNIreIr14P2QoxcGYuDYYA
         9lX7DQybEPMJeqzGD0QZngN3r2BMDH+hz7Xu1Zm30C7ZgOpJ6WxMDHOhWLxmJIHBPi1R
         KRX3AaCU+J3e88/6BXO0jR/Z2W9atWE50ygGaYV3bCLXhvWoLikaVcSRJk3fzF50IvFc
         orCJb+SJ6IihG5e8MJMYAJbX32wnBO5Sh4C1Q5T3f9K8w19IHwZGl4rrAKNBgGR0UCbj
         UxujiW2Tf7zKPdsYo3FKzZD18Ju/U8/aOLPS5SJ0m5/LTsB+eZB0NhHyxwi4G2/bvZXw
         +IRA==
X-Gm-Message-State: AFuF++nL/m9QzOwu0OGQoD43YD4wSmTF6hXvyHf+8Uz74pwbAGfiCeY2
	auw3Yh/zWtgQo8EgfsBBhiHaPI4hC1f1EUGE0qfWzIYJ6JOc58Gl6MXE820at0dv
X-Gm-Gg: AYBFou1T6NJgN1sBcCMqEjMtGl1AkMjZ4zGx31XZSZ3bmS7lg1caiAaXBY3yQyoT1yC
	9pvc//bggSWNSVytTsEJH5hAb+AviJJjzK6uj2cotJ5IuSmAjCd/y9qryuXV1gJxoqs5LKceV8Z
	wIZWUUgBNhW+ARG98gT0Syl3YVP8ztLSPFyMwef42umVY+BrJ2fHKDj941eleLsZwgSBGRtdxVF
	+77tC1pUNhCfyewiULNZcaBo7SV60/mH1G7GNT1j/uloFR9pQEHUk0AXEDI6otv72b4Y1bblqMO
	e8coGZvaQOAzapFKODnTckYzJgCxDEabG7fMAbYSR/tEWmuCqgJgapDpYujhOX1uVXEn7/RYTZ9
	9SF1boBH9aXk0lVlJVlarOZwyJyjtrk76JHZEiQWm+uJ2P56VUq/H8OySTdRKRp47O88t/tl5Lr
	KPvvkOUEbEpDpIkcN9u+IkyKMz6mdmeOua2iR9nfHGl4XVdHcutJC8sPct9fQg2vcUn2dYJ4QmB
	e8LzFB3XPUDh0JTqmYt1De6XLW5HF89XAhyWppqB9TAu9EZqrvisvOy228nMPo7zNMJY13PsG5t
X-Received: by 2002:a05:620a:1720:b0:93e:c12c:9dc3 with SMTP id af79cd13be357-93ec12ca03emr123560585a.67.1791549411682;
        Fri, 09 Oct 2026 05:36:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9724fd1sm176559085a.1.2026.10.09.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:36:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Joe-Ju-Alpha <joe_ju@alphanetworks.com>
Subject: [PATCH v2] sestatus: avoid self-referential symlink
Date: Fri,  9 Oct 2026 08:36:37 -0400
Message-ID: <20261009123638.182622-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe-Ju-Alpha <joe_ju@alphanetworks.com>

Otherwise, install will break in customized openwrt 22.03 build or
other non-GNU-coreutils environments.

Fixes: https://github.com/SELinuxProject/selinux/pull/545
Signed-off-by: Joe-Ju-Alpha <joe_ju@alphanetworks.com>
---
 policycoreutils/sestatus/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 6f8db774..54082adc 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -28,10 +28,11 @@ install: all
 	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(SBINDIR)
+ifneq ($(BINDIR),$(SBINDIR))
 	# Some tools hard code /usr/sbin/sestatus ; add a compatibility symlink
-	# install will overwrite a symlink, so create the symlink before calling
-	# install to allow distributions with BINDIR == SBINDIR
+	# install will overwrite a symlink, so create it before installing.
 	ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)
+endif
 	install -m 755 sestatus $(DESTDIR)$(BINDIR)
 	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
-- 
2.55.0

