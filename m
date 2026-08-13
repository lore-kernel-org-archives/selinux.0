Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED63AA9F4
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651214; cv=none; b=FAsWAqdWLMw1UOz1TuYLVLsGnfJJunz0gzPIZvp3lWVC7JJot754WZTFvHTFNnB8nxra9Jllr4KFgdg3RPVcY0T/3RG1eFfyEwkvdeBJWIbgnxFT3JYTqhrXee6bpqVwNCioigBdqFbGuRRxlyaYIGj4zwOS/6qC7+nqD6X+9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651214; c=relaxed/simple;
	bh=g8ne5rO/lMybZr3qaMBgIYJGPJKmoC8oluZLVM4rTZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO9o2Fg+6/zNxlazlwxS1DIEljyaTioI7xWVetC513pxyYkQEIRUVeeLzAYnfZjsENdLmWpjYliw5KYGYAdauEbr0qEotC9K5eUnaEfDvT70kBkiUiciG76juPAKOOaCz39ng0anbY1f/kDvGMN1si0nFoV7ITHNx97JbEcdcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRqRhmjA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRqRhmjA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c5382806fso3047241cf.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651212; x=1787256012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSh8BNbKyyS3uYS93ZN7qk9VYl2VhZIhum85GstKrOA=;
        b=qRqRhmjAymg/tChaoya8J0Ui324B+M/8c+Hhp7bt/IGuePUNQMAqkI8j3aEZ52VQMw
         HDwrOnXYirGaL638bliLeszqysZWzYlAzeiYTl4ka1+VHIx6rLICNLyYRhST7jLTA4UM
         yjmwX/QapjYnGVvnpZ2E/RVHTpjjQGOwCUVkO9Ci6WGb0liAh5B+tjsXD9gvUqg5V1Z9
         1pvf9DBVG2Orb3SR+TrnxIK5TFUNZat8pUi5YWbhAICw9I6V1L7lulxsv4TXR8q1r19E
         VfWAPtpYLuGp1AwPk0wXaD0zBU9bO2klHOfmRBhaBXm/8FGcGn1Z1zcBvd9ho8Z94G/p
         jz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651212; x=1787256012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSh8BNbKyyS3uYS93ZN7qk9VYl2VhZIhum85GstKrOA=;
        b=GtvqXOPk1KwuBv9cAMu+VLEZS8vFMQ3K/qmfxmGuAZOQJ+Hru4z1Dq549VVwlru9vb
         v70sArXyH0r7cI8Q9hSi1HtJCxRS1cyElZ8H4qLg5PRq3W3n1Sbn9zjmrqmyUZhJfvKk
         sHYEBZMiWfEpj813Cr1JDrn2AJ3WTcOiJISwwqZpf7R6L5oAIZrfTjylqNgBj32ludGt
         yCi/RzIY2yORZ7ZC9TIR7l8YfCQ+iC/TRPszzHLAGjIQb9o/p/sFCR1o7vrwp5MTCOWG
         s+zvZ+PycJgGvy1pwM3R77C56p9B9CPA6RoT4l8tzsefX1rP44hwx70sCbOnsaj6Tf55
         5TBA==
X-Gm-Message-State: AOJu0YzSkGQJPoCv1IRSdLna95CDglXL96anA6+aBvefNrL/qLUtQDm9
	j/NLq06mI8onGsdJV3IrXyM6nb7eL5CYbmim10TPMY6UjhP8Q+DRvDEC7/3lhA==
X-Gm-Gg: AR+sD13Lsg4zcoILBee0rC0/pH6hWUjvr5uB6MS/vc1Ch/Q6vi9uBEufhrMcuYtO2VM
	5fnenH4brQokFSTCngPt1rWo0xRpiS7gmNI060E1YJpkXZwxcFmai7dIVGNsrGHm8DmoldWBjjY
	sFjmo4+ZXHmThbmfiI3txV2K6NzUm51UsfzVCHB6jbfP0hHNCkD5brv4/cFA3HBf0xQNJEpJ4eG
	J4CM3I7S8VhLBAmYDbkYj5+MzdSw95ihsT0ewN5ql0ExxK1teszNrJPJooSdGI6t0VREECWSjFp
	fMcjIdzYSpe7+ogdFH5JtzWr5W5HzZTSUISIoDYfKfgtN3tocNff9JtVVJIcEKF21ezNlxKIJvF
	iUAUrthH/afaGJG0yTmtMRmDQ0Y5aAM9fPUsXrJcIqi76CW9p2L0DL1IMWWHhbXeyDmgvPuAtLy
	6PQaCZbN3dRLxaCJ86tMZ3hmiHevxd2qDitKZFECI/Nqm8uJTJhw6/jTEq34YA7RBujp9oTxush
	+r/AYmSWnXrZU72d+4+RQYcCHKPMMLLQDkl94+gTFoSNXVekfDpUObxHM0SumTeYtSsz9k5BGa5
	mJf0
