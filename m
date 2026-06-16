Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851330EF94
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639208; cv=none; b=Jok0nwUcbBz6lIlz02nmG6soYb8FbmH2vHilbo/2JyqRs1ob7odD//FS/oOI+rjE/0tjJKtBZSd7CLuGu9a23cCpvHiU17O7AWpMuHf/bfjlGYmotmGKhC2LfBWWbbpjToO4PS8IzNXb8l2HeyFyjfztoE5OoURWM+pVvkB0mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639208; c=relaxed/simple;
	bh=pqhtdHyTiAM+erSl025G71s3PuSl/RIlgmUaM6y9qwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwQMkf+AiYP3ZtEXgYAGXvdE7l2xRUXxXJkwwKUSFSbhOtKNXk8VVyJ9JLSWAtHPvrAePf6J1Ip+ZocI98E64gbDqzLuIPzo3/ACMexlfOIh+SpPOFDRS7gYZoz1W3Njf77eghmtv8guLsTE76/QnxVDu+6U++A4P3SjR6JUJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6icO1TM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6icO1TM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-915d17e2721so696674085a.3
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781639207; x=1782244007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/HXNegyGgdQsYlg6j7St3AE0WK6p3TYW75QR7rqmzo=;
        b=e6icO1TM7MVf/0vDqzxY9cJiebvrGWbo+6Aoc4hNUs3UyUnHMTpleucr4KQLpptkY3
         YicqvstVuXRaC5pQw7le0Y9Vl+X/VjM/ygRq2M+Ydw3J8ITJsqKMJW+Pq2/9anDq3IE7
         1bZPunCs7ypnIS3oQ/4LikzqTxjRqETFAr2LN1RAV53sUluI5eK3MrEZloEgWznbFOPK
         IJ7sIFIgob7oucnukuPk1vYilSJm5SOz0To5QBxoFSTh7jhowZo9+5jRnhnoHwRart4r
         nBvCjKkVTcxy1JlBxFbMcTIhiP4f1Q5AWnNX9gdD0mwX0rJWpro/39KvgDjUi3pIoBvX
         NgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639207; x=1782244007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/HXNegyGgdQsYlg6j7St3AE0WK6p3TYW75QR7rqmzo=;
        b=OkSst1OpTBsXCVJj/dbmS8kIYOE4ya0La/p5z5Ygzm9e5GK4uCN4fA6KMFuGq5Q+1R
         eZPljyn97yDnneqzQJGvV1G0k8rJj4Yi3VGWiOPLWNhVgkaDcblnFbhaOMZMbXUw3x+r
         PVYsCees3C83sl35mt+XhtyPUW35JW0fsT3pFmg123al7uGQCMqPKgnxZLkH7K/WSfMt
         dY7uzG9d/8Jhmaz2/68JkDH9WjSArJji6CNFrJYMngNpOPUZxr5FZA4TkA6Knok6WWFG
         8rqvEkQSYiGdL+zvEdGIjpuPSRwIZPUoTaG1ZPCKm1CeiAiv6dfJPcTJMytHDziERrUF
         Xhig==
X-Gm-Message-State: AOJu0Yx9BfE8F01yDMw6Qc/Qfn1ywSt5VlMRaCFuUxaITdZWCJUmupir
	SENe9Mit4cJ1CEcQZke2VEDM/YVCmdGjXAQUvWLNdz4wG7fUOJePjTUw8ocIlw==
X-Gm-Gg: Acq92OGlNpSXrE5RBcRGyMg8ez6Bj5Fp5HEVzQdTWqVKnYK3M+rCv3lMoB7bvkMDGs1
	H4xkpSodWCKCN8MBe3cBPwP+8Gc8RgBxV3cB1tZEyX/ciDI5n1WkVDg3nZDapdI/5wBKXXxBldG
	YgW1JHo16quQMhcIok1ajlW1MvjVWwRkvrQryaC+DQl47sdlQEr13xMUdPUwcTJv2SoSfIFo7dJ
	yq5EtpVqOjZPvHxGjlGz4mWx1RcOPNWgfy/OGsTc1Cv6LOM13wg4v0TRuPmOcL5VCt/SMAM4f0W
	Z9w6uiX/zYddtrLzhgr4Inypv2Aef+ehxIgd4hdpFWYwDQynz4+JYzLpcN50gTtNrbBohrB0uck
	HknHfwS8tKsgkhLSDEUOlOLZONu4wL7kUzHor0jfneTImoNpdBguRILUkoarnYCak4jyUY1CeUd
	cMuT+gVnwFePGaMgobHKW0iLhfMhsa3tAyRcVIaEkeKGMayXAVhoTE81fLi7GXtTvOfyQo70sNA
	s9IGtf3cMonAZOkdRzGXmlUWNI=
X-Received: by 2002:a05:620a:d95:b0:915:5379:b511 with SMTP id af79cd13be357-91d8b5bdd40mr193355985a.43.1781639206613;
        Tue, 16 Jun 2026 12:46:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm1568192885a.14.2026.06.16.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:46:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] python/semanage: do not leak an audit fd per logger instance
Date: Tue, 16 Jun 2026 15:46:03 -0400
Message-ID: <20260616194602.58335-2-stephen.smalley.work@gmail.com>
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
v4: it helps to actually commit the change before sending.

 python/semanage/seobject.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 9ef99be3..5914ef7e 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -106,9 +106,12 @@ try:
     audit.audit_close(audit.audit_open())
 
     class logger:
+        audit_fd = None
 
         def __init__(self):
-            self.audit_fd = audit.audit_open()
+            if logger.audit_fd is None:
+                logger.audit_fd = audit.audit_open()
+
             self.log_list = []
             self.log_change_list = []
 
-- 
2.54.0

