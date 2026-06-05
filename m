Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705A54739
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680146; cv=none; b=HhivE8gXpCo1NMRi9SqDfZAGX8dM0nZRyE5WJri9kIvbnjEATc24e9BgtcBiz6ayKRBq/RHRjoRetmEHDpQINOJToLkf9rVHA5r55HXwHwZBL6dPmD23HiLdUblMQjEuf/nkEHVjaUJwcQkGC2V7Yhf/NoHd0lYCYjz9KiYNRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680146; c=relaxed/simple;
	bh=9Hb/HPBl2Xj9PDH+Zw+oQSsnHri8evpM2XqaZis0wfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nMIeHdrctO3RV9IoIu5fDVhB/lSZerwRm4BZYN2/5BFqFLFXJGHo3qALVP/T/MmPCFNs1ot28Kip7dq42Q0x9gbmU57Q6VIoK+d4pCgTZD1F1TSQ2u+aw7S/hso81UoGjWirWg2VOUxBWYg51KrxPe2IPoZH+j0JvTmGoymyU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZQJYW+sv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZQJYW+sv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680143;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Zmc6OtKd8pJzTGEw8w7o+02jiX7aGwyfW4pfBaI3peE=;
	b=ZQJYW+svmgm/GrJ1EbiMHnn9/ryYkUSV5VSnPoZrUjhvU67VkdlLcFn9jB8PXeffACBfJo
	uvjWyEB6dQpqe3ga7O/vBSQBbytZk6pYjoCB4q4IwPPZWn/EGh2Gv+mvp7EgdaMSYlNZh4
	JSxs09y81hvO51Kthguf6lG3qPPkIsTr9iYgH653e9liXzvf46vHbvIFKgPC64ZyyLDI/X
	q+gngR84TJVwKrjQx1bE/RLNzK8YFJahQ7JHD+dPAU47OTs/HdPdGQCT3McUfFJEiw0+wU
	IafLK3ug8yVHUMfh3sj+qT9qcKDCV6mDMBfsteBE9xxSN1c218V9MAfMplKj+A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/11] libselinux: drop trailing returns
Date: Fri,  5 Jun 2026 19:21:57 +0200
Message-ID: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Drop return statements at end of functions returning void.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/init.c  | 1 -
 libselinux/src/regex.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 68585d42..499e4e44 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -129,7 +129,6 @@ out:
 	free(buf);
 	if (fp)
 		fclose(fp);
-	return;
 }
 
 void fini_selinuxmnt(void)
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 0289a45a..bd7f2188 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -653,5 +653,4 @@ truncated:
 	default:
 		break;
 	}
-	return;
 }
-- 
2.53.0

