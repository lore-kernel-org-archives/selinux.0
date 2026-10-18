Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4018C332
	for <selinux@vger.kernel.org>; Sun, 18 Oct 2026 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286945; cv=none; b=jQ3/S8jZhDY+IuUx25Nr/nnOxKB6cEJxgLu70L24/F5M4ThNJ8oQrRFDD1fzuVGpAvKDHfcrcaLXM/YPZTs3SeLwOEK0EMQxbbA+J7DGTeoLtWLvQghWzgq6PIbBXdNhfSKi6C0txCTlAZ6A87yZYldOHgvFKOVGzoJeiOV5ZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286945; c=relaxed/simple;
	bh=nJkIzjojqS1sX0J19d39J/Tqqh+DbhAZoats7C2rwuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b5IQwYcNRNDvBdYzATAbGjGqKwuabMxSm9+jLImyGppS5naliVAQL0eiM8v3UMWprPLzWiT+9zbMwnclIB3yrEpRi0R6CBuH6l/joFTRktio6kvNsZ439iAmQMoogyZCUBAkkukKd2Q39IGBFWcqrO+4twiD7r04h+zlfjMD6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyvQx4ZM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=crXOCykJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyvQx4ZM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="crXOCykJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792286942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O3V+8QFK+YhdJo7dKVhm6ymn3bQ6rIsRKi+Lj8v8oNQ=;
	b=LyvQx4ZMW8uov6wpomLEvdh7KIwFXOKQufUwk1XbnW7jX3KqHVmlS49+TxFxKIYsXua5tI
	id6WKPJtLwbnEnygKjxf2d+1wKqL62LCp/5HAeR2biSUWljDca2Rn2CpVQKKFw2t7I1AR5
	r14epZ/i0142F6SQ7a9RM55cSbNT6sA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-J-un60_1NDmChcnVgt3J6g-1; Sun, 18 Oct 2026 01:29:01 +0000
X-MC-Unique: J-un60_1NDmChcnVgt3J6g-1
X-Mimecast-MFC-AGG-ID: J-un60_1NDmChcnVgt3J6g_1792286941
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eab2a9a633so886676e0c.2
        for <selinux@vger.kernel.org>; Sat, 17 Oct 2026 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792286941; x=1792891741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3V+8QFK+YhdJo7dKVhm6ymn3bQ6rIsRKi+Lj8v8oNQ=;
        b=crXOCykJ3HwuceCcTo6zQMgfrLkg2RrbYkSo35LN8B5pBS+80moU3Dst0QwEcn77dB
         fNUodbqbB/mvqEHfDCAsFm5a2InDOUoqemukY14S2KQcJbS6QPf1o6/bd6TmEZzwA5uG
         ILbDsJPkZRCp4gGnM7eTMN2vLtzZHyjkOfzy9XAEInx026+upIGrziqKcDzmITYVAzM4
         GfQkkG43a2STyQIrTf2dwoJgWA1lhYZ7TwLMl0te+g4H5fb6me4gUVysK+F9iid/1nkh
         XsdpcLafAdQa/U5MuKyyRllfpm9unahNZe0eJyTv++XBLVgRmvmfCWtUJ7nueTurbGFa
         r/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792286941; x=1792891741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O3V+8QFK+YhdJo7dKVhm6ymn3bQ6rIsRKi+Lj8v8oNQ=;
        b=Yx+wUnTREFmQp43XAc+YJuwXekrwPFBjJz2nNe0KjRKjrpvxoW0nLddO3gYz7PoK6C
         w6HghX+mmkpXDUVZYbuBsffVba8SZWcQIUZrWawTaTOK0iC76n0GDWgt9WdGVe3ZgTK9
         Xocbl/jubpRAB40tu/cyRV9qCc4OCJAharJskkikX8r62HKCfLKBDvLqhMAuhOS0zy0+
         T4dgOQ3wDKCYnkM7TIllwcnJFSpAEeECaeAlNZiMaV2kmBlgaQ7WBNPDeBSWTcfu6qOh
         klfLRrVf8FrX7AsEmb88AcYDuKKk2AGj64WJSd0/B6TwjmdE0gBagmP20zvG7i1aTnZN
         pK2Q==
X-Gm-Message-State: AFq9FYKV4I15MzZvNFshp+1cOMPhu3XZsLylMQQ6oGRmYKMZ6JV4YrVU
	uczS3M4LuGrrGAho+1QjFZ/RMbU1ebjFmLXLKt6MnG8ahnFS1Nbyvqqit2tupfhUIyfIHqKDu2w
	+BmHDIoXPzVTWTlOl2oIqCjWOddAwMLmdj+W0OdtRW8SNsQpW6jmhHJ0tdHDqt12vQO+FhiqobH
	nN5GHcCNcsSJOkntm/wsmZZZxtqQVCDp0ENwIdTCcZ
X-Gm-Gg: AYBFou2RmckXFl8hEnd0eSUzN/WCET5+5lAmxcCBekgBU10oKxiSvZtayA+yAeBe9Ra
	NiRH2+FbgHft9UPx30H384iLnY8j2lR9CyML2tqR62ksQHYXNLaQU24P46jlAPP+zm8xipykPTu
	iGyE7ITx15GbZCD4wVbWDGKASEn0h3Atphy8QvDdijvoXquOLGIfwatqDaOb2Q7wKDhRVR47A1p
	7B8b6tgSUunkS1gD3NxBiQ8Wd6JyXp3BSPtuU2aWMv9MfMfcPEwDSzlwSjcrpWQv7fdgsVdTr8Q
	5fTGMqfD2f+vhQtRX6xVnP58irZS3J5VYLeSreryFcynVNR2HavMjIpCuO+LXFUGBkzp6I0yj1z
	ZgqtrmpBVg18=
