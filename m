Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24574328267
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043387; cv=none; b=EMjSaXic6bf2JTJnNxq4faLQypdcdgmLcIvjeld8b8puQP5BNlGnLmFWmAqiUc470KhNMnP1Fj7GfGdEPst36hpNEJi5YkhnRcGA9byzwnU4QhamLIYU/++2SFSSWMQ1Vstym5hhaWCd/9ry4gJoizKflBgLMAS7c6CDbtP/vY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043387; c=relaxed/simple;
	bh=c/KkA7ozLzS18Z2yo4idMFbwM7gg3/UiBQZuvIFBaks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5ApLECpofexMZp47tx79OxXqD1HXUYat3f+bSu0shZLpcd+UOSwtGDNSim3y1MZxORgD1qLhz6WYbzZWDPEbdyETB2Ox/x7uuLsxUz+3sHrP/X0FjMYU1Y7R4S3X+sQiQ0FBTZhf4s8KOKCf3IiCXmkFBf15T4m6VmjqxjxCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9SDNPzA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9SDNPzA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so30241125e9.0
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043383; x=1792648183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io8aLexXEDq0YktMSUQfUNFkjR+9uCefOGd4TbnS4Rs=;
        b=n9SDNPzAwPhOfOUiZg8eJKQlc23qWDeWC6pdJWfl8ZU46m3ZQS2tWuYWhcbSTtyT+5
         wc7RwTAxiGVmqaYL/kYUe2WRW0Kw7mPeb2Qi5dU1zzvkBCfx3/pCFNgPwKYMkdD3B4Oi
         ELvMxDMrrIu8oP9K2X/uasAoKgPHfnY9mARqG04GedaMXmw+SJebz5FSVwK6AtidjxwX
         Lnh2SSF+49vV1aHtkCeuGxRAW6y3F2+aAOThAUK4vyewGwK3z+Wvdv2bod5Amwi2WMY4
         EdQ88zN0JxK1hlTCnIiLmPkOOxw3AlBNSPSeUSKrwdKJIjARLYBhn2B9jEA2NWoRRy37
         K0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043383; x=1792648183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io8aLexXEDq0YktMSUQfUNFkjR+9uCefOGd4TbnS4Rs=;
        b=ul5HEpvur1BIeXDgSk57i0cTcIfCC/MyeDghk4zFrY+AIHuhbTNMWl+u6BEUB4ocSN
         d5npaXGsSTWuy7nY5Gr/VhX7q91IZJbLYCtuZcSdATyPLkThY/6jaB7AzMkOyRm7wCJY
         epml579w0m9gc1Ivrz34eWfITU47Qv+2Syk4m6S07FacWGrrwF2gETccAdxrVDJZgmJa
         eDPqVoIISlGIkn+SrBzeoYHHMEG5mJ6zPxuU2dMQ9RZb1uK1fxHXu9/OKT/vzmHi9qR7
         sSz+g1ac8BJt8hdH5gC+lJwa35i+pZVVp3InYF8JyXuahBO21FG93L+i7a9AO/2/PTf4
         f/Mg==
X-Gm-Message-State: AFq9FYJFR4RaVSs3y2imVoH38d0xqLz6gNHbJNdIaKv7QzcGK22JSexh
	nRSJmLKgoNVUKxas8Dx9nAJJywfDwhnif0AAZUd62DcYFktiKjPQpq0DyrnYFw==
X-Gm-Gg: AYBFou0e3lS6klS5vtKnTidcjAf9J6z3lr/MXn7kxMaVa3ZlQGxsBnQdnVpcnVbJm0X
	43qQr/j6NWl3nrQvl/tTZD+kx8rzh9dRtsNAVi0cWRvmGj73t0Tk8ly1QjFmo86PKdRyR5WImBo
	4L2TXzobdjKvV6ifpBqWNFWxcbNeRrderQCEYBUTK2ckD5uEwc+EqQW/Wbyycr1fi+/McYpUl2M
	Hv+x9GHDZa7/utxp7z1xJ7ZCHw4sby3rpzN4wHf4bb/Vl7n3usRGY9I/GBOj35rITRzhQ6L4u9Q
	Nv07innQH/gSBmtiCOw7V+toQBKyr+yguDOe8bGYywub+5zy3QIwm9PMdTsYpo7nSWyv+0MeNDq
	ywpsIPvrkQtx+xEwj3NO+SGdAlHbLyIqwRC6Og0umVrDsr8LFeQzdQ1GoNMe45BEuvy34LAfJ/9
	ewz0Raaa7VImweW+WCe/E6PfIUeEWZ4nFIhrGIR+WBPm6PqVCZxs1g+TBzlq/349GEFpg9pUFWU
	RD73ogeuWqaBt4=
