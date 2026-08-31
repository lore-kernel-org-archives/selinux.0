Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932642AF9C
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183317; cv=none; b=aQ8S4N1BNUrZ7VhZ5CUmsAOfkGJlNmIkkFLkiF156hib1a2Nhei+Lh4SM7+T8s8sSaP33GttGXd2yRPp8AIUB+pQ8pggoeziA9Kg5Vi210e2qFQ72nGNWaqhXlVm8kTxjpRiINn2DHEjQDdWFVMKueNti5M+o3kbO7ULdwMsnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183317; c=relaxed/simple;
	bh=98jFFfaFglPqZrdvsI6XoU+VQsFUPo74lZ9MDX96Uk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICZIE1lWG9ntKlrmtSg4vMWqsVmR7lO7goW+mQcJ/ci4YpQZfm7Bn2uu1N8cDSWOUFiiA4fF4ERWeeyBY5AOtVpmvvdowfcgNDHsu/0fKIYqMe8vecNXuVjbd7C6nI8h55eCksdLQPEz7NrUa6kzpQhNAUJf/2QCDcNFDD0DFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cNQGIZT+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cNQGIZT+"
Received: from DESKTOP-NVB873J.localdomain (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D74F20B710C;
	Mon, 31 Aug 2026 06:34:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D74F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788183280;
	bh=jVrW33/Lf31t9aXxmyTG5pFeeX1YclpAa1Tt44FfaNs=;
	h=From:To:Cc:Subject:Date:From;
	b=cNQGIZT+IkciiFRTfyUMwcxw4cPr06DuZFltrmv9P6YoVMYpDyeQhmQDurUFaTyIj
	 ayCDmEHA45DhYX9VKcduDJ3JfAD7+MeGDYVukcvjKRlNAOz6DiMqCTFR9ziwabMbxP
	 csifJAfUDxasopaeTOa+NKXYu+3w/1UVOBccJlhU=
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH] libselinux: Use correct struct name in comments
Date: Mon, 31 Aug 2026 09:35:09 -0400
Message-Id: <20260831133509.3287-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct selabel_opt does not exist.  The correct struct name is
selinux_opt.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 libselinux/include/selinux/avc.h   | 2 +-
 libselinux/include/selinux/label.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 6d728ce0..e38eb4bd 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -208,7 +208,7 @@ extern int avc_init(const char *msgprefix,
 
 /**
  * avc_open - Initialize the AVC.
- * @opts: array of selabel_opt structures specifying AVC options or NULL.
+ * @opts: array of selinux_opt structures specifying AVC options or NULL.
  * @nopts: number of elements in opts array or zero for no options.
  *
  * This function is identical to avc_init(), except the message prefix
diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 10e3a718..994b3c9c 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -71,7 +71,7 @@ struct selabel_handle;
 /**
  * selabel_open - Create a labeling handle.
  * @backend: one of the constants specifying a supported labeling backend.
- * @opts: array of selabel_opt structures specifying label options or NULL.
+ * @opts: array of selinux_opt structures specifying label options or NULL.
  * @nopts: number of elements in opts array or zero for no options.
  *
  * Open a labeling backend for use.  The available backend identifiers are
-- 
2.34.1

