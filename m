Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9C1BD508
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942196; cv=none; b=K7qUiKea6df3yJOXmMcGA4JKlz9Vq/EzhvB4fbXmLo425wxCzoUj1/9gp21CGFAC87Auc3EofHAgVQICfillMkjAnQiwhOA3aP22QHImHpvX6bjcO3kmcK9jlQVH594z/tX/EhBzSxujMV3EDoR78zPD6OeESpjlAB77SoxNXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942196; c=relaxed/simple;
	bh=Zs5RtfaX+Mr03PHFB3vLsqCQK8jZPid7gvY6zuq3EK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC5uf5gAy9l1ikGjokHrQbFdgfL3G8A05Sn6VUHsbq3gqkCGMqJN390c3cC75t4PKLmapCsG0DGsc0dzjc1x4795+/RH6Kz3fkrUSbCAkDkmwoVm4R2W+vYGKznY7hCDvTjo5eTjqDV+QiY+1atXnW4vw4iWfW1WcBCpSgVebzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Eixq4JwX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Eixq4JwX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7yp73895MB08TReEH0j7Ox3CGe9oI3eZVz16p8vcCg=;
	b=Eixq4JwXAG7ZdB5xeCEaG1Pr09IYpFNgfTHC71UosntOu/VFAziItGPBz96Ki9pGYiE1+T
	foJVt0Ga7p4HgW0rujpnaCVsSHZsItjChB5mDO44ySkdO2uZ+Yad5XOshXqadMYs9NZhzo
	6oWjUrdmv/6a347tEeHDLQHu+r/HAdqBqv0ZzmnGOQetlUtjdb+sZedIQ0InSJBPiwpkrv
	ntMMbseeMh9G58vYR0vIj5i2vidtT2qTDeNj/7VLebm9UFmIR2maUWfAmdICT56pNxMety
	P1cHhuWNVsuo1XqsUzF8QNl47ugZ6uFp2nLGf6Hu3+8gI8R4OrNjU9ntBWJRBg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/17] tests: enable strictness for perl scripts
Date: Mon, 18 Nov 2024 16:02:27 +0100
Message-ID: <20241118150256.135432-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/loop.pl        |  9 ++++++---
 tests/nfsruntests.pl |  6 +++++-
 tests/runtests.pl    | 16 ++++++++++------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tests/loop.pl b/tests/loop.pl
index f5bf6ba..2c97b77 100644
--- a/tests/loop.pl
+++ b/tests/loop.pl
@@ -1,12 +1,15 @@
 #!/usr/bin/perl
 
-$count = shift || 1;
+use strict;
+use warnings;
+
+my $count = shift || 1;
 
 print "Running all tests $count times\n";
 
-for ( $i = 0 ; $i < $count ; $i++ ) {
+for ( my $i = 0 ; $i < $count ; $i++ ) {
     print "$i: ";
-    $foo = `./runtests.pl`;
+    my $foo = `./runtests.pl`;
     if ( $foo =~ m|All tests successful.\n| ) {
         print $';
     }
diff --git a/tests/nfsruntests.pl b/tests/nfsruntests.pl
index c3f0626..fa4e23a 100755
--- a/tests/nfsruntests.pl
+++ b/tests/nfsruntests.pl
@@ -1,5 +1,9 @@
 #!/usr/bin/perl
+
+use strict;
+use warnings;
+
 use Test::Harness;
 
-@test = "$ARGV[0]";
+my @test = "$ARGV[0]";
 runtests(@test);
diff --git a/tests/runtests.pl b/tests/runtests.pl
index a2ed7ea..7654a82 100755
--- a/tests/runtests.pl
+++ b/tests/runtests.pl
@@ -1,20 +1,24 @@
 #!/usr/bin/perl
 
+use strict;
+use warnings;
+
 use Test::Harness;
 
-@dirs = split( / /, $ENV{SUBDIRS} );
+my @dirs    = split( / /, $ENV{SUBDIRS} );
+my @scripts = ();
 
 for (@dirs) {
     push @scripts, "$_/test";
 }
 
-$output = `id`;
+my $output = `id`;
 $output =~ /uid=\d+\((\w+)\).*context=(\w+):(\w+):(\w+)/
   || die("Can't determine user's id\n");
-$unixuser = $1;
-$user     = $2;
-$role     = $3;
-$type     = $4;
+my $unixuser = $1;
+my $user     = $2;
+my $role     = $3;
+my $type     = $4;
 
 print "Running as user $unixuser with context $2:$3:$4\n\n";
 
-- 
2.45.2

