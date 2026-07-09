Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CA1BC2A
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602049; cv=none; b=Bh4w5Qsqw6RtQtbk243OD2/ehAbn609iu5iRUvlZbf8Y5PZZv8Q3Bnwvph1RlIy2vkgounzOpid5kp9qa7xF+nUWRm9YyUZCqf1gRUTU9IWUENUbhoS00TfvV4VOjxOBRWExtJF6qwY4DPPVBgXbjqkMQFVaCjnIFT8DCh4QADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602049; c=relaxed/simple;
	bh=zLMXeYMhyPqUNzlxSUc/Ug13gJsNJq2OfxemJIOXWD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMSVjN0/QN0qY7273R/k4K9XNyqQRHbMhLNlPXfAi3O592BUKnGPalyYC88xDc9ZImuo4sG+IywoteLIN1eUbRb//fnJp0qgC3Ez7Z92LCRIZoIIW86GsbMpOwQNcOiar2/nnMvbAsLUwL+E6TMnh0/vn/h/wbDksxglcvfH7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Si8G3Akv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh2l0fvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si8G3Akv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh2l0fvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783602047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=033rzxQvzf78T3iiOLc2LGFJcv2JXn8xjAl3sUcVqFk=;
	b=Si8G3AkvcpO23VOffVNKbB2wllQXqpJkBTjHcnlzW9GXhn5niv49cOjG9nQgls8nIylW9J
	siu9Ls0jrTQyh0CEOjwSeoo8ZXphES0rvrPFnjmXjqewJ+byjnvPJGj0CtNTs28cTtQM+a
	grTrle9TNzmsryBGVqkRa9Zasw0MaXM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-27pE5UWSMzaM-J8DtHy5oA-1; Thu, 09 Jul 2026 09:00:45 -0400
X-MC-Unique: 27pE5UWSMzaM-J8DtHy5oA-1
X-Mimecast-MFC-AGG-ID: 27pE5UWSMzaM-J8DtHy5oA_1783602044
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47deed1aeb4so454516f8f.3
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783602044; x=1784206844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=033rzxQvzf78T3iiOLc2LGFJcv2JXn8xjAl3sUcVqFk=;
        b=Kh2l0fvpNovJ4blLvlDsjhQSIQd/9gw0YbjyDdS7h+Hk8yptALjvtMUUOf0k5lyfAY
         JOHaiZj8Y6ua0hZZNZnFxyykpX4WWB/SqJSQI4OGr6Ir4aM3QdK112AeqbWYIrWAh5Xm
         WUiF9qGXwOYBUtkmHgwf0ktWGFkqcvMmEkeIRfKYq4o61bsYdZm50fU3fpT3lAKYIKTu
         TWoN3y0/pkT+BUhjFKFkhc9/xEkoypTIq23eh2PnKxb0V5E+Sj6hwCNqi3Bw4sNy5Cye
         cLO2Fq1SOJYpkaWyULN4xuMpwif4xgbaj9EI3e2xVBRgh6k4R84VdGtc6orrwOvlYg2z
         3v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602044; x=1784206844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=033rzxQvzf78T3iiOLc2LGFJcv2JXn8xjAl3sUcVqFk=;
        b=GrqNxEKDeNFneZ/3ciwGOHSusy3f+Q6tLx+uHourUaRFLLYooh7UQ2Smiah38VpmL1
         26qSpapKDCzhskdi672Pucbtf7em/zyd71+8uO0YAjlwX9GXKfvu+1EvDErK1EEkPl8D
         sAsEs5Nqp4WzATJqKkAnCKCsMnX7+29pokeeFDXQS74XwR/K0aF/xeR4kU6il+cJZkDr
         WsJFHJOQyYi8PBq0aclUVDmvMecwK7RML7OBhNBrLs2xjNNJcL1L2fP7HuR1bmP2LW3c
         qy49bpTIVdVp7LCdJ+Y120IVE4FiozPQRr7XAjfkTkT/OPK06RGbbVTvw1YkBVZxFdTE
         UrCg==
X-Gm-Message-State: AOJu0YwK3jG9MpCLPyCU8KvxVlVCM/emtb2kLXKLpTilnT0ksszRqzMk
	vdUFpTXsmqMIDoTx8LmhlhkjWB4w6KQgdpLIeXpw2Rsu08bB/sAes5xEc2bdL2iyEsurgDp6wSx
	TkMmlz/XLi3g+Ieh0bRI6VSmlTvsiy3Yk6S/BAzB0kcr3P1hmj30MKXuziGbNAi7FDjogI0Zs4c
	7skHYfUpXxeOS8LGwXXtOzRGiZT+9zioE6l3eNT/Q84ak=
X-Gm-Gg: AfdE7cmGAtC0lkloeMy9dEF0QnJCVtiyGti4ISVIhvi23Kl/OySH5QncCD4a17o+wER
	3J9Nkin1GfDufFQYuLk7IHjgWMke7QW/0gvde2qwaoDTzTOot1CKOGUoYgpVvhvamG8x3qn8P2Y
	vANTZ1hWIBjjFpcRIW1EtMYcW8fHDCd3UGoR8duIvlD/wV+sqzLjGBVnbuHLbbBnUjwaP7fRrxU
	2aXl5pqmkzBOPv9PKNYDvop8MtvWemFE+G4qGbdWshyCTWiAAtERGDrI6/qqrjKfietOxd8VUPn
	BxXBpAfKPe1jvzLnOs3BRAJF0YuWspZH2xr5t7dFULyROHyc08LeaY0MfGLnUkdQ3p8ir9lpPde
	F758VybCDzV+rCPOe9wxR8Gcx
