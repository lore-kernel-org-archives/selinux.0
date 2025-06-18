Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4D36B
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205080; cv=none; b=ikBVLQiaQKpUD1qsI5j7LR1RCfCQ998ZG429s0vYHhRtNC7MCewA5Bwf5Ir3p/3TFX9lfPJbIurEB8HyKTfLWzRF4Gk3jQUUtBhNxKAOPTRZXGELaFady0c2n3rpY4DVbDo8sP5wpeWoIB3eVfnB/kFKovLZEo88ERunRT7H+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205080; c=relaxed/simple;
	bh=YImTkwJDLXjm6tpylHkVH9C6u3jvNHj04ZG10R5e0o4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=os/t/koYhOA4YXYhDef417A8saWs65Dtn7xLfOeuf6VCkRGmCLWGS0km6kgrGOweK7Drif2smNQbGoV8X3K9CDf0aWAathvGka8YF/2Je1u6UuNukFFHH2KqTmOht6JA1aIHq19flc1Gmgi/oTOz/rILSXKIXthACf91gBE2Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmKDEqjF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmKDEqjF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so5933876a91.1
        for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750205076; x=1750809876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jvSKakw08oHk3vo8nIpN0Hufv9uNKfZ1P+dDeGz9es=;
        b=MmKDEqjFfirgpog5vmes8+1yydi/hRYYjZH6gW4glluwWxoeOl4en5VQHWb9EfCg9L
         p9Upbh41YmB1p49Ai3EB8+WonORTLn/8xBhi34hTG0migcASSatB6t/uZB/HCcMHlvZf
         Q4myL0xB6GjHrpsS0HJ+eJ37MvbPXHj++oDYR+CDMx6pZH8eXhADpeWE9Dyzus1P3cwl
         zaAcI559m25byxDgEDffyWLRL46cqqiYGzUZdN2XnUxvpiBrZimaXpntRy+HvIPO2qph
         hRBegFIf52t84Si3zn5SwRWXsQ5bUtPB/rlcX6F1sG/xwCIaEq6vOZCAv8w6CFOmLXGL
         85tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750205076; x=1750809876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jvSKakw08oHk3vo8nIpN0Hufv9uNKfZ1P+dDeGz9es=;
        b=EmOqk20HjmfsidXPj9qqX1R7BOpv5BCLaigLXDUHNM+HKeEomfGvYWvfnN6jFAlNNI
         CR+FqlkY7Pz2vGrfeXGj9ToJCt3ZwXEuvSzhZIbXfbrvLUtNICpeKkqVqiRKKoyeBU3O
         sGkYNLWG2pmirAnVQkxRRp1QXoJieWTszqVXXVxR+bQvRG5kPf76Ntf9nbQCTkOFDdH8
         ihtrK+hZo30StGFLFdMApK+z/CwUtkl5eBXZJYGnFVg+10WxCWaFyJPpCog75EFo45x7
         SzYDy/P0hNinJUAXaKSRDZoJDMPXHyoDyebP5kLZZ6OHY5uGuhQ4zsSbtZiz5SvJAC4K
         h5Dw==
X-Gm-Message-State: AOJu0YwlIaWoFgCqUv/CL7Oyd9Lvsnc2Etp7ETDScktHx2D7cn3hAzsN
	/ch8tX74697XKshNjxivwVjek5EAxL+kxjBwZdeGtAqRMJJlmqBrWHrhs2u5j4nw
X-Gm-Gg: ASbGncurhWpTRi2EYuYSoCLu5mBJnwIzyt2T1YRrkMgLGmT7RTavxk/Bg395Dnvu9LJ
	JOOUu0tIK507kjXtCeyZ7rf8iNup+4GSvJ8c+ac/OD1nWPralUWvCVLU33b06CCOcI3O426CfgY
	GxrYngixjTZ8WHRBzx/59+XOCbNQoIb5QJ+lRcxW9KXviWomRjZbtA8w+nLsnth43BSgTOiGCp8
	0g9gH+yws/etqFY/HDiP7IgEAMfWeEU6+Ho4QGChqlVQ2zrq27/lkA1mL2fEvk+tMxlKZND+/+T
	+GlkvvbcrJivADY3ACLMt2kizhHpRr1wmqEgI/pK9cOXb40Tpg4FkaTLVDwSNg1MAskFxEEAneP
	gyWkMsbgS
