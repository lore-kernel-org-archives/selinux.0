Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD540B36D
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356739; cv=none; b=FN5EzQMguiJ5h7LghixvqTg5JgtJ2GRhKphx+UDO/LeihjiFr9D20tZmQycnwl/npvAHPcxnInAoL+E280QoI6CNwRw0HJNDDFPb53PcY9eSk1g9yfrloE92Gqgnik6GfTxDFO1PT4ajVCd7SUu70Qj6aCWhhEt4Yp9qK8TxGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356739; c=relaxed/simple;
	bh=1w8YlBGemLyFGKhwYNd/g0zSOZLLcAzah30VZmWLah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWka1h7VYV9+RleC5oc4453uT0hxfIXw0cU8yvuFS3+j6dznjpulTPH8bdGnTm2eDt6yqM/5RcyvRr7A3WWz5v3G6EOwXX5oFbG59/aXeVpkSVvEneHifVVkeDP0yLUsz2oFt+9qaqqCY5en29OGXen8p6nqrs9anA+A84qN36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=soGO+i5c; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="soGO+i5c"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356713;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iL8fdiDbyut7a1XVnmiVPSvG5BpKKQlJp+gdiQ7u0qI=;
	b=soGO+i5c6qsi22s3bVnRbWlg8wRhr2IigDsnUCA+f/kV0EPIb2dCzPzuyWf/eZ3m6n3G/7
	L/L1T3PzPPyS97xwZNJpBXgIPG2mJqh7ycdHC0tTl8QvqNFTCrbR2Pk3c7Q4jV8CVVzId9
	JaOnAvmPNYsLj7AN7eNgVKQ9POgXU8VmI7xTlOKxZHqrcYJy/+SJugnR9+eqL8MYoBKddU
	7lKxa7ufJDo36SuKobRdcDsvM6i7FfMR0mtS08+TW6X6RaQ3FIzLDZ4ShhoV0UljChKhYK
	aYAGCu0KK0x7bWr64n+bYoi1bnK34tEDnaIxixDdV5rJd7QEo+IuW5s01D4Dqw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 11/21] tests: enable strictness for perl scripts
Date: Fri, 25 Sep 2026 19:17:43 +0200
Message-ID: <20260925171755.2029271-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

