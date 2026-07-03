Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359F3955F9
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079311; cv=none; b=eNy2Y7T16r7jwP8ygmEUDNGcXIwJ8kpp0e6JtbBL+64X3yAd+y7Ml5Yuz2iWHsFLp5vNpoe8JzqmO7F3l8fb1WtMYWnUTufZ675jw06eSjgH8fMe6aNutgoKgc2zTxBueKFNGCk9Kjyv8SWn/7u1PuWbJV0MZplWcPZk021W5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079311; c=relaxed/simple;
	bh=fhS5LO9dtF4R5rMbiRRkamB5gDDhsq/XTLg8CB8hB2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZhbePhhRDzN9oPAVkwUGfZ+ITs+uTJT7qdF6DGPYgHpQA1okVbvmOsjd9GTN8whxBRX+Hciysghe5OrRTgvDB9RkTtrApLgutfRwHynbWUyZm80j3G4ZWt0z7KRSpAdOwPTB/jRMWeYtP2VtSu5ssZIBMny+Sx/j4wbh8zACYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZxjD2uJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsqmZPq6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZxjD2uJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsqmZPq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783079309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=83K4PwPudgu635DZo+616aA96U6Y1s89ZFL1BvxYAi8=;
	b=QZxjD2uJO2uu6yPNeqxw0Z61eyt9AAxUptjvmUBycsEGhTwATcnoFjXms8v978kzsBhC8w
	PHf6VSGmCHjCJF0EI4NiLjrEIw/G6dKTh2Ybo4b1w9XXS8TmEKXp1peaOykZDoJnbooeO6
	kzssqvJ+9uESozxmsA+MpKJjC282Cx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-2oV9xGT5O82QVbFJi-w63w-1; Fri, 03 Jul 2026 07:48:27 -0400
X-MC-Unique: 2oV9xGT5O82QVbFJi-w63w-1
X-Mimecast-MFC-AGG-ID: 2oV9xGT5O82QVbFJi-w63w_1783079307
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4744b72f90bso398480f8f.0
        for <selinux@vger.kernel.org>; Fri, 03 Jul 2026 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783079306; x=1783684106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=83K4PwPudgu635DZo+616aA96U6Y1s89ZFL1BvxYAi8=;
        b=TsqmZPq6Ucp8vj0z918nyuocrchpUFZMdX9Y7A+Yq7QHwtBpddFnVnP1GoszsOL5ne
         ww1AwbNNFn+fxiq2pVIrk4vaJJt0wtd9FA/mUPUgiC09PS6pJBR5McfXsM2gzcWkLBtl
         0u3H5uUVUd5FucVcNzF4BsJRPxiTShcCseSvdTBtLEBHXLh719VhGsmqw14lJzGIboFM
         Zi5C0pVUp2nL0TVubqhfGVmaMbxK02XodLI1QtLEJSLQ7VjQLUBjkPHXSM+uMIPeEKjg
         Yw7XIL7BDAK1eQjzJHVv0nSo+MBOGYsQ15IRgmZo2XDK/7Vc7SkrcoUlJBNxsMBBiPLZ
         svvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079306; x=1783684106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83K4PwPudgu635DZo+616aA96U6Y1s89ZFL1BvxYAi8=;
        b=kt+N063TaSo6GuyVU7rXlMO5oFbw77oQ0zYrTYyEWXo0zvyk6ykFA/7EBuPhu6toAC
         9pyv4K1rP7+r+/JNBrtW+lEdz8MpyYrBFkkf57cvgxrd0EtLppJtXDO5jzxI9m6vrOzP
         77cA65kXLD2lTn0KB8gdjCEng6rZS3MV2oppbo/qWu3PhCFX/ropGPsD/0tH/UjcPoXb
         aKQbSZ/k4ULVUpMa5i5StUg7z1Ew3hsPd2QTKP8X6gKQzOiJsJgcwpR9l0720DQi+KGt
         5O+Wx5OlqNfM1RTbIs9WTSmTJk1sJEBkxeSonqkLFp910khAa+8P9IAkYrTDhbztCHRj
         iEzg==
X-Gm-Message-State: AOJu0YyDVVcHwA4kJA4SKwmohsYIitIfdHm33gwfNdNdq12JBHSN5l8u
	GAxdclYWXEd+JUVkCzbFHEjU0lHGwdoI0u8XaHBtsTaWeqSwLYftV3Rp4BMJ31jpkWch2Nkr5vH
	QNYpz3rnMmMb9CcM054mxXTQE/LcIGwcvDRAZM1rtrg/jKqpS/XpbX354p8UsOwVIiY+ERXRQQk
	Eg85tcuzUnAbTPy8AEeCPoyvZS50XOEqU7b1mhMeWWt7U=
X-Gm-Gg: AfdE7ckYBGPF+XJTwaI1xwVYwg4EMgtp6ADzfDaagfxOdtYGXz+dlTXXyNksCKGpdDY
	N65PUwKWzrKm78Hk5rzKHKitshCorwD0r4S+rIIcuoh+8Ic3SpKy8MYdsRO5vsHvsY0R5maLZCV
	CjidRyHcJdWFji5gKbwXbgiLeTHZjZn9bSDeDjom1mppVTdN+6YFh0wQGpuVRQAPJocZftnNAYa
	p8aBJLPtgUsnGQG7FpTP/UeR8GictqRYSBB+dlusxVa8xH3jgB+lfixrZEa1UGGQvAXyXIwqwpM
	LWuj4caW9MWUztJUHQQgQ5V6JLFF6uc/mCmVGE/sGIfY+SRWI1EfrbbuSyA3+F7f8a8R
X-Received: by 2002:a5d:408c:0:b0:477:6da:1b8f with SMTP id ffacd0b85a97d-4775a0fdfc0mr11921493f8f.34.1783079306394;
        Fri, 03 Jul 2026 04:48:26 -0700 (PDT)
X-Received: by 2002:a5d:408c:0:b0:477:6da:1b8f with SMTP id ffacd0b85a97d-4775a0fdfc0mr11921449f8f.34.1783079305791;
        Fri, 03 Jul 2026 04:48:25 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cec5sm16907174f8f.19.2026.07.03.04.48.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:48:25 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/overlay: verify that execmem is not checked for the mounter
Date: Fri,  3 Jul 2026 13:48:16 +0200
Message-ID: <20260703114816.1244235-1-omosnace@redhat.com>
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
---
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
index da1ae36..ccf955e 100644
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
+			  strcmp(argv[2], "EXECMEM")))
+	{
+		fprintf(stderr, "Usage %s <file> R_OK|W_OK|EXECMEM\n", argv[0]);
 		return EINVAL;
 	}
 
 	file = argv[1];
-	rdonly = strcmp(argv[2], "R_OK") == 0;
+	rdonly = strcmp(argv[2], "W_OK") != 0;
+	execmem = strcmp(argv[2], "EXECMEM") == 0;
+	flags = execmem ? MAP_PRIVATE : MAP_SHARED;
+	prot = PROT_READ | (!rdonly || execmem ? PROT_WRITE : 0) | (execmem ? PROT_EXEC : 0);
 
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

