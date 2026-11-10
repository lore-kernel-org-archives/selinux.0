Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325370;
	b=gtOsYaqmbatxMAoKNlHAPCza5naDQpCH8/Pz/PQvL5mem9zCW7NgCwuUr9U7u79PTyuK
	 XCtvarZYdb4DFnmSASUxOnTmDkuAfIsKzgcQ8IlKtOKxGtwGHSUSAhCVt71BoVrJ4CXMA
	 q/Hy0LZeJZraz37K6Cz9/oR/N30nL/78fH5vCgxiwQ8Nd6ip3jXXWvsZjha586ggM4BuE
	 kVO7qr2ICUT5FyPQluYuYAPVKh15v4gi/y4p19E5ofbwXw02efzlJ5dh2UQMMB4TR0CwF
	 8rWxKcHYTy3rJdOmnGM61aW3RqdRg53ynIB0LsJ9cYU9ws1qcLaRVZig3FN6/qX00rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JEwcdKPr70GiIqBNpCo2iy7Lvi7Dl/y4v62zuj6UR/g=;
	b=zhLEYJTOJoz7fsPiy3ZDIhYHagxCt3MuwduikK7Ha6qtOMEt8bvgkxIQhcTvzchL7yAJ
	 0kvjLT2Hydqveq8mg+8Z2QYXY9L66HMq3bdUG6hGrv5+GTTdmDeNOBG3sxFePXYl8C4JS
	 Uzs26BjfNND3wduq/aXNiHcaowjDzCJOKLZqk34ovlDkRZPEjuIPdtPjbQpmBh+e7FOBb
	 k1b0KKXITzVtzvOiqs9ia/ya0ICHoUuqnG1v7VRJ7P7UZKkGlRDjIGH/CzkEzK9hi0nOC
	 meqirOYFHddieVZRBIU4eq2SfJMvcox4HHGx3JAmr7aiRcOF2BuJMgv/4Q6uqKhyrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aK/hQkrZ";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07356606D74E
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07356606D74E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aK/hQkrZ
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-537548b811aso16896141cf.3
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 07:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325369; x=1794930169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEwcdKPr70GiIqBNpCo2iy7Lvi7Dl/y4v62zuj6UR/g=;
        b=aK/hQkrZmopE4XbVkTP/lMeQa5YNAMRTwmprUguTocWSxLbQYcdVXZC632yyFYW485
         2QfKKk0qKAsY24g1+giEwYVI5GMFgos0t9UFY0rY3L3xTl9gw7ckpEi5Jc02e/NrjYKx
         7n539X7Wrbipv9/ZKOeZQpZ4tiZY4IQLfH4Ojcic8kpPqipQ216canQB2Boh5F1toJBj
         wseAq7bWVefp6FN7QfuF8Ct6a7BII5ARPD0LiAOgtrIvMKYeNhLmiT7nzyZgJijJKHlJ
         AdaemUw0JXdPP06PMzjHPNGz4C/z1yCBGrRRctdMqLxxIBKG+e5K9eUEaw6JQcaacJni
         Tnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325369; x=1794930169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEwcdKPr70GiIqBNpCo2iy7Lvi7Dl/y4v62zuj6UR/g=;
        b=wF9QzAp+OuppIzMIPiR6+f0MTS/5Bsrq+xxBsgIKM+tW8jKrnGyXrZyqc5dTP4Eo4q
         GmM4WIySA+MusydsmkMPs9+sFg8xpeIkJgBQ3Ihwtwl+/xgjwk/tma+w21+SA3GJbiYj
         6Dr5hGQCqTRF97l9BmTaETaTBgFkDF4b2ZmktSk8zrQxhYww8nADiVvwQAlL6Cd7ewBd
         zF9QezLNr6dJbFRaU7aZGrrrQoo7G6CaGJXGd+7jXwq/v3x+GONtuThM4bvJRbj44Vo7
         RsyNmZ0lzeUo8OiXkteHMsFVM5AmpJaZsWWhjscbz33FNt8+g+uGsZMIcgrR4U9QQscV
         lI0w==
X-Gm-Message-State: APuU4Z/BDBIp6pinV3A0NTrx9s7Ai/H7ZF2/31KFI+1rTzMw6GcRukFS
	NvAsf+LygcLhb7h2+2UgS8h2/rthtyEpSMXSmM5tjpbyaItYd4r/QIQBRMfh5Tpo