X-Received: by 2002:a05:6122:1348:b0:5cd:590:c22e with SMTP id 71dfb90a1353d-5eaaadb9cecmr1722003e0c.21.1792286940753;
        Sat, 17 Oct 2026 18:29:00 -0700 (PDT)
X-Received: by 2002:a05:6122:1348:b0:5cd:590:c22e with SMTP id 71dfb90a1353d-5eaaadb9cecmr1721997e0c.21.1792286940132;
        Sat, 17 Oct 2026 18:29:00 -0700 (PDT)
Received: from thiccpad.redhat.corp ([179.129.232.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eac2c68171sm138814e0c.8.2026.10.17.18.28.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:28:59 -0700 (PDT)
From: Pablo Alessandro Santos Hugen <phugen@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] tests/keys: skip KEYCTL_DH_COMPUTE when unavailable
Date: Sat, 17 Oct 2026 22:28:55 -0300
Message-ID: <20261018012855.1795025-1-phugen@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 32f07cc40c9b ("crypto: dh - disallow plain "dh" usage in
FIPS mode") landed in linux 5.18, plain "dh" is disallowed in
FIPS mode per SP800-56Arev3. As noted in the commit:

> This change will effectively render the
> keyctl(KEYCTL_DH_COMPUTE) syscall unusable in FIPS mode, but
> it has been brought up that this might even be a good thing
> ([1])."
>
> [1] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au

keyctl(KEYCTL_DH_COMPUTE) returns ENOENT in FIPS mode.

So, this patch treat ENOENT and ENOSYS as non-fatal in
keyctl.c (because the operation is unavailable, not denied by
policy). SELinux denials (EACCES) still exit 9. Skip
test_key_no_read_t in FIPS mode since KEYCTL_DH_COMPUTE is
the only operation requiring key { read }.

Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>
---
 tests/keys/keyctl.c       | 15 ++++++++++-----
 tests/keys/request_keys.c | 15 ++++++++++-----
 tests/keys/test           | 21 +++++++++++++++------
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
index e13c655..261c00a 100644
--- a/tests/keys/keyctl.c
+++ b/tests/keys/keyctl.c
@@ -142,12 +142,17 @@ int main(int argc, char *argv[])
 	/* Requires key { create read write } */
 	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
 	if (compute < 0) {
-		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
-			strerror(errno));
-		exit(9);
-	}
-	if (verbose)
+		if (errno == ENOENT || errno == ENOSYS) {
+			if (verbose)
+				printf("KEYCTL_DH_COMPUTE not available, skipping\n");
+		} else {
+			fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
+				strerror(errno));
+			exit(9);
+		}
+	} else if (verbose) {
 		printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
+	}
 
 	/* Requires key { write link } */
 	link = keyctl(KEYCTL_LINK, base, KEY_SPEC_PROCESS_KEYRING);
diff --git a/tests/keys/request_keys.c b/tests/keys/request_keys.c
index 43b20d9..7cf7cd0 100644
--- a/tests/keys/request_keys.c
+++ b/tests/keys/request_keys.c
@@ -127,12 +127,17 @@ int main(int argc, char **argv)
 	/* Requires key { read write } */
 	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
 	if (compute < 0) {
-		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
-			strerror(errno));
-		exit(8);
-	}
-	if (verbose)
+		if (errno == ENOENT || errno == ENOSYS) {
+			if (verbose)
+				printf("\tKEYCTL_DH_COMPUTE not available, skipping\n");
+		} else {
+			fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
+				strerror(errno));
+			exit(8);
+		}
+	} else if (verbose) {
 		printf("\tKEYCTL_DH_COMPUTE key ID size: %d\n", compute);
+	}
 
 	exit(0);
 }
diff --git a/tests/keys/test b/tests/keys/test
index 061bc62..9e50633 100755
--- a/tests/keys/test
+++ b/tests/keys/test
@@ -29,6 +29,9 @@ BEGIN {
         $test_link_53 = 1;
     }
 
+    # KEYCTL_DH_COMPUTE is disabled in FIPS mode
+    chomp( $fips = `cat /proc/sys/crypto/fips_enabled 2>/dev/null` );
+    $skip_dh = ( $fips eq "1" ) ? 1 : 0;
     plan tests => $test_count;
 }
 
@@ -51,8 +54,11 @@ ok( $result >> 8 eq 6 );
 $result = system "runcon -t test_key_no_view_t $basedir/keyctl $v 2>&1";
 ok( $result >> 8 eq 8 );
 
-$result = system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1";
-ok( $result >> 8 eq 9 );
+SKIP: {
+    skip( "KEYCTL_DH_COMPUTE unavailable in FIPS mode", 1 ) if $skip_dh;
+    $result = system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1";
+    ok( $result >> 8 eq 9 );
+}
 
 $result = system "runcon -t test_key_no_link_t $basedir/keyctl $v 2>&1";
 if ($test_link_53) {
@@ -101,9 +107,12 @@ $result = system(
 );
 ok( $result >> 8 eq 6 );
 
-$result = system(
-"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_read_t $basedir/request_keys 2>&1"
-);
-ok( $result >> 8 eq 8 );
+SKIP: {
+    skip( "KEYCTL_DH_COMPUTE unavailable in FIPS mode", 1 ) if $skip_dh;
+    $result = system(
+    "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_read_t $basedir/request_keys 2>&1"
+    );
+    ok( $result >> 8 eq 8 );
+}
 
 exit;
-- 
2.56.0

