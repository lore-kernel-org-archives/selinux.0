Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4F303CAE
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666904; cv=none; b=r0m2YIhrAFLPkXhXcgXadSKIxOOo22Gd4CdoftIurdXVXdnSJVrcHrocBFQ/xPtd8L8Fhq6vcOLoSBQQ+6y1Puf/Dgvv2GFbk2AZcUFv6PzDwp0Panx6hGrMe795QMlWWkqaUyntgrQ9K0WJFweqi1iLIIZlvhyXKsfIvsESveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666904; c=relaxed/simple;
	bh=8PzC31V+i4TmgfZ1ATYO5V54JmgQo2qEmmGrNld65oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dA8A7yKQKMaGnKuA6h5Db6YGHXwJKWhHMOsvuiyYOcUJM0TfnnIADo2Ir5h15q9XLv/nQ4s6KL4uysYFJUsm59W8MS4tD/v7klml6jmf4kLq4K43LkYcIH/zqY19oH0a9j5aVrkOaifQRm8IZiw9ZjmQ1HWYkWtGwpzF+nuKYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jjRxOC6O; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jjRxOC6O"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780666423;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0hHFThEmG3wCSpqBPGRl5mVoGDv/FOpY3jYoQwhlYxA=;
	b=jjRxOC6OL8XdJwe/SmMPDKq2DXgI+d58R9jnzsIyfsgBYWgX+nxWxUWZrw1/9lcFNIpYOU
	9XJ60UG1sKDTQrxJ3UrYH3SuJv+HzK82VHp8KgDYqa2x2gGdFht00DKF7py8Gqxj/VUwPc
	2DXyIP4nZrZuEz1Irb0oT+HK3FUyKvqn6DLqhQLNyE/425rL19+dcZql04j6TRzYW/3ynx
	2bEYA+mj5ZW6KqUCUz9IlO0nEuD8m1ERCIuFcyckbK6gMejstm9PWBwDt2u9q9u+dhrbl8
	LLOoJRQI8ajgqAIbIhO0Kp7WVI3+kvpYJJ+0E196P57OIvM+wnbyk4vvc2PCtw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] Makefile: support custom clang-format binary
Date: Fri,  5 Jun 2026 15:33:27 +0200
Message-ID: <20260605133327.62535-1-cgoettsche@seltendoof.de>
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

Allow overriding the clang-format binary, e.g. for versioned LLVM
installations:

    CLANG_FORMAT=clang-format-22 make format

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 972d5525..0e70f3d4 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,8 @@ SUBDIRS=libsepol libselinux libsemanage checkpolicy secilc policycoreutils $(OPT
 PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBDIRS=libselinux libsemanage
 
+CLANG_FORMAT ?= clang-format
+
 ifeq ($(DEBUG),1)
 	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
 	export LDFLAGS = -g
@@ -55,7 +57,7 @@ distclean:
 FORMAT_SOURCE_FILES := $(shell find $(SUBDIRS) -type f \( -name '*.c' -o -name '*.h' \))
 
 format:
-	clang-format -i $(FORMAT_SOURCE_FILES)
+	$(CLANG_FORMAT) -i $(FORMAT_SOURCE_FILES)
 
 check-format:
-	clang-format --dry-run -Werror $(FORMAT_SOURCE_FILES)
+	$(CLANG_FORMAT) --dry-run -Werror $(FORMAT_SOURCE_FILES)
-- 
2.53.0

