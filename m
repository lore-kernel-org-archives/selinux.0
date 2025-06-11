Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE02750ED
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668754; cv=none; b=DV5GIkr+jyeEjFau33za/Xu+r6GgLFEzytlgEhVxkh0YQhKMMR00yedgczRQUuElHK72/IWOLv0OHEwnH09e1NHOGvzhguKWRMIRB6DiZBlXkG5vcI6REYERo34O1ur0dqAUHKczHgHwNhdQuCjVaYiR39f89X058BH1JW7m48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668754; c=relaxed/simple;
	bh=NYXxZTZyTmzTg2t2PUZscl5DYp3j0TMEa51/b2Xf3KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+R8telHRLUOF4ipfm2cOPlHVobiaMgBMNj+Apy6iAQa2kLVoqsKAlYbA6uHb/cp5PZxLQp1Dzf7vgx2UUYzhZXErE/+58X/sXrmLWD+SPSW1HjHHQyRyqtVwdxIwIFphH051WWyjBRFyy9LlNcBGnxKozgi9KRZ5frcvsGeAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXmTyYYN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXmTyYYN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fafdd322d3so2622806d6.3
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749668752; x=1750273552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2ACJ6IAfElGizc0AzCkLv4DEwWyP2X1hy67tYo/wUs=;
        b=nXmTyYYNg61webJE5/RAkBa3AznYP8JFXqntZD7DEjAlikcyF1EJCJwGm89ZWFSQOl
         Hv+SRFe7b7PbkLe6E5akUKZI9GU58QvzF78eAcOQtlRzdqshVGXIzYxEFEqNU55LuMzO
         We4e+2EfxzVFNAAN6LHZ2zQFEfTOLIWW0wlfp+lGwYqdGqKsnNmE2DNYlfzuJOxrIKGb
         JFKFQZCxSFJgEV+OVQmbDqTtvfXiPyGiY+Sf31OJfTTVfV7ILq07/1TN1LBoNER6JTlj
         dt35W3vYurpPm3gCQO3u7dLZfZ2hnw+CxAjgel4Wo1dT5hF0OKPdXHTY1lrlmXrvOWQw
         8/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749668752; x=1750273552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2ACJ6IAfElGizc0AzCkLv4DEwWyP2X1hy67tYo/wUs=;
        b=X3A2mcDMrKzWwP7UtICHlELt6niGH2FsEcya/ILS1I+swInAImL430tuQMLXOm7cB1
         88tErsFAN/bkiWpDy44jXkFKt8eCOZRNPUiILcY7LnTwfyc2ReR0Rx63N0Ioc5jfPGkR
         rQInhwdIPGnAxD753kDIOR6mE9C1Dm1BhpPMo9ule3+0H4pahP8hKVV+KvX6RB/iau45
         hMES6RvvKRzwiMY3VNH995ROR5a6Y2e2tieqGbR9O+Z+mjaCE/LnS56+QXTSobwW5z54
         9C26wamfrYShRZeydhJ0BCLnnn4YwfZqQ835mVwLIYg4xXiGSanuy0ko/i6MKhTPz7Sa
         5ozA==
X-Gm-Message-State: AOJu0YxD7V0cEm2KLRT/Tosouly937sBo4wMXjeOySaQ5eVpx18l1GHU
	etALO9T4OSGbHsqtJ1xKp+qIOG5k5do0z24YuPqzza4yCsLs7piUvXIoNX3kGg==
X-Gm-Gg: ASbGnctv9YP3CoFXggmXDG9/fE9fLUvWnx63CrY5DYlNMky9TeyfZtz/g0Hsyuc0Dzl
	rrdWPpK01ki2Fo2zXqRBj7oKCrSpQYCMbqg3j2OEd4bS0w0ChYdd9OX/a4aJ1TJrAQCbj6XDKFD
	oeXjVcX87BDbbcJMjfX7bczRAUi5gzrO8YEsgSU84P8Nds7AI7ZfLLDKFXP9goxrh9i67HdcjE0
	guHbpqbtbQ7jQ5+8uedUc6/czx7FmbqXjOU1pSSDE6PzzrfSBcotz9V/urwPhC1YKokHxKxJGWt
	SAfcWQNScTwNMQcG0aHl2xtCIy8UYsnr/JstLVu2FFjQpswrPFP8ZcZ6ccuvqs+1FRuMbAiJkAs
	kfEERvoYNv4v1HH61FQ+S6ukvF8zyczufLkvFqsLTfQG6s0gm3Aq8NACZSHPpE8Npx5qwJodPn9
	lkdPskGPknZ7rWYuE=
X-Google-Smtp-Source: AGHT+IFuvfoyhxBiLMBHk4aF4rE+keG0pZWlszewJZDdQyPAUuH+jEWd42ixKjJg+eswgwxfp/GdtQ==
X-Received: by 2002:a05:6214:21ee:b0:6fa:faf7:7545 with SMTP id 6a1803df08f44-6fb34ea055emr6086926d6.31.1749668751966;
        Wed, 11 Jun 2025 12:05:51 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b36647sm85337456d6.113.2025.06.11.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:05:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/mac_admin: disable test of getting undefined label on nfs
Date: Wed, 11 Jun 2025 15:05:12 -0400
Message-ID: <20250611190512.23743-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already had a workaround in the test script to expect a different
result on NFS to the unique aspects of labeled NFS, but this
workaround won't work when/if SELinux namespaces are enabled
(due to the introduction of the global SID table and its
correct preservation of the original context value) and was
really only papering over the lack of support. Just disable
this particular test when run on NFS filesystems.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/mac_admin/test | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/mac_admin/test b/tests/mac_admin/test
index 32161f3..8390d06 100755
--- a/tests/mac_admin/test
+++ b/tests/mac_admin/test
@@ -7,8 +7,11 @@ BEGIN {
     $basedir =~ s|(.*)/[^/]*|$1|;
 
     $isnfs = `stat -f --print %T $basedir`;
-
-    plan tests => 8;
+    if ( $isnfs ne "nfs" ) {
+	plan tests => 8;
+    } else {
+	plan tests => 7;
+    }
 }
 
 # Verify that test_mac_admin_t can relabel a file to an undefined context.
@@ -38,14 +41,11 @@ $result = system(
 );
 ok( $result, 0 );    # we expect this to succeed.
 
-# Verify that test_mac_admin_t sees the undefined label value.
-$result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
-chomp($result);
 if ( $isnfs ne "nfs" ) {
-    ok( $result, "UNDEFINED" );
-}
-else {
-    ok( $result, "unlabeled_t" );
+	# Verify that test_mac_admin_t sees the undefined label value.
+	$result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+	chomp($result);
+        ok( $result, "UNDEFINED" );
 }
 
 # Verify that test_no_mac_admin_t sees the unlabeled context.
-- 
2.49.0

