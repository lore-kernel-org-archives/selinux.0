Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E84E80BD
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611116; cv=none; b=BAvcOFCQ5wy4FVoyQKRl2yBswoSI8L06s98kQ6pmpoIDcKw7DsUDJrnwQwTegLB/w5LQuxCiS61eRUTbKDN2rsS1QhctqiyehnPepXqH7G0F7gNCjBThgeIzwynOwuPLh9o6fhYpbscOOfSJMfEToBJzWaoLd2Hk8YWS7ujWsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611116; c=relaxed/simple;
	bh=1w8YlBGemLyFGKhwYNd/g0zSOZLLcAzah30VZmWLah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDePVRfM4yl546TNK8WDi9ko7qFMffSqj8aSzqPQJZzZpE1DReYol+N6BHJ/ruFTpP8JCV4peLTyihYNR7mMuXKEHwIxriRnEpvhqjCgl+J6gPIW13pgLwqBeI5XxBbzelpwLWtXFoFDnHevDbVrqvq5jaJAIkL83WcbL8SLpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NB8IZjXm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NB8IZjXm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611102;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iL8fdiDbyut7a1XVnmiVPSvG5BpKKQlJp+gdiQ7u0qI=;
	b=NB8IZjXm5tzBdeXTU4Y5vU4WEzOXwyrVH/YeeoBQQHjKPFkiy1GBMq/WnaDwThYuEbvxoM
	SoTCgGCMNB2hBRfHxXCa+8PPDhxPX1uadwZqyN00NbiWv+iJWuIi60CzpTUNkMxTxs08eL
	fsmTtLyJmJz4+BYyP/qSBSOeGPfpKsvHKSA5uAO59+hZRVQdY0SlfAyJ4ZykhbINNxGNdy
	6SwHnCqYvVl1MdZPrmmby9rPzLd8VkFVEnt5HC/A04ef23OqVzBnD9dHK7+17aY0RMuV3V
	z5Hsk9U0i/Io24lkLPYIlpgzjvzhv7+XeK5RBGMYW6ITaOmBRNhgrtlbUCJs/A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 11/21] tests: enable strictness for perl scripts
Date: Mon, 28 Sep 2026 17:57:42 +0200
Message-ID: <20260928155753.2259807-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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
2.55.0

