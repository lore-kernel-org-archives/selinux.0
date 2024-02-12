Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42618030
	for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733810; cv=none; b=KO3XQmlT0OFsT1JdLHT7FNk4sOHN60lkIb2PtCMCuueWLtZsJNP0QlOZXKihaOxvwNrkJTSxgbg/lBKmPa18OWZ2nUdS4JUl+Plm3PMOg922NPmnW+yJOnr4ZLO3ubnKEoNU0ogNqEFdJQoe1Ors1d7v0fmEGxlWvLMJvwJouc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733810; c=relaxed/simple;
	bh=zZBec8Ph5lux94PtCST48ptJ8eQHrm77tz57uri0XlY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bsSEtlV/7qxLeA7m4mtVB39BVLtlUM9eB3vhXCfBWC/6u350XSE6FAWQf8g1/rdH4xr/Ea7+H7A1Ja//t7uXYPwmdPlmt3XWaLqPSSKvd+mrav6wRJy6GARBNp7jQrPOB70u6DRbJ59pyWDG/BsxHrm6BBWwn3PmHhgeOyYJRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3bGxR89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3bGxR89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Er1+R2mBh5a7e/TRusddJtEwkn+J/TY8xnPRg92BX9U=;
	b=f3bGxR899trSCaIrPOPpY4LaqN53ISxWBeX/VNePs+sx5Gwcx+ZNKVDg7Q4nL9CH51r0qU
	PX91gNhSvXWydSUXbn3T7May0RzjULwRNB8a3lt2/Ifh74QG7GA36VyAOOePQ21dMLWk2O
	RSymTyfO7folHC5ou7FNMkSmV2BcpM0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-6Usjy2u0NE2U2lfQxcZ4kg-1; Mon, 12 Feb 2024 05:30:05 -0500
X-MC-Unique: 6Usjy2u0NE2U2lfQxcZ4kg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d09fe39949so24718731fa.0
        for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 02:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733784; x=1708338584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Er1+R2mBh5a7e/TRusddJtEwkn+J/TY8xnPRg92BX9U=;
        b=M29OCMLZuRB2hMa3L/9vO9ueP5gS95/9HevHJYDpEZo24AMwA8arC1SezLcSrIe7bq
         ZL0Gek6ZinbMf+tHwIHHIRJxLiaR5X7SU2EIC721kQB1MY5KT2YUc6WfBVJPFxtWHyyD
         OL6xQSvA5dF/ODMwT4Z9O48qYIJHNrpvTt5YkXJmG/EFeM/XoK0+rhPBikTxrv9mfKCZ
         Z7z29iwnH3Lcl+9dtAUUn5F5DFdjbZw4pMPnh4VW+pxdl/ybymh0uxmoH1qib6/yYHhh
         L2eFKAIb7eZy1NGa7LVuqZ1TIoggNFOVl4WxmjIUAbtEk9zhq6vhRAzWydqzZ7JY4Reu
         0JcA==
X-Gm-Message-State: AOJu0Yz0hn97taIdrWQynAPFQVrf6c8zyyMErfwh+BBfs4HNaE9gBZYQ
	Tg383L1WnLjAJBLnwSsZFyvr6QDYJnUz4BUY4KbTLaaXji2rX6zgheVCb8vmShQRBX79ZuTlB3Y
	kp7HLHSZ46xu3KTHbhuOazVGpPiIHXORfRUknfMBcMtiwSCAY32zV4QJiQ+LMjDEk/VhotVKgbt
	yseYOtC+oFy+H3hMlyUykfB3AhJyYG1DVDVeMzmnGgRw==
X-Received: by 2002:a2e:8297:0:b0:2d0:b663:f053 with SMTP id y23-20020a2e8297000000b002d0b663f053mr4322400ljg.22.1707733784246;
        Mon, 12 Feb 2024 02:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmUGz7k7LDUQJEO0rGNxn9rvBe01Z1WEMQuG4VhjnRsk7i0G2qEKfdrTrcUS0daMbi3rcYYA==
