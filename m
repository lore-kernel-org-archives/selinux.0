Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EC3DA7C2
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638433; cv=none; b=cEzFUVxZd2ypOw5jdIIga0hU2HN47ugtfN6pnB/9MwogpSlie4YkZZdtuGHMM5wWT/DbLIXSRzbPsIucHBz74+yWECcVRqqNKF20s+xqq2geC/B1Eg+msvBqpRAv8aoGIz26haATImhPFecMsk+y2QnDBletlPVhBG6qu3j9hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638433; c=relaxed/simple;
	bh=upDvrLDzk0u92rzjPswsLS17ZPz3Ubewxm9qgf3YXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuCvXX9ZFGLFKznvHDybvsqXq7etA7diqib9oXB0Hh8XEP1TEIupUYKJaPj4R5V1WAnAlrj7U/NfM91+/scJs8uKpwiMd1piYFFgFDnpLQsXB571Pa5d3eUc7c6jtnayqF7JAK4CLA4sZ4hHmyI2byBUfbCT5+XgYkWUNTQfptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lexKK6tX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lexKK6tX"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d0db9372so41289551cf.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781638431; x=1782243231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsrH+3TqrQF1uCaT4w4ZhdVkB/DCTlHiQ0WDpRbLSdY=;
        b=lexKK6tX9uPNaS+OdigujFmnoPVf74yd7wS8dSsXZ2WBxmUO6QtBIlVvz+1fHV0d0d
         95X5sUoXRTnZLwUNJN+HXv4ZNlD4NpZWr/hkKAu7hIVUHxoiBl1fU/EyifXWrrEzM71o
         any7GMr4FUVTN0ylsxDU5NcmQflr+IImNc72GpNz7QwXaJnX02UzBhXYWo6TUA0tunZq
         Qv0MKDijNf+RjXM7ciY1iOqSRbcvR/D04MVHYNoHIiCPrgv1SqgIZnOjpP86GNhbh88v
         fINx/qarFnmF+YVAqWhK75JTs1gQ5sIJWiMZOMhSyr9k7M1XCBaemLCS3eXK3IuDHGF4
         nNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781638431; x=1782243231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsrH+3TqrQF1uCaT4w4ZhdVkB/DCTlHiQ0WDpRbLSdY=;
        b=AlPb4sjlHl+w+dX804xBJYEnKX2V7OzZ2oDTL+7RY1lCNR/S+i/o13duAyER5b9Bpo
         PmwJnM/PI+3+Jx4kEmjcYOGcA13OXCWZ4euw0P4idKmx2nq4VYy2QErS2AkjJ7V3hx2N
         +wqxKU95+rl1guKKnvq10lXrOPjI/AduC1epV9BBsOwKRAWYpX4v9oQfVuz1Bw29C0hA
         kSKYVpzEz+Q1AtmTzh66tz+4ZU2lO95qxWIfvpVBKJXlvJx9oULRTtNpu7sHuMZ0SVqL
         yIXRKVlR4/siFxcJeen4Jrjj5hOKUvrSxvqxM/5u2vzo3l2ojerjG1UN2OWihGp6CVyh
         a9OA==
X-Gm-Message-State: AOJu0YyeHNDsOE7iw7p0nBUUjfINBrpzEoUj4RIO2tcboFGp3Gzh7Q3N
	W9pZBfXUimOcgi3Gb3SLDZcg5284g8R9xqImxJO1e+lS2T4rMpZRm+SW9tVyOg==
X-Gm-Gg: Acq92OGb620ZXuZDqzZsICUD4TA97aEQmcoXY3vT3avJJ1CDM2OjGbiKNRiAaHW3foT
	eqGTNiJCnoFwzBGPyqwBnii9jp5RpjUMZfHsscRdJPM30f3V0pc93/WMF/HAXM6067Ji6P9IwxK
	suJ0TnTV8NIU1Ruc6pVhQxL1qInb6kLK3rgdyzI4WyjJQzlGMX39OEQBU2SNCxxmeJm/FR3EOjH
	hUWgbq1mTHtTqFbTiRtnr0YV0mjVGlBkljzgI3e1Pn7F6cZMhxRbSMCW9xArUZ8WOK5qB90/zcP
	+eEcAjm8vwGeCsgZ2Q09wU8BBkw1biDBEdITYMgLYY9hprd4FE/vXzHzVYNe3BXoM68dDxDMXgw
	IyvSufmrVDUNOufQnzmHS0PAwBmwm8B0t+aGOZZgwRRngIsj2QiALIpdarNneeGcEOvLtuimDFe
	1raGtXISzgfaJEnHcb/UsmBZqSkihbSTtgFNOmKlyFMiAd0p+94xI88NeiNPxEVPpMHONnX4rdF
	bjq94K8rIKbUK6Jpih59VeoU33ACOmYDwf9uQ==
X-Received: by 2002:a05:622a:7acd:b0:50d:7c18:c66e with SMTP id d75a77b69052e-519a8dd8166mr11896231cf.13.1781638430801;
        Tue, 16 Jun 2026 12:33:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb620338sm147171631cf.6.2026.06.16.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:33:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] python/semanage: do not leak an audit fd per logger instance
Date: Tue, 16 Jun 2026 15:33:11 -0400
Message-ID: <20260616193310.58019-2-stephen.smalley.work@gmail.com>
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
v2 fixes the code to set logger.audit_fd exactly once and then
assign self.audit_fd from it.

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

