Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB01274FFA
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701379; cv=none; b=L3NSssaN90Hz2f2y3VISO2JzM4JXun9TRCv+KDWqvBlvbBXOcB9ypg0P4ED+KhfCBEewdF3rmEpXiQU8gohStgdTb0xURvm/9KQB+wnnTQQp5nWmMbwXSIVrGH9ouXsEeCgjvv/Zak/HOz8rxlRT/KPxEnus2sjBNFP5VKf0NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701379; c=relaxed/simple;
	bh=n9MhbkoCgjXiklx7Gu6dJsoCzFl44u+5C+qmS9u//9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZAwBeSK7I00awWfwmLyZoYVOl80RClQISiHmLlHC9AWmjtcS1XnA1gcSLjvzHVS3P6pv1RKXViiAA2qycAr+d1/ZtGIoJiw9VaKUXkuVVsuwAXppbGBoF3SJHQqpj5s/8VDgKT+zUkLo/ytBBNdvTaQG7Oh3RUmAAA+sdfpGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SHAnv5w7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHAnv5w7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6887308b3a.2
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744701377; x=1745306177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93Y/PcDLHLXdCrqLt2vpFN5+4uiBa0eKmnsl4Fbs4/I=;
        b=SHAnv5w7qcmlaFX4st9RqUYGwVDmMhrl3lsYXFIAdRq2bnkxRUt0Og9KTbDoHqOlGP
         dbZqb9NZo4BfHWd8itpqtMKoHKGsp+EGwDJ10Fr8qoKWSCY8qjorUxaNER2qmAVOfUcK
         CxuySLDEXaJSlAoXdeOHXaVFSKK9cx5YhNyXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701377; x=1745306177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93Y/PcDLHLXdCrqLt2vpFN5+4uiBa0eKmnsl4Fbs4/I=;
        b=tbDl6XMHLujNQfwxFGzGZfYTrfn5wvhTH142Cu6MuekJmlts6SLsKb5u5z8HwLbomb
         xAGniIU24IbESw6qAGcfqEPgIZoz9Kx+vWKJxG1Ox9m94q6F1zjgjuwNjVFCqWnzxpps
         9QS56NAksFCIPIffCjAySV1cAEmzjdGp4M1oYUFnOEDchce7+F1sHRZWB8LEjWe5OalD
         iWuuJ1apNLfzMdaGRwWfT8X8osmgKwOjxz6WlTE8A74f7bykySn1f3TZVSO9+Mhnod2e
         uFq7MTl4fOXAQbVF1BQ2edLE3msWL9C6776L8I5TP3nWmgSffIMO//YCycQbT17JC4fu
         ob6w==
X-Forwarded-Encrypted: i=1; AJvYcCUC20gOa8eKfuRQNGwFROFMQTeZ50ErkYqElE0gccTeLbN1o4T+cLlZ2Y4DFvszrRYzcQzOtWpk@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAxYpjrO/EcybA7tWa0KBbGWZCKcOHkhlq+djcw7Jr8wsECVW
	KbguW1BqB9soV/GXLPjfEbVWuorLh1ClzASACoSnEuTuog4dGPigtaAmK8NHZQ==
X-Gm-Gg: ASbGncs7JqHCSvAEcBdDShA0TKIV2FRDOjT/jPhNzF5I2GmrZXoX8Z2WPxk0a9tVdJQ
	QSVqHojxe29dWaJOqS2qvoAIEJZZta/1EOfRPdlvd4fp78y3DNmNSFboyc7zyZqv++oMVO8brIt
	820ao50JCxEK3sXwM4Me62LXs4KHww0k+qz3vQsZtP+EB4/B7RTwXBYgnB8CS4xmko4vxE9+/4h
	GWUqPIg7xfF/ulVecLtU1hj5db62Bv8r3+HphFCwKxeEyWfbsyKPlqDijDbuv/R5v7MIMEPDU5Y
	QCO9mXG/JgscLxdHn+2N0pY1sz+Up9FOoSPVYWLCFkNBL4s1cTftENdNPCfGYfaW0x7CiBTRKDG
	70kQ/SMOSqW/hdFBC5gWTHiU9jiniqzio
