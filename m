Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6C3B585F
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136746; cv=none; b=TTx7qrVFbe2lFBUcvoHBwZkei86twHMyO6iXFP2sR9+HgZ37bxvlSRfTE6+4MYRhxkmPc4omCEqbiCDQw+hCJCya9EHMSUsuQEqfyhqLC3aOF4GSMpLM3s7bVPwMqY2UsV3d8BptVRFQUkdkQtuku8hKdMPe8QVDy0/9ViVxvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136746; c=relaxed/simple;
	bh=Ms9P997Tpdf4UyFdhQBE3uXd85LvcbGudhBYIPshWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4CfKVYl8/IcwB0hGmkfOfDM5iPafroL4o7Wt4jt+WSqnAwyfEKVk4qvA8cQnXIUSUHPhATh9fhvuvYB+WW1jkgryEGRMIlCZCIbGmPfZ6zmNp+pjm+rjBIMyaNCMapnKHbrYf6Qet5YlCd8IIPc2LI1OYvVEe/JWpvp9Aenzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RulSS8ge; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RulSS8ge"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91ae31bbaa9so399914985a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136743; x=1782741543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGbkdFHTlyigTp4vouASpJdlZxYB1unhx/BiRO540Uo=;
        b=RulSS8ge+SeXnSxAhDikgfirHVu9e2tbuLKLuC5bLyBNQTaVVB5FBr64Tz+/7gZsbB
         txKhBjGt5sCnCtjJ9FWjJC34SNSGF1AaWNFykbdNDS9FFIFMMwZA6wWsjfiIsBJBzQ3S
         djyTeRYgK6Uwk1sf2wly2DZeZJELb47aJX4Wo1XL2ATDCcr5tI1CoMzfNs8TOBk4Aa77
         s7feX+OQFQD2owNF7SM8JFuRaWZ7af7ukuHJoe7i7Nois+8ZqSPtOT9rPoIaRusyXUe7
         cj+m4mOGK871Pep/Tg6H6t4HvLjDDJpQjGW42pO8E0GdfpY11W3NjXT2vSYA5mx82tnK
         2m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136743; x=1782741543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbkdFHTlyigTp4vouASpJdlZxYB1unhx/BiRO540Uo=;
        b=h4e+Oa2WtMqWlr1sG14xFmyAiEe+UkujwgTfGwG5sl5saEnGc9GEAjsP4C7BQP+d/m
         MkNnVJ0c8df+gbCHiIdMmvJf1KlD2sj/WiU2pBM9EyOYRLfn8xUgMN9GAYWLRco8oxFk
         j8aFnC7pXAEMJaX/oGLfaDrFun8uFB1Tc3AE5j6+u2l0FvzwSZ5P0rDGbm+37Pp/p9Yk
         t7QOEkODlHlLl/aOxLby6hS+fF52BEMmIOA7nNKlxU1zlX/gqof7i4RbppCRPl4Wxv5r
         4evvhyzJujVb5nao8oNl1om1oQYKydEoFsnsJYEaedFY4bTu9zVu/lAF8NtXulHyIL/O
         8pCg==
X-Gm-Message-State: AOJu0YwcUX3gpAJJZYptfH9oaf3FLU0QMwpAOLSDGbJdndj/KT1Knujm
	+u9gE1qP82F2JbPmobz87EBd/vGL3Lj8KuGi4Je3qj0vqYMGWNp+lvMyI40I2A==
X-Gm-Gg: AfdE7cmPDMyUcSZTGMggszZ7eAi1WxJg0+WZgLHzM481mgfzkUN4v6hkNJ0UhSRYREc
	U7p37IbSkvBfrEHZjCAAxTA553iIKbm8fXjTNWLd+LPA+z7s1jz7jBsWcVZ4UPesXZMnc101A0Q
	c4jWA3hu6swtWyr4ffVr4Qi2YbQmdNzLgoIag0ymDOJWqs2a8ukNk9fdzCF+jQetLwqPDC2SWWV
	hSBfxSXqxTaY5KFYhSuQS1IbAuR+2B1/NU5z/i2XfsOyYJGJ7dVGsuuuhShIKlBQMKhnBpZl5MP
	nXSvwOzJuJ0oL3nJygMIjTHS4u8GZLLvejOPa5ayJFI3kui3+lNWkXHp314rCb9mijusbXZqkhb
	T/v22f/zkxhAm633Ll3oFLQnm/bliYaHbNi/CAtqXV0nYfGDtW8PDmkvwo8EeT/dT3cOJtebalG
	5Chs2Wp3+7q/awk7apdCTOtPbuDshVrqkC02wfvMUeGIxEm68xczQ9cyQrAIE0cT1GYUFwFBxTI
	gvko1QmX6brohJ8