X-Received: by 2002:a5d:5e03:0:b0:475:f0f0:9ecd with SMTP id ffacd0b85a97d-47df0818268mr7889556f8f.56.1783602044146;
        Thu, 09 Jul 2026 06:00:44 -0700 (PDT)
X-Received: by 2002:a5d:5e03:0:b0:475:f0f0:9ecd with SMTP id ffacd0b85a97d-47df0818268mr7889457f8f.56.1783602043278;
        Thu, 09 Jul 2026 06:00:43 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:102b:4004:ea06:68fb:2122:49a2:546c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm52757824f8f.0.2026.07.09.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:00:42 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite v2] tests/overlay: verify that execmem is not checked for the mounter
Date: Thu,  9 Jul 2026 15:00:40 +0200
Message-ID: <20260709130040.76391-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that verifies that the execmem permission is checked only on
the process mapping/updating the memory region and not against the
mounter credentials.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---

v2: apply tools/check-syntax formatting

 policy/test_overlayfs.te   |  4 ++++
 tests/overlay/map_access.c | 20 ++++++++++++--------
 tests/overlay/test         | 11 ++++++++++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index 787685c..e1e1ebb 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -122,6 +122,10 @@ can_exec(test_overlay_mounter_t, test_file_t)
 allow test_overlay_client_t self:dir list_dir_perms;
 allow test_overlay_client_t self:file read_file_perms;
 
+# For testing execmem checking (should be checked only on the client,
+# never on the mounter)
+allow test_overlay_client_t self:process execmem;
+
 mcs_constrained(test_overlay_client_t)
 
 kernel_read_system_state(test_overlay_client_t)
diff --git a/tests/overlay/map_access.c b/tests/overlay/map_access.c
index da1ae36..6160563 100644
--- a/tests/overlay/map_access.c
+++ b/tests/overlay/map_access.c
@@ -11,15 +11,20 @@ int main(int argc, const char **argv)
 {
 	const char *file;
 	void *ptr;
-	int rdonly, fd, ret;
+	int rdonly, execmem, flags, prot, fd, ret;
 
-	if (argc != 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W_OK"))) {
-		fprintf(stderr, "Usage %s <file> R_OK|W_OK\n", argv[0]);
+	if (argc != 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W_OK") &&
+			  strcmp(argv[2], "EXECMEM"))) {
+		fprintf(stderr, "Usage %s <file> R_OK|W_OK|EXECMEM\n", argv[0]);
 		return EINVAL;
 	}
 
 	file = argv[1];
-	rdonly = strcmp(argv[2], "R_OK") == 0;
+	rdonly = strcmp(argv[2], "W_OK") != 0;
+	execmem = strcmp(argv[2], "EXECMEM") == 0;
+	flags = execmem ? MAP_PRIVATE : MAP_SHARED;
+	prot = PROT_READ | (!rdonly ||
+			    execmem ? PROT_WRITE : 0) | (execmem ? PROT_EXEC : 0);
 
 	fd = open(file, rdonly ? O_RDONLY : O_RDWR);
 	if (fd == -1) {
@@ -28,8 +33,7 @@ int main(int argc, const char **argv)
 	}
 
 	/* try direct mmap */
-	ptr = mmap(NULL, 1, rdonly ? PROT_READ : PROT_READ | PROT_WRITE,
-		   MAP_SHARED, fd, 0);
+	ptr = mmap(NULL, 1, prot, flags, fd, 0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
 		return 3;
@@ -37,13 +41,13 @@ int main(int argc, const char **argv)
 	munmap(ptr, 1);
 
 	/* try mmap with PROT_NONE followed by mprotect with full access */
-	ptr = mmap(NULL, 1, PROT_NONE, MAP_SHARED, fd, 0);
+	ptr = mmap(NULL, 1, PROT_NONE, flags, fd, 0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap PROT_NONE");
 		return 4;
 	}
 
-	ret = mprotect(ptr, 1, rdonly ? PROT_READ : PROT_READ | PROT_WRITE);
+	ret = mprotect(ptr, 1, prot);
 	if (ret == -1) {
 		perror("mprotect");
 		return 5;
diff --git a/tests/overlay/test b/tests/overlay/test
index 2d0555a..ae8ec33 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -19,7 +19,7 @@ BEGIN {
         plan skip_all => "overlayfs upperdir not supported on NFS";
     }
     else {
-        plan tests => 135;
+        plan tests => 137;
     }
 }
 
@@ -641,6 +641,13 @@ sub test_68_8_ctx {
     return;
 }
 
+sub test_68_9 {
+    print "Check execmem map access on mapreadfile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/mapreadfile", "EXECMEM" );
+    ok( $result eq 0 );
+    return;
+}
+
 sub test_70 {
     print "Check unlink access on client_nounlinkfile, should fail.\n";
     $result = system(
@@ -891,6 +898,7 @@ sub nocontext_test {
     test_68_6();
     test_68_7();
     test_68_8();
+    test_68_9();
 
     print "=====================================================\n";
     print "unlink tests.\n";
@@ -1033,6 +1041,7 @@ sub context_test {
     test_68_6();
     test_68_7_ctx();
     test_68_8_ctx();
+    test_68_9();
 
     print "=====================================================\n";
     print "unlink tests.\n";
-- 
2.55.0

