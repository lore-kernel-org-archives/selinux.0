Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453E28136F
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794743; cv=none; b=IpBOyHD775m6Z7Oulbc7ldNHwqTPVrgW+nUm6K2wIF6Mylqk3WjSn8Wk3JIK/1qT7QK6iInc2qd7p2b8063Qf1BkyixLh0arxj+acLApXr3lMf/taZFWvqm81H+9kkThDCQSGqECdymQn22X31bcq5LhNCC7eat48opCE5HVBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794743; c=relaxed/simple;
	bh=2e2EkW/Kv+64mGjr4LxqwFCFxt5eeIOuAdF3a+cHPaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf+wuUq0rUW06x7QimATKTEcG8y0VbLG/yfi2lHuhoU7TGUxDEqW7D9zdhMsbEtGzuOyR9+4N3aO2aV50yDOh82s7Dax83WAcGvdTIwz+sIJKM3wpxsiBt7cXnB8BxB0aYOFmCpoty+qiAPNSI5nQflpWMucvxsiAwrBQye5PZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTaW29ro; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTaW29ro"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882475d8851so17763376d6.2
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762794741; x=1763399541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Anb6ycyv1i4DJYb/ym1O+XK3h7pDCAaMl4V3Ye5u2dI=;
        b=nTaW29rofqiXMCmVSzOrtChzuCpSIzHXSeUYb2nUB5fiSqHySNYkE6doP3SjkiUn2l
         rzsKzZ8Rf0UFWU7JeXeqIe/tJH2wqQd/eOpfruAbf6k9poUnCPdbA0yvZiKXUIZyR7G1
         NtetUY1/iKtM9tXLkabp2hJtBJ2ySz28EJBBnFNmjSp0U/Cnl6teL6yXYyewKpwwgcB2
         cm2Xxo9YQTz65BjIGO4Fm9/+ahAKz+EyUw/KtMGgEuuyWttQLoPTPUHlMeMp3/m3XjPq
         zbNy6AMvMUGKElZPdaTuwaGkX0KVX9vjUxxcuKC8l/ARYbyu8wlpO5rfON9EpFlpxjkW
         9OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794741; x=1763399541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anb6ycyv1i4DJYb/ym1O+XK3h7pDCAaMl4V3Ye5u2dI=;
        b=o0k16eZMae+4L4VPEb35pfDuQyC0Ktn7GKm2f+JhTUQlwn5e2eu2Q23GPL8dcRU8hc
         T55bpLwmaOD33nEji0lz/cR/XCsU5zTn0WogNjJKPzEBtl8ZrLXtyGJzqJkOgqkpm8xx
         jW4mFAvox1XkI4VqsdRmYIIh3aaQULaw9+lGIZNC3iXfgZb5XRDlrh50sWgym67NsoFb
         L6KUYVjoiDvmQFIpZGetf7QcCWicwHCrzzOx3X71i7rr9ISEhoBcjf4ZhxdVJpR/iU8i
         r8U5sgTadPoZjJZJiYF4kuluLkThIEdnmYpmXrbz+AEPUWsOFemM00HMvfYpgtdnvBEH
         l9jg==
X-Gm-Message-State: AOJu0YyVnha2Tu5okRk1Q8ZkYjwTBdQRyGWeZNeA9THLwzUfAqiIaE22
	dV1Oneg/vJ2XjfQKEv2+C3i6im2aJj62dOFIokC/QeGgNOSq2js/yM3tekHiTw==
X-Gm-Gg: ASbGncsoItolE9QEujZ3Kvjx8j7MWgURQBMPuAYlzyIReumB6O4xzRrzjQziJ6X5amx
	dzRVLT6s3so2ULNy7uMAb/sgtVztdkKf2W5+iNCKQ19VstWgeKSkEJwX0Egkky3A/+7OmChr5tz
	As0CIfZkebj+HqBmAMXFbXgjRK5QHG8coMWjyAFOsTTT41tIXWC8ghw+uEaXhTeHQPtio6hZpbJ
	vz9vx957I6K86WBFyrthGNY1TF0lfZ840/ZOQTizf8lL4n8r7WbhAydhdOgblkeIGKeg7bGICIy
	ZgAAwRiYSF9DZFZZSwo98Lu6+qR2kaWL5/YtfTpiouwzo2PXo5kmbhkI4/B4qvf6ROVMC6Q5SJ+
	Cln6Cptt/UqYOL/GUHh2Ppqko4acTQxz85C3u/U54QTzqoqFbtljO+FNjjTb58wYVdFeRS9hGCi
	Lshv8f1Xrk/Q4O4lI1C6rSAi7BfDZqtct9+QK/7LweQ5m3hQrzyFlm8TCnCI7EwkYJnDbFTrEeK
	hfB9+MZdx9vSe8=
X-Google-Smtp-Source: AGHT+IHXFrLImO6xUGbPfNEhBhdFYduocUxGd+7dHSitP/X2QJ3br70bQqb53jD0m7knHYfW8UJ5Wg==
X-Received: by 2002:a05:6214:d86:b0:880:68ee:ad87 with SMTP id 6a1803df08f44-88238764f8emr117298266d6.64.1762794740798;
        Mon, 10 Nov 2025 09:12:20 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b40396sm54029356d6.38.2025.11.10.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:12:20 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite v2] policy: do not modify the allow_domain_fd_use boolean
Date: Mon, 10 Nov 2025 12:09:59 -0500
Message-ID: <20251110170958.23627-2-stephen.smalley.work@gmail.com>
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
v2 addresses a comment from Ondrej Mosnacek <omosnace@redhat.com>,
rewriting the sigkill rule to use testsuite_caller_domain and moving it
to a more appropriate location.

 policy/Makefile          | 6 ------
 policy/test_binder.te    | 3 ++-
 policy/test_fdreceive.te | 4 +++-
 policy/test_global.te    | 1 +
 policy/test_inherit.te   | 3 ++-
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 17bb80d..a43883f 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -223,16 +223,10 @@ build: $(TARGETS)
 
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
index 0078485..759353c 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -69,6 +69,7 @@ optional_policy(`
 
 # Needed for domains outside domain_type()
 dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure rlimitinh siginh };
+allow testsuite_caller_domain testsuite_domain:process sigkill;
 
 # keys test may trigger search AVCs for root's keys
 dontaudit testsuite_domain testsuite_caller_domain:key { search };
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