X-Google-Smtp-Source: AGHT+IEnueGIDuiq6IcaSey4kNpHaHj/13Oxz+Lx1rzzUoF7NkVQtCgv5SQBZlA2Icu4kQi+ft0JDg==
X-Received: by 2002:aa7:888d:0:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73bd0e989eamr18172836b3a.0.1744701376729;
        Tue, 15 Apr 2025 00:16:16 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230dd17sm7737757b3a.129.2025.04.15.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:16:16 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH 1/2] policy,tests: add test for new permission binder:setup_report
Date: Tue, 15 Apr 2025 00:16:06 -0700
Message-ID: <20250415071606.3271807-1-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250415071017.3261009-2-dualli@chromium.org>
References: <20250415071017.3261009-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

This new test depends on the corresponding kernel patchset
"binder: report txn errors via generic netlink", which implements a new
feature "transaction_report" in the kernel binder driver, protected by a
new permission "binder:setup_report".

This test updates the base policy to define this new permission and add
a new test for it. If the kernel does not support them, the test will be
skipped.

For testing purpose, you can update the base policy by manually
modifying your base module, applying the following patch and then running
the selinux-testsuite as usual.

    sudo semodule -c -E base
    sed -i.orig \
    "s/set_context_mgr transfer/set_context_mgr transfer setup_report/" \
    /usr/share/selinux/devel/include/support/all_perms.spt

    make -C policy load
    make -C tests test
    make -C policy unload

Signed-off-by: Li Li <dualli@google.com>
---
 policy/test_binder.te       |  24 ++++
 tests/binder/.gitignore     |   1 +
 tests/binder/Makefile       |   2 +-
 tests/binder/setup_report.c | 277 ++++++++++++++++++++++++++++++++++++
 tests/binder/test           |  35 +++++
 5 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 tests/binder/setup_report.c

diff --git a/policy/test_binder.te b/policy/test_binder.te
index 4c7974a..a75979e 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -94,3 +94,27 @@ allow test_binder_client_no_transfer_t test_binder_mgr_t:binder { call };
 allow test_binder_client_no_transfer_t test_binder_provider_t:binder { call impersonate };
 allow test_binder_client_no_transfer_t device_t:chr_file { getattr ioctl open read write };
 allow_map(test_binder_client_no_transfer_t, device_t, chr_file)
+
+#
+################################## Report ###################################
+#
+type test_binder_report_t;
+testsuite_domain_type(test_binder_report_t)
+typeattribute test_binder_report_t binderdomain;
+allow test_binder_report_t self:netlink_generic_socket { create bind read write };
+allow test_binder_report_t self:binder { setup_report };
+
+#
+######################### Report No Generic Netlink #########################
+#
+type test_binder_report_no_genl_t;
+testsuite_domain_type(test_binder_report_no_genl_t)
+typeattribute test_binder_report_no_genl_t binderdomain;
+
+#
+############################# Report No set up ##############################
+#
+type test_binder_report_no_setup_t;
+testsuite_domain_type(test_binder_report_no_setup_t)
+typeattribute test_binder_report_no_setup_t binderdomain;
+allow test_binder_report_no_setup_t self:netlink_generic_socket { create bind read write };
diff --git a/tests/binder/.gitignore b/tests/binder/.gitignore
index dc6ce20..ae57d57 100644
--- a/tests/binder/.gitignore
+++ b/tests/binder/.gitignore
@@ -3,3 +3,4 @@ check_binderfs
 manager
 service_provider
 client
+setup_report
diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index b89d4db..56a5b07 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -1,7 +1,7 @@
 # Required for local building
 INCLUDEDIR ?= /usr/include
 
-TARGETS = check_binder client manager service_provider
+TARGETS = check_binder client manager service_provider setup_report
 LDLIBS += -lselinux -lrt
 DEPS = binder_common.c binder_common.h
 
