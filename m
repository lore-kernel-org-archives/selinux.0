Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03964A843C
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362132; cv=none; b=VNhttuo8nVe3N90Y8Ed/qPW4WHTH22QMI0v6vnsLbpbYq2ny5JwiJq1agslUFaQekdWgfbQHEAwGwXd+xDNoYIzTzYslwp5rwXLtaPtTwoVi1xPmgDK+XkCudkRCDy79PW0kIN3eZ9g3SM5dbHdBGH1toH1qHz7fOQhsYbZNUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362132; c=relaxed/simple;
	bh=Dd7BBoSUrzJt9VWBUzfcLh0QFyljaeUdTJDSkZKprMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpNIZBXKx23i654bA1xoE9lnSSWoFpqf8HvqIsNM0ziVCXMRx/3eyYIO+N2mX5+uLnW7d4kiliQlauDKaaIvyiJ/a8mh37SBFeyTBWZ80uWZ7J/rE28I31tdROb8wSyRmGKaAm2c9or8EweI4GQrfUvyR2c5o0lxNwct6MQp6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkWT3Z10; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkWT3Z10"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93900ed2925so116215385a.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362128; x=1788966928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unRRvm1EosMY7VfDTTn9bBm26oQ8NKRizJ6pCYoIZCY=;
        b=UkWT3Z10UtW7cltgUEfDC3ljF8RZtnX9FPBIWNliTg0K0MKMlYCJycjx05hIPZXiYK
         qnBPLyKQDl5w22K26LxHfJpQIn8RzyZsjTgja4pXUxph1ZrdhHD8LNdz+yHfQclLwbrL
         ZsnMEs1ZMfTB2a6pReJH4pQSSocMqkZC1CAGww0yenCAerZaRLuH5xVYVAhdDHsmLnuY
         vOiL9Nj6uED0vjDX8f88rsiD/0amWGee1qXg0/LTmHEa7p+JnJtwfi9GSCDyk049/LwW
         AdPCLwR7xk4l1gbMG6o5OGDsUG0/JQasgwgS8K5RPBQ5U6w0AkwGqzYjH9h7VA9zafmM
         cNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362128; x=1788966928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=unRRvm1EosMY7VfDTTn9bBm26oQ8NKRizJ6pCYoIZCY=;
        b=dF7sfcfc+OtbRSuF6IzQHKl9cXW8M8Q7+k47F/30v8ejkiHo1GPQCn4X0Z00ZZtHSD
         DPeNzLK4yQZYAs6wEza+GDoZoc9J5tV48O5Fko5mse1LuN2FwsRaEUiCqjTgQndW971d
         SANshARE/E4AmAFyF+65j3O16Ht1x+GPqAQpoPqgAlo8lVdolYMjebH9BTuxvcYQrxFU
         LQYgJ4AWEwyMhpVfjdRD5m7Du0q60yUNgr8oHrb1c0r8cswCj8Crls5CVTTff8r7xQeN
         aWp3iNXspWVzfL4rJTzSrUXLOGxWVgNGoKjyDMx5Grh7vlSLJzr8EuGT1D9q6PcM2XCx
         MYRw==
X-Gm-Message-State: AFuF++mYr/51+NUkExjm5b6ywflk9XM/V9QyrsFuI3WpY2aEzqUhzKkY
	APoRWPKbjhDVOK8EwgvKCQYOOj6BTianTvfSY26v3KyGVOSKXSTsT0icV3U2Qw==
X-Gm-Gg: AR+sD13aZGgm2Ij5ZG7g60IwN+Ls4UzJ7Iw68WgGXuBVZr1MkxxAWHPIZzVDG2V8V2t
	WeNlKML3bO0DFnK8htWdmyRAlvlKROxMAKqnm7+ZvsS2Wp6rWeX/4PFN2O1LZ/CPE2kYstALQDg
	/3Q539ZWQLYkqVJ+p6SUXdTSv+rzQyGhxaioQJXePL+yvLLX1pMH0W2gizuhxiFWg+3t7JVC134
	YYFMtXRK5AuAG/WmeCOES8gA+ixKEC2sZ3iMcWC4whWj/Qr3pWKcZPX6WJH5qdTkEyqX4mYmKBD
	JPx+MtTADm/JEHSj4Fzx3dx7TXQG6bW1Y99T54DNjb6UusBFA/x4k6aSfoGryBbmWgGJdkNvYgO
	oCD8oj9rz0f4KjDJ09YGEYlNTMy38MFtia/AINI4nJ+1dyYbpMYr6kY5b6WulPIpY32YjxVmoba
	4vy6xUXZi7LFdgqASkxV1MutQF4MPd8T5bM4NT/j7EnIaEA1xjqVlnWspVYOnL73N2ToW5XwnXB
	HAvMymP9lnIghUrXD53XB0mHeag4eXm+Ybrezf3qsrVpVsRTsw4womQAC1g6QSE
X-Received: by 2002:a05:620a:19aa:b0:939:31b5:4e08 with SMTP id af79cd13be357-939608a7d9cmr666272785a.0.1788362127861;
        Wed, 02 Sep 2026 08:15:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 9/9] libsemanage: document semanage.conf search path and ro-store-root
Date: Wed,  2 Sep 2026 11:14:06 -0400
Message-ID: <20260902151406.54168-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new semanage.conf search path:
	 /etc/selinux, /run/selinux, /usr/lib/selinux

and document the new ro-store-root option for semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 36 ++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 74f0d34f..1373a11a 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -5,8 +5,18 @@ semanage.conf \- global configuration file for the SELinux Management library
 .PP
 The
 .BR semanage.conf
-file is usually located under the directory /etc/selinux and it is used for run-time configuration of the
-behavior of the SELinux Management library.
+file is used for run-time configuration of the behavior of the SELinux Management library.
+It is searched for under
+.IR /etc/selinux/ ,
+then
+.IR /run/selinux ,
+then
+.IR /usr/lib/selinux ;
+the first one found is used.
+This lets a vendor ship a default under
+.I /usr/lib/selinux/semanage.conf
+and an administrator override it under
+.IR /etc .
 
 .PP
 Each line should contain a configuration parameter followed by the equal sign ("=") and then followed by the configuration value for that
@@ -35,6 +45,28 @@ Specify an alternative root path to use for the store. The default is "/"
 .B store-root
 Specify an alternative store_root path to use. The default is "/var/lib/selinux"
 
+.TP
+.B ro-store-root
+Specify a colon-separated list of additional, read-only module-store roots to search after
+.B store-root
+when reading, e.g. "/usr/lib/selinux".
+Only the
+.I active
+subtree of a listed root is read; the sandbox, previous store, and lock files always live under
+.BR store-root .
+Module listing is the union across all roots, and a module at the same priority and name under
+.B store-root
+shadows one from a read-only root; installing at that priority overrides the vendor module and removing the local copy un-shadows it.
+.B semodule \-r
+on a module that exists only in a read-only root is refused (use
+.B \-d
+to disable it), as is
+.B semodule \-e
+on a module that a read-only root marks disabled.
+Unset by default, in which case only
+.B store-root
+is searched and behavior is unchanged.
+
 .TP
 .B compiler-directory
 Specify an alternative directory that contains HLL to CIL compilers. The default value is "/usr/libexec/selinux/hll".
-- 
2.55.0

