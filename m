Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111392EA755
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786574; cv=none; b=In1S2gbnszeiHbsCzQJP/0D80Frs1387JN0yBvI0ECnSjtDhWHd9Kvz9cT28Yik11FiQPk+WY35yoHOjQmGB1T+ydAo6LCEQQ6lMX1YvxGdSL5tijlCMT/JujUGgBd+3xF9xoSIw8YxmRRU3x/rjxuHhoYBbdEqhofcO9KiRTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786574; c=relaxed/simple;
	bh=OiOFQSvRMcR2qs9K5nGDGC87ROBpP/XhLgD6O1sEAKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FI6ZliuQlUTcuDwWmbTIm0dtKzufzqJTCo8J2bdHX+v9qgtrK/13Qi6wonQbijJ0fzxixT3RUA5UWIB4fPZqLzXdRQ6LXkMI1hdP2JKgcUoLph1gQEsSE3XhTezRiML7r+Z/0PGMlMS3+3XyqrLeL4AyyThE7yD6k37AFTo/DtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBTBW31v; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBTBW31v"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882379c0b14so20036886d6.1
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786572; x=1763391372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4/w3FfKXJgJ1sO6bZaLFY/ABid2ZFPjdcEmferLW0=;
        b=UBTBW31vENKZN/X5U1t45HKOL0oMF+d1DvfDRzFGyh/Z7ph9A4RCaba5ck6KrzSbOD
         +oKLipYum0WiIozLjGHyiZbtRcWgc2NbvOBJcRoq+zZPYxNKXbDCqiokzz0UXO+iBV+A
         1koL6a8/1WYyQE5AZIYCjKS3pK2AsnI7n9UTJmWhXFEVb+/ceKdAqO2gs3M3e2cYlhBW
         lBAZoClF/CBSx9ACdwjCJMSrAAnToHBpKSOdMLAilnLgcPngCDvoOoC8JhAMHrN0z9qm
         rlJWHNZ87/XjoXN9OtzVj9fEhcqcLoZe+pQ244Cm4GhH24xd6WI5flClxE4+75iS5jEa
         tGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786572; x=1763391372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft4/w3FfKXJgJ1sO6bZaLFY/ABid2ZFPjdcEmferLW0=;
        b=B9fuKuZm+ibYurvNDJR96EOCjrPbTFZeX+yAuk5ZwdXrbkG8QJQTNj/hcWxlID67eJ
         qQVgtsMN45euPxMd2DH02D030EPKqvPrF+rO1OXHeiuoTS9gmkdVCNiiMaL2b4SuMNwK
         JK20XsgZUVoFdipy2pzOS28+qgfFTa44NInrnYZcPWcPxercCDNlx7Da+gB2RLAAnTu+
         JVJ8JzrOIKXawqRr4MhPJ30tAnb+ZuUVXaI4sNfx6a3n0GumNhUQQ7GalXPEB2Jqf1cj
         tVAi9kDznfm2Y/d51nMrQC8utx3l0qN9/9bSV+B2HoHZU5BmMwz+dRd2yIeeCJ1dimx+
         CN7Q==
X-Gm-Message-State: AOJu0YyT/3r5UIGeBqA6J8GYsrzbS3eIsvBKI7ksHgK3HuDKxtMAKdZN
	ztqxiE1blS059Wlx4o5D1nrqqkyy1ckAuSZTGno7nzwWjnpmbBlDzrvuJaQXhQ==
X-Gm-Gg: ASbGncuufEDoL7byXN+grU8o2kfV11v6QEiz8yUlKP2ujzImp7ZLbedVxf3qD/b4qsx
	FBasWm4Zm9CAdGqeT9xwsN3HGf+P52aodJQmj8aUEbQO2MBpl3uTNodyoLugWhEd2rWo9AyKqNb
	xtssN9C/CnNutoJuXeklYhqF8g2k0N/WSTDbQ4UfpOL4MIjiNmFdQ/+Lg3zNBRFmwDPIhutbTR2
	Xbc1VqWLzQj29jxth1npWyhXq3McJwd+Y1B9sUnoRNdayk+WHKtVWe9SwKAhcv7ljn2PV0cCVi9
	yWHmauVUfy+MP9RXHHtpvCGe5iyS5KFTUX/gINj7Kn9gX4AxQBQLc+XXmBPGp/McztcYE2qZZ+J
	yobSpzs73rZsX3L8zIVFGUIixA9hkZFjROCBoWopw9vrhDHyG03Uao32eOpLANob0vHPb0LRSch
	sn9XvuEUwh8HDJJdjjDPMZ/IOdyZ2+OO9yv2xsk6xlVXjjlBFjYnTV53k+2hYCLgU/KKK/60k9a
	9LzjDctz7O8KH8=
