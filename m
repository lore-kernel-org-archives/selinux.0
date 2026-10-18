Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36026FA4B
	for <selinux@vger.kernel.org>; Sun, 18 Oct 2026 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286960; cv=none; b=ZcQiCLUmENtvGOW2/UYk59b+zW+g7hl7NjWjmsH5J4Lu+HuRrGbzszDFVDVRa9xEfuOJmwxKDHNG3y+mZaTdcZwuLFtt1lwR6dAKjQ76tpsyGrZa+XyKeG3vpP1XiFDWDc+1WqwUm1oRdi3J9uUZsswdhBqTWet+tv7bYGmdK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286960; c=relaxed/simple;
	bh=+cWf5taTJ2l7gE8QduybTjAfuoQ4+4A/HtH4ksbHkF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PRisLeKiKptihq0D2wbO3W6bvgmQy+3Mb/f1Wq3EsNoloeG+tR6VIbL9LDrAbBTCLfheZCRdkQKvxohKc/SQj5VNb849h3yGT+hPHh1u65XxAl3eTFvn2Mtwg0eKnXJ08EySQxWaQc35sFfkvKa2JEH9WotVPd1tU81UfMsGzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY8/J2d3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvVHMxtF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY8/J2d3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvVHMxtF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792286957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYZGo/G0leMUbrA2p6zY8+tgobjmEUYi3dDNsTIC1Nw=;
	b=WY8/J2d3TxG4CEH91YmCuRuwqSUYiaVnQ8509HHyPYpFbdw7gp0E/Ceo6rpFKB+8EfTQmG
	yomGBZnp6tzZZY/z+esaKyxyiwJhM9QLB2ubXJjY02wi4PCcaCzj8MsGgdPVHjcd+4vzhd
	55CJZlsuR5ybElOLly13KwOM+Nlmsr4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-joH-Y2Z1Mg-NhdsNnnirxw-1; Sun, 18 Oct 2026 01:29:15 +0000
X-MC-Unique: joH-Y2Z1Mg-NhdsNnnirxw-1
X-Mimecast-MFC-AGG-ID: joH-Y2Z1Mg-NhdsNnnirxw_1792286955
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e944179148so1411007e0c.3
        for <selinux@vger.kernel.org>; Sat, 17 Oct 2026 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792286955; x=1792891755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYZGo/G0leMUbrA2p6zY8+tgobjmEUYi3dDNsTIC1Nw=;
        b=JvVHMxtFFN656TUhaN5KXH1dFEpDhkdZ4+2uLdb54/GSHYz68pjXTOtuOcYbxXFRAH
         u+27khzMS+P2XPeqP/rqgeT6i6eTCOH/Do0jcFnzCdtX82EcUbimQz7dJG/m5g3I4VxR
         zfM9KjMbAsRJVtIyD+LIEwGewUbRqTYfnJgXmeYZFsAUiLqQNW296Zcw26XOswSsrCjA
         L+QUJ0QtpUyeG/zMr82lQ4UcHKg21RXXKAzPDNo4hyIUs41JumFssALTQXWdBOnvdJ1t
         eonnXWh94j6jcMi6eyZ/OcZ9peVrHZroBHYseN/BIh7H2whVYkt/lIhxvJZyMDg+nY4s
         BRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792286955; x=1792891755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DYZGo/G0leMUbrA2p6zY8+tgobjmEUYi3dDNsTIC1Nw=;
        b=VnfqFhCIgvwZBz1PehsVZIlJ1SN4puib6SPiqfyMHFN7egCBUegIpfG95Li2DilE7V
         IVe1AcX+ZzFTJGUL2eZ6woL3XRazj37ah0at8R1DCknVGpI+euKyEYYWp5pZfJE/7wzn
         fL54yl4GfpysPqC42/OFRUKNCel6TklOlEZk6AQnUbym9dNO/1y9eECa8372eYUE5V6G
         vqWrH4AfIT4ysVYnmgCICyEv2Lw6AXwMJuqdBojZdtkiCJlJXQsCwCNCYhnrwDS+J766
         pQs1vhJLMYH9efYtcL+Pe7MJSoIolGN7vYAUMEHH4Cs8OALJHog7PfzJ/1+MjOIJKFvj
         4PnQ==
