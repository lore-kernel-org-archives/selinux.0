Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DE4E50BE
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618328; cv=none; b=YOsZ27H/rfuPd0UZGw7eQrLEuxZb5G5giWii3gmoUZZIDIo3NSdGKYKXROzqOiL673OsCmB3elhpOmv+gJ6vi6s8bTidRnJCVSVmTENtEcqclf/s34RahVd67EU9vCZJ2sB4RLzw8gp425qoOiEzyL1XDvOAMg9JfcfZuqcMLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618328; c=relaxed/simple;
	bh=fKBkAdm6145yVdVX/EFjq5gmCPqfv0ZE/yTRQKdJW4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=durkl9t9nS3fJbh8xu62/Jkd8M7A4NSTwzZEFMtVVY1u8dpycb72sAXDSr0Ozexv+Jszx3HLvSEoBFb0S7Ra13WnfP9G3ihTOJjTR6MQDDUR3BN5UW618sS0F+V/jFgQf1O4zExC4djvCIOV0aepFPd9eEAhfV3KIxn4hlTTvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMiUkMnI; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMiUkMnI"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5333b3bf8c2so4962751cf.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618326; x=1791223126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6hiVtnaTcaRv1JxWP888ZMXPKwIlo62ye0hQBEdWlM=;
        b=lMiUkMnIa56Fwj5Hr1klUcT4Kj47/yPmmP/oCMc3uLIGoyPKnxRKnPExQWBEeddKIp
         LKzZID5m9KsEDuiqe7EhLGWeZT/t3bSLU/ICRJc0A3NM04EgpbCnZuYh2wBrp+eIm2Ik
         0IAWJtY4gi18g0aRCW9/JwE1f3anraHMlBopjErH+hAMEeyaj7cvJmHn4ms/yomLEzk1
         qXJPANGbQcHsbinxAR8GSl3s7GbDG/j8EYNy2bEaAr9HZU+F4UM3hsVzPZawaaaTt58b
         utkndHlJOtD+M27d/36YZJiw1c7V+UouKwyU0eSeAtT8yEmm5/ULKkw5g6Fssi2Jwyr0
         g8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618326; x=1791223126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6hiVtnaTcaRv1JxWP888ZMXPKwIlo62ye0hQBEdWlM=;
        b=m0euzv6rzmN4Ea8rn+uePoiJwSQm6HAFbIYSRkkJfLqrqsWSVsAgkLXOAIMXXj0No5
         Yb6p6EWtMQsr0lvl9DQAENC59eBvzu9tHcvOUx39PlwPYsUK8IZYWWPp90IKj02e2pLL
         qlfUoaza7KcNa10LD6SyyM/JY+Huvz8WCZhIBmPWoWyaUBKA4u2KdRfVdeHwQiKDmQ4q
         IVxChcrD9Y6ZsUGTVQK7hnkotTueiGKchQQROxL6q7JjYX/YLKStgSuM7eRD/b9eTbPm
         SCZRKQhd9O35gTsfXn3lK7ck8v15xmpwM73BKTiGbAlivuWhlO1tg8awDmBgiP6OSDJo
         fQSg==
X-Gm-Message-State: AFuF++lXhJgvC7BtWbqkkSRCldxTonDNCEyJNPe649KsoQXSj/UvIXnZ
	raIiW9/Q8tClmEzEKXVG/E+/6DyMpn09sP1zTNqBWqtHQ5aOMMIUHgAcOOtAAA==
X-Gm-Gg: AYBFou0jinSPK0AMdrcyN10buc2sBO7dV3PSphNN9bMW8kumgRZxal41i98rALer+8S
	X7nCwZonzQEkK+XVJL3WQT05fLogbAm8qLkBMZ1gYObVjioRyzzlH/jE6erMQYXWK3DfgBFyILC
	Nw/TCsKvjfHdeC5oBpL41hMKwHWpIzqXHZyE0WSFawsOr7ZlGBCpW0cY8ZHjmsd8QQl1DOe0/ad
	p8piMTfimysJgD604e3VUwvift5+iZVRgyEOb+MpgDcoRpOmtfAcSgvW3mdcRmiWXc+8s2LS4kf
	Dn1iCMwribZd2xz0VwGvsJYJVcJUFDXugEX4OS5heUUqvxkH1X6Xj/kHxUwziOPa2eO7GSnNd7T
	BDzoLVSWPjA7/ypkWlmD30znh7af+EMwtfiwps0v4x1RIm1xxe1MFGAle9h1WQ7SLXP5x4GyMrx
	suaVG1Fvzkb8OpYec0ciBxM8Z++SrPzKVrbseH+B1Dbip4AOwGiA+xEM2gXEnPqnH36ol8rdGCg
	1rFY6dA6WSsTnIOQkYyDLW+HOkR4Uv5mbDsGk//djGFZrnLNOQ4llwCQQ3AX/HO2MGlYMazBno=
X-Received: by 2002:a05:622a:610a:b0:533:43dc:5911 with SMTP id d75a77b69052e-53357f6bca9mr1499151cf.7.1790618326348;
        Mon, 28 Sep 2026 10:58:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322422063sm67366331cf.28.2026.09.28.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:58:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] python/sepolgen: search fallback location for sepolgen.conf
Date: Mon, 28 Sep 2026 13:58:29 -0400
Message-ID: <20260928175830.78464-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sepolgen.conf is a top-level configuration file (not under the policy
root), so libselinux's selinux_policy_open() search does not apply.
Give PathChooser a first-existing search over a small tuple of
candidate paths and add /usr/lib/selinux/sepolgen.conf as the
fallback, matching the per-tool pattern used for other top-level
configuration files (restorecond, newrole). A single string is still
accepted so external PathChooser callers are unaffected.

Absent both files behavior is unchanged: PathChooser falls back to its
built-in SELINUX_DEVEL_PATH list, so audit2allow -R / sepolgen-ifgen
still find the refpolicy headers on a stock install.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolgen/src/sepolgen/defaults.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
index 6e800695..d72f5cd3 100644
--- a/python/sepolgen/src/sepolgen/defaults.py
+++ b/python/sepolgen/src/sepolgen/defaults.py
@@ -25,7 +25,14 @@ import re
 class PathChooser(object):
     def __init__(self, pathname):
         self.config = dict()
-        if not os.path.exists(pathname):
+        if isinstance(pathname, str):
+            candidates = (pathname,)
+        else:
+            candidates = tuple(pathname)
+        for pathname in candidates:
+            if os.path.exists(pathname):
+                break
+        else:
             self.config_pathname = "(defaults)"
             self.config["SELINUX_DEVEL_PATH"] = "/usr/share/selinux/default:/usr/share/selinux/mls:/usr/share/selinux/devel"
             return
@@ -68,14 +75,19 @@ def interface_info():
 def attribute_info():
     return data_dir() + "/attribute_info"
 
+SEPOLGEN_CONF_PATHS = (
+    "/etc/selinux/sepolgen.conf",
+    "/usr/lib/selinux/sepolgen.conf",
+)
+
 def refpolicy_makefile():
-    chooser = PathChooser("/etc/selinux/sepolgen.conf")
+    chooser = PathChooser(SEPOLGEN_CONF_PATHS)
     result = chooser("Makefile")
     if not os.path.exists(result):
         result = chooser("include/Makefile")
     return result
 
 def headers():
-    chooser = PathChooser("/etc/selinux/sepolgen.conf")
+    chooser = PathChooser(SEPOLGEN_CONF_PATHS)
     return chooser("include")
 
-- 
2.55.0