X-Received: by 2002:a05:600c:46cc:b0:4a0:8b1:f5c with SMTP id 5b1f17b1804b1-4a18e4b583fmr355135195e9.22.1792043383278;
        Wed, 14 Oct 2026 22:49:43 -0700 (PDT)
Received: from omos-acer ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48deeadc0b5sm6901587f8f.6.2026.10.14.22.49.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:49:42 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 1/4] tests/binder: fix compiler warnings on ppc64le
Date: Thu, 15 Oct 2026 07:49:29 +0200
Message-ID: <20261015054932.845406-2-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054932.845406-1-omosnacek@gmail.com>
References: <20261015054932.845406-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct format specifiers and casts to make sure that the code
compiles and works correctly on all architectures. This particularly
fixes compiler warnings on ppc64le, which are now treated as errors.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tests/binder/binder_common.c    | 36 ++++++++++++++++----------------
 tests/binder/check_binder.c     |  8 +++----
 tests/binder/check_binderfs.c   | 10 ++++-----
 tests/binder/client.c           | 36 ++++++++++++++++----------------
 tests/binder/manager.c          | 37 +++++++++++++++++----------------
 tests/binder/service_provider.c | 22 ++++++++++----------
 6 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index 7cf6c74..62af7b6 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -64,8 +64,8 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 			      (binder_uintptr_t)txn_in->data.ptr.offsets;
 	size_t count = txn_in->offsets_size / sizeof(binder_size_t);
 
-	printf("\thandle: %d\n", (uint32_t)txn_in->target.handle);
-	printf("\tcookie: %lld\n", txn_in->cookie);
+	printf("\thandle: %lu\n", (long unsigned)txn_in->target.handle);
+	printf("\tcookie: %llu\n", (long long unsigned)txn_in->cookie);
 	switch (txn_in->code) {
 	case TEST_SERVICE_ADD:
 		printf("\tcode: TEST_SERVICE_ADD\n");
@@ -77,8 +77,8 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		printf("\tcode: TEST_SERVICE_SEND_FD\n");
 		break;
 	default:
-		printf("Unknown binder_transaction_data->code: %x\n",
-		       txn_in->code);
+		printf("Unknown binder_transaction_data->code: %lx\n",
+		       (long unsigned)txn_in->code);
 		return;
 	}
 
@@ -96,13 +96,13 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		printf("\tflag: TF_ACCEPT_FDS\n");
 		break;
 	default:
-		printf("Unknown flag: %x\n", txn_in->flags);
+		printf("Unknown flag: %lx\n", (long unsigned)txn_in->flags);
 		return;
 	}
