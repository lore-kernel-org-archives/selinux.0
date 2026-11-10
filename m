Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324689;
	b=rUAOCNxDplx8A/slExWaiv1xQXR2r2847vdqSaCy+J6oZZoOrBnJpwxxICr/pD4h73Rm
	 Iz5JkzILbSUjYSsaRLQcoMrud/LjTgw+k5evmEiPP4U/vfT1IX+Xm3vqL8BWd5eujlHpV
	 KwJ/lBgt2VkrOZSHJg+R1qz2CegAGA/U8TQqHIIc5PzZ3Xl7OoPtyXJOg3l60gvQ9BvnB
	 h/lRYd/d6zJS+tE6pn51MKQLvyRk/2cnwBC6hNPhAtoWPtWXJY85y9cYhiWy6cTPI6rW4
	 IDQp7C2RFIgr6Gxwcp29AZzRnZzGn0EvrvrDO/2OVnXlS6vvq8LYVtYkhISJdQMYN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xgAW+44Ms+ke2OZSs2xcQ9NnuRtVxyZl7hkDAnLZ4EU=;
	b=GmR0h6jDRezOm0WX8eFoT3E18dBXqTeBLjpcRO7WCUwAyaCchkWiQKHRiGNhiogopBQc
	 ZxuDUGskWrJ6yz5dCngR0zz6iBxN2VKtePihTsQrjwH6DTn/SkJGGjjeyre+JWrNz5kqh
	 62EYG4bw1UEo9xSRMN3bmQ4nlKS0LofWmjdbPPZCF4Bx2G7fLrWU3IcK/WnilbyO06Dg3
	 b45uNO5I7fEGewV+S+n/L4gR2pPmA7dlQX2yLuBaB25peG9XMPQcLJDAZzuHekB/Ob+h9
	 LArE3Y5CJlJQiAHZSdxQ3yz5AxZZgt8guC6Zdg2PcdqjzX0PHEyRfCdpDqJOPVeFG2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=He5upXNL;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C0606A320
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 15:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75C0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=He5upXNL
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2ca055399so688227137.3
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324688; x=1794929488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgAW+44Ms+ke2OZSs2xcQ9NnuRtVxyZl7hkDAnLZ4EU=;
        b=He5upXNLfFAZB3JgK3jdiCNPlol5glRK771OTE/pjwHkuLKrr3IoI8S+C0cqSRbViK
         IcBs/sZYXhrkDa+lLVXMuHavyChVBOaUbS8LmqqUZBGZqZZgakx2FC70/ohOM1oFbSiR
         C+4KHqtwOrnkQKuLdW4T4z+GyPvtmUollcpwNO0FQvTGAi3Zk+eoP43sIg7EDNqyn+UR
         QoKDWSKSL2YfHqpfMdFzgIPAeh8TumJR9BaLtbNpBnETBo6xGf2ETSqqK2aYrIaTb0G3
         xltXS/2Z5ny49SBQ5n6fdVSWSyRk2TAxBcv15Isj+xTGkUebmqjMqu38UVx2IBTM58zp
         nuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324688; x=1794929488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgAW+44Ms+ke2OZSs2xcQ9NnuRtVxyZl7hkDAnLZ4EU=;
        b=QoVEbjzXbGqW8lSQIlCy82AVJbBrSyXrsUeTX5TimWRvm6/4GcG4KGA0k4yfFvjNBS
         FJTaJOTLGSz+3g0CCWxWV9ChZBBJLGYW6LgBZ/SZ6Xd1wHOl2lmNe1yYrUaVAyMzuO9r
         yojcJp92eYEvcyBF5Quamg4GrNUqYouUrZKsJkeF1eZm097l5Bjf5NCU814JOAF+tMwL
         2x+JxYh2YrqylqbQUmolVOgzbW1BEvcMhvAqvIBHnDMpSA194S7/KcscYn4Xg9p5BCUf
         I8NIGqhgKoBRFgznnV+q8hSBoMHF1TSsqkNgXjmUhSLNz9tP3U+usHfgw7irPNBe64mL
         9ttA==