X-Google-Smtp-Source: AGHT+IGgvNR3QP4EuN290CAq0Hkl+mfAE9SDLTp0NOPW3A2dW7SbpnLdaxqzYlKlp6gTByHv4WVSRQ==
X-Received: by 2002:a17:90b:3148:b0:313:31ca:a69 with SMTP id 98e67ed59e1d1-313f1daa79emr27368729a91.18.1750205075696;
        Tue, 17 Jun 2025 17:04:35 -0700 (PDT)
Received: from cbl-mariner-ECbkw2SOF1TN.. ([49.204.236.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b59611sm11337877a91.34.2025.06.17.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 17:04:35 -0700 (PDT)
From: Sindhu Karri <klsssindhu@gmail.com>
X-Google-Original-From: Sindhu Karri <lakarri@microsoft.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	Sindhu Karri <klsssindhu@gmail.com>,
	Sindhu Karri <lakarri@microsoft.com>
Subject: [PATCH] Expect Key error for module_load test in lockdown mode
Date: Wed, 18 Jun 2025 00:04:23 +0000
Message-Id: <20250618000423.779510-1-lakarri@microsoft.com>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sindhu Karri <klsssindhu@gmail.com>

Signed-off-by: Sindhu Karri <lakarri@microsoft.com>
---
 tests/module_load/test | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tests/module_load/test b/tests/module_load/test
index 98c5946..de3812b 100755
--- a/tests/module_load/test
+++ b/tests/module_load/test
@@ -25,10 +25,40 @@ BEGIN {
     plan tests => 17;
 }
 
+# Read current lockdown mode
+my $lockdown_mode;
+if (open(my $fh, '<', '/sys/kernel/security/lockdown')) {
+    my $line = <$fh>;
+    close($fh);
+
+    if ($line =~ /\[([^\]]+)\]/) {
+        $lockdown_mode = $1;
+    } else {
+        warn "Warning: Could not determine active lockdown mode, assuming lockdown mode is 'none'.";
+        $lockdown_mode = "none";
+    }
+} else {
+    warn "Warning: Cannot read /sys/kernel/security/lockdown, assuming lockdown mode is 'none'.";
+    $lockdown_mode = "none";
+}
+
+print "Current lockdown mode: $lockdown_mode\n";
+
+# In cases 1 and 5,
+# In lockdown integrity mode, the expected error code is 129 i.e. Key is rejected by the service error
+# In lockdown none mode, no error is expected.
+$expected_pass = ($lockdown_mode eq 'none') ? 0 : 129;
+
+# In cases 4 and 8,
+# In lockdown integrity mode, the expected error code is 129 i.e. Key is rejected by the service error
+# In lockdown none mode, the error expected is 13 i.e.  EACCES
+$expected_fail = ($lockdown_mode eq 'none') ? 13 : 129;
+
+
 print "Test finit_module(2)\n";
 $result = system
 "runcon -t test_kmodule_t $basedir/finit_load $v $basedir setest_module_request";
-ok( $result eq 0 );
+ok( $result >> 8 eq $expected_pass );
 
 # Deny capability { sys_module } - EPERM
 $result = system
@@ -43,12 +73,12 @@ ok( $result >> 8 eq 13 );
 # Deny system { module_request } - EACCES
 $result = system
 "runcon -t test_kmodule_deny_module_request_t $basedir/finit_load $v $basedir setest_module_request 2>&1";
-ok( $result >> 8 eq 13 );
+ok( $result >> 8 eq $expected_fail );
 
 print "Test init_module(2)\n";
 $result = system
 "runcon -t test_kmodule_t $basedir/init_load $v $basedir setest_module_request";
-ok( $result eq 0 );
+ok( $result >> 8 eq $expected_pass );
 
 # Deny capability { sys_module } - EPERM
 $result = system
@@ -63,7 +93,7 @@ ok( $result >> 8 eq 13 );
 # Deny system { module_request } - EACCES
 $result = system
 "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $basedir setest_module_request 2>&1";
-ok( $result >> 8 eq 13 );
+ok( $result >> 8 eq $expected_fail );
 
 SKIP: {
     skip(
-- 
2.33.8