-	printf("\tsender pid: %u\n", txn_in->sender_pid);
-	printf("\tsender euid: %u\n", txn_in->sender_euid);
-	printf("\tdata_size: %llu\n", txn_in->data_size);
-	printf("\toffsets_size: %llu\n", txn_in->offsets_size);
+	printf("\tsender pid: %ld\n", (long)txn_in->sender_pid);
+	printf("\tsender euid: %lu\n", (long unsigned)txn_in->sender_euid);
+	printf("\tdata_size: %llu\n", (long long unsigned)txn_in->data_size);
+	printf("\toffsets_size: %llu\n", (long long unsigned)txn_in->offsets_size);
 
 	while (count--) {
 		obj = (const struct flat_binder_object *)
@@ -111,31 +111,31 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		switch (obj->hdr.type) {
 		case BINDER_TYPE_BINDER:
 			printf("\thdr: BINDER_TYPE_BINDER\n");
-			printf("\tbinder: %llx\n", obj->binder);
+			printf("\tbinder: %llx\n", (long long unsigned)obj->binder);
 			break;
 		case BINDER_TYPE_HANDLE:
 			printf("\thdr: BINDER_TYPE_HANDLE\n");
-			printf("\thandle: %x\n", obj->handle);
+			printf("\thandle: %lx\n", (long unsigned)obj->handle);
 			break;
 		case BINDER_TYPE_FD:
 			printf("\thdr: BINDER_TYPE_FD\n");
-			printf("\tfd: %x\n", obj->handle);
+			printf("\tfd: %lx\n", (long unsigned)obj->handle);
 			break;
 		default:
-			printf("Unknown header: %u\n", obj->hdr.type);
+			printf("Unknown header: %lu\n", (long unsigned)obj->hdr.type);
 			return;
 		}
 #if HAVE_BINDERFS
-		printf("\tflags: priority: 0x%x accept FDS: %s request security CTX: %s\n",
-		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		printf("\tflags: priority: 0x%lx accept FDS: %s request security CTX: %s\n",
+		       (long unsigned)obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
 		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO",
 		       obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ? "YES" : "NO");
 #else
-		printf("\tflags: priority: 0x%x accept FDS: %s\n",
-		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		printf("\tflags: priority: 0x%lx accept FDS: %s\n",
+		       (long unsigned)obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
 		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO");
 #endif
-		printf("\tcookie: %llx\n", obj->cookie);
+		printf("\tcookie: %llx\n", (long long unsigned)obj->cookie);
 	}
 	fflush(stdout);
 }
diff --git a/tests/binder/check_binder.c b/tests/binder/check_binder.c
index 119b2b2..3f0646d 100644
--- a/tests/binder/check_binder.c
+++ b/tests/binder/check_binder.c
@@ -41,15 +41,15 @@ int main(int argc, char **argv)
 
 	if (vers.protocol_version != BINDER_CURRENT_PROTOCOL_VERSION) {
 		fprintf(stderr,
-			"Binder kernel version: %d differs from user space version: %d\n",
-			vers.protocol_version,
-			BINDER_CURRENT_PROTOCOL_VERSION);
+			"Binder kernel version: %ld differs from user space version: %ld\n",
+			(long)vers.protocol_version,
+			(long)BINDER_CURRENT_PROTOCOL_VERSION);
 		result = BINDER_VER_ERROR;
 		goto brexit;
 	}
 
 	if (verbose)
-		printf("Binder kernel version: %d\n", vers.protocol_version);
+		printf("Binder kernel version: %ld\n", (long)vers.protocol_version);
 
 	result = BASE_BINDER_SUPPORT;
 
diff --git a/tests/binder/check_binderfs.c b/tests/binder/check_binderfs.c
index c0d8ea4..8eedde2 100644
--- a/tests/binder/check_binderfs.c
+++ b/tests/binder/check_binderfs.c
@@ -47,7 +47,7 @@ int main(int argc, char *argv[])
 
 	if (verbose)
 		printf("Allocated new binder device: major %d minor %d"
-		       " with name \"%s\"\n", device.major, device.minor,
+		       " with name \"%s\"\n", (int)device.major, (int)device.minor,
 		       device.name);
 
 	result = sprintf(dev_str, "%s/%s", BINDERFS_DEV, BINDERFS_NAME);
@@ -76,14 +76,14 @@ int main(int argc, char *argv[])
 
 	if (vers.protocol_version != BINDER_CURRENT_PROTOCOL_VERSION) {
 		fprintf(stderr,
-			"Binder kernel version: %d differs from user space version: %d\n",
-			vers.protocol_version,
-			BINDER_CURRENT_PROTOCOL_VERSION);
+			"Binder kernel version: %ld differs from user space version: %ld\n",
+			(long)vers.protocol_version,
+			(long)BINDER_CURRENT_PROTOCOL_VERSION);
 		result = BINDER_VER_ERROR;
 		goto brexit;
 	}
 	if (verbose)
-		printf("Binder kernel version: %d\n", vers.protocol_version);
+		printf("Binder kernel version: %ld\n", (long)vers.protocol_version);
 
 	result = BINDERFS_SUPPORT;
 
diff --git a/tests/binder/client.c b/tests/binder/client.c
index 220d37a..db44c18 100644
--- a/tests/binder/client.c
+++ b/tests/binder/client.c
@@ -56,8 +56,8 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 	      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs);
 
 	if (obj->hdr.type != BINDER_TYPE_FD) {
-		fprintf(stderr, "Header not BINDER_TYPE_FD: %d\n",
-			obj->hdr.type);
+		fprintf(stderr, "Header not BINDER_TYPE_FD: %lu\n",
+			(long unsigned)obj->hdr.type);
 		exit(130);
 	}
 
@@ -69,8 +69,8 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 	}
 
 	if (verbose)