X-Gm-Gg: AYBFou1Oc9Ac/swSlNosVOXKgQj4mE57QCNpHQhuWlJOcJZAXQBRisekpjbbfdWQrwq
	4ic54ao8+2J0QfEz5Hy615tZ/bvcvNIY18NyMVmGZ9tsNWx34EjUd1UchaFNgGhS6ln072nMJ0P
	TNaHvY04JAJuZX2gwvRwY7whUdMqCEG4hkC9c4bi9hyv3sru13J59gePanjCTD0spAw5IMcJsG3
	oi7MsuQJb/qVh9TlsoVfSH3HiVpGrHtHpHQ2M44fype+OXzW34O9Lg5VffZkDFS0b04YI36hF0b
	ixMkjMeq3yzTjdCVyMyxExocl7Hfa4u6ZlvrOHLlMCpJ+pJ1VDb2RH9jd3qLRKrDshSrW9Qrwu4
	Kg3sppP6WT4iHghm9f2sV6mmSjZvR6DZEqeqfgjSgcIx0zypPDp3319B/9USg9corYHgYukeyDJ
	YRcES9eRbArGZseGY5eVCQYSEzcyHyhi/Es5ZsyJgfgNNbUYPxBe3C6RiIUzhoxKuEVN+yEGYBc
	jAhcLp68pMzlHXl9bECWK/NZQTVC6qNSJ6levmeUkf9pvwPUVQZjIxwNaHuLixY0OxRyah/NU79
	CGsvjl0oHRtyKpL7IABbcLHOYorIZFKMH7FnaEvWOV5OqBbatGGo3J984XMwvEf5LqiiMBfxVsb
	PpqVJWGAgNfSR1oWkpTCqSvhjqqE/GGv79cHbvRwT7KwbnkXUPDwTtrREdqdp8UwBiHLaNyHnzx
	Vk8KeikXLoYye+Q3j72Qfq9HNkDjszhPsfSdC+GPZPYNp/IGyeD/fcTjPbH0DVKXhfy24=
X-Received: by 2002:a05:622a:181a:b0:532:acb9:595d with SMTP id d75a77b69052e-555253df951mr41592161cf.8.1794325368683;
        Tue, 10 Nov 2026 07:42:48 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550ba432c4sm26379661cf.20.2026.11.10.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:42:48 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	jeffv@google.com,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] tests/binder: fix binder tests to work with the Rust binder driver
Date: Tue, 10 Nov 2026 10:41:26 -0500
Message-ID: <20261110154125.31153-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the original Android binder driver it was possible for a process
to invoke binder transactions on a binder fd opened by another
process. Hence, SELinux originally implemented an impersonate
permission check to control such usage. This however was never used in
practice by the Android userspace and never allowed in Android SELinux
policy.

The Rust reimplementation of the binder driver intentionally prevents
such impersonation from ever happening, failing such operations with
EINVAL. Update the SELinux binder tests accordingly to drop the
testing of this now-obsolete SELinux permission and to not rely on its
availability for the other tests. It doesn't seem worthwhile to retain
the test for the older driver since it was never allowed in Android
even when it was possible.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 just re-runs ./tools/check-syntax -f to fix a formatting nit.

 policy/test_binder.te           | 23 ++------
 policy/test_binder_bpf.te       |  4 +-
 tests/binder/binder_common.c    |  4 +-
 tests/binder/client.c           | 97 +++------------------------------
 tests/binder/manager.c          |  5 --
 tests/binder/service_provider.c | 10 ----
 tests/binder/test               | 28 ++++------
 tests/bpf/test                  |  4 +-
 8 files changed, 31 insertions(+), 144 deletions(-)

diff --git a/policy/test_binder.te b/policy/test_binder.te
index a267a85..5f80648 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -27,12 +27,12 @@ allow test_binder_provider_t test_file_t:fifo_file rw_file_perms;
 
 #
 #################### Service Provider no fd {use} ###########################
-# test 7
+# test 6
 type test_binder_provider_no_fd_t;
 testsuite_domain_type(test_binder_provider_no_fd_t)
 typeattribute test_binder_provider_no_fd_t binderdomain;
 allow test_binder_provider_no_fd_t test_binder_mgr_t:binder { call transfer };