X-Gm-Message-State: APuU4Z+8cMCngTDA1Nl5uszyEnnkuR0s4bE1dz6l7yVpCYvJMK6n3OUX
	ulqaqi8CGppPxQhJmGlNlnUcSfIbPngvQ0NkyfsiGaYK4bKuCj7Bwhf3GCtT5Dg+
X-Gm-Gg: AYBFou0ANhReSlUXIeL7VhTtXAoeA3GCXD80BapsdgmqNOM8h+ne5ri9mgYZ8FiKteG
	24iZKeZBGb+gDeSUEOOSs4JXoZx3Coiq1ie8KErJXj/33Al4vRtr/EUDl1SlzCLadISeevpMh9W
	xc8RiW/IbenwUcU5sSaWqfemyvXNr5wX9C+Sx2vyC7LJaySbeU3p/27gcF/9pYiC8XEnbPL+CQA
	0fyn+qdRCaMBsVBhPDlqObNyI0/9OmTXGCu7dzKrMC4hhOOpNisrVuQfUwDqXy+tiyjnEZ6mD+R
	FVyah9QAuwilW7ZdfLf91gQuzX6NMAu1WJM2vSObPlMmT3kD+pKeu+Tiq4UUb5C7tMGvXuI2jmt
	LClGDkkB5ptH1HeFltI6rQ7ShCgH7HTfqsKwZBoX7VKgkEYKsys4YjkFEYl/pTv0J6bD4fKNX6J
	QM0EaA4LwHTNUPkX4lj/JpQeJ178nUZVTleFlftmPqkTWO2GzU2Dgtu56uNAG5BNK322atOV40/
	jGOJoB5z8GsLUlltOxNIfTG6bQfQriYuVOcEY5wcbN8NeXjMTZIVZG0ky7Bf62spo/Tvc4hbfT8
	WCyNOChhgm8djXcCZZN8OMNpIA6RSUbdtOFVSIJlvjfaE/Up08A6Fr+4RtIX4XH0yA+oKcQ1xjh
	Scdge1qgyx5q5+vITQJS/F7tvfZq8V8Iv+hNp98SeJXkYUUiMovDG9FnYvp+fiqWerHQ8RkoB0N
	vERWcAgJWcpuHDjFLpSNur/1d71MC43BYDnaDo+FABaeenA51CcHERdeJ6DO5zX3Eqbgk=
X-Received: by 2002:a05:6102:2922:b0:7ce:6474:720b with SMTP id ada2fe7eead31-7d301bf266dmr829635137.23.1794324687372;
        Tue, 10 Nov 2026 07:31:27 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0501c1csm23047486d6.30.2026.11.10.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:31:26 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	jeffv@google.com,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] tests/binder: fix binder tests to work with the Rust binder driver
Date: Tue, 10 Nov 2026 10:31:10 -0500
Message-ID: <20261110153110.29256-1-stephen.smalley.work@gmail.com>
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
 policy/test_binder.te           | 23 ++------
 policy/test_binder_bpf.te       |  4 +-
 tests/binder/binder_common.c    |  4 +-
 tests/binder/client.c           | 97 +++------------------------------
 tests/binder/manager.c          |  5 --
 tests/binder/service_provider.c | 10 ----
 tests/binder/test               | 30 ++++------
 tests/bpf/test                  |  4 +-
 8 files changed, 32 insertions(+), 145 deletions(-)

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
index 95af41a..b7bc8be 100755
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
@@ -114,15 +114,10 @@ ok( $result >> 8 eq 125 );
 # 3 Verify that client cannot call service provider (no call perm).
 $result =
   system
-  "runcon -t test_binder_client_no_call_sp_t $basedir/client $n $v -r 2 2>&1";
+    "runcon -t test_binder_client_no_call_sp_t $basedir/client $n $v -r 2 2>&1";
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