-		printf("Client retrieved %s fd: %d st_dev: %ld\n",
-		       fd_type_str, obj->fd, sb.st_dev);
+		printf("Client retrieved %s fd: %d st_dev: %llu\n",
+		       fd_type_str, obj->fd, (long long unsigned)sb.st_dev);
 
 	/* If testing BPF, then cannot do impersonate check */
 	if (fd_type > BINDER_FD)
@@ -110,8 +110,8 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 	}
 
 	if (verbose)
-		printf("Client read_consumed: %lld\n",
-		       bwr.read_consumed);
+		printf("Client read_consumed: %llu\n",
+		       (long long unsigned)bwr.read_consumed);
 
 	cmd = binder_parse(obj->fd, (binder_uintptr_t)readbuf,
 			   bwr.read_consumed);
@@ -163,8 +163,8 @@ static void request_service_provider_fd(int fd, uint32_t handle)
 	bwr.read_buffer = (binder_uintptr_t)readbuf;
 
 	if (verbose)
-		printf("Client sending transaction SEND_CLIENT_YOUR_BINDER_FD to handle: %d\n",
-		       handle);
+		printf("Client sending transaction SEND_CLIENT_YOUR_BINDER_FD to handle: %lu\n",
+		       (long unsigned)handle);
 
 	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
 	if (result < 0) {
@@ -198,8 +198,8 @@ static void extract_handle_and_acquire(int fd,
 	      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs);
 
 	if (obj->hdr.type != BINDER_TYPE_HANDLE) {
-		fprintf(stderr, "Client - Header not BINDER_TYPE_HANDLE: %d\n",
-			obj->hdr.type);
+		fprintf(stderr, "Client - Header not BINDER_TYPE_HANDLE: %lu\n",
+			(long unsigned)obj->hdr.type);
 		exit(150);
 	}
 
@@ -219,8 +219,8 @@ static void extract_handle_and_acquire(int fd,
 	}
 
 	if (verbose)
-		printf("Client acquired binder handle: %d for Service Provider\n",
-		       obj->handle);
+		printf("Client acquired binder handle: %lu for Service Provider\n",
+		       (long unsigned)obj->handle);
 
 	/* Now get their fd */
 	request_service_provider_fd(fd, obj->handle);
@@ -291,8 +291,8 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 			break;
 		default:
 			if (verbose)
-				printf("Client parsed unknown command: %d\n",
-				       cmd);
+				printf("Client parsed unknown command: %lu\n",
+				       (long unsigned)cmd);
 			exit(160);
 		}
 	}
@@ -358,8 +358,8 @@ int main(int argc, char **argv)
 	pid = getpid();
 
 	if (verbose) {
-		printf("Client PID: %d Process context:\n\t%s\n",
-		       pid, context);
+		printf("Client PID: %ld Process context:\n\t%s\n",
+		       (long)pid, context);
 	}
 	free(context);
 
@@ -434,8 +434,8 @@ int main(int argc, char **argv)
 		ioctl_wr++;
 
 		if (verbose)
-			printf("Client read_consumed: %lld\n",
-			       bwr.read_consumed);
+			printf("Client read_consumed: %llu\n",
+			       (long long unsigned)bwr.read_consumed);
 
 		cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
 				   bwr.read_consumed);
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
index f7f1723..89a8609 100644
--- a/tests/binder/manager.c
+++ b/tests/binder/manager.c
@@ -45,8 +45,8 @@ static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
 			sp_handle = obj->handle;
 
 			if (verbose)
-				printf("Manager has TEST_SERVICE_ADD obj->handle: %d\n",
-				       sp_handle);
+				printf("Manager has TEST_SERVICE_ADD obj->handle: %lu\n",
+				       (long unsigned)sp_handle);
 		} else {
 			fprintf(stderr, "Manager failed to obtain a handle\n");
 			exit(20);
@@ -68,8 +68,8 @@ static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
 		}
 
 		if (verbose)
-			printf("Manager acquired binder handle: %d for Service Provider\n",
-			       sp_handle);
+			printf("Manager acquired binder handle: %lu for Service Provider\n",
+			       (long unsigned)sp_handle);
 
 		/* Inform the Service Provider of outcome. */
 		reply.cmd_reply = BC_REPLY;
@@ -85,20 +85,21 @@ static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
 		break;
 	case TEST_SERVICE_GET:
 		if (verbose)
-			printf("Manager has TEST_SERVICE_GET handle: %d\n",
-			       sp_handle);
+			printf("Manager has TEST_SERVICE_GET handle: %lu\n",
+			       (long unsigned)sp_handle);
 
 		reply_with_handle(fd, txn_in);
 
 		break;
 	case TEST_SERVICE_SEND_FD:
 		if (verbose)