-allow test_binder_client_t test_binder_provider_no_fd_t:binder { call impersonate };
+allow test_binder_client_t test_binder_provider_no_fd_t:binder { call };
 allow test_binder_provider_no_fd_t device_t:chr_file { ioctl open read write };
 allow_map(test_binder_provider_no_fd_t, device_t, chr_file)
 # For writing to flag file:
@@ -45,7 +45,7 @@ type test_binder_client_t;
 # Must use _minimal interface to avoid granting domain fd use permission
 testsuite_domain_type_minimal(test_binder_client_t)
 typeattribute test_binder_client_t binderdomain;
-allow test_binder_client_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_t test_binder_provider_t:binder { call };
 allow test_binder_client_t test_binder_mgr_t:binder { call };
 allow test_binder_client_t test_binder_provider_t:fd { use };
 allow test_binder_client_t device_t:chr_file { getattr ioctl open read write };
@@ -57,7 +57,7 @@ allow_map(test_binder_client_t, device_t, chr_file)
 type test_binder_client_no_call_mgr_t;
 testsuite_domain_type(test_binder_client_no_call_mgr_t)
 typeattribute test_binder_client_no_call_mgr_t binderdomain;
-allow test_binder_client_no_call_mgr_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_no_call_mgr_t test_binder_provider_t:binder { call };
 allow test_binder_client_no_call_mgr_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_call_mgr_t, device_t, chr_file)
 
@@ -72,19 +72,6 @@ allow test_binder_client_no_call_sp_t test_binder_mgr_t:binder { call };
 allow test_binder_client_no_call_sp_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_call_sp_t, device_t, chr_file)
 
-#
-######################## Client No impersonate ##############################
-#
-type test_binder_client_no_im_t;
-testsuite_domain_type(test_binder_client_no_im_t)
-typeattribute test_binder_client_no_im_t binderdomain;
-allow test_binder_mgr_t test_binder_client_no_im_t:binder { transfer };
-allow test_binder_client_no_im_t test_binder_provider_t:binder { call };
-allow test_binder_client_no_im_t test_binder_mgr_t:binder { call };
-allow test_binder_client_no_im_t test_binder_provider_t:fd { use };
-allow test_binder_client_no_im_t device_t:chr_file { getattr ioctl open read write };
-allow_map(test_binder_client_no_im_t, device_t, chr_file)
-
 #
 ########################## Client No transfer ###############################
 #
@@ -92,6 +79,6 @@ type test_binder_client_no_transfer_t;
 testsuite_domain_type(test_binder_client_no_transfer_t)
 typeattribute test_binder_client_no_transfer_t binderdomain;
 allow test_binder_client_no_transfer_t test_binder_mgr_t:binder { call };
-allow test_binder_client_no_transfer_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_no_transfer_t test_binder_provider_t:binder { call };
 allow test_binder_client_no_transfer_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_transfer_t, device_t, chr_file)
diff --git a/policy/test_binder_bpf.te b/policy/test_binder_bpf.te
index fa79320..993f4c1 100644
--- a/policy/test_binder_bpf.te
+++ b/policy/test_binder_bpf.te
@@ -38,7 +38,7 @@ allow test_binder_bpf_provider_t self:process { setrlimit };
 type test_binder_bpf_client_t;
 testsuite_domain_type(test_binder_bpf_client_t)
 typeattribute test_binder_bpf_client_t binderbpfdomain;
-allow test_binder_bpf_client_t test_binder_bpf_provider_t:binder { call impersonate };
+allow test_binder_bpf_client_t test_binder_bpf_provider_t:binder { call };
 allow test_binder_bpf_client_t test_binder_bpf_mgr_t:binder { call };
 allow test_binder_bpf_client_t test_binder_bpf_provider_t:fd { use };
 allow test_binder_bpf_client_t device_t:chr_file { getattr ioctl open read write };
