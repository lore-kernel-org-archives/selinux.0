Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588C1A08A3
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518890; cv=none; b=DIRAYohNin32pFZOp955pa9tudfLDNGh2V2p49lgBGQIUqX+Jq5YyTq19y8o5PX+Alj3ZXCdYC+VfyA0zKb1vb+NmlpW7UzbemPE2+dsJxWU33CKG7JDJMaaP9tor0mmTD+SRiljc3P6TDPx3wJEUwvXao3JazAEpq7NpsIltYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518890; c=relaxed/simple;
	bh=EFdIJeGwE/HxbHdg6X2dS0xI5dMV6fyvl6VuuespqMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvrqM42cyAf+yKKXtSepH2HZV9pntzgKUnASo/O5f/szbepKxDd/P6LDpNftMpmB8S3JSkvFCnpHB7Y89ZL9eZoVRTwBDd3w36OmBsJ9q6fOJEndQqx5yqm1G+lHkn5exHH0VgKF964GTvYq+pWBpmysu0HWxm9Lmd2RBY/mODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czgLgTsr; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czgLgTsr"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so28384066d6.1
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759518888; x=1760123688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBZ+fXn60zJmHzorFnAQZGMpYX9weZ7qaIhMEuD5a/E=;
        b=czgLgTsr781evwPSrayZ/HB9nruUqe3LePNYGXWLDBw9o9Efk8wAEgVc5/doakLguO
         qKt8Jf/3HcR8lA++iMgMFdnA0Wwni48xo9Xfpx0vvGWjfkwRpcmIWyWGtMX6DSz6dXJN
         s9BT2EEKk8epBAJKi8ENOhLpWDzPJn0B8/i0UNJZg7U9OlC/CLVR+RY4z2VInfc3bsnG
         2RkJ2SJpim9CTYgDgZPymwUJQ5ijErn7bRjiZIDVAgbKVvXnchLnzfWpD/6bol3SQZOp
         kMOGgZdTkVQlkaJxXi4jPAoNqCkNgRpSYj2Mha9Mek5kqY+XHYaTQCtnQSrkc39ev4zB
         /ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518888; x=1760123688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBZ+fXn60zJmHzorFnAQZGMpYX9weZ7qaIhMEuD5a/E=;
        b=e1k+r8t2qEa4gLagF9ZozT5WN7OuefFl2Vk1x6WsA8Ub0nzKpBNgNvlrsu6VNSEVnw
         0GW9oZpp6gPxaLgZgx09ivBOsn9AdrJRD+IBQjpcCwQk+lhHfHGKecTBXXRmWPOQai9V
         Rvxltb2hdISfkAkdJ9xpuDf9RrWYIy0niZc4MLCHYZG4+ib/OpPOyVFK/uvDi1FYv+Pe
         a8zNKWPfPywqIBpyYZU0Rdn6Jl1VCCYlfddGyPr05yJNl8StvOVqjLlLN08RjckCwqMP
         MdutOm47h9V6XoXgj6v+8vwyqC9rD+Y1pyK5ax+TOOyygPR1Ne5x+oYzDxDGR79cVctH
         RXPg==
X-Forwarded-Encrypted: i=1; AJvYcCVy2tA/9UphWimS047yKUD4zZTTUOxXAp0TgNEj0uuZHO6UC9k8uEb9tAXN1GR4nPWY5BT2hyRB@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/MxxPJjUFCpHnh37oHbXcfB5AedESkxzcOQqaFHYpEJNzoQY
	TRw8AiCgWSltHEiMBlO450OtUdkOLF4MEqJK+CVDuJP2q4Zzir1XGaoA
X-Gm-Gg: ASbGncvGAGKzge7IVDc6ot+jmrrAePgICGDuI8piZoFJpdFzOgzHarLjseesTdRHOYJ
	uWO19kaMsDJpP5Wy2wY+M/G7Fh1jkmXryxfbviiNBCifxDZcfDe6vez4bZHOZ2lt6IzX22RkdOT
	lLmXotY1rqaee3Ko9TFKc3NHJGQcdlhFRQNfINJmhSTB75acPo9cJzwLNmY6FslkDCuigtXPqIE
	ocbQAM4MPRHv2jSSEzcLOQJuS5tfzYGM8yhmwTYcHUkIMc9Oajo9qzj9T0cpe6yfHub2cnaR1bA
	Ib3ZRORBmyMgp/JNUru9Zf3G2puLOvZ99W6F6csL0WglVihd3U7VGh8DwzKug5UIJnrZQ9nXXj+
	MhOS+zvsvA+OtQqgTiUriCdPd3j5cRSYmKetU+B8FE/R2WChjoN6ujGIDbsmSwvF8K1GFK4IFWQ
	Tfmp/KsngQi2BSfeVMpI/4v4PXdz5XnMH3WY5YnYrsOYuJDugXT/10C9kd+G29Nu0OAm7vyuRLe
	24KbbViJhfT4g==
X-Google-Smtp-Source: AGHT+IFx4Jfwg6/X5cCyhYwQPBf1yxAZ6BmS05Uy97ML2M8LufGgh07cB2cAmOIgxbmhwT/DqHR0fA==
X-Received: by 2002:a05:6214:2344:b0:790:40cb:6df0 with SMTP id 6a1803df08f44-879dc482967mr61450166d6.34.1759518887507;
        Fri, 03 Oct 2025 12:14:47 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd783965sm45577996d6.40.2025.10.03.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:14:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	corbet@lwn.net,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: implement LSM_ATTR_UNSHARE