-			printf("Manager Rx'ed SEND_CLIENT_YOUR_BINDER_FD for handle: %d\n",
-			       txn_in->target.handle);
+			printf("Manager Rx'ed SEND_CLIENT_YOUR_BINDER_FD for handle: %lu\n",
+			       (long unsigned)txn_in->target.handle);
 		break;
 	default:
-		fprintf(stderr, "Manager unknown txn->code: %d for handle: %d\n",
-			txn_in->code, txn_in->target.handle);
+		fprintf(stderr, "Manager unknown txn->code: %lu for handle: %lu\n",
+			(long unsigned)txn_in->code,
+			(long unsigned)txn_in->target.handle);
 		exit(22);
 	}
 }
@@ -148,8 +149,8 @@ static void reply_with_handle(int fd, struct binder_transaction_data *txn_in)
 	}
 
 	if (verbose)
-		printf("Manager sent Service Provider handle: %d to Client\n",
-		       sp_handle);
+		printf("Manager sent Service Provider handle: %lu to Client\n",
+		       (long unsigned)sp_handle);
 }
 
 /* Parse response, reply as required and then return last CMD */
@@ -210,8 +211,8 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 			break;
 		default:
 			if (verbose)
-				printf("Manager parsed unknown command: %d\n",
-				       cmd);
+				printf("Manager parsed unknown command: %lu\n",
+				       (long unsigned)cmd);
 			exit(40);
 		}
 	}
@@ -258,8 +259,8 @@ int main(int argc, char **argv)
 	pid = getpid();
 
 	if (verbose) {
-		printf("Manager PID: %d Process context:\n\t%s\n",
-		       pid, context);
+		printf("Manager PID: %ld Process context:\n\t%s\n",
+		       (long)pid, context);
 	}
 	free(context);
 
@@ -348,8 +349,8 @@ int main(int argc, char **argv)
 			continue;
 
 		if (verbose)
-			printf("Manager read_consumed: %lld\n",
-			       bwr.read_consumed);
+			printf("Manager read_consumed: %llu\n",
+			       (long long unsigned)bwr.read_consumed);
 
 		binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
 	}
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 1e6b490..ed8c9bc 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -95,13 +95,13 @@ static void request_service_provider_fd(int fd,
 		break;
 #endif
 	default:
-		fprintf(stderr, "Invalid fd_type: %d\n", fd_type);
+		fprintf(stderr, "Invalid fd_type: %d\n", (int)fd_type);
 		exit(73);
 	}
 
 	if (verbose)
-		printf("Service Provider handle: %d and %s FD: %d\n",
-		       txn->target.handle, fd_type_str, obj.fd);
+		printf("Service Provider handle: %lu and %s FD: %d\n",
+		       (long unsigned)txn->target.handle, fd_type_str, obj.fd);
 
 	txn->data_size = sizeof(obj);
 	txn->data.ptr.buffer = (binder_uintptr_t)&obj;
@@ -219,8 +219,8 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 			break;
 		default:
 			if (verbose)
-				printf("Service Provider parsed unknown command: %d\n",
-				       cmd);
+				printf("Service Provider parsed unknown command: %lu\n",
+				       (long unsigned)cmd);
 			exit(81);
 		}
 	}
@@ -307,8 +307,8 @@ int main(int argc, char **argv)
 	pid = getpid();
 
 	if (verbose) {
-		printf("Service Provider PID: %d Process context:\n\t%s\n",
-		       pid, context);
+		printf("Service Provider PID: %ld Process context:\n\t%s\n",
+		       (long)pid, context);
 	}
 	free(context);
 
@@ -383,8 +383,8 @@ int main(int argc, char **argv)
 	}
 
 	if (verbose)
-		printf("Service Provider read_consumed: %lld\n",
-		       bwr.read_consumed);
+		printf("Service Provider read_consumed: %llu\n",
+		       (long long unsigned)bwr.read_consumed);
 
 	cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
 			   bwr.read_consumed);
@@ -454,8 +454,8 @@ int main(int argc, char **argv)
 			continue;
 
 		if (verbose)
-			printf("Service Provider read_consumed: %lld\n",
-			       bwr.read_consumed);
+			printf("Service Provider read_consumed: %llu\n",
+			       (long long unsigned)bwr.read_consumed);
 
 		cmd = binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
 
-- 
2.54.0