X-Received: by 2002:a05:620a:4483:b0:915:cda5:2805 with SMTP id af79cd13be357-920d53d1cf8mr2022353885a.52.1782136743188;
        Mon, 22 Jun 2026 06:59:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7e4f79esm963959385a.12.2026.06.22.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:59:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	hexlabsecurity@proton.me,
	matthieu@buffet.re,
	ivanov.mikhail1@huawei-partners.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/inet_socket: add tests for TCP Fast Open
Date: Mon, 22 Jun 2026 09:57:58 -0400
Message-ID: <20260622135757.2172-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TCP Fast Open. These are expected to fail until
the corresponding kernel patch is merged.

Link: https://lore.kernel.org/selinux/20260618175513.112443-2-stephen.smalley.work@gmail.com/T/#u
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/inet_socket/connect.c | 55 ++++++++++++++++++++++++++++---------
 tests/inet_socket/test      | 13 ++++++++-
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
index e2d02da..067d196 100644
--- a/tests/inet_socket/connect.c
+++ b/tests/inet_socket/connect.c
@@ -17,7 +17,7 @@
 
 void usage(char *progname)
 {
-	fprintf(stderr, "usage:  %s protocol port\n", progname);
+	fprintf(stderr, "usage:  %s [-f] protocol port\n", progname);
 	exit(1);
 }
 
@@ -30,26 +30,42 @@ main(int argc, char **argv)
 	int result;
 	struct sockaddr_in sin;
 	socklen_t sinlen;
-	int type, protocol;
+	int type, protocol, opt;
 	unsigned short port;
+	bool tcpfastopen = false;
 
-	if (argc != 3)
+	while ((opt = getopt(argc, argv, "f")) != -1) {
+		switch (opt) {
+		case 'f':
+			tcpfastopen = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind + 1) != 3)
 		usage(argv[0]);
 
-	if (!strcmp(argv[1], "tcp")) {
+	if (!strcmp(argv[optind], "tcp")) {
 		type = SOCK_STREAM;
 		protocol = IPPROTO_TCP;
-	} else if (!strcmp(argv[1], "mptcp")) {
+	} else if (!strcmp(argv[optind], "mptcp")) {
 		type = SOCK_STREAM;
 		protocol = IPPROTO_MPTCP;
-	} else if (!strcmp(argv[1], "udp")) {
+	} else if (!strcmp(argv[optind], "udp")) {
 		type = SOCK_DGRAM;
 		protocol = IPPROTO_UDP;
 	} else {
 		usage(argv[0]);
 	}
 
-	port = atoi(argv[2]);
+	if (protocol == IPPROTO_UDP && tcpfastopen) {
+		fprintf(stderr, "TCP Fast Open only works with TCP or MPTCP\n");
+		exit(1);
+	}
+
+	port = atoi(argv[optind + 1]);
 	if (!port)
 		usage(argv[0]);
 
@@ -95,13 +111,26 @@ main(int argc, char **argv)
 		exit(1);
 	}
 
-	result = connect(csock, (struct sockaddr *) &sin, sinlen);
-	if (result < 0) {
-		perror("connect");
-		close(ssock);
-		close(csock);
-		exit(1);
+	if (tcpfastopen) {
+		char byte = 0;
+		result = sendto(csock, &byte, 1, MSG_FASTOPEN,
+				(struct sockaddr *) &sin, sinlen);
+		if (result < 0) {
+			perror("sendto");
+			close(ssock);
+			close(csock);
+			exit(1);
+		}
+	} else {
+		result = connect(csock, (struct sockaddr *) &sin, sinlen);
+		if (result < 0) {
+			perror("connect");
+			close(ssock);
+			close(csock);
+			exit(1);
+		}
 	}
+
 	close(ssock);
 	close(csock);
 	exit(0);
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 4cc3852..9f846bd 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -12,7 +12,7 @@ BEGIN {
         $is_stream   = 1;
         $fail_value1 = 5;
         $fail_value2 = 5;
-        $test_count  = 19;
+        $test_count  = 21;
     }
     elsif ( $proto eq "udp" ) {
         $is_stream   = 0;
@@ -308,6 +308,17 @@ if ($is_stream) {
       system
 "runcon -t test_inet_no_name_connect_t -- $basedir/connect $proto 65535 2>&1";
     ok($result);
+
+    # Verify that authorized domain can connect to TCP socket via TCP Fast Open.
+    $result = system
+      "runcon -t test_inet_connect_t -- $basedir/connect -f $proto 65535 2>&1";
+    ok( $result eq 0 );
+
+# Verify that domain without name_connect cannot connect to TCP socket via TCP Fast Open.
+    $result =
+      system
+"runcon -t test_inet_no_name_connect_t -- $basedir/connect -f $proto 65535 2>&1";
+    ok($result);
 }
 
 if ($test_ipsec) {
-- 
2.54.0

