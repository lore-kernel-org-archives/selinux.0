Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B62DCF48
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888056; cv=none; b=i9cKrHlfrgnMwNS9gCqE8fu+KYcjqTC2KcvdqzR7Gy2KyAkx198U5joX2Mp3Yk01lXNf77Ftv8g7xsObzAFoF9aIcMZS0Ypwwm9ZHtllKVevNHhADRmPqdD8VgiVaXFrSsuj1RRQ053iPYF7+bIBPtaWj9dLvBokIqP+rUEzjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888056; c=relaxed/simple;
	bh=+kD8U/D1Eci5pc4pqVceIugjV1Z6EJR2haK/66LcRN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXFyPWxW+7Eoekc5rTeIfyeHWx4aMMvMWZR+yvYLILtChoHmPrHBkP2TOh3mjpk+wGi6iKcCc1HeRYO5T0AnsHZHzpBE0940mHUqwjIDNOvAK/YtZ2kM6LpcUO6s1bB0MvW4siLYxv/SL3B/QN2Uq2ygQmNKa7jX73MFFIZKp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn1PF7hd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn1PF7hd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso6375125e9.1
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753888052; x=1754492852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZd5ZZ9RjXBzXj+p4VBXvjypM2OE0/0+pzuxc1GM3QU=;
        b=Pn1PF7hdD/i7KzgBi3AiiVy0NR8jL7H4OVODIxxAdCak/ilTZkMptKdTyJEX+ci07X
         wjU+Xgtahcy25yNEvTT5Dsy4KhCeqLFtTAGeG8O4Kp75GU0iHuwkBSYFnqq/SN/fHbvV
         ugNUTtwo9TMjrxF/d4LMK/QCWbVNePX+/YHqMO5HIw81iBoy4gOeiiLf10nv82ZfYJJX
         5MoIwQTjk5o7BEVXYlNhVoO1Hba2JRu8Xp5cvwAl3SNWJIdUVnpOo5Aaw3QaOheWcSxK
         u1wJXegP2CYUq4z7yycPnKCdFssh8nn7FkY962emSJg/QbPXX0H7voJVdSZOXnp0P136
         Fcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753888052; x=1754492852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZd5ZZ9RjXBzXj+p4VBXvjypM2OE0/0+pzuxc1GM3QU=;
        b=Dgb7MXgiPf9+k8JlyFbgQauE4tasCjDcGkSCiFR8fB2rmSWKzGt3/s/zx36iTT/iJq
         g1j49bIHHpHPEy6keMyeyTkgGSozNS0E5XOLt8/nbLKSKESPpfYN1OzUwM5yhuI7z3Df
         y+MgCNh6j0gIbJNUnmCokg8NfyKPiZNt4f7MngW6Ta3xvSJc4qDmor+q1xis44EV+9sq
         CY7u1UfFaKxtYc4xawFknFJ1YeRwC7wneWV1ub7sMpoCqwYUKerFJoN5hfJYHDdyWboH
         3fYSduf7t8Zk2is6M1vLc/TPGc9qrm8o+pcWmYN81Df4s6r1jAWc12SYpprt7keRNujj
         Xqiw==
X-Gm-Message-State: AOJu0YzqDrkj0eZ4iLJT2+btl2cb0D31B9SGuSsa9G5q5dbFB6a1Bv0I
	Vzqp/rfIi86LYcLMNmSRDGHnUgjWjeqeH0RsGz3Crt2lvAZIZidpn1Rk5BypoA==
X-Gm-Gg: ASbGnctntXjS1L3yT8ZWhCwb2xQOEPHOUOuV1T0J1EkheDwzmLGHRDr/nyB35C3y6Ql
	HO9S2Dc7CONRfjEMVH6qvLtRIEuyPr+8FjntYawfDqVW5Uy6bCkE1OmTKZMfnjcKd5SDA5VWyI8
	om4Zs+p21GfsBnUx8qvjRWbbaXbEpIlRUHa2f5QjQoDmUlEcEGD5i4G77weGpgLcrwotL+zVKRC
	m+0TpWf5nIUH5hrZuOhtZk6XX5oLI6sqWAO7SSTunB6Xov/TTo5mLV5lJ4NqutouXd2bvSUrvCJ
	Y71HrtTqmkK5ZU7a1tYtTNT1W7Rgc0+/5EUaFeg9I+B+Fp97rbD4ltHUZRiBlPOP0PVX8p/KBXV
	f3/Wsd+KATB/B