Date: Fri,  3 Oct 2025 15:13:28 -0400
Message-ID: <20251003191328.3605-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the recently defined LSM_ATTR_UNSHARE attribute for
the lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls for
SELinux.

lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) immediately unshares the
SELinux namespace of the current process just like an unshare(2)
system call would do for other Linux namespaces.

lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) sets ctx->ctx_len to 1 and
ctx->ctx[0] to 1 iff the SELinux namespace was unshared and has not
yet been fully initialized (i.e. no policy loaded yet); otherwise it
sets ctx->ctx_len to 1 and ctx->ctx[0] to 0.

Differences between this syscall interface and the selinuxfs interface
that need discussion before moving forward:

1. The syscall interface does not currently check any Linux capability
or DAC permissions, whereas the selinuxfs interface can only be set by
uid-0 or CAP_DAC_OVERRIDE processes (as a side effect of the fact that
it is done via the filesystem interface). We need to decide what if
any capability or DAC check should apply to this syscall interface and
if any, add the checks to either the LSM framework code or to the
SELinux hook function.

Pros: Checking a capability or DAC permissions prevents misuse of this
interface by unprivileged processes, particularly on systems with
policies that do not yet define any of the new SELinux permissions
introduced for controlling this operation. This is a potential concern
on Linux distributions that do not tightly coordinate kernel updates
with policy updates (or where users may choose to deploy upstream
kernels on their own), but not on Android.

Cons: Checking a capability or DAC permissions requires any process
that uses this facility to have the corresponding capability or
permissions, which might otherwise be unnecessary and create
additional risks. This is less likely if we use a capability already
required by container runtimes and similar components that might
leverage this facility for unsharing SELinux namespaces.

2. The syscall interface checks a new SELinux unshare_selinuxns
permission in the process2 class between the task SID and itself,
similar to other checks for setting process attributes. This means
that:
    allow domain self:process2 *; -or-
    allow domain self:process2 ~anything-other-than-unshare_selinuxns; -or-
    allow domain self:process2 unshare_selinuxns;
would allow a process to unshare its SELinux namespace.

The selinuxfs interface checks a new unshare permission in the
security class between the task SID and the security initial SID,
likewise similar to other checks for setting selinuxfs attributes.
This means that:
    allow domain security_t:security *; -or-
    allow domain security_t:security ~anything-other-than-unshare; -or-
    allow domain security_t:security unshare;
would allow a process to unshare its SELinux namespace.

Technically, the selinuxfs interface also currently requires open and
write access to the selinuxfs node; hence:
    allow domain security_t:file { open write };
is also required for the selinuxfs interface.

We need to decide what we want the SELinux check(s) to be for the
syscall and whether it should be more like the former (process
attributes) or more like the latter (security policy settings). Note
that the permission name itself is unimportant here and only differs
because it seemed less evident in the process2 class that we are
talking about a SELinux namespace otherwise.

Regardless, either form of allow rule can be prohibited in policies
via neverallow rules on systems that enforce their usage
(e.g. Android, not necessarily on Linux distributions).

3. The selinuxfs interface currently offers more functionality than
implemented here for the sycall interface, including:

a) the ability to read the selinuxfs node to see if your namespace has
ever been unshared. This is currently leveraged by a corresponding
patch for the selinux-testsuite to detect that we are running in a
child SELinux namespace and skip certain tests in that case. Currently
the lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) only returns 1 if the
namespace has been unshared and is not yet fully initialized for use
by e.g.  systemd to detect that it is running a child namespace and
should load a policy.

b) the abilities to get and set the maximum number of SELinux
namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
node). These could be left in selinuxfs or migrated to some other LSM
management APIs since they are global in scope, not per-process
attributes.

Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 24 ++++++++++++++++++++++++
 security/selinux/include/classmap.h |  4 +++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f48483383d6e..3be0b6a51313 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6756,6 +6756,18 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	case LSM_ATTR_SOCKCREATE:
 		sid = tsec->sockcreate_sid;
 		break;
+#ifdef CONFIG_SECURITY_SELINUX_NS
+	case LSM_ATTR_UNSHARE:
+		*value = kmalloc(1, GFP_KERNEL);
+		if (!(*value)) {
+			error = -ENOMEM;
+			goto err_unlock;
+		}
+		**value = !!(tsec->state != init_selinux_state &&
+			     !selinux_initialized(tsec->state));
+		error = 1;
+		goto err_unlock;
+#endif
 	default:
 		error = -EOPNOTSUPP;
 		goto err_unlock;
@@ -6816,6 +6828,12 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 		break;
+#ifdef CONFIG_SECURITY_SELINUX_NS
+	case LSM_ATTR_UNSHARE:
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS2,
+				     PROCESS2__UNSHARE_SELINUXNS, NULL);
+		break;
+#endif
 	default:
 		error = -EOPNOTSUPP;
 		break;
@@ -6927,6 +6945,12 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		}
 
 		tsec->sid = sid;
+#ifdef CONFIG_SECURITY_SELINUX_NS
+	} else if (attr == LSM_ATTR_UNSHARE) {
+		error = selinux_state_create(new);
+		if (error)
+			goto abort_change;
+#endif
 	} else {
 		error = -EINVAL;
 		goto abort_change;
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index be52ebb6b94a..07fe316308cd 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] = {
 	    "siginh",	    "setrlimit",     "rlimitinh",   "dyntransition",
 	    "setcurrent",   "execmem",	     "execstack",   "execheap",
 	    "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
-	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
+	{ "process2",
+	  { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
+	    NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
 	    "module_request", "module_load", "firmware_load",
-- 
2.51.0