X-Gm-Message-State: AFq9FYKTxFRq/2ryTSfwnNwBNnjnk2h5b4txF65755PgiXu7wwcvpFT/
	GQiTR/YO72ygLaX2e1y6WcK+ihBR59LTnjeoEksb3m98a2An+38L9r7pXsbGj42iyN8r0MFpLja
	VP1qlYOvmzfJgVPnQ4Y4eRj5x01DYyVPexb8a7PTIWhoO0zpiqzkH8y/h4v5yw1t66J+TPhGeB+
	DpsiW7d7RSxh7rVLWoQjU7CwGoSynfvA0luqp+mbtm
X-Gm-Gg: AYBFou1i25emSihPJBi0bRj6ewvONDnWHcayOBCW+POhMxqoP3gOYKaIjBTHCd+crS1
	kr3jqX1ozMFTuHxRfl0T0AA0G35uTnTaB4dAuzbtumHWb7Sr3dtJcoIKp1pAErf0sSX2cJEr6fD
	LQGrsjq14ywB9nFs2VqD9ZialrzQ05T4kcb0qxL3MWJnQyrHasVU7MHtIxRtGesZsS4fzCVUC90
	On9DXuF62f/F6NYLEU4d8pAWJ+WPw70JxXrxQysIU1dkjobJHdbmtWSbNMGY2QOKUzkhYaTnObj
	olrJXBBNlo5qKzJFV1QlsZJJXAi2edfR+N6RtbZ2pHDkiElhR9XiXIPQmw7TjXlIJxQg6f2jJ1C
	f9fHFcLdZ2Yg=
X-Received: by 2002:a05:6102:418f:b0:7cc:306:d3ab with SMTP id ada2fe7eead31-7cc3670bf24mr1463630137.5.1792286955170;
        Sat, 17 Oct 2026 18:29:15 -0700 (PDT)
X-Received: by 2002:a05:6102:418f:b0:7cc:306:d3ab with SMTP id ada2fe7eead31-7cc3670bf24mr1463626137.5.1792286954555;
        Sat, 17 Oct 2026 18:29:14 -0700 (PDT)
Received: from thiccpad.redhat.corp ([179.129.232.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc197e7362sm6264503137.4.2026.10.17.18.29.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:29:13 -0700 (PDT)
From: Pablo Alessandro Santos Hugen <phugen@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] tests: fix format string mismatches on s390x/ppc64le
Date: Sat, 17 Oct 2026 22:29:09 -0300
Message-ID: <20261018012909.1795176-1-phugen@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast printf arguments to match format specifiers across
filesystem/statfs_test.c, binder/{binder_common,client,manager,
service_provider}.c, and perf_event/perf_event.c. Types like
__fsword_t, binder_uintptr_t, binder_size_t and __s64 differ
in width across architectures, triggering -Wformat under -Werror.

Fixes: cb49040 ("tests: fail on compiler warnings and enable Wextra")
Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>
---
 tests/binder/binder_common.c    | 10 +++++-----
 tests/binder/client.c           |  4 ++--
 tests/binder/manager.c          |  2 +-
 tests/binder/service_provider.c |  4 ++--
 tests/filesystem/statfs_test.c  |  2 +-
 tests/perf_event/perf_event.c   |  4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index 7cf6c74..6f7e5b3 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -65,7 +65,7 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 	size_t count = txn_in->offsets_size / sizeof(binder_size_t);
 
 	printf("\thandle: %d\n", (uint32_t)txn_in->target.handle);
-	printf("\tcookie: %lld\n", txn_in->cookie);
+	printf("\tcookie: %lld\n", (long long)txn_in->cookie);
 	switch (txn_in->code) {
 	case TEST_SERVICE_ADD:
 		printf("\tcode: TEST_SERVICE_ADD\n");
@@ -101,8 +101,8 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 	}
 	printf("\tsender pid: %u\n", txn_in->sender_pid);
 	printf("\tsender euid: %u\n", txn_in->sender_euid);
-	printf("\tdata_size: %llu\n", txn_in->data_size);
-	printf("\toffsets_size: %llu\n", txn_in->offsets_size);
+	printf("\tdata_size: %llu\n", (unsigned long long)txn_in->data_size);
+	printf("\toffsets_size: %llu\n", (unsigned long long)txn_in->offsets_size);
 
 	while (count--) {
 		obj = (const struct flat_binder_object *)
@@ -111,7 +111,7 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		switch (obj->hdr.type) {
 		case BINDER_TYPE_BINDER:
 			printf("\thdr: BINDER_TYPE_BINDER\n");
-			printf("\tbinder: %llx\n", obj->binder);
+			printf("\tbinder: %llx\n", (unsigned long long)obj->binder);
 			break;
 		case BINDER_TYPE_HANDLE:
 			printf("\thdr: BINDER_TYPE_HANDLE\n");
@@ -135,7 +135,7 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
 		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO");
 #endif
-		printf("\tcookie: %llx\n", obj->cookie);
+		printf("\tcookie: %llx\n", (unsigned long long)obj->cookie);
 	}
 	fflush(stdout);
 }
diff --git a/tests/binder/client.c b/tests/binder/client.c
index 220d37a..a35fd7b 100644
--- a/tests/binder/client.c
+++ b/tests/binder/client.c
@@ -111,7 +111,7 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 
 	if (verbose)
 		printf("Client read_consumed: %lld\n",
-		       bwr.read_consumed);
+		       (long long)bwr.read_consumed);
 
 	cmd = binder_parse(obj->fd, (binder_uintptr_t)readbuf,
 			   bwr.read_consumed);