@@ -52,7 +52,7 @@ allow test_binder_bpf_client_t test_binder_bpf_provider_t:bpf { map_read map_wri
 type test_binder_client_no_bpf_perm_t;
 testsuite_domain_type(test_binder_client_no_bpf_perm_t)
 typeattribute test_binder_client_no_bpf_perm_t binderbpfdomain;
-allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:binder { call impersonate };
+allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:binder { call };
 allow test_binder_client_no_bpf_perm_t test_binder_bpf_mgr_t:binder { call };
 allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:fd { use };
 allow test_binder_client_no_bpf_perm_t device_t:chr_file { getattr ioctl open read write };
diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index 891ce9d..b534905 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -1,13 +1,13 @@
 /*
  * This is a simple binder Service Manager/Service Provider that only uses
  * the raw ioctl commands to test the SELinux binder permissions:
- *     set_context_mgr, call, transfer, impersonate.
+ *     set_context_mgr, call, transfer.
  *
  * If configured, the BPF permissions are also tested.
  *
  * Using binder test policy the following will be validated:
  *    security_binder_set_context_mgr() binder { set_context_mgr }
- *    security_binder_transaction()     binder { call impersonate }
+ *    security_binder_transaction()     binder { call }
  *    security_binder_transfer_binder() binder { transfer }
  *    security_binder_transfer_file()   fd { use }
  *					bpf { map_create map_read map_write };
diff --git a/tests/binder/client.c b/tests/binder/client.c
index db57adf..a519e2c 100644
--- a/tests/binder/client.c
+++ b/tests/binder/client.c
@@ -1,20 +1,15 @@
 #include "binder_common.h"
 
 static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
-static int transactions_complete;
+static bool received_fd;
 
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-c] [-n] [-r replies] [-m|-p] [-v]\n"
+		"usage:  %s [-n] [-r replies] [-m|-p] [-v]\n"
 		"Where:\n\t"
-		"-c  Use the number of replies for the BR_TRANSACTION_COMPLETE"
-		" count.\n\t"
 		"-n  Use the /dev/binderfs name service.\n\t"
-		"-r  Number of replies expected that depends on the test.\n\t"
-		"    It can be the number of BR_TRANSACTION_COMPLETE if\n\t"
-		"    the -c option is set or number of times to issue the\n\t"
-		"    ioctl - BINDER_WRITE_READ command if -c not set.\n\t"
+		"-r  Stop after this many reads instead of waiting for an fd.\n\t"
 		"-m  Service Provider sending BPF map fd.\n\t"
 		"-p  Service Provider sending BPF prog fd.\n\t"
 		"-v  Print context and command information.\n\t"
@@ -30,21 +25,11 @@ static void client_alarm(int sig)
 	exit(-1);
 }
 
-/* This retrieves the Service Providers file descriptor, then using this
- * sends a simple transaction to trigger the impersonate permission.
- */
-static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
+static void receive_fd(const struct binder_transaction_data *txn_in)
 {
 	int result;
-	uint32_t cmd;
 	struct stat sb;
-	struct binder_write_read bwr;
 	const struct binder_fd_object *obj;
-	struct {
-		uint32_t cmd;
-		struct binder_transaction_data txn;
-	} __attribute__((packed)) writebuf;
-	unsigned int readbuf[32];
 
 	binder_size_t *offs = (binder_size_t *)
 			      (binder_uintptr_t)txn_in->data.ptr.offsets;
@@ -73,61 +58,8 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 		       fd_type_str, (long unsigned)obj->fd,
 		       (long long unsigned)sb.st_dev);
 
-	/* If testing BPF, then cannot do impersonate check */
-	if (fd_type > BINDER_FD)
-		return;
-
-	memset(&writebuf, 0, sizeof(writebuf));
-	memset(readbuf, 0, sizeof(readbuf));
-	memset(&bwr, 0, sizeof(bwr));
-
-	/* Send response using Service Providers fd to trigger
-	 * impersonate check.
-	 */
-	writebuf.cmd = BC_TRANSACTION;
-	writebuf.txn.target.handle = txn_in->target.handle;
-	writebuf.txn.cookie = txn_in->cookie;
-	writebuf.txn.code = txn_in->code;
-	writebuf.txn.flags = TF_ONE_WAY;
-
-	writebuf.txn.data_size = 0;
-	writebuf.txn.data.ptr.buffer = (binder_uintptr_t)NULL;
-	writebuf.txn.data.ptr.offsets = (binder_uintptr_t)NULL;
-	writebuf.txn.offsets_size = 0;
-
-	bwr.write_size = sizeof(writebuf);
-	bwr.write_consumed = 0;
-	bwr.write_buffer = (binder_uintptr_t)&writebuf;
-	bwr.read_size = sizeof(readbuf);
-	bwr.read_consumed = 0;
-	bwr.read_buffer = (binder_uintptr_t)readbuf;
-
-	result = ioctl(obj->fd, BINDER_WRITE_READ, &bwr);
-	if (result < 0) {
-		fprintf(stderr,
-			"Client ioctl BINDER_WRITE_READ error: %s\n",
-			strerror(errno));
-		exit(132);
-	}
-
-	if (verbose)
-		printf("Client read_consumed: %llu\n",
-		       (long long unsigned)bwr.read_consumed);
-
-	cmd = binder_parse(obj->fd, (binder_uintptr_t)readbuf,
-			   bwr.read_consumed);
-
-	if (cmd == BR_FAILED_REPLY ||
-	    cmd == BR_DEAD_REPLY ||
-	    cmd == BR_DEAD_BINDER) {
-		fprintf(stderr, "Client %s() failing command %s, exiting.\n",
-			__func__, cmd_name(cmd));
-		exit(133);
-	}
-
-	if (verbose)
-		printf("Client sent transaction using Service Providers FD: %lu\n",
-		       (long unsigned)obj->fd);
+	close(obj->fd);
+	received_fd =  true;
 }
 
 static void request_service_provider_fd(int fd, uint32_t handle)
