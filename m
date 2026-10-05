Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BA363C5A
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226431; cv=none; b=qgy5Y+Nsia9kNrQymIZACj6Jf3zenKQRiJr25IBYEAGSs/2RqOwGbCMOfW3TsMhzUHS+psS99yZQjbYjmVuD/6mrjkk4KhanQ0mYBYfCi4UkuCPGrYTFulutyTG/csT7az29+iYMRugHZ9XlzSzr8UKMwxeRTz4qvoYEEk/aYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226431; c=relaxed/simple;
	bh=TQ6xNoY+5gsSOaHSTA3wwW9C4wPip74ffDiskmCJdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JasasPGmEPZfseeU6w+VMVigyMxqNS88FBKuF1J/fnKguktuPOf8RBQP1vbm2Frs4AFZuiaHRj42FYUlvNfhwbqW6H8az0QdQjHFiSumgBeH63NwCBvUPq9o4TCKG4rjU9s+GUAI1Xd8ORsLKQBqIvC5nqgvXuCSUrWqJ7pqwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O589fqjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O589fqjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791226428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3c51oCokzZ7uGbPrkHVskGANE6NKQ4EW/ssfgTHN790=;
	b=O589fqjjNDaqx2k+ygY5A5j0qWHa590CkElapzyGvU5pu8I1sh7fajxIISFfbXnXKQ0qZp
	dgDGp+kOcCdjOpTe46t703eji75UD830z6Mt5hVuREn3j1wKkSLR6TcOFTJldF5NBC7v49
	2Z4XT/s3dPtpEH/m/edLdBaIvKShKtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-9MnsRZaoP7Gn1PFizPFzSQ-1; Mon,
 05 Oct 2026 14:53:46 -0400
X-MC-Unique: 9MnsRZaoP7Gn1PFizPFzSQ-1
X-Mimecast-MFC-AGG-ID: 9MnsRZaoP7Gn1PFizPFzSQ_1791226425
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16A11800644;
	Mon,  5 Oct 2026 18:53:45 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CDE5426;
	Mon,  5 Oct 2026 18:53:44 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Cc: Brian Grech <bgrech@redhat.com>
Subject: [PATCH] tests/io_uring: check io_uring_disabled before probing
Date: Mon,  5 Oct 2026 13:53:43 -0500
Message-ID: <20261005185343.2782019-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

With kernel.io_uring_disabled == 2, the unconfined probe also fails
(io_uring_setup() -> EPERM), so the probe's generic skip_all fires
before the sysctl-specific elsif is ever reached, giving a less
specific skip message than possible.

Check the sysctl first so the more specific message is used when it
applies.

Fixes: c3911c7 ("tests: skip io_uring when unsupported or disabled")
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/io_uring/test | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/io_uring/test b/tests/io_uring/test
index fb6528e..217ac0a 100755
--- a/tests/io_uring/test
+++ b/tests/io_uring/test
@@ -6,27 +6,31 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    # Probe unconfined so a failure here means io_uring isn't built into
-    # the kernel at all, not that it was denied by policy.
-    my $io_uring_supported =
-      system("$basedir/iouring probe >/dev/null 2>&1") == 0 ? 1 : 0;
-
     # kernel.io_uring_disabled was only added in v6.6, well after the
     # io_uring support being tested here (v5.16), so its absence does not
     # mean io_uring is unsupported - only a value of 2 means io_uring is
-    # administratively disabled, even for privileged processes.
+    # administratively disabled, even for privileged processes. Check
+    # this first: when it applies, the unconfined probe below would also
+    # fail (io_uring_setup() -> EPERM), giving a less specific message.
     chomp( my $io_uring_disabled =
           `sysctl -n kernel.io_uring_disabled 2>/dev/null` );
 
-    if ( !$io_uring_supported ) {
-        plan skip_all => "io_uring not supported by this kernel";
-    }
-    elsif ( $io_uring_disabled eq "2" ) {
+    if ( $io_uring_disabled eq "2" ) {
         plan skip_all =>
           "io_uring is disabled via the kernel.io_uring_disabled sysctl";
     }
     else {
-        plan tests => 11;
+        # Probe unconfined so a failure here means io_uring isn't built
+        # into the kernel at all, not that it was denied by policy.
+        my $io_uring_supported =
+          system("$basedir/iouring probe >/dev/null 2>&1") == 0 ? 1 : 0;
+
+        if ( !$io_uring_supported ) {
+            plan skip_all => "io_uring not supported by this kernel";
+        }
+        else {
+            plan tests => 11;
+        }
     }
 }
 
-- 
2.55.0

