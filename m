Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F133065D
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529602; cv=none; b=HDDSnL1M5CGCI8yppRQlJqfE/dHiZMGS59uLBFXLbw/8vNlojrnrlvIQjXGCjfiiZiTMRhP4UkIv5ZJ4Ot5uP/uDkr/1rJiTwbo7k7vtOoNvT1lZEQB157WuD0ig2NvKVA4GZgE+c/VM9ePiMQftPLaUgOG2HY5Yd4KQ2Tm2Ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529602; c=relaxed/simple;
	bh=pKRZIX3nVp7CFNPyDE6rYcxaDdTxoRjfEC/r0uf9/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZ8LY4DDFqMUDtYpK+VYFvwNH+/I8wpogW4cbxWvPeBqKXMtpNHI1SF9Mkgp9XexAIS4pEe31ib89NTD+T4SmBz8uiPpSP27zhaSY/HObbcWtzGMoQrrTftoYYSSv1WYRjvUh/ApmRdwTkH+F3Q/7RFV62ehvTtDIBXLprWAhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjK1B6fg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjK1B6fg"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176096116fso40344391cf.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781529600; x=1782134400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9yETBsUUxX1wvDiFmnrKCtn3OEGpatVbdmOOMSoMfk=;
        b=CjK1B6fgmB2lpz99k2Z7WWN5uG5rKWIH5o+q6lRnzmTkOu7B/EfCNqI1hfa4lvricu
         k1hjDjRvjoukw/ndd+gctopxh9khP0nRicF4znliKqMiMnbnnQfjqpue9PZLUOuTR6Qj
         KQu9e1oOuyLz89UX3s/mjmKNRwUCae6XG6/pfKHzZ5FkqZ/FnawilwuNiPj0XcxKYUDQ
         J00O8UdR1dBgAMIKJCC5LQZX1Zu8Vy/JegBhhs2ozHbA3sidw0dB7ao0AEaxpAYiL0DB
         +BExB6HHLZxTRsEfKw+Trizth5J9zpwdJ4NCPdLKYG9V3Cm6F1fBjFLHqCsY66ZVXMMr
         ZaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529600; x=1782134400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9yETBsUUxX1wvDiFmnrKCtn3OEGpatVbdmOOMSoMfk=;
        b=Xp+w/FrEEa//LQO49/PD9t+/TK8imUJIaLxoLyK3BejO4Oc05gWU8/YJvT4EeHvCXe
         o5cNSoKlDmj/vS6uAvqt7oRrkIeV3XMPEDuWn5PXM28vgPzv/W1tPu890M5wOLlraNv+
         okkYB32dUuXQT5r8ZeEzIHVEp33jYvZsq0+lxLqcENjPbMGKBNwENeqVUCYG15gdhKfY
         EgNgxbg0i73MfRhHP1beXeB8UzARffkvp90cZ8McwzhImTYYA5N1mmYR70dGux5hn3vQ
         Glnx0l1KrwLvNWn1+R0Cxt7BZMtFGxDvCjOvCTs1+a6ivqxQFV1O4xs2Dj+3PQtNk0TO
         W/zg==
X-Gm-Message-State: AOJu0YxNkUCnApcety9aNhs2mX7IWzKpGZGagqlQk2ht7Y0Gra29USap
	S4Xl+pixJorucTD4nLLL+6h4ZZi7lBwRa+WxhuI9DL7c3WT9oJvM69LYS7wjKQ==
X-Gm-Gg: Acq92OGwvzy+igy1mJHoIrsiq++4urBjNmpEDU0baWG/WGYKsNrqVfOrgBJoyfhpfIE
	sTP4mWuXAVwH+wuZt6juVQ7vVnypd44mtxOqov4b7ni1UB5RZv/W9uQ4JCgRcNwfVXlZrHkSezW
	HNZNHzY0IT1l6HGbaQwCdb7GnAlIIM2K165XtliZuXuXBPZvq1M25uK38eR3sOgfUh7mvgTJ8Xt
	5W55HmRo7K1yWr/N6XZ7mKecn/OI2u6/mDE8/6xvBPeJk0GDAN37cmEnlN+35s0i5jy+C9XNaqI
	iwbJNemtcUofDrbRWIbEY4sNRKPGGoC+pl7j7K/E1c5nRuhgLnoueZUv6bB50PNSB+SDfwmKymb
	lq7Ea5/Uv8lo5Cjeinm6v7feO5keJnmQ0EXsTlmC5gcTLQ4E0Oj7yhT2Z8y/KLxcTzXpdezKPld
	TaPsjVQ0BOQWnXYf0dNHEnQaIEZcbTOuMRs4OCIAqWeECNO+hT3HaXQ4neIWO2P2NYqHq4pE9iB
	4ukx58jXLRkHpE60A7wtv5iylA8QSLfwspS7w==
X-Received: by 2002:a05:622a:5916:b0:517:760d:48ea with SMTP id d75a77b69052e-5195339bd2dmr174083151cf.18.1781529599901;
        Mon, 15 Jun 2026 06:19:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm105895961cf.16.2026.06.15.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 06:19:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/semanage: do not leak an audit fd per logger instance
Date: Mon, 15 Jun 2026 09:19:45 -0400
Message-ID: <20260615131945.42765-1-stephen.smalley.work@gmail.com>
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
 python/semanage/seobject.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 9ef99be3..830b82bd 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -106,9 +106,11 @@ try:
     audit.audit_close(audit.audit_open())
 
     class logger:
+        audit_fd = None
 
         def __init__(self):
-            self.audit_fd = audit.audit_open()
+            if logger.audit_fd is None:
+                self.audit_fd = audit.audit_open()
             self.log_list = []
             self.log_change_list = []
 
-- 
2.54.0

