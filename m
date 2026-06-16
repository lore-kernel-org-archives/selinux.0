Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BD23AB88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638943; cv=none; b=QAQnKxEuAv5sYAvWa9C729WQ7f+BhbhGwGRU/r22d+qNS8GK8kvMzTnfDUHSBukMJ2aSlqsul6F6umj3bO8G2qb6KLuFUzNstPSO+ybHu6anwiQP9duukaMtnW/3p1CxFZ4Y3VQOaxdP9A/Jl+SRG1bjClSC6D39+Er1Gdz8uWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638943; c=relaxed/simple;
	bh=52s9TXk+HTWLjUwuJMGOaZ3aQ8XZ1j4Djt0y5XJqfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9F5Faw+7xf3R2zW+sJqnj++sHSZiwAC6Gn9LWweZX/4cowNZnrlyxW3DmxzYqVVX98qD2YctzDdHgyjP0n7czn/hsus2yNz+f6GecvSFIMyTeF3ok3aDSfTnQfrMX2Ul8boNTSv5Wmf/R1U0IS/jjk2iK6O2Bj1l4WoGmDqvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MagiNpy9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MagiNpy9"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91591f19c30so669467585a.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781638941; x=1782243741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/UZwKlhIgbiyBH5HMyv8KQKzokOrC0vRr04Kad3w7E=;
        b=MagiNpy9sfj1SbDFlZLpuhgQxZPN2unpbYjXXkqk29aE5H8fOoRVRYsfh2bIsJk8+a
         p2a8NlTYQXRQMMOYIJgdo1PlAwo5OYUDo+Utc6+wOrv9ZBB9kJARFgNzxvEiCL6vzVqJ
         IOeFXTqC+iU8WpSMlIJHPTTjTyPMmMsTv2oXSFT7etI6G4TDnEVZDdXgG+GwNWU071tn
         EmrefrFQnuXnDtQSfy5QWL2cnhhiUqoPGdbb1k3YsTzNwSPePncB1fij2h57Wu6NjFtb
         uPnch9QDU0ylRI3mTvv+0D7z7RPDNVOhE0CdlijFdUbOT+IK6pk7UqWJ/MPtFn5BFpbV
         CS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781638941; x=1782243741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/UZwKlhIgbiyBH5HMyv8KQKzokOrC0vRr04Kad3w7E=;
        b=PEiiz5aZJQi3kQA4o3XYUOA4SboCdGxKMcXB7TydGP52syWeea9U7r2gWQGwxiEb7N
         Ivat1Am0xKLTSzNUt4Bs0WCr/jCdZjkFi+efoFHmRtfU8UeKsDgPEWdUoIjmiyuTC0hC
         lUQHfbwn1+QSZ2h7xKWqkjRabifCyquFQ8KGKOCFN1Xl7ea2RKX+tCBITcEWLW6G5RYZ
         CUDeJ+gHUO3S1lC8KNfWq7JsX6WDWQUeNDldx6z/caUCyir2hYriqjoYmbJYEnyjyGFd
         LtTIhr/m+Vkc2mC0ooCB4vYqL5Sq4XNQh87sTcDV+hhN65W9SFMo7bwyh7wxEM+BDxny
         Y9JA==
X-Gm-Message-State: AOJu0YxxtnUV1ri6urmT/pFcHL5oZ5itnlPSwIsH/bQK5t89U+scGc5u
	da+GkPPVQWqRISPKzFZiZXselarfUwieeqnDfrgjSzN8z/cWVbPizYD8OdYxnQ==
X-Gm-Gg: Acq92OGcvJ6nCCihFiHJtznArECqemF83Sy2eXNDE3q2d89Ryy3ZrKI8c366nU8jMsx
	UtCnAJ59PkNEB/L0pEV1g2axbW3jjXs4H+RwfDmlJkxqabhBdGhnS9a7n2Nf6gA+L1rS9Uzxt+2
	fb7t5ZGG6YmFEilAo7R44+GJgB3cMv2P7qK+Rndk+yikCj/GroTbxIwT9WHD1BrEeSaOcx1hXSM
	HoaqljnwJNWECjzYdfXSUipIx+atzxheZXDtwLubUVx44nbtY94TR0kqrw1VVxNs9SlCgDTrGzE
	hfj9lRFNt+BxrqNs1flcLBG9MwdNunPhY8MJswEL8LpS6d2F92OOV4NLBdxuWsLLS6cbkyrhc+q
	jRhRp6ujGTiGLCkbQld+DAKkPfmKiKoN8VLF+CGaGu8UBkvyu3xbcVEG5atvt+mHSfqntYviee5
	UErWhT0a0kG5HDHatS/ncyrDJ2iS1rrlJ7p+N5q7olcCV+PBkdn1EHD5Zw6cFexcFsw3h8NlPl+
	fVCwOlnNvsfawkWK51Sr+Z5ukM=
X-Received: by 2002:a05:620a:4624:b0:911:9a7a:8076 with SMTP id af79cd13be357-91d8a7ecddbmr198674285a.8.1781638940769;
        Tue, 16 Jun 2026 12:42:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a005a49sm1542785985a.23.2026.06.16.12.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:42:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] python/semanage: do not leak an audit fd per logger instance
Date: Tue, 16 Jun 2026 15:41:02 -0400
Message-ID: <20260616194101.58195-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanageRecords.__init__() constructs a logger() for every instance,
and semanage import constructs a fresh object for every line of the
import file. With the audit-backed logger class, each logger() opens
its own audit netlink socket via audit.audit_open() and never closes
it, so a large export/import round-trip leaks one fd per line and can
hit RLIMIT_NOFILE.

Open the audit socket once and store it as a class attribute, the same
way semanageRecords already caches the semanage handle.

Fixes: https://github.com/SELinuxProject/selinux/issues/291
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 drops the setting of self.audit_fd entirely; later references to it
will resolve to the class atttribute now.

 python/semanage/seobject.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 9ef99be3..93c7f690 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -106,9 +106,13 @@ try:
     audit.audit_close(audit.audit_open())
 
     class logger:
+        audit_fd = None
 
         def __init__(self):
-            self.audit_fd = audit.audit_open()
+            if logger.audit_fd is None:
+                logger.audit_fd = audit.audit_open()
+
+            self.audit_fd = logger.audit_fd
             self.log_list = []
             self.log_change_list = []
 
-- 
2.54.0

