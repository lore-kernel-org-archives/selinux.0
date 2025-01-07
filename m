Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C18C1E
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257975; cv=none; b=GV6JCibKwrpG77Z7uAnlX8XFnXEEfvwh2SoZJhUHHzZyGmT1fN8FwXrmhuV/Eymn/PKKW3D0vlwdZ00qNjbO5/kqRCsBWK4hvck/R9wlUZ1VVcVhk7kLYRmAVspIJsSPsAugH7eAm7L2xYM7kcLw2wK/WEknzUtVKip0vGxCJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257975; c=relaxed/simple;
	bh=pwUmLeotEeIpNgfqucJYyyYm8ht9gbbxa9u50ujilw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbk/G9XxANnhAHrDskusqWx38ge2HHc5w1hTkICx6dtBkXFdcDNZ9V8XRUBWNAI28EOIgBFNSIGQ6sx01qsaTQE2S78oW90fECGeI8WcWn47UXAiSjxLYpX4eLGgsm1MBLOMCHZ56E1wujHkoL6du0SEyCfB+vunDMPg2ZDYcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=btHmIto1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="btHmIto1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257573;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i71CyXV7ngSNdjqVGajkhAjfmP/9Md4KrYj/7RLzjkw=;
	b=btHmIto1F6f/HyiDE0ZM5kB/3vXVox1Aj57+2S8Xd8c6SUZ9jVhvz7Su+JCkU1D28PpBR3
	vv6D3CrS2jVl6SM3fMzWtFsEAgEKjHkrQ/LDSwQZi0cDXPkBVQb2yFBYdwXnyYzMQCA+c+
	54N8lVqTu5NFXqgKjXZRuE9hQmQpgBgmFH5wzbZmc6AtI6/rd61k6RIUlIndpr6XWeqe1D
	dF3gbX8OezVcoEX4JEkK2rRfAhEzGMWAbX3UYk3+b65HMHdszd//DiYLBaCZcZw27gDoqF
	8Picqiln5esJJj6IerfZ93FmH3LKyWL5liywr/pwGGWcNfz99J1nNwbZMmHpNg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 05/17] tests: enable strictness for perl scripts
Date: Tue,  7 Jan 2025 14:45:53 +0100
Message-ID: <20250107134606.37260-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
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
2.47.1

