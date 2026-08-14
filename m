Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7346E005
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711486; cv=none; b=Veg8Z9HIJblipK3R7lsAZOuVit/TnmGpcC9b2GdeURmIF/ETf6+idqFxbcXR0eb8owwvcjjTKDayAgVt9QiZYkMWilOY5bBUs6nucHmIodzyfFTpI8/r7e2fQQiCuMTgIoCWfyhTjhcPwAO5mw8kaJ6E+EgUEfD5aVx+9zTichg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711486; c=relaxed/simple;
	bh=YkO25xXa/BmBv7moCijKmzl/RIBMzaq9ZMfTGtuXWdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dro0a/HhbILFGscV8dS59xUGUfA5SqTKSVkkxgzqQgU33Q5j8JNiWDEQl6ut4V99AK33wgiAnlrv5A60GZe/v7v01LhvnOaSqoC27MwcJydjhsB42a28guk40qhtIPuTb9RrmWjQTmth4H7Mpi1mEtesF4CSZ3QrWCEyKboytpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEPrzaoA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEPrzaoA"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52d590ce5cdso8413611cf.1
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711480; x=1787316280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVoDeTLhzFTtSW0Vo3EWmiqKUCstv0B71QL1AShHSt8=;
        b=TEPrzaoA8i65/e4DdWqJLPvJlI8trmRphNDdex/ez2DR+gfl2CXwExv+CBzLgcLhTn
         h34MTz8nWYPxAdKZbrQWz0RAZfJFUMXO7T+syVnx7AhFslfQWUQEaUrkqWjkl7h6gg18
         7ymy8u2Oj7q2CRAggGsk7z/0SQiBKpQnm5K/ee1Wcm6wHo/TnqUhg2fFSkvI7sVH0NOS
         YpsJMeRk9cSOQzXE8HH2h3XIpWxQZfqCffNZJdxaQgVgSwe5ZuIqXG4axGmdDodGeJqC
         YlFqOvPpLH49D+Hste0v6NojGhvxCUw/s8x56YvmibA1oW1y3H/6lrWeCZMa7Jwqv6XU
         YjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711480; x=1787316280;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVoDeTLhzFTtSW0Vo3EWmiqKUCstv0B71QL1AShHSt8=;
        b=P6vBcr1Z7dicQC4A5EMHqtbhbxqipXVgYT1Ays28NV5RQzk2MuXLqyI4d+2oxQKy8x
         vOIweI09+GxRDnlbgYauVf8K2sXR0lzfxCaNfRmGcMaKh39zn7LHyUmInYC99f2men/P
         kxL1H1Lkb5NQhoZ3bZkzyeLnypp/41NwPYJmhCGWMKZUqjLnRoiW0n5O82/x6UjWn8cz
         ZtJXnWmiEeToalZ2FtQcJ3pHDfAHr7SiULx+XoZEhkhQCpxztGmAtQ5Fi9KqhkVE31qK
         XkBTXwnozkEMifDOY/NGii4l75uaElWdevl9JcxJOaMymARjW12udoPCpxYttgChItVh
         L4kA==
X-Gm-Message-State: AOJu0YylGMksWPcl1/2zQpF6JEiSW0IMjfX1pNC0NEanhTJovjVs1J9M
	if7dC242AJ3a2ecNFkNwGqUADo4oyzdcAeHNizwFAj89O5NYJsW2kyzQQTKcHg==
X-Gm-Gg: AR+sD1248ON4pkbhY6S1uXcCehJIXz53FgyXnGKusMfq4RgLA4wes+OG5A6jD/Pjw/B
	gThq+H2F9onmHjpONuPpUn6YAdeF++oub1XTdEvjBlxphpolyaFyGrCjcg4kjorXvFVhCouhnMV
	zDgiVniQ3QkUIWNCgthYvYK91Cj/64VS9IyLkamTD05y0i79WuRlAljrWLAJ7d3sMWfL0Nmh5va
	V7AgDx+REOGFN4Yg+VWDVP1dg87rT3D8I9kPbrTVBwd40w3CAjrb09i6Q3pn85kt4gyUanbvoiV
	NYbEprOOpHYc6+BzwOYUFy1oSnAPjbWrc9I53Bkj9lEyg8QI+BC/ln8RHB510Q/EfN8+/eye5eQ
	p5jHBYdxoTEBF1/a1ZSjpm+I2t9bFc3g1sLsHT3zKzGUuPX+THsP0ciVqYYMi992ubvR7UDIB3K
	nubqDGtb1HZbROFZYIM76av+eiKbZ0JJaiO6u2Kf92nHDGz7vWst373vK32qUsfKZJlhKzYAAHc
	jG6x6fpC4b7OxzmawcKRYyiOWFf8+RrZ2ioOyJ/IetKGG6Pg5IJbSH9SKPB46BXz1MXeZqlfdA=
X-Received: by 2002:a05:622a:a1a:b0:52b:4c5a:5844 with SMTP id d75a77b69052e-52d85420e07mr65401751cf.20.1786711480141;
        Fri, 14 Aug 2026 05:44:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d840e1749sm21032901cf.28.2026.08.14.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:44:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>
Subject: [PATCH v2] README.md: Further elaboration on minimum policy versions
Date: Fri, 14 Aug 2026 08:44:25 -0400
Message-ID: <20260814124425.202855-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Provide further elaboration on minimum policy versions and
considerations when updating them.

Acked-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 59 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/README.md b/README.md
index bfd32b89..3069e1a5 100644
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
+5. Android, which is on kernel policy version 30. There has not been
+any need for newer policy version features yet. Android does not use
+binary policy modules so it is unaffected by changes to the minimum
+modular policy version.
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

