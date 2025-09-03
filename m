Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBF1624C0;
	Wed,  3 Sep 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927731; cv=none; b=ERiefEVcVvaowBJhSbOly4Mt1ogvgEeQdVXJ/8/H6vXzMsbMe/xOB64+bW+glDoAKqKVuizxYqwVEhVWuEg7vgjkMEirRVSWIwqq+qtFxNDqSzE4XNevzumSBX0KI6bd11lJ/JzkPTHhTnHS2evG5z7PJUuErGWuMmg41r8AcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927731; c=relaxed/simple;
	bh=LnxooHGGnFvb25CXrFU4GtdZtT8rLYXVQKEaSL6QZrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oV5kitC1uya/lRlUjpKyprO1WMX6+/Hz+fb5oU7zqj+SAagwOFMUsp66FfC/cKWwF8aEq8zmp/jh2fgZHLn3YCCVXULLH/jx4uzhhys7EgSXjpD+DcTLGSQZ1/o+uKlWaHIdjTJL2z94gODTFFkjgMiUqaFPMAAlY8vWYF39CIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx7MtI3W; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx7MtI3W"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80e2c527010so10276785a.1;
        Wed, 03 Sep 2025 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927728; x=1757532528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpDeAr1QBcc2u/Mv7c11WaNYMQZEsUjqbXZP6iV3zNc=;
        b=Jx7MtI3WB9wJoVZUwbjhWQyXEZmDZQlnGVbBykAyuSTkuvsS9AArx57/+jutLWGFzL
         AEl4oUM0yjugLuHIXNPDZygyXW3QlaCvw7E7FXA9jedM5kazrY2lxGiFGHpzlgNrtDqN
         BFN4SXQtoGTltTEP+UXyAiCEMcVCppB0pdk7hBk/AgJ+QxT+d+uaZib0BK3GIkCe3/9n
         3FTOvJtEtCA32sisWVebeTqU7ZbC213dfNMa7JhPv9iIkb1SJ/htiMxHpowibkzTHE6g
         iksBjHm0JKKJG0oflisHEdgnvTqhaIEgw8wURcLqlYKnSTcCHOUSLT90ZWgtK8YhtKCm
         trVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927728; x=1757532528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpDeAr1QBcc2u/Mv7c11WaNYMQZEsUjqbXZP6iV3zNc=;
        b=JmWOPW1cMEGBLOaj22kxyXDqm+dBSBaozR7F29Qq092zWKxmUQnRRHeF7f+LigSST5
         u5HeetK5S2Tycr+9KQeBrOQQgjw/lb79//VwWpNIAKZhkUYozC7Gu8GJVgdlQa8+Iz+E
         NBddPBO7iobq4v2ljEHc09AcLXv5JRjbOcjM4uKN7FLOvi7E+Y8LclcJ5w4vNm6EbVlt
         SqttrnFsmSncfz+22hAnCZ6IA0cm/8fVKjyW0B47oXjOYe7EhnGsnsKWy0fDmbp/sudk
         Gl79mAxbR23gsze3M0dHkRgHTmGfFGAvXkT6XoyBKKSkcDl0Dvi6tBrB8tQiNJ7rA1ns
         yUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXU/nor0Y7RUh4dKiKF9WKxhKufHuIR4yYvS646oZsq+kWkGWHlI6Ssdb4rI7KthBlPNByleMSmrRev2x1X6KT00RK+VRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5b5aWMXF9toW1Ilv2cxDbrOUrKxR4QS5zcwSKL/Dw/u7xfrw
	186kjFyvH+PVzGO/8ZgmDcKSnKI/EUrdtV55FAZcBTuo15GGbHK1b7+DiISq9A==
