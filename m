Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C54C4F6C
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271282; cv=none; b=iSzJlfxHMG4KnLd6zUIbcUqYtqBmZ77m6hquyPCs6leoBfSWqE5OglfyNwansW7YskrTzVVadt2dPeyLrsa61vBSG1AAcXaMgCbwCjiLmNwUXzuSIq70+yh3fcsty9D5o4WIzbnRVPJW/DNFMfsj4kcMiaW8s0Se0TlaKd4xKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271282; c=relaxed/simple;
	bh=5ncVrUKmgn9ZPdjhwYaSJwjgH7fXj30/KdYGD4FIwd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHsqStpJWbjQ0gJzYkLbuiKk8gz5Gs6BmcL8BuUmh9q3zOXkQjMhv74NpwKSKGFA1gKCyVzKo87dFCXtl0F6kUw4qsIeRDlyglMlCy3r+VCD+YEM8JifUrFXcjayg9N2VwSr+CIuAD0efSBck3Hg9+1Snt25flg9c27uXfNYQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuIKBZXF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuIKBZXF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe208so1343216d6.0
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271279; x=1790876079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I3R6mI+bCnxKTja03qZL2tI8HrKCPUv9eL20iDYlD5U=;
        b=UuIKBZXFlPIwY6R0ETRUauezD5JrfgSzv2oAM7YwPS6jf7acG2hhpjKPSQ8r2jYDlL
         tv0TRoxDAEkSpWyFbUyU6/fQFBN1wEqjwBf0ZxC7B2KAuxtBDHo7y7QDH4aND7BHjKLU
         mi0aJ76kro0/EB7wB0yjpSTbC5pDEiI7nL/zVZ2aKmmLDnzO1i0e3IkCa3gVdq6W2dvr
         5RIGzSlm1UrWjsVMTOB/9KSIKez7S7r69jx//6FG2iTHVN6h2nWvMmgf/XjGmTVyU+9G
         UZbxd/tBqmGW9vzfbYwh/h9ODXvxtYxtLhLG2GhgEad+d51DpqZ4kuWWmoRFjTPk2IPH
         Ex0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271279; x=1790876079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I3R6mI+bCnxKTja03qZL2tI8HrKCPUv9eL20iDYlD5U=;
        b=Rpq6y1JyHAWeDMCvNYX8N06s/1EPqhuicKEpIWTaCdEjg8FcVRlmReh5BWx3NGB1+U
         983anG9/H/NTnUOpVob2OKg5BshK2l9aaNRM2OazZRmdDYoF1+87g05FQbqCBQN2vV1h
         gAu9NESw1PiRGAT7gThxNiIkDM4B3x/UmiIqZ43hKTwlHE0AK9HlUyyHCkHjyM9/IC6t
         xTnz/vpBj6csojd+cACv2/BsA9mejPej1b5xw7cHmvFqX4Dk5Q9g55sPHfe/wC5f6Kx2
         Jc2xpHCXliDIc/4FjH/hBBK9hmatuOeUUzzifz8OPTSal4iOQot9yTtBQxjtpTa3iF7r
         sEzw==
X-Gm-Message-State: AFuF++nnFC60y83aavWxiEij6GuHAxdkkW5Cu3/vvk0UTUPi9zzhFB4q
	NJQ/z1tzH8legmQZCmaJ2GsKBP4wRbc99zlNCD5NCFWABGBD9akCtPhRWNlO9g==
X-Gm-Gg: AYBFou2a+OQEGhUCagOVJHIHOh4nYdg/PQ8xfVsyjshM/Ww3UqLt21Xuczc8S62Y492
	MA13cIwmByFD0GF5YB7a4X/iDAyFJe9KqxvoHNd1GsfddZ8lgthhPm4jLaYV34vyTfKpBf7jGHF
	0uyrx/iTTRWnpSIE4swHiP04smP2N2YqGKQUGsBC1Ba4d/TG47SQpGEoxJfd2lOWtfNQrzCPO63
	Bd3pAm4m45YfxZQV/ncK9uTMzWdwTYB2atoKg9DgU85kMLWteJF91n/YWi/L+8uUmOG7MBo1RMy
	THnqDvw1kW5ytjcaoMNfTToS0TQbyOnDyddpv1ZoBz+JjEttuNBcDy1doWlAXKMdx5kOKRl1OjY
	xiwu62LaDaKrfRfcms2sabzRbk7doUhhK9b2gNbB0FdX2hc7bywdFdGP8TN4nk2XmGEzAxgtDXq
	+cKbZG6W/KrFGkzfwf/D5v2gi4xynPJSk1Rcc2M42Xea5WWx0X7/CkRQVDNaM29sHAir5D3WT+Z
	5IjMO4iQJ1alXf1bSJVYl/ESS/7Xwdi6BKEsyeoBY/CFwvjZf6/2PCygOg1JayZSM83m1viUOc=
X-Received: by 2002:a05:6214:130d:b0:912:517b:20e1 with SMTP id 6a1803df08f44-91421ef3338mr33363036d6.41.1790271279447;
        Thu, 24 Sep 2026 10:34:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e21995fsm21511576d6.10.2026.09.24.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:34:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux: add Python binding for selinux_policy_open()
Date: Thu, 24 Sep 2026 13:34:21 -0400
Message-ID: <20260924173422.65885-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regenerate selinuxswig_python_exception.i so the SWIG-wrapped
selinux_policy_open() raises OSError from errno on failure instead of
returning -1, and add a policy_open(path, mode="r") convenience helper
to the %pythoncode block that calls selinux_policy_open(path, O_RDONLY|O_CLOEXEC)
and returns an os.fdopen()'d file object. Python callers can then read policy
configuration files with the same fallback-root search that C users of
selinux_policy_open()/selinux_policy_fopen() get:

    with selinux.policy_open(selinux.selinux_translations_path()) as f:
    	 ...

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinuxswig_python.i           | 9 +++++++++
 libselinux/src/selinuxswig_python_exception.i | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 74d923e4..2340ed2d 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -62,6 +62,15 @@ def install(src, dest):
     """ An SELinux-friendly shutil.move method """
     shutil.move(src, dest)
     restorecon(dest, recursive=True)
+
+def policy_open(path, mode="r", **kwargs):
+    """ Open a policy configuration file for reading, searching fallback configuration roots (see selinux_policy_open(3)). Returns a file object """
+    fd = selinux_policy_open(path, os.O_RDONLY | os.O_CLOEXEC)
+    try:
+        return os.fdopen(fd, mode, **kwargs)
+    except:  # noqa: E722
+        os.close(fd)
+        raise
 %}
 
 /* security_get_boolean_names() typemap */
diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
index e5e55a79..6ab1bc6a 100644
--- a/libselinux/src/selinuxswig_python_exception.i
+++ b/libselinux/src/selinuxswig_python_exception.i
@@ -743,6 +743,14 @@
   }
 }
 
+%exception selinux_policy_open {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
 %exception selinux_check_access {
   $action
   if (result < 0) {
-- 
2.55.0