X-Google-Smtp-Source: AGHT+IF88ea9JlUP09zvU1p2d8TV3nW0d+2eVsP5sSa0KQSBIuz8EX1g6xwy/GyAwqiSYMpAXopPwg==
X-Received: by 2002:a05:600d:108:20b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-458939439ecmr21567175e9.3.1753888052207;
        Wed, 30 Jul 2025 08:07:32 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm32882345e9.25.2025.07.30.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 08:07:31 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libselinux: load_policy: log using selinux_log instead of fprintf
Date: Wed, 30 Jul 2025 16:07:23 +0100
Message-ID: <20250730150723.974292-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows consumers to override our logging to stderr using the
callback based mechanism selinux_log provides.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/load_policy.c | 37 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index f67e5538..8e737a23 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -16,6 +16,7 @@
 #include <sepol/policydb.h>
 #endif
 #include <dlfcn.h>
+#include "callbacks.h"
 #include "policy.h"
 #include <limits.h>
 
@@ -136,25 +137,25 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 		fd = open(path, O_RDONLY | O_CLOEXEC);
 	}
 	if (fd < 0) {
-		fprintf(stderr,
-			"SELinux:  Could not open policy file <= %s.%d:  %m\n",
-			selinux_binary_policy_path(), maxvers);
+		selinux_log(SELINUX_ERROR,
+		            "SELinux:  Could not open policy file <= %s.%d:  %m\n",
+		            selinux_binary_policy_path(), maxvers);
 		goto dlclose;
 	}
 
 	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr,
-			"SELinux:  Could not stat policy file %s:  %m\n",
-			path);
+		selinux_log(SELINUX_ERROR,
+		            "SELinux:  Could not stat policy file %s:  %m\n",
+		            path);
 		goto close;
 	}
 
 	size = sb.st_size;
 	data = map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED) {
-		fprintf(stderr,
-			"SELinux:  Could not map policy file %s:  %m\n",
-			path);
+		selinux_log(SELINUX_ERROR,
+		            "SELinux:  Could not map policy file %s:  %m\n",
+		            path);
 		goto close;
 	}
 
@@ -175,9 +176,9 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 		if (policydb_set_vers(policydb, kernvers) ||
 		    policydb_to_image(NULL, policydb, &data, &size)) {
 			/* Downgrade failed, keep searching. */
-			fprintf(stderr,
-				"SELinux:  Could not downgrade policy file %s, searching for an older version.\n",
-				path);
+			selinux_log(SELINUX_ERROR,
+			            "SELinux:  Could not downgrade policy file %s, searching for an older version.\n",
+			            path);
 			policy_file_free(pf);
 			policydb_free(policydb);
 			munmap(map, sb.st_size);
@@ -192,9 +193,9 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	rc = security_load_policy(data, size);
 	
 	if (rc)
-		fprintf(stderr,
-			"SELinux:  Could not load policy file %s:  %m\n",
-			path);
+		selinux_log(SELINUX_ERROR,
+		            "SELinux:  Could not load policy file %s:  %m\n",
+		            path);
 
       unmap:
 	if (data != map)
@@ -205,7 +206,7 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
       dlclose:
 #ifdef SHARED
 	if (errormsg)
-		fprintf(stderr, "libselinux:  %s\n", errormsg);
+		selinux_log(SELINUX_ERROR, "libselinux:  %s\n", errormsg);
 	if (libsepolh)
 		dlclose(libsepolh);
 #endif
@@ -317,7 +318,7 @@ int selinux_init_load_policy(int *enforce)
 			*enforce = 0;
 		} else {
 			/* Only emit this error if selinux was not disabled */
-			fprintf(stderr, "Mount failed for selinuxfs on %s:  %m\n", SELINUXMNT);
+			selinux_log(SELINUX_ERROR, "Mount failed for selinuxfs on %s:  %m\n", SELINUXMNT);
 		}
 
 		if (rc == 0)
@@ -365,7 +366,7 @@ int selinux_init_load_policy(int *enforce)
 	if (orig_enforce != *enforce) {
 		rc = security_setenforce(*enforce);
 		if (rc < 0) {
-			fprintf(stderr, "SELinux:  Unable to switch to %s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
+			selinux_log(SELINUX_ERROR, "SELinux:  Unable to switch to %s mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
 			if (*enforce)
 				goto noload;
 		}
-- 
2.50.1

