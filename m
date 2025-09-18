Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B9221557
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204469; cv=none; b=TPZ8HSK8bqHaGSa2P10ClYwJxrZ/pEarr1SVn8G+RysgRifKyrs3OiOJ0l/Y4DQjIq24utSYSmInFllFlm7bbWCSKegRZDMus/SQMa12PKkPLLzP2p3eAFb3O+lik1RsTHdF4oZyJT9ugx4ddixdNplb3JwaiK006UpxSx56Tbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204469; c=relaxed/simple;
	bh=PW5pU3SEtjuE0eKcxZzb4+iRfAaTqBLJ3Ef0QdqPyLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKKL0pxyJqDqibM3Qs2WUpgahBh6+PT8vPvVJZ54gkMxV8/pGHhu+q6L+LpGTMC4Ng6EEMx2N9dhH0cuE9Qr6Rt6iuJffC02v5zHywgvyN8F12Fveg5LavCFjxqVrWu7s+nEKr6qpSxeaPCI+ftu2tPI0c3/1H6/+6pdmd71To0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDDZyalz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDDZyalz"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78ea15d3489so9689966d6.3
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204466; x=1758809266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeQoas8PqpBGb7ryjr8a1ErU10km1dJJT/SCC9Pi2eY=;
        b=iDDZyalzloq12R79TM6KvpZpbw0MSMqst3e3vNYTB6VxE4R1pHlY8e8NARpxM/SS3u
         jaP+PcwyASAsr7dHVwgNX5eyoItGM2m9Rk4XLlQ4701WKrsEXbo6E/pakP5cjAuHkfBi
         fUhxlAg8JWHJpXdJKnJLQI62XxHZFxwEg/YobR13solzfOM4vxugBqP2NKPFTIpbA+MD
         c3jMbeeJooE12t7va8HhKygcvRjrMk1YHVqawYeQoKcqz6wX1NeA1wJAb5zmIWkfrYHA
         JX/LcJc1SLcsbSeewfHnTfqR3Q1nR0dsiM04rA0Q4ZMzDn1BSlvVLZwqT1eaOg0Qhv7y
         +/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204466; x=1758809266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeQoas8PqpBGb7ryjr8a1ErU10km1dJJT/SCC9Pi2eY=;
        b=RJr6ou8FNoNswFfHSQvLogclS4ycszGvdLEGNjWvtsRN75p9BiLERYeULX7YXGXF4x
         ZO/cJfqUjSNEbDOKM3WxP2D2sssCwmEEUMs8DDjWNiJafYFXGXVjRoLqP0hFbdZnjJZR
         R5Ulhl+HFgArPwY72yfLLQ3F720BLmlzP4BbNZJR+wXs77lSSRAsAWEgrNvJHxEj/h+k
         0VKTnodcT/nMTeQHoxyTdQeqXnUgfPo/5CfvJ8YOKTk+Jq20VMkWjWZpWUgx39UNcH9a
         vXErLxpQfryU+UB6TK0xfN3BDeELu4gTN2xdAY8LNiZ9IuaWJHcxf0Mt+aKd3EWe09Mb
         LDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhh0l5Or1q5/q7pTPG1NiWyAi5fU1ZDn6nPHNZWQfFRc8wgkecMxJgX8sTavg2Ll+ekBx8gaNi@vger.kernel.org
X-Gm-Message-State: AOJu0YywDKvzb1dnYPHXctj5kNJKNhtIZn0tuQvGyAvlcpocjv7vXldu
	/SDnkjWvORgt2xQihLJC1GiUth2HFOWqgKbingnLoeMtaMbdmh23Bqrs
X-Gm-Gg: ASbGncszaQJvw8xiYzkadxyS4DDGus+ZMvpCvIsug8FBLopFP6nobu0ZS/fEh2VFyEq
	gVmXF7iyLUvsw1UGwyOuUzfQVObG/nLQWw1Kdm8x6Kky5+wzvTUIqaTa+02s2xDp4U5tN6EenJW
	TVOpJVzlBTEl+4jGv9N0pJJ2i+e3+/gIWQOk/5WNa8M1FuEcdkmfpdU7lT/d21qs4lSOkbgswC/
	pMo6pm56S6UIfpjwpniVUKxLDUF+aNOseSV4efLwhi7qXVYZGstEaPsE4S6dzCGVZmCCjGflSOD
	uniTOZDQ9mHCLYdGvnlMyuzPidKR6qvbnQ41qIvd5obtwCTXyjUvaU9dA0q6IbKWaybmL7KaYCC
	yu5JvyhmKwZ+qhkW9wZLXu2qxSJCwZjEYjwocvkrchFy41nCCyT0eTSHizDxx9pKlEdvNntq900
	Pvz3YGAv/ds3S58N1+SP4tccMXiGakxBUQ5mwUPYBXmqgR
X-Google-Smtp-Source: AGHT+IEZcqCaAlB8tDl4mwjmiNMogID/BslW1mNco0kIzZFTf7/53cEmy78iG0ikG4s6ab879K2XYQ==
X-Received: by 2002:ad4:5ca2:0:b0:781:d761:5468 with SMTP id 6a1803df08f44-78eceb32ef8mr82820096d6.39.1758204455245;
        Thu, 18 Sep 2025 07:07:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79347e50865sm13318066d6.33.2025.09.18.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:07:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	john.johansen@canonical.com,
	serge@hallyn.com,
	casey@schaufler-ca.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it up for SELinux
Date: Thu, 18 Sep 2025 09:59:05 -0400
Message-ID: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC-only, will ultimately split the LSM-only changes to their own
patch for submission. I have now tested this with the corresponding
selinux userspace change that you can find at
https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.work@gmail.com/
and also verified that my modified systemd-nspawn still works when
starting containers with their own SELinux namespace.

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
v2 fixes a typo (PROCESS->PROCESS2) and is now tested.

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
index f48483383d6e..1e34a16b7954 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6816,6 +6816,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 		break;
+	case LSM_ATTR_UNSHARE:
+		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS2,
+				     PROCESS2__UNSHARE_SELINUXNS, NULL);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 		break;
@@ -6927,6 +6931,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
2.50.1