@@ -435,7 +435,7 @@ int main(int argc, char **argv)
 
 		if (verbose)
 			printf("Client read_consumed: %lld\n",
-			       bwr.read_consumed);
+			       (long long)bwr.read_consumed);
 
 		cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
 				   bwr.read_consumed);
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
index f7f1723..14e3e0c 100644
--- a/tests/binder/manager.c
+++ b/tests/binder/manager.c
@@ -349,7 +349,7 @@ int main(int argc, char **argv)
 
 		if (verbose)
 			printf("Manager read_consumed: %lld\n",
-			       bwr.read_consumed);
+			       (long long)bwr.read_consumed);
 
 		binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
 	}
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 1e6b490..40734a2 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -384,7 +384,7 @@ int main(int argc, char **argv)
 
 	if (verbose)
 		printf("Service Provider read_consumed: %lld\n",
-		       bwr.read_consumed);
+		       (long long)bwr.read_consumed);
 
 	cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
 			   bwr.read_consumed);
@@ -455,7 +455,7 @@ int main(int argc, char **argv)
 
 		if (verbose)
 			printf("Service Provider read_consumed: %lld\n",
-			       bwr.read_consumed);
+			       (long long)bwr.read_consumed);
 
 		cmd = binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
 
diff --git a/tests/filesystem/statfs_test.c b/tests/filesystem/statfs_test.c
index 310b66d..4a318d2 100644
--- a/tests/filesystem/statfs_test.c
+++ b/tests/filesystem/statfs_test.c
@@ -59,7 +59,7 @@ int main(int argc, char *argv[])
 
 	if (verbose)
 		printf("statfs(2) returned magic filesystem: 0x%lx\n",
-		       statfs_t.f_type);
+		       (unsigned long)statfs_t.f_type);
 
 	return 0;
 }
diff --git a/tests/perf_event/perf_event.c b/tests/perf_event/perf_event.c
index 0e8bdce..b8d3dae 100644
--- a/tests/perf_event/perf_event.c
+++ b/tests/perf_event/perf_event.c
@@ -161,7 +161,7 @@ int main(int argc, char **argv)
 		if (verbose) {
 			pe_page = base;
 			printf("perf mmap(2) return value: %lld\n",
-			       pe_page->offset);
+			       (long long)pe_page->offset);
 		}
 
 		munmap(base, mmap_size);
@@ -178,7 +178,7 @@ int main(int argc, char **argv)
 		}
 
 		if (verbose)
-			printf("perf read(2) return value: %lld\n", count);
+			printf("perf read(2) return value: %lld\n", (long long)count);
 
 		close(fd);
 	}
-- 
2.56.0