@@ -243,9 +175,7 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 
 		switch (cmd) {
 		case BR_NOOP:
-			break;
 		case BR_TRANSACTION_COMPLETE:
-			transactions_complete++;
 			break;
 		case BR_INCREFS:
 		case BR_ACQUIRE:
@@ -278,7 +208,7 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 				extract_handle_and_acquire(fd, txn);
 
 			if (txn->code == TEST_SERVICE_SEND_FD)
-				extract_fd_and_respond(txn);
+				receive_fd(txn);
 
 			ptr += sizeof(*txn);
 			break;
@@ -305,7 +235,6 @@ int main(int argc, char **argv)
 {
 	int opt, result, fd, client_replies = 0, ioctl_wr = 0;
 	bool name = false;
-	bool use_transactions_complete = false;
 	uint32_t cmd;
 	pid_t pid;
 	char *context;
@@ -319,15 +248,11 @@ int main(int argc, char **argv)
 	} __attribute__((packed)) writebuf;
 	unsigned int readbuf[32];
 
-	transactions_complete = 0;
 	fd_type = BINDER_FD;
 	fd_type_str = "SP";
 
-	while ((opt = getopt(argc, argv, "cnr:vmp")) != -1) {
+	while ((opt = getopt(argc, argv, "nr:vmp")) != -1) {
 		switch (opt) {
-		case 'c':
-			use_transactions_complete = true;
-			break;
 		case 'n':
 			name = true;
 			break;
@@ -451,11 +376,7 @@ int main(int argc, char **argv)
 		}
 
 		result = 0;
-		if (use_transactions_complete &&
-		    transactions_complete == client_replies)
-			break;
-		else if (!use_transactions_complete &&
-			 ioctl_wr == client_replies)
+		if (received_fd || (client_replies && ioctl_wr == client_replies))
 			break;
 	}
 
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
index 89a8609..85e0691 100644
--- a/tests/binder/manager.c
+++ b/tests/binder/manager.c
@@ -91,11 +91,6 @@ static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
 		reply_with_handle(fd, txn_in);
 
 		break;
-	case TEST_SERVICE_SEND_FD:
-		if (verbose)
-			printf("Manager Rx'ed SEND_CLIENT_YOUR_BINDER_FD for handle: %lu\n",
-			       (long unsigned)txn_in->target.handle);
-		break;
 	default:
 		fprintf(stderr, "Manager unknown txn->code: %lu for handle: %lu\n",
 			(long unsigned)txn_in->code,
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 36c10d2..94fbb05 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -31,11 +31,6 @@ static void request_service_provider_fd(int fd,
 	struct binder_write_read bwr;
 	struct binder_transaction_data *txn;
 
-	if (txn_in->flags == TF_ONE_WAY && verbose) {
-		printf("Service Provider no reply to BC_TRANSACTION as flags = TF_ONE_WAY\n");
-		return;
-	}
-
 	if (verbose)
 		printf("Service Provider sending BC_REPLY with an FD\n");
 
@@ -64,11 +59,6 @@ static void request_service_provider_fd(int fd,
 	 * The Service Providers binder fd is used for testing as it allows
 	 * policy to set whether the Service Provider and Client can be
 	 * allowed access (fd use) or not.
-	 * This also allows a check for the impersonate permission later as
-	 * the Client will use the Service Provider fd to send a transaction.
-	 *
-	 * If a BPF fd is required, it is generated, however it cannot be
-	 * used to check the impersonate permission.
 	 */
 	switch (fd_type) {
 	case BINDER_FD:
diff --git a/tests/binder/test b/tests/binder/test
index 95af41a..c0b951f 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -26,7 +26,7 @@ BEGIN {
         plan skip_all => "Binder not supported by kernel";
     }
     elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
-        $test_count += 7;
+        $test_count += 6;
         $n = " ";                    # Use /dev/binder
 
         $kvercur = `uname -r`;
@@ -55,7 +55,7 @@ BEGIN {
     }
     elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
         $test_binder_ctx = 1;
-        $test_count += 8;
+        $test_count += 7;
         $n = "-n";                   # Use /dev/binder-test
     }
     elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
@@ -102,7 +102,7 @@ $sp_pid =
   service_start( "service_provider", "-t test_binder_provider_t", "$n $v" );
 
 # 1 Verify that authorized client and service provider can communicate with the binder service manager.
-$result = system "runcon -t test_binder_client_t $basedir/client $n $v -c -r 3";
+$result = system "runcon -t test_binder_client_t $basedir/client $n $v";
 ok( $result eq 0 );
 
 # 2 Verify that client cannot call manager (no call perm).
@@ -117,12 +117,7 @@ $result =
   "runcon -t test_binder_client_no_call_sp_t $basedir/client $n $v -r 2 2>&1";
 ok( $result >> 8 eq 141 );
 
-# 4 Verify that client cannot communicate with service provider (no impersonate perm).
-$result =
-  system "runcon -t test_binder_client_no_im_t $basedir/client $n $v -r 2 2>&1";
-ok( $result >> 8 eq 133 );
-
-# 5 Verify that client cannot communicate with service provider (no transfer perm).
+# 4 Verify that client cannot communicate with service provider (no transfer perm).
 $result =
   system
   "runcon -t test_binder_client_no_transfer_t $basedir/client $n $v -r 2 2>&1";
@@ -132,21 +127,21 @@ ok( $result >> 8 eq 125 );
 service_end( "service_provider", $sp_pid );
 service_end( "manager",          $sm_pid );
 
-# 6 Verify that provider domain cannot become a manager (no set_context_mgr perm).
+# 5 Verify that provider domain cannot become a manager (no set_context_mgr perm).
 $result = system "runcon -t test_binder_provider_t $basedir/manager $n $v 2>&1";
 ok( $result >> 8 eq 14 );
 
-# 7 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
+# 6 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
 #   Note that this test requires the Reference Policy boolean "allow_domain_fd_use" set to FALSE.
 #   (setsebool allow_domain_fd_use=0)
-# 7a Start Manager
+# 6a Start Manager
 $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n $v" );
 
-# 7b Start Service Provider
+# 6b Start Service Provider
 $sp_pid = service_start( "service_provider", "-t test_binder_provider_no_fd_t",
     "$n $v" );
 
-# 7c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
+# 6c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
 #    to the client will not be valid for service provider domain and binder will return BR_FAILED_REPLY.
 $result =
   system "runcon -t test_binder_client_t $basedir/client $n $v -r2 2>&1";
@@ -166,10 +161,9 @@ if ($test_binder_ctx) {
         "$n $v -e test_binder_client_t"
     );
 
-# 8 Verify that authorized client and service provider can communicate with the binder service manager.
+# 7 Verify that authorized client and service provider can communicate with the binder service manager.
 #   Also check that the service provider can receive the Clients security context.
-    $result =
-      system "runcon -t test_binder_client_t $basedir/client $n $v -c -r 3";
+    $result = system "runcon -t test_binder_client_t $basedir/client $n $v";
     ok( $result eq 0 );
 
     # Kill the service provider & manager.
diff --git a/tests/bpf/test b/tests/bpf/test
index 7119916..3eb53ab 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -225,7 +225,7 @@ if ($test_binder) {
     # Verify that the BPF map fd can be transferred.
     $result =
       system
-      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -m -r 1";
+      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -m";
     ok( $result eq 0 );
 
     # Verify BPF no map perms.
@@ -242,7 +242,7 @@ if ($test_binder) {
     # Verify that the BPF prog fd can be transferred.
     $result =
       system
-      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -p -r 1";
+      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -p";
     ok( $result eq 0 );
 
     # Verify BPF no prog perms.
-- 
2.56.0

