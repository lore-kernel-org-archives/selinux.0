Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C54E9C14
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611118; cv=none; b=GoBvkMzfB1+bxO0Q6oP/8W5Hjth/zwR3mKALG3samPa5SyRZKteDplehn/1qp0nGFS2qounoh73sE4QQEmQAIsrBbnM2BiKBmAl7w7BPw5a7K2ejpz+hbukZzJfWbMR++BClqFfH0mGpi1lEvDszxjbVm7cMoH+Oi8s0c1SOHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611118; c=relaxed/simple;
	bh=KPfkSJdhiqSRRmjY6+to7AEZ2X5LVCnXaCjGYrrkFsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhTcGcEHCEF7B/CVXqolkMvXpR4jq537q9SEvpKLG7sRk4K2qCLapkikvGl0bbTEoKsejPQALBNhMhw29s80BqWyhaIlqutXmsSCRpiTii34UqZ1LwnqfMSjWUz2bR59PpegozDjeNeZaA4ri7cX6n50e+g3ckw1krU2tJ7pNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KIKfE+H8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KIKfE+H8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611105;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jIfzdaUz7jWUViHDYntGOUa34RRU5OeVuY2oyrFJa8=;
	b=KIKfE+H8daS1GuiVmrzcfso68CooQ2U89ZHPEFFrs+zQnX71mE36xw4IO1DmMbuMnMJMXX
	Ll39w2SJCbPN5Lq/1FdotRxXOmIjE7dQQXzGhpk/rAF3oGWYN2n3D10Pien2wSdYh2m71f
	mpAV1if0jWO6KToHVE8C5qE/ydWF8bpKZ945f7u3Otkwaagc5ecU1rowIBHImJeu/m4kbc
	7YWUVGYq8AW1ykx79OOVk8D5t1e1REZHn/7/9EBmbRXQ0qFqxWLS2RnX0SCH46LPtkZr6B
	XlQ6IyFAvHFTGcV/I1522r0CPl/Nw5UsA+n3bXbiauSDEbvQStpxIP6OEmfWtQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 20/21] tests: fail on compiler warnings and enable Wextra
Date: Mon, 28 Sep 2026 17:57:51 +0200
Message-ID: <20260928155753.2259807-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Warnings issued by -Wall and -Wextra most of the time point to actual
issues in the code.  Treat them as errors, so the resulting test run
failure will be investigated and the issue handled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use correct plural in commit message
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index d1edd4d..1118089 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -6,7 +6,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
 FILESYSTEMS ?= ext4 xfs jfs vfat btrfs f2fs
 
-export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
+export CFLAGS+=-g -O0 -Werror -Wall -Wextra -Wno-unused-parameter -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
-- 
2.55.0