X-Gm-Gg: ASbGnctrL0dfNA9lMLZ5JgCaztm+oKiSFHBgmTyrTWo5bmSrzaN9P6l6HdCd6dSSs1v
	+EciqWOYe/wRob4H9JEDWg9qtabF3lqmsyj+y+F2cE4EnYQgUF7lRpAwCKk6OgL0tLVpB42E06o
	YMePm4R2PVBzViLJlyIp0ysLIWr0rEzgQ/YbvtkHLYJFoIk4HD6T2S56g0wGLPXoJbCPIhAR7fS
	rliDsmrrFtwn3Ma9Tp27Bem2Qn1g+5eVFlhsXKdvmT9cgTU06+Xzl6W8Rekf9KtPgJRU6UUw9sc
	HqxdSpP+Vn29aiApbwQSSW6ziSFRzCOHj8AnVVTxmdobwHxjIUHu1MRHx6wuwZjab07fjlsuhHv
	8RF0WMpfb87UIM8LEJP5H09Uz3mh232Ohc9aVcuYqHLc/s6ju8l+2KJsaUDULBq2YSypZIst8dS
	4nxiaBmm8bAbxTz3v7R0yX73k5gGeXbVbj3UeimYym/mI97MkGT6E=
X-Google-Smtp-Source: AGHT+IEnRJqmnLkGkwD4X6t83BnUx8xtb3ojh1GEf/xswxTesSSmWCVsfAaanHyta1xFr9jwnsBh4g==
X-Received: by 2002:a05:620a:3704:b0:7fa:aea2:24f8 with SMTP id af79cd13be357-7ff27b2249fmr2040694885a.23.1756927728242;
        Wed, 03 Sep 2025 12:28:48 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa62c789esm157146485a.11.2025.09.03.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:28:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	john.johansen@canonical.com,
	serge@hallyn.com,
	casey@schaufler-ca.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it up for SELinux
Date: Wed,  3 Sep 2025 15:24:26 -0400
Message-ID: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the hopes of nudging the conversation in [1] in a more focused
direction with a goal of getting SELinux namespaces upstreamed, this
RFC provides a starting point for a concrete discussion. This is RFC
only and has only been build-tested thus far.

This defines a new LSM_ATTR_UNSHARE attribute for the
lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
the underlying function for unsharing the SELinux namespace. As with
the selinuxfs interface, this immediately unshares the SELinux
namespace of the current process just like an unshare(2) system call
would do for other namespaces. I have not yet explored the
alternatives of deferring the unshare to the next unshare(2),
clone(2), or execve(2) call and would want to first confirm that doing
so does not introduce any issues in the kernel or make it harder to
integrate with existing container runtimes.

Differences between this syscall interface and the selinuxfs interface
that need discussion before moving forward:

1. The syscall interface does not currently check any Linux capability
or DAC permissions, whereas the selinuxfs interface can only be set by
uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
capability or DAC check should apply to this syscall interface and if
any, add the checks to either the LSM framework code or to the SELinux
hook function.

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

3. The selinuxfs interface currently offers more functionality than I
have implemented here for the sycall interface, including:

a) the ability to read the selinuxfs node to see if your namespace has
been unshared, which should be easily implementable via
lsm_get_self_attr(2).  However, questions remain as to when that
should return 1 versus 0 (currently returns 1 whenever your namespace
is NOT the initial SELinux namespace, useful for the testsuite to
detect it is in a child, but could instead be reset to 0 by a
subsequent policy load to indicate completion of the setup of the
namespace, thus hiding from child processes that they are in a child
namespace once its policy has been loaded).

b) the abilities to get and set the maximum number of SELinux
namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
node). These could be left in selinuxfs or migrated to some other LSM
management APIs since they are global in scope, not per-process
attributes.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 include/uapi/linux/lsm.h            | 1 +
 security/selinux/hooks.c            | 8 ++++++++
 security/selinux/include/classmap.h | 4 +++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..fb1b4a8aa639 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -83,6 +83,7 @@ struct lsm_ctx {
 #define LSM_ATTR_KEYCREATE	103
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
+#define LSM_ATTR_UNSHARE	106
 
 /*
  * LSM_FLAG_XXX definitions identify special handling instructions
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c544b3e2fd5c..11b0b3c5b74a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6812,6 +6812,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 		break;
+	case LSM_ATTR_UNSHARE:
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS2__UNSHARE_SELINUXNS, NULL);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 		break;
@@ -6923,6 +6927,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		}
 
 		tsec->sid = sid;
+	} else if (attr == LSM_ATTR_UNSHARE) {
+		error = selinux_state_create(new);
+		if (error)
+			goto abort_change;
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