X-Google-Smtp-Source: AGHT+IEMSqhLD8HjvBa9L8VmT6TNVrAkcAduzkSz3abAtYPtiTkrpBw52Y4PMpkpmCurV+VEeRAA5w==
X-Received: by 2002:ad4:5ded:0:b0:880:85cd:6d98 with SMTP id 6a1803df08f44-882385b8b46mr99378966d6.4.1762786571602;
        Mon, 10 Nov 2025 06:56:11 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm54806496d6.17.2025.11.10.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:56:11 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy: do not modify the allow_domain_fd_use boolean
Date: Mon, 10 Nov 2025 09:55:32 -0500
Message-ID: <20251110145531.69069-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modifying the allow_domain_fd_use boolean value during testsuite
execution is increasingly triggering breakage on Fedora since its
policy defaults to 1/true, to the point that you can't ssh or even
console login to a VM while the testsuite is running or even afterward
if the testsuite encounters any failures. Instead of modifying this
boolean, just update the relevant test domains to use the _minimal
interface so they do not inherit this rule by default and add any
required allowed rules to them.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/Makefile          | 6 ------
 policy/test_binder.te    | 3 ++-
 policy/test_fdreceive.te | 4 +++-
 policy/test_global.te    | 2 ++
 policy/test_inherit.te   | 3 ++-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 520f891..0446f87 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -219,16 +219,10 @@ build: $(TARGETS)
 
 load: expand_check all
 	# General policy load
-	@if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
-		/usr/sbin/setsebool allow_domain_fd_use=0; \
-	fi
 	$(SEMODULE) -i test_policy/test_policy.pp $(CIL_TARGETS)
 
 unload:
 	# General policy unload
-	@if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
-		/usr/sbin/setsebool allow_domain_fd_use=1; \
-	fi
 	$(SEMODULE) -r test_policy $(subst .cil,,$(CIL_TARGETS))
 
 clean:
diff --git a/policy/test_binder.te b/policy/test_binder.te
index 4c7974a..a267a85 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -42,7 +42,8 @@ allow test_binder_provider_no_fd_t test_file_t:fifo_file rw_file_perms;
 ################################# Client ####################################
 #
 type test_binder_client_t;
-testsuite_domain_type(test_binder_client_t)
+# Must use _minimal interface to avoid granting domain fd use permission
+testsuite_domain_type_minimal(test_binder_client_t)
 typeattribute test_binder_client_t binderdomain;
 allow test_binder_client_t test_binder_provider_t:binder { call impersonate };
 allow test_binder_client_t test_binder_mgr_t:binder { call };
diff --git a/policy/test_fdreceive.te b/policy/test_fdreceive.te
index df9e974..805e04e 100644
--- a/policy/test_fdreceive.te
+++ b/policy/test_fdreceive.te
@@ -27,7 +27,9 @@ typeattribute test_fdreceive_client2_t fdreceivedomain;
 # Can receive fds from client, not from client2.
 # Can access test file, not second test file.
 type test_fdreceive_server_t;
-testsuite_domain_type(test_fdreceive_server_t);
+# Use the _minimal interface to avoid allowing fd use by default
+testsuite_domain_type_minimal(test_fdreceive_server_t)
+allow test_fdreceive_server_t self:unix_stream_socket create_stream_socket_perms;
 typeattribute test_fdreceive_server_t fdreceivedomain;
 
 # Grant the necessary permissions for the server domain.
diff --git a/policy/test_global.te b/policy/test_global.te
index 0078485..4978993 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -23,6 +23,8 @@ optional_policy(`
 
 	# Transition from the caller to the test domain.
 	allow unconfined_t testsuite_domain:process transition;
+	# Kill the test domain as needed.
+	allow unconfined_t testsuite_domain:process sigkill;
 	role unconfined_r types testsuite_domain;
 	# Report back from the test domain to the caller.
 	allow testsuite_domain unconfined_t:fd use;
diff --git a/policy/test_inherit.te b/policy/test_inherit.te
index da26ea3..7e09534 100644
--- a/policy/test_inherit.te
+++ b/policy/test_inherit.te
@@ -22,7 +22,8 @@ typeattribute test_inherit_child_t inheritdomain;
 # Domain for child process that cannot inherit from parent due to lack
 # of fd use permission.
 type test_inherit_nouse_t;
-testsuite_domain_type(test_inherit_nouse_t)
+# Use the _minimal interface to avoid allowing fd use by default
+testsuite_domain_type_minimal(test_inherit_nouse_t)
 typeattribute test_inherit_nouse_t inheritdomain;
 
 # Domain for child process that cannot inherit r/w fd to test file
-- 
2.51.1