X-Received: by 2002:a2e:8297:0:b0:2d0:b663:f053 with SMTP id y23-20020a2e8297000000b002d0b663f053mr4322387ljg.22.1707733783774;
        Mon, 12 Feb 2024 02:29:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d756000000b0056140d51b7asm2614226eds.83.2024.02.12.02.29.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:29:43 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket: test CALIPSO also with datagram protocols
Date: Mon, 12 Feb 2024 11:29:42 +0100
Message-ID: <20240212102942.71393-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't compare the labels because of the lack of SCM_SECURITY support
in IPv6, but otherwise this case can be at least basically tested.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/inet_socket/test | 61 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 3bcbd29..08c7b1d 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -31,19 +31,16 @@ BEGIN {
     }
 
     # Determine if CALIPSO supported by netlabelctl(8) and kernel.
-    $test_calipso_stream = 0;
-    if ($is_stream) {
-        $netlabelctl = `netlabelctl -V`;
-        $netlabelctl =~ s/\D//g;
-        $kvercur = `uname -r`;
-        chomp($kvercur);
-        $kverminstream = "4.8";
-
-        $rc = `$basedir/../kvercmp $kvercur $kverminstream`;
-        if ( $netlabelctl gt "021" and $rc > 0 ) {
-            $test_count += 3;
-            $test_calipso_stream = 1;
-        }
+    $test_calipso = 0;
+    $netlabelctl  = `netlabelctl -V`;
+    $netlabelctl =~ s/\D//g;
+    $kvercur = `uname -r`;
+    chomp($kvercur);
+
+    $rc = `$basedir/../kvercmp $kvercur 4.8`;
+    if ( $netlabelctl gt "021" and $rc > 0 ) {
+        $test_count += $is_stream ? 3 : 2;
+        $test_calipso = 1;
     }
 
     # Determine if kernel has legacy iptables support
@@ -401,30 +398,48 @@ if ($test_nft) {
     system "nft -f $basedir/nftables-flush";
 }
 
-if ($test_calipso_stream) {
+if ($test_calipso) {
 
     # Load NetLabel configuration for CALIPSO/IPv6 labeling over loopback.
     system "/bin/sh $basedir/calipso-load";
 
-    # Start the stream server.
-    $pid = server_start( "-t test_inet_server_t -l s0:c0.c10", "$proto 65535" );
+    if ($is_stream) {
 
-    # Verify that authorized client can communicate with the server.
-    $result = system
+        # Start the server.
+        $pid =
+          server_start( "-t test_inet_server_t -l s0:c0.c10", "$proto 65535" );
+
+        # Verify that authorized client can communicate with the server.
+        $result = system
 "runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e system_u:object_r:netlabel_peer_t:s0:c0.c10 $proto ::1 65535";
-    ok( $result eq 0 );
+        ok( $result eq 0 );
 
 # Verify that authorized client can communicate with the server using different valid level.
-    $result = system
+        $result = system
 "runcon -t test_inet_client_t -l s0:c8.c10 $basedir/client -e  system_u:object_r:netlabel_peer_t:s0:c8.c10 $proto ::1 65535";
-    ok( $result eq 0 );
+        ok( $result eq 0 );
+    }
+    else {
+        # IPv6 currently doesn't support getting the packet context
+        # via CMSG (https://github.com/SELinuxProject/selinux-kernel/issues/24)
+        # so don't check the returned label here.
+
+        # Start the server.
+        $pid = server_start( "-t test_inet_server_t -l s0:c0.c10",
+            "-n $proto 65535" );
+
+        # Verify that authorized client can communicate with the server.
+        $result = system
+"runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e nopeer $proto ::1 65535";
+        ok( $result eq 0 );
+    }
 
 # Verify that authorized client cannot communicate with the server using invalid level.
     $result = system
 "runcon -t test_inet_client_t -l s0:c8.c12 -- $basedir/client $proto ::1 65535 2>&1";
-    ok( $result >> 8 eq 5 );
+    ok( $result >> 8 eq $fail_value2 );
 
-    # Kill the stream server.
+    # Kill the server.
     server_end($pid);
 
     system "/bin/sh $basedir/calipso-flush";
-- 
2.43.0

