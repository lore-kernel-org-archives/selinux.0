Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936191C1F29
	for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336895; cv=none; b=iuBFkgdeyjdSEWWKXUbzaXcEHhllrqCcvXHPtiEJpPdeR9rIfht7qC431hmAnjmYHajQGZzH6vEFTWFHZIgL1Rk9ALsyDsXLoTYuI+V2mNwlt7rFDMoxB3fMiwdtZoMHgvgKUHpZbVwfBznRu92NaSxO/mPFEb5D6z3mvkvPpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336895; c=relaxed/simple;
	bh=zn4Z4pMPynMlVikrZX8wXdT/aJXykUJe1vJ9GGYKtSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fWSxg87rG3JAdaJHqm+4F7et/BoXQbVmxW9v4rt6hNwUB8b0MyloB7dOQXHO24kluuonGgTNb7/nsPAiX+qogs4Vqsgbw1MDETRcQWaxja6+HxOr9tW+FM426/Rr7pgx3ixSDAvczoBPRCySRTPhwIF5tUgOBr7+X5NS0lrHVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bli4P22S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bli4P22S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738336892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kyKMLLrR63h7+vo8Zi40rjmdHWVCniaxJakMQGWaEPU=;
	b=bli4P22S9CUqt355WlMI5KhMrlQmAzf2Lz7DpHsIJWWVmcrnHOTVaKf+nbe8YeHh5z/GYI
	B2sgfC20X6EHXoK5ikipVAli/6sTmh/ep90+kOLo5etlOkvsPaHNb6mzoi2xG24r/qsA4B
	U57fJBBSK2V96DjWE2f10AaGlKgEaHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-cbC_XO8ENpervIC7GQrjOA-1; Fri, 31 Jan 2025 10:21:29 -0500
X-MC-Unique: cbC_XO8ENpervIC7GQrjOA-1
X-Mimecast-MFC-AGG-ID: cbC_XO8ENpervIC7GQrjOA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso10786265e9.1
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 07:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738336888; x=1738941688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyKMLLrR63h7+vo8Zi40rjmdHWVCniaxJakMQGWaEPU=;
        b=BQeP0LW0ohWFGfFiIGcldY/EYbXKWhYtiOoriBJzdlG+FTa7Duzj/QKFSWw2mq/nUM
         Qa58Z7Y2jbPAM28gDSJmybL0/FWYEl//2y9RnVyDeI+1VA0F6P6GY8bdZbMqPmp6EFt4
         yC0Oj66wU3JD6Sq2U9Wg87Vd5lu8zPaySox6pVsej9vRz04ziL/atlI720XtSAkrW3gi
         DtS0I+h8airnShFo2disSbpTmW4G2YakbkRiY9+1PONE3lB6gzTbhL4wB0ZqjEqMmzn/
         urYfG2DDHgoinhl+zwSdwfF6SNiVYPUoqP7wdsm8Ec8Elegfhr68tDVDxlhVP7Ei2/bz
         5k6Q==
X-Gm-Message-State: AOJu0YwVVNd32QBiaqT014BYFU4KgGVPfvgQkMkohxBwFitKFZJB6n+F
	l2LHA0zFXl+djSOz9j39kUazci25eM4mG4OKwLAnoQylp37Q3Mr9F1dGkz1vOpwwt9/r3MTNrDX
	GxqnSrZf9pHmHSgATll0sbAO20qfFkjsx4fxoC06swOnEYVssPr+Ddbu6OpiQx89MXxC1btocyl
	oIf59djdTNf6MLnL88kaxzI0EQS258uh2TCmxG81U=
X-Gm-Gg: ASbGncvIMVGaRC53l8/n+BzqrcFcsrJsJ0QnlD3bn/0ndJ0O2jEPF9/OQ3qNv0gEU4t
	pkGyIffvjSSEv2LZqm+yGnD0/IfnQ2v7frnLtJgecSGVifavI+BoXkQXlWKJtyxJUOPHy9kBwxm
	lS7aMEyDGcPWfV8C4VC8vjksmi8En+Aj5mSY1hDCOE9QPWHHxeUsLxn7bo+aIO3kBy9CM2ClXDA
	KKURgc6tVbVww0sCvFKk9sm1//QkiR/rEqJnR6ZB4ZCIZ4eqL0VFofuVI5dC8hTOaASvcrcBreF
	kjaBFalSrnZC8dQ4f5IM
X-Received: by 2002:a05:600c:3585:b0:435:192:63ca with SMTP id 5b1f17b1804b1-438dc3fc57cmr95058945e9.21.1738336888379;
        Fri, 31 Jan 2025 07:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEku3+kqW6TUGq2l7i6Xll0m7E5PjaDjOWd2P6+57gVk6NlSmmdmf9vP2muaNB1lGW6pbXx/A==
X-Received: by 2002:a05:600c:3585:b0:435:192:63ca with SMTP id 5b1f17b1804b1-438dc3fc57cmr95058745e9.21.1738336888017;
        Fri, 31 Jan 2025 07:21:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245f14esm57163495e9.34.2025.01.31.07.21.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 07:21:27 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket: enable MPTCP if it's disabled via sysctl
Date: Fri, 31 Jan 2025 16:21:22 +0100
Message-ID: <20250131152122.1452103-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In CentOS Stream 10 (and possibly other environments) the
net.mptcp.enabled sysctl will be set to 0 by default. The testuite
currently doesn't detect this and hangs when trying to run the MPTCP
tests. Adjust the test to temporarily enable MPTCP during the test so
that it can succeed in these conditions.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/inet_socket/test | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 08c7b1d..ae06ae7 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -91,6 +91,16 @@ sub server_end {
     system("rm -f $basedir/flag");
 }
 
+if ( $proto eq "mptcp" ) {
+
+    # Temporarily enable MPTCP if it's disabled by default
+    $mptcp_enabled = `sysctl -n net.mptcp.enabled`;
+    chomp($mptcp_enabled);
+    if ( $mptcp_enabled ne "1" ) {
+        system("sysctl -w net.mptcp.enabled=1");
+    }
+}
+
 # Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback.
 system "/bin/sh $basedir/cipso-fl-load";
 
@@ -445,4 +455,10 @@ if ($test_calipso) {
     system "/bin/sh $basedir/calipso-flush";
 }
 
+if ( $proto eq "mptcp" and $mptcp_enabled ne "1" ) {
+
+    # Reset net.mptcp.enabled if it was 0 before test
+    system("sysctl -w net.mptcp.enabled=0");
+}
+
 exit;
-- 
2.48.1