diff --git a/tests/binder/setup_report.c b/tests/binder/setup_report.c
new file mode 100644
index 0000000..0c1e651
--- /dev/null
+++ b/tests/binder/setup_report.c
@@ -0,0 +1,277 @@
+#include <linux/android/binder_netlink.h>
+#include <linux/genetlink.h>
+#include <sys/socket.h>
+
+#include "binder_common.h"
+
+#define BINDER_MSG_SIZE 1024
+
+#define GENLMSG_DATA(glh) ((void*)((char*)(glh) + GENL_HDRLEN))
+#define GENLMSG_PAYLOAD(nlh) (NLMSG_PAYLOAD(nlh, 0) - GENL_HDRLEN)
+#define NLA_DATA(nla) ((void*)((char*)(nla) + NLA_HDRLEN))
+#define NLA_NEXT(nla) ((struct nlattr*)((char*)nla + NLA_ALIGN(nla->nla_len)))
+
+struct genlmsg {
+    struct nlmsghdr nlh;
+    union {
+        struct genlmsghdr glh;
+        int error;
+    };
+    char buf[BINDER_MSG_SIZE];
+};
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-n] [-v]\n"
+		"Where:\n\t"
+		"-n  Use the /dev/binderfs name service.\n\t"
+		"-v  Print context and command information.\n\t"
+		"\nNote: Ensure this boolean command is run when "
+		"testing after a reboot:\n\t"
+		"setsebool allow_domain_fd_use=0\n", progname);
+	exit(-1);
+}
+
+static int sendgenl(int fd, __u32 pid, __u16 nlmsg_type, __u8 cmd, __u16 nla_type,
+		const void* nla_data, __u16 nla_len)
+{
+	if (NLA_ALIGN(nla_len) + NLA_HDRLEN > BINDER_MSG_SIZE) {
+		fprintf(stderr, "Oversized data to send\n");
+		return -ENOMEM;
+	}
+
+	struct genlmsg msg = {
+		.nlh = {
+				.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN),
+				.nlmsg_type = nlmsg_type,
+				.nlmsg_flags = NLM_F_REQUEST,
+				.nlmsg_seq = 0,
+				.nlmsg_pid = pid,
+		},
+		.glh = {
+			.cmd = cmd,
+			.version = BINDER_FAMILY_VERSION,
+		},
+	};
+
+	struct nlattr* nla = GENLMSG_DATA(&msg.glh);
+	nla->nla_type = nla_type;
+	nla->nla_len = nla_len + NLA_HDRLEN;
+	memcpy(NLA_DATA(nla), nla_data, nla_len);
+	msg.nlh.nlmsg_len += NLA_ALIGN(nla->nla_len);
+
+	struct sockaddr_nl sa = {
+		.nl_family = AF_NETLINK,
+	};
+	int ret = sendto(fd, &msg, msg.nlh.nlmsg_len, 0, (struct sockaddr*)&sa, sizeof(sa));
+	if (ret < 0)
+		fprintf(stderr, "Failed to send (%d %d %d %d): %s\n",
+				nlmsg_type, cmd, nla_type, nla_len, strerror(errno));
+
+	if (verbose)
+		printf("Sent %d / %d bytes to binder netlink\n", ret, msg.nlh.nlmsg_len);
+
+	return ret;
+}
+
+static int sendgenlv(int fd, __u32 pid, __u16 nlmsg_type, __u8 cmd, __u16 nla_type[],
+		const void* nla_data[], __u16 nla_len[], int n)
+{
+	__u32 len = 0;
+	for (int i = 0; i < n; i++)
+		len += NLA_ALIGN(nla_len[i]) + NLA_HDRLEN;
+
+	if (len > BINDER_MSG_SIZE) {
+		fprintf(stderr, "Oversized data to send: %d > %d\n", len, BINDER_MSG_SIZE);
+		return -ENOMEM;
+	}
+
+	struct genlmsg msg = {
+		.nlh = {
+				.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN),
+				.nlmsg_type = nlmsg_type,
+				.nlmsg_flags = NLM_F_REQUEST,
+				.nlmsg_seq = 0,
+				.nlmsg_pid = pid,
+		},
+		.glh = {
+			.cmd = cmd,
+			.version = BINDER_FAMILY_VERSION,
+		},
+	};
+
+	struct nlattr* nla = GENLMSG_DATA(&msg.glh);
+	for (int i = 0; i < n; i++) {
+		nla->nla_type = nla_type[i];
+		nla->nla_len = nla_len[i] + NLA_HDRLEN;
+		memcpy(NLA_DATA(nla), nla_data[i], nla_len[i]);
+		nla = (struct nlattr*)((char*)(nla) + NLA_ALIGN(nla->nla_len));
+	}
+	msg.nlh.nlmsg_len += len;
+
+	struct sockaddr_nl sa = {
+		.nl_family = AF_NETLINK,
+	};
+
+	int ret = sendto(fd, &msg, msg.nlh.nlmsg_len, 0, (struct sockaddr*)&sa, sizeof(sa));
+	if (ret < 0) {
+		fprintf(stderr, "Failed to send (%d %d %d): %s\n",
+				nlmsg_type, cmd, n, strerror(errno));
+	}
+
+	if (verbose)
+		printf("Sent %d / %d bytes\n", ret, msg.nlh.nlmsg_len);
+
+	return ret;
+}
+
+static int recvgenl(int fd, struct genlmsg* msg, int len)
+{
+	int ret = recv(fd, msg, len, 0);
+	if (verbose) {
+		printf("Received %d\n", ret);
+		printf("nlh: %d %d %d %d %d\n", msg->nlh.nlmsg_len, msg->nlh.nlmsg_type,
+				msg->nlh.nlmsg_flags, msg->nlh.nlmsg_seq, msg->nlh.nlmsg_pid);
+	}
+
+	if (ret < 0) {
+		fprintf(stderr, "Failed to receive %d: %s\n", ret, strerror(errno));
+		return ret;
+	} else if (msg->nlh.nlmsg_type == NLMSG_ERROR) {
+		ret = msg->error;
+		fprintf(stderr, "Error msg received %d: %s\n", ret, strerror(-ret));
+		return ret;
+	} else if (!NLMSG_OK(&msg->nlh, ret)) {
+		fprintf(stderr, "Wrong message data\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int fd, opt;
+	pid_t pid;
+	char *context;
+	char *name;
+	__u16 id = 0;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	/* Get our context and pid */
+	if (getcon(&context) < 0) {
+		fprintf(stderr, "Failed to obtain SELinux context\n");
+		exit(-1);
+	}
+	pid = getpid();
+
+	if (verbose) {
+		fprintf(stderr, "Setup report PID: %d Process context %s\n", pid, context);
+	}
+
+	free(context);
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open socket: %s\n", strerror(errno));
+		exit(151);
+	}
+
+	struct sockaddr_nl sa = {
+		.nl_family = AF_NETLINK, .nl_pid = pid,
+	};
+
+	if (bind(fd, (struct sockaddr*)&sa, sizeof(sa)) < 0) {
+		fprintf(stderr, "Failed to bind socket: %s\n", strerror(errno));
+		exit(152);
+	}
+
+	if (sendgenl(fd, pid, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME, BINDER_FAMILY_NAME, strlen(BINDER_FAMILY_NAME) + 1) < 0) {
+		fprintf(stderr, "Failed to send CTRL_CMD_GETFAMILY\n");
+		exit(153);
+	}
+
+	struct genlmsg msg;
+	if (recvgenl(fd, &msg, sizeof(msg)) < 0) {
+		fprintf(stderr, "Failed to receive reply of CTRL_CMD_GETFAMILY\n");
+		exit(154);
+	}
+
+	if (msg.glh.cmd != CTRL_CMD_NEWFAMILY) {
+		fprintf(stderr, "Wrong glh cmd %d, expect %d\n", msg.glh.cmd, CTRL_CMD_NEWFAMILY);
+		exit(155);
+	}
+
+	int cur = 0;
+	int payload = GENLMSG_PAYLOAD(&msg.nlh);
+	char* data = GENLMSG_DATA(&msg.glh);
+	while (cur < payload) {
+		if (verbose)
+			printf("Checking NLA payload %d / %d\n", cur, payload);
+		struct nlattr* nla = (struct nlattr*)(data + cur);
+		if (verbose)
+			printf("NLA type / len: %d / %d\n", nla->nla_type, nla->nla_len);
+		cur += NLA_ALIGN(nla->nla_len);
+		switch (nla->nla_type) {
+		case CTRL_ATTR_FAMILY_NAME:
+			name = NLA_DATA(nla);
+			if (verbose)
+				printf("Binder Netlink family name is %s\n", name);
+			break;
+		case CTRL_ATTR_FAMILY_ID:
+			id = *(__u16*)(NLA_DATA(nla));
+			if (verbose)
+				printf("Binder Netlink family id is %d\n", id);
+			break;
+		case CTRL_ATTR_MCAST_GROUPS:
+			if (verbose)
+				printf("Binder Netlink MCAST_GROUP ignored\n");
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!id) {
+		fprintf(stderr, "Failed to get binder netlink family id\n");
+		exit(156);
+	}
+
+	__u32 proc = 0;
+	__u32 flags = 0;
+	__u16 type[3] = { BINDER_A_CMD_CONTEXT, BINDER_A_CMD_PID, BINDER_A_CMD_FLAGS };
+	__u16 len[3] = { strlen(BINDERFS_NAME) + 1, sizeof(proc), sizeof(flags) };
+	const void* buf[3] = { (void*)BINDERFS_NAME, (void*)&proc, (void*)&flags };
+
+	if (verbose)
+		printf("Sending BINDER_CMD_REPORT_SETUP %s %d %d\n", BINDERFS_NAME, proc, flags);
+
+	if (sendgenlv(fd, pid, id, BINDER_CMD_REPORT_SETUP, type, buf, len, 3) < 0) {
+		fprintf(stderr, "Failed to send BINDER_CMD_REPORT_SETUP\n");
+		exit(157);
+	}
+
+	if (recvgenl(fd, &msg, sizeof(msg)) < 0) {
+		fprintf(stderr, "Failed to receive reply of BINDER_CMD_REPORT_SETUP\n");
+		exit(158);
+	}
+
+	if (msg.glh.cmd != BINDER_CMD_REPORT_SETUP) {
+		fprintf(stderr, "Wrong glh cmd %d, expect %d\n", msg.glh.cmd, BINDER_CMD_REPORT_SETUP);
+		exit(159);
+	}
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/binder/test b/tests/binder/test
index 95af41a..8cba452 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -7,6 +7,7 @@ BEGIN {
 
     $test_count      = 0;
     $test_binder_ctx = 0;
+    $test_binder_transaction_report = 0;
 
     # Allow binder info to be shown.
     $v = $ARGV[0];
@@ -57,6 +58,19 @@ BEGIN {
         $test_binder_ctx = 1;
         $test_count += 8;
         $n = "-n";                   # Use /dev/binder-test
+
+        # Check transaction_report feature
+        open my $fh, '<', '/dev/binderfs/features/transaction_report' or warn $!;
+        chomp( my $feature = <$fh> );
+        print "### my $feature\n";
+        $test_binder_transaction_report = int($feature);
+        print "### feature = $test_binder_transaction_report\n";
+        if ( $test_binder_transaction_report eq 0 ) {
+            print "Binder feature transaction report not supported\n";
+        } else {
+            $test_count += 3;
+            print "### test count = $test_count\n";
+        }
     }
     elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
         plan skip_all => "Binder kernel/userspace versions differ";
@@ -176,6 +190,27 @@ if ($test_binder_ctx) {
     service_end( "service_provider", $sp_pid );
     service_end( "manager",          $sm_pid );
 
+# 9 Verify that authorized process can send generic netlink command to set up binder reports.
+    if ($test_binder_transaction_report) {
+        $result = system "runcon -t test_binder_report_t $basedir/setup_report $v";
+        $ret8 = $result >> 8;
+        ok( $result eq 0 );
+    }
+
+# 10 Verify that unauthorized process can't use generic netlink socket (no genetlink perm).
+    if ($test_binder_transaction_report) {
+        $result = system "runcon -t test_binder_report_no_genl_t $basedir/setup_report $v";
+        $ret8 = $result >> 8;
+        ok( $result >> 8 eq 151 );
+    }
+
+# 11 Verify that unauthorized process can't use setup_report command (no setup_report perm).
+    if ($test_binder_transaction_report) {
+        $result = system "runcon -t test_binder_report_no_setup_t $basedir/setup_report $v";
+        $ret8 = $result >> 8;
+        ok( $result >> 8 eq 158 );
+    }
+
     # Cleanup binderfs stuff.
     system("/bin/sh $basedir/cleanup_binder.sh $v 2>/dev/null");
 }
-- 
2.49.0.604.gff1f9ca942-goog

