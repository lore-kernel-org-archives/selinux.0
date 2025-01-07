Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A081F0E43
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257591; cv=none; b=GvPoVY2L61kAQzis/yUnAUciQZo051OnoVu5QWAHmYhdbPpnF2vT4dO8xMtQDZNtk7QyxHUl+PscuXWsnXde62oUvzvKyQyaDbXNdM4l+znmFD3NqVD8VcieFodYJxePB6Wxcy10Rtjfk40cESDJ3mCkVqNRp/+8xA17nOALLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257591; c=relaxed/simple;
	bh=CaqiiZYzGlHjDug07HFX1gdVtGu63dL4ptdRSORiNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVsSbCh1ewicVwnIStP+kyqNKN8jxrpLJdDGMUPoemon4X1Wcxb6fgbMEALKpHAUEvk80CDhtHheOcnpmGsltanCKQJFKpYIMYf/R1zQVloptI2rQnUKJ9d7wqcJLGBU0aC0YNSRPToKy7ByhEjQfOtFSX/j/qhlTA3S1jeyUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HpiC7mqK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HpiC7mqK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257576;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCleUBSyKVUpIu4hNRxZIH+tgtEvF4lAKmkNc57uduk=;
	b=HpiC7mqK5q3NFNLDJa7hkxjeAWqQvW8nRdhhM2sXaHPOYh9L+eGkj8W5oSq5aineSs0wGs
	xTBElnb4Zmll7EyO/Baf2ZaprgwKGNY433QWC/TagH1fB6B1xY+1FD09QagsqP3oNgYvTh
	kvZ7xJOqAvr7llOkHCFWARQGtPmCj4dJxV1H13rLotR1vsSbOeVKJlx6RGx2RnDVHTuwQP
	ZATC9gfOE6xQyjScge1vYsBdGGBPlDMMZsXdgNcUXPk40aid6czNpVuGBoMKQePJj8FN3V
	q76EANgIXKT9JjX6gxQaJI+hwc9VoZcgFFtJCCHmBb2FkfoYJrd2zVBhxgTg/w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 16/17] tests: fail on compiler warnings and enable Wextra
Date: Tue,  7 Jan 2025 14:46:04 +0100
Message-ID: <20250107134606.37260-16-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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
issues in the code.  Treat the as error, so the resulting test run
failure will be investigated and the issue handled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 35bb358..6af7651 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -6,7 +6,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
 FILESYSTEMS ?= ext4 xfs jfs vfat
 
-export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
+export CFLAGS+=-g -O0 -Werror -Wall -Wextra -Wno-unused-parameter -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
-- 
2.47.1