X-Received: by 2002:ac8:5856:0:b0:527:edca:8761 with SMTP id d75a77b69052e-52d853b7d15mr6465881cf.19.1786651211712;
        Thu, 13 Aug 2026 13:00:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d840e1749sm3830031cf.28.2026.08.13.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:00:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] README.md: Further elaboration on minimum policy versions
Date: Thu, 13 Aug 2026 15:59:56 -0400
Message-ID: <20260813195956.197456-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide further elaboration on minimum policy versions and
considerations when updating them.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 59 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/README.md b/README.md
index bfd32b89..a2427bb4 100644
--- a/README.md
+++ b/README.md
@@ -25,8 +25,9 @@ for more information.
 
 Minimum Supported Kernel Version
 --------------------------------
-Linux v3.0 (for /sys/fs/selinux mount point directory) for libselinux
-and anything that uses libselinux to access selinuxfs.
+The minimum supported kernel version is Linux v3.0 (for the
+/sys/fs/selinux mount point directory) for libselinux and anything
+that uses libselinux to access selinuxfs.
 
 Note that the policy build toolchain (e.g. libsepol, checkpolicy,
 checkmodule, secilc, semodule_package/expand/link) does not link with
@@ -35,18 +36,56 @@ Linux kernel version. The policy build toolchain has in the past
 successfully been built and run on non-Linux platforms as well
 (e.g. macOS), although this is not officially supported.
 
-Minimum Supported Policy Version
---------------------------------
-Kernel policy version 24 (boundary) for the SELinux and Xen
-targets. Support for this policy version first shipped in libsepol
+Minimum Supported Policy Versions
+---------------------------------
+The minimum kernel policy version is 24 (boundary) for the SELinux and
+Xen targets. Support for this policy version first shipped in libsepol
 2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
 4.0.0. libsepol dropped support for kernel policy versions older than
 24 starting with libsepol 3.12.
 
-Modular policy version 10 (boundary alias). Support for this modular
-policy version first shipped in libsepol 2.0.35 (userspace release
-20090403). libsepol dropped support for modular policies older than 10
-starting with libsepol 3.12
+The minimum modular policy version is 10 (boundary alias). Support for
+this modular policy version first shipped in libsepol 2.0.35
+(userspace release 20090403). libsepol dropped support for modular
+policies older than 10 starting with libsepol 3.12
+
+These minimum policy versions in libsepol affect:
+1. The policy build toolchain. For example, checkpolicy, checkmodule,
+and secilc cannot generate a policy with a version less than the
+minimum.
+2. libselinux and its users. For example, libselinux cannot downgrade a
+policy file to a version less than the minimum, and libsemanage cannot
+read a binary policy module that was compiled with a version less than
+the minimum.
+3. SELinux policy analysis tools. For example, setools cannot read a
+policy with a version less the minimum.
+4. The Xen hypervisor, which compiles its XSM/Flask policies using
+checkpolicy, and only currently supports kernel policy versions 24 and
+30 for the Xen target. Xen does not use binary policy modules so it is
+unaffected by changes to the minimum modular policy version.
+5. Android, which has remained on kernel policy version 30 since
+moving to it since it has not needed any of the newer policy version
+features yet. Android does not use binary policy modules so it is
+unaffected by changes to the minimum modular policy version.
+
+Increasing the minimum kernel policy version for libsepol therefore
+prevents generating, loading, or analyzing policies for Linux kernels
+or Xen hypervisors that only support a kernel policy version lower
+than the new minimum. The minimum kernel policy version should only
+be increased when there are no still-supported versions of the Linux
+kernel and Xen hypervisor that require a lower kernel policy version.
+
+Increasing the minimum modular policy version for libsepol prevents
+generating binary modules for distribution releases that only support
+a modular policy version lower than the new minimum, and also prevents
+reading and hence using binary modules that were built with a version
+lower than the new minimum. This could affect modules originally built
+under an older release and carried forward through system upgrades.
+The minimum modular policy version should only be increased when there
+are no still-supported Linux distributions that require a lower
+modular policy version _and_ any binary modules carried forward
+through system upgrades can reasonably be assumed to have required a
+rebuild anyway due to major changes to the system policy headers.
 
 Installation
 ------------
-- 
2.55.0

