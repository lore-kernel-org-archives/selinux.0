Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1E235C00
	for <selinux@vger.kernel.org>; Mon,  3 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032153; cv=none; b=Y1C33OjhLd8qjSwMmbgORDcErSWN6AwH82IIpM6m7P7rnxdQNNvqnsL1P+7U5HMDC1JCMzerF6WmsPoSWCc3J75TkuYCD+NP7bjDR6G4RInhRJasSTKFcJ5YLASHnDxYJfV5Rf6nU9AJfVeJBYTceD7zQLaEj/U/1umhQqF3AW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032153; c=relaxed/simple;
	bh=sOCh27P1/msCBLx1Vq1a3LnVe7kA5pRxYlw4QL/NqOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBT8Xi+VvFSmwYybXgwSARe1PZ78fMJtCqf241zjEqoC8t9li3uYw44OVv1/8pvsmjT07wbHJWNj3+uDEZkhEGzwVZXeErhLRz8uiimmjxceyBsk0xF9nd6XjXr5eg1PUb+SDR+d97oQoi8rscyJeVugCiI6GE95WEFJl6Zucaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XLDggVnP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLDggVnP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22339936bbfso71416925ad.1
        for <selinux@vger.kernel.org>; Mon, 03 Mar 2025 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741032150; x=1741636950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFRmuuWC6nLr/d7Z0reZyVHV7p+iTW0U28Cez+/1ICo=;
        b=XLDggVnPj5uGNc0ydQtxMpg7hn2xHahZklf3anROy+VcyFj+HrwDaYG/wTrvl9K0eb
         o5NtDtPvrZuwzNxeB36sW5HwDajjqtuAv2EcdVQSBcfjHAI+jLa6U3F6a5pPC1ANFmhN
         bHxOo3noudZ5IjYYvMuNf5Grm7Uspbo+DkC/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032150; x=1741636950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFRmuuWC6nLr/d7Z0reZyVHV7p+iTW0U28Cez+/1ICo=;
        b=pk1lYEo3mOIoyrQlOyw5PWvmTIzoI+9cIApwOimZ3dzsCG9NW/VSs8rgZvChu6PiME
         vJxG9AtcPVYrhgJUGE3cWxqqNAlILXMICSaNjUmXxqhvySD4TX3nx5KdHFBhv0Sn99yq
         vu+WEIjS6FyrACwLS1r/xgIhdNOsq9dYrU/5IjIecDdQtQQV+NVhw2nBaGvXzGGFVRS2
         6zXO2GnljsPbVehNYZAy1dBdnsA7hdwOh+Nc/f2IwouxXAgJq0T/k5cRMXfBqoKl/lu3
         EMVJBDT6effrt26SaFPUx4NRvcoAkjpDxu2MKlufFr3xXdV39V515TyVRAQmEnprAatg
         nWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6+uXPWHUTcXgxxbfo/lKpEruwMB3QPZPLNpsQtqSq8MhtXihnuEffCIeoy58vE8TVopOumDvn@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnYr3Dk4SXbprPtV03PsWbRUSxwOSBO/edvZfwC/Gkr+/n60h
	T35CJaTlfyUKhXDZoW/e8Gp0hTylf1skvazAHSIKDxWFuUvtdJTwBRiqGNXYgA==
X-Gm-Gg: ASbGncs170um0bAqJdcI+9mkyti3bmoHerAGDaViYsfthzxL/gne3pMPK50/CZhzC6W
	7ptHzvdq1nz0iqg/BY6/6k9UFNZHaq75EdrYiCjaeN89QDp/0oPfMVmdEyY8GW4bPlEO0i4FpiN
	vzFO5UO3SDebzcOeu0IOH9/nja2MysHQqOZJDD9GlLBov01RvHbluttD/aU/rwVFLQwxcx/D1R6
	guDoQackrWKECTl7AOJs7tAUiNhePSPDWqF5fOwTMYWfqCqJbER8MmuZefBy9hEPqBq13QDi1vx
	cyU3tqLulRNeptRmKMQln7E3TSHlZ8DEpD1MoD6ji3l1RUxonvRGf4BZikvBqZ39Y21ZVlvhu4U
	9x+o/jR9oxpF4Nk7kF47eHq1FC27v2Vc=
X-Google-Smtp-Source: AGHT+IG251vDiS5LnZShDdOM7gPPNx1TJCkqEmU+Hgnl06eBXjvZ6Hm8Vge4jeEDWguBjieJ2hXP5g==
X-Received: by 2002:a17:903:32c8:b0:223:245a:11e2 with SMTP id d9443c01a7336-22368f71ed9mr186248885ad.6.1741032150094;
        Mon, 03 Mar 2025 12:02:30 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc4b4sm81233875ad.171.2025.03.03.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:02:29 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v16 2/3] binder: report txn errors via generic netlink
Date: Mon,  3 Mar 2025 12:02:11 -0800
Message-ID: <20250303200212.3294679-3-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303200212.3294679-1-dualli@chromium.org>
References: <20250303200212.3294679-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Introduce generic netlink messages into the binder driver so that the
Linux/Android system administration processes can listen to important
events and take corresponding actions, like stopping a broken app from
attacking the OS by sending huge amount of spamming binder transactions.

The binder netlink sources and headers are automatically generated from
the corresponding binder netlink YAML spec. Don't modify them directly.

Signed-off-by: Li Li <dualli@google.com>
---
 Documentation/admin-guide/binder_netlink.rst | 108 +++++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder.yaml      | 116 ++++++++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 229 ++++++++++++++++++-
 drivers/android/binder_internal.h            |  16 ++
 drivers/android/binder_netlink.c             |  46 ++++
 drivers/android/binder_netlink.h             |  23 ++
 drivers/android/binder_trace.h               |  35 +++
 include/uapi/linux/android/binder_netlink.h  |  57 +++++
 11 files changed, 630 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h

diff --git a/Documentation/admin-guide/binder_netlink.rst b/Documentation/admin-guide/binder_netlink.rst
new file mode 100644
index 000000000000..83f54f0d8c45
--- /dev/null
+++ b/Documentation/admin-guide/binder_netlink.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================
+Generic Netlink for the Android Binder Driver (Binder Netlink)
+==============================================================
+
+The Generic Netlink subsystem in the Linux kernel provides a generic way for
+the Linux kernel to communicate with the user space applications via binder
+driver. It is used to report binder transaction errors and warnings to user
+space administration process. The driver allows multiple binder devices and
+their corresponding binder contexts. Each context and their processes can be
+configured independently to report their own transactions.
+
+Basically, the user space code uses the BINDER_CMD_REPORT_SETUP command to
+request what kind of binder transactions should be reported by the driver.
+The driver then echoes the attributes in a reply message to acknowledge the
+request. The BINDER_CMD_REPORT_SETUP command also registers the current
+user space process to receive the reports. This BINDER_CMD_REPORT_SETUP
+command is protected by SELinux, to prevent unauthorized user apps from
+triggering unexpected reports.
+
+Currently the driver reports these binder transaction errors and warnings.
+1. "FAILED" transactions that fail to reach the target process;
+2. "ASYNC_FROZEN" transactions that are delayed due to the target process
+being frozen by cgroup freezer; or
+3. "SPAM" transactions that are considered spamming according to existing
+logic in binder_alloc.c.
+
+When the specified binder transactions happen, the driver uses the
+BINDER_CMD_REPORT command to send a generic netlink message to the
+registered process, containing the payload defined in binder.yaml.
+
+More details about the flags, attributes and operations can be found at the
+the doc sections in Documentations/netlink/specs/binder.yaml and the
+kernel-doc comments of the new source code in binder.{h|c}.
+
+Using Binder Netlink
+--------------------
+
+The Binder Netlink can be used in the same way as any other generic netlink
+drivers. Userspace application uses a raw netlink socket to send commands
+to and receive packets from the kernel driver.
+
+Usage example (user space pseudo code):
+
+::
+    /*
+     * send() below is overloaded to pack netlink commands and attributes
+     * to nlattr/genlmsghdr/nlmsghdr and then send to the netlink socket.
+     *
+     * recv() below is overloaded to receive the raw netlink message from
+     * the netlink socket, parse nlmsghdr/genlmsghdr to find the netlink
+     * command and then return the nlattr payload.
+     */
+
+    // open netlink socket
+    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+
+    // bind netlink socket
+    bind(fd, struct socketaddr);
+
+    // get the family id of the binder netlink
+    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME,
+            BINDER_FAMILY_NAME);
+    void *data = recv(CTRL_CMD_NEWFAMILY);
+    if (!has_nla_type(data, CTRL_ATTR_FAMILY_ID)) {
+        // Binder Netlink isn't available on this version of Linux kernel
+        return;
+    }
+    __u16 id = nla(data)[CTRL_ATTR_FAMILY_ID];
+    __u32 grp = nla(data)[CTRL_ATTR_MCAST_GROUPS][CTRL_ATTR_MCAST_GRP_ID];
+
+    // join the mcast group to listen to the binder netlink messages
+    setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &grp, sizeof(grp));
+
+    // enable per-context binder report
+    send(fd, id, BINDER_CMD_REPORT_SETUP, "binder", 0,
+            BINDER_FLAG_FAILED | BINDER_FLAG_DELAYED);
+
+    // confirm the per-context configuration
+    data = recv(fd, BINDER_CMD_REPLY);
+    char *context = nla(data)[BINDER_A_CMD_CONTEXT];
+    __u32 pid =  nla(data)[BINDER_A_CMD_PID];
+    __u32 flags = nla(data)[BINDER_A_CMD_FLAGS];
+
+    // set optional per-process report, overriding the per-context one
+    send(fd, id, BINDER_CMD_REPORT_SETUP, "binder", getpid(),
+            BINDER_FLAG_SPAM | BINDER_REPORT_OVERRIDE);
+
+    // confirm the optional per-process configuration
+    data = recv(fd, BINDER_CMD_REPLY);
+    context = nla(data)[BINDER_A_CMD_CONTEXT];
+    pid =  nla(data)[BINDER_A_CMD_PID];
+    flags = nla(data)[BINDER_A_CMD_FLAGS];
+
+    // wait and read all binder reports
+    while (running) {
+            data = recv(fd, BINDER_CMD_REPORT);
+            auto *attr = nla(data)[BINDER_A_REPORT_XXX];
+
+            // process binder report
+            do_something(*attr);
+    }
+
+    // clean up
+    send(fd, id, BINDER_CMD_REPORT_SETUP, 0, 0);
+    send(fd, id, BINDER_CMD_REPORT_SETUP, getpid(), 0);
+    close(fd);
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c8af32a8f800..655f39ddf1cf 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -120,6 +120,7 @@ Block-layer and filesystem administration
    :maxdepth: 1
 
    bcache
+   binder_netlink
    binderfs
    blockdev/index
    cifs/index
diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
new file mode 100644
index 000000000000..e184645f6c41
--- /dev/null
+++ b/Documentation/netlink/specs/binder.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: binder
+protocol: genetlink
+uapi-header: linux/android/binder_netlink.h
+doc: Netlink protocol to report binder transaction errors and warnings.
+
+definitions:
+  -
+    type: flags
+    name: flag
+    doc: Define what kind of binder transactions should be reported.
+    entries: [ failed, async-frozen, spam, override ]
+
+attribute-sets:
+  -
+    name: cmd
+    doc: The supported attributes of "report-setup" command.
+    attributes:
+      -
+        name: context
+        type: string
+        doc: The binder context to enable binder netlink report.
+      -
+        name: pid
+        type: u32
+        doc: The binder proc to enable binder netlink report.
+      -
+        name: flags
+        type: u32
+        enum: flag
+        doc: What kind of binder transactions should be reported.
+  -
+    name: report
+    doc: The supported attributes of "report" command
+    attributes:
+      -
+        name: context
+        type: string
+        doc: The binder context where the binder netlink report happens.
+      -
+        name: err
+        type: u32
+        doc: Copy of binder_driver_return_protocol returned to the sender.
+      -
+        name: from_pid
+        type: u32
+        doc: Sender pid of the corresponding binder transaction.
+      -
+        name: from_tid
+        type: u32
+        doc: Sender tid of the corresponding binder transaction.
+      -
+        name: to_pid
+        type: u32
+        doc: Target pid of the corresponding binder transaction.
+      -
+        name: to_tid
+        type: u32
+        doc: Target tid of the corresponding binder transaction.
+      -
+        name: reply
+        type: u32
+        doc: 1 means the transaction is a reply, 0 otherwise.
+      -
+        name: flags
+        type: u32
+        doc: Copy of binder_transaction_data->flags.
+      -
+        name: code
+        type: u32
+        doc: Copy of binder_transaction_data->code.
+      -
+        name: data_size
+        type: u32
+        doc: Copy of binder_transaction_data->data_size.
+
+operations:
+  list:
+    -
+      name: report-setup
+      doc: Set flags from user space.
+      attribute-set: cmd
+
+      do:
+        request: &params
+          attributes:
+            - context
+            - pid
+            - flags
+        reply: *params
+    -
+      name: report
+      doc: Send the requested reports to user space.
+      attribute-set: report
+
+      event:
+        attributes:
+          - context
+          - err
+          - from_pid
+          - from_tid
+          - to_pid
+          - to_tid
+          - reply
+          - flags
+          - code
+          - data_size
+
+kernel-family:
+  headers: [ "binder_internal.h" ]
+
+mcast-groups:
+  list:
+    -
+      name: report
diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 07aa8ae0a058..e2fa620934e2 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -4,6 +4,7 @@ menu "Android"
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
 	depends on MMU
+	depends on NET
 	default n
 	help
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c9d3d0c99c25..b8874dba884e 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -2,5 +2,5 @@
 ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
-obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
+obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_netlink.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..262c120a175a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 
 #include <linux/cacheflush.h>
 
+#include "binder_netlink.h"
 #include "binder_internal.h"
 #include "binder_trace.h"
 
@@ -2990,6 +2991,110 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
 	binder_thread_dec_tmpref(from);
 }
 
+/**
+ * binder_find_proc() - find the binder_proc by pid
+ * @pid:	the target process
+ *
+ * Returns the struct binder_proc if the pid is found, or NULL otherwise.
+ */
+static struct binder_proc *binder_find_proc(int pid)
+{
+	struct binder_proc *proc;
+
+	mutex_lock(&binder_procs_lock);
+	hlist_for_each_entry(proc, &binder_procs, proc_node) {
+		if (proc->pid == pid)
+			break;
+	}
+	mutex_unlock(&binder_procs_lock);
+
+	return proc;
+}
+
+/**
+ * binder_netlink_enabled() - check if binder netlink reports are enabled
+ * @proc:	the binder_proc to check
+ * @mask:	the categories of binder netlink reports
+ *
+ * Returns true if certain binder netlink reports are enabled for this binder
+ * proc (when per-process overriding takes effect) or context.
+ */
+static bool binder_netlink_enabled(struct binder_proc *proc, u32 mask)
+{
+	struct binder_context *context = proc->context;
+
+	if (!genl_has_listeners(&binder_nl_family, &init_net, BINDER_NLGRP_REPORT))
+		return false;
+
+	if (proc->report_flags & BINDER_FLAG_OVERRIDE)
+		return (proc->report_flags & mask) != 0;
+	else
+		return (context->report_flags & mask) != 0;
+}
+
+/**
+ * binder_netlink_report() - report one binder netlink event
+ * @context:	the binder context
+ * @err:	copy of binder_driver_return_protocol returned to the sender
+ * @pid:	sender process
+ * @tid:	sender thread
+ * @to_pid:	target process
+ * @to_tid:	target thread
+ * @reply:	whether the binder transaction is a reply
+ * @tr:		the binder transaction data
+ *
+ * Packs the report data into a binder netlink message and send it.
+ */
+static void binder_netlink_report(struct binder_context *context, u32 err,
+				  u32 pid, u32 tid, u32 to_pid, u32 to_tid,
+				  u32 reply,
+				  struct binder_transaction_data *tr)
+{
+	struct sk_buff *skb;
+	void *hdr;
+	int ret;
+
+	trace_binder_netlink_report(context->name, err, pid, tid, to_pid,
+				    to_tid, reply, tr);
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb) {
+		pr_err("Failed to alloc binder netlink message\n");
+		return;
+	}
+
+	hdr = genlmsg_put(skb, 0, atomic_inc_return(&context->report_seq),
+			  &binder_nl_family, 0, BINDER_CMD_REPORT);
+	if (!hdr)
+		goto free_skb;
+
+	if (nla_put_string(skb, BINDER_A_REPORT_CONTEXT, context->name) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_ERR, err) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_PID, pid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_TID, tid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_PID, to_pid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_TID, to_tid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_REPLY, reply) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FLAGS, tr->flags) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_CODE, tr->code) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_DATA_SIZE, tr->data_size))
+		goto cancel_skb;
+
+	genlmsg_end(skb, hdr);
+
+	ret = genlmsg_multicast(&binder_nl_family, skb, 0, BINDER_NLGRP_REPORT, GFP_KERNEL);
+	if (ret < 0)
+		pr_err("Failed to send binder netlink message: %d\n", ret);
+	return;
+
+cancel_skb:
+	pr_err("Failed to add attributes to binder netlink message\n");
+	genlmsg_cancel(skb, hdr);
+free_skb:
+	pr_err("Free binder netlink report message on error\n");
+	nlmsg_free(skb);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -3683,10 +3788,17 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (t->buffer->oneway_spam_suspect)
+	if (t->buffer->oneway_spam_suspect) {
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
-	else
+		if (binder_netlink_enabled(proc, BINDER_FLAG_SPAM))
+			binder_netlink_report(context, BR_ONEWAY_SPAM_SUSPECT,
+					      proc->pid, thread->pid,
+					      target_proc ? target_proc->pid : 0,
+					      target_thread ? target_thread->pid : 0,
+					      reply, tr);
+	} else {
 		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
+	}
 	t->work.type = BINDER_WORK_TRANSACTION;
 
 	if (reply) {
@@ -3736,8 +3848,15 @@ static void binder_transaction(struct binder_proc *proc,
 		 * process and is put in a pending queue, waiting for the target
 		 * process to be unfrozen.
 		 */
-		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+			if (binder_netlink_enabled(proc, BINDER_FLAG_ASYNC_FROZEN))
+				binder_netlink_report(context, return_error,
+						      proc->pid, thread->pid,
+						      target_proc ? target_proc->pid : 0,
+						      target_thread ? target_thread->pid : 0,
+						      reply, tr);
+		}
 		binder_enqueue_thread_work(thread, tcomplete);
 		if (return_error &&
 		    return_error != BR_TRANSACTION_PENDING_FROZEN)
@@ -3799,6 +3918,13 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node_tmpref(target_node);
 	}
 
+	if (binder_netlink_enabled(proc, BINDER_FLAG_FAILED))
+		binder_netlink_report(context, return_error,
+				      proc->pid, thread->pid,
+				      target_proc ? target_proc->pid : 0,
+				      target_thread ? target_thread->pid : 0,
+				      reply, tr);
+
 	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
 		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, code %u size %lld-%lld line %d\n",
 		     proc->pid, thread->pid, reply ? "reply" :
@@ -6334,6 +6460,98 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
 	mutex_unlock(&binder_deferred_lock);
 }
 
+/**
+ * binder_nl_report_setup_doit() - netlink .doit handler
+ * @skb:	the metadata struct passed from netlink driver
+ * @info:	the generic netlink struct passed from netlink driver
+ *
+ * Implements the .doit function to process binder netlink commands.
+ */
+int binder_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct binder_context *context = NULL;
+	struct binder_device *device;
+	struct binder_proc *proc;
+	u32 flags, pid;
+	void *hdr;
+	int ret;
+
+	ret = security_binder_setup_report(current_cred());
+	if (ret < 0) {
+		NL_SET_ERR_MSG(info->extack, "Permission denied");
+		return ret;
+	}
+
+	hlist_for_each_entry(device, &binder_devices, hlist) {
+		if (!nla_strcmp(info->attrs[BINDER_A_CMD_CONTEXT],
+				device->context.name)) {
+			context = &device->context;
+			break;
+		}
+	}
+
+	if (!context) {
+		NL_SET_ERR_MSG(info->extack, "Unknown binder context");
+		return -EINVAL;
+	}
+
+	pid = nla_get_u32(info->attrs[BINDER_A_CMD_PID]);
+	flags = nla_get_u32(info->attrs[BINDER_A_CMD_FLAGS]);
+
+	if (!pid) {
+		/* Set the global flags for the whole binder context */
+		context->report_flags = flags;
+	} else {
+		/* Set the per-process flags */
+		proc = binder_find_proc(pid);
+		if (!proc) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Invalid binder report pid %u",
+					   pid);
+			ret = -EINVAL;
+			goto err_exit;
+		}
+
+		proc->report_flags = flags;
+	}
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb) {
+		pr_err("Failed to alloc binder netlink reply message\n");
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	hdr = genlmsg_iput(skb, info);
+	if (!hdr)
+		goto free_skb;
+
+	if (nla_put_string(skb, BINDER_A_CMD_CONTEXT, context->name) ||
+	    nla_put_u32(skb, BINDER_A_CMD_PID, pid) ||
+	    nla_put_u32(skb, BINDER_A_CMD_FLAGS, flags))
+		goto cancel_skb;
+
+	genlmsg_end(skb, hdr);
+
+	if (genlmsg_reply(skb, info)) {
+		pr_err("Failed to send binder netlink reply message\n");
+		ret = -EFAULT;
+		goto err_exit;
+	}
+
+	return 0;
+
+cancel_skb:
+	pr_err("Failed to add reply attributes to binder netlink message\n");
+	genlmsg_cancel(skb, hdr);
+free_skb:
+	pr_err("Free binder netlink reply message on error\n");
+	nlmsg_free(skb);
+	ret = -EMSGSIZE;
+err_exit:
+	return ret;
+}
+
 static void print_binder_transaction_ilocked(struct seq_file *m,
 					     struct binder_proc *proc,
 					     const char *prefix,
@@ -7013,6 +7231,11 @@ static int __init binder_init(void)
 	if (ret)
 		goto err_init_binder_device_failed;
 
+	ret = genl_register_family(&binder_nl_family);
+	if (ret) {
+		pr_err("Failed to register binder netlink family\n");
+		goto err_init_binder_device_failed;
+	}
 	return ret;
 
 err_init_binder_device_failed:
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 6a66c9769c6c..8ddd1ddea8e0 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -11,15 +11,28 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <net/genetlink.h>
 #include <uapi/linux/android/binderfs.h>
 #include "binder_alloc.h"
 #include "dbitmap.h"
 
+/**
+ * struct binder_context - information about a binder domain
+ * @binder_context_mgr_node: the context manager
+ * @context_mgr_node_lock:   the lock protecting the above context manager node
+ * @binder_context_mgr_uid:  the uid of the above context manager
+ * @name:                    the name of the binder device
+ * @report_flags:            the categories of binder transactions that would
+ *                           be reported (see enum binder_report_flag).
+ * @report_seq:              the seq number of the generic netlink report
+ */
 struct binder_context {
 	struct binder_node *binder_context_mgr_node;
 	struct mutex context_mgr_node_lock;
 	kuid_t binder_context_mgr_uid;
 	const char *name;
+	u32 report_flags;
+	atomic_t report_seq;
 };
 
 /**
@@ -413,6 +426,8 @@ struct binder_ref {
  * @binderfs_entry:       process-specific binderfs log file
  * @oneway_spam_detection_enabled: process enabled oneway spam detection
  *                        or not
+ * @report_flags:         the categories of binder transactions that would
+ *                        be reported (see enum binder_genl_flag).
  *
  * Bookkeeping structure for binder processes
  */
@@ -451,6 +466,7 @@ struct binder_proc {
 	spinlock_t outer_lock;
 	struct dentry *binderfs_entry;
 	bool oneway_spam_detection_enabled;
+	u32 report_flags;
 };
 
 /**
diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
new file mode 100644
index 000000000000..9dc1820951c3
--- /dev/null
+++ b/drivers/android/binder_netlink.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "binder_netlink.h"
+
+#include <uapi/linux/android/binder_netlink.h>
+#include <binder_internal.h>
+
+/* BINDER_CMD_REPORT_SETUP - do */
+static const struct nla_policy binder_report_setup_nl_policy[BINDER_A_CMD_FLAGS + 1] = {
+	[BINDER_A_CMD_CONTEXT] = { .type = NLA_NUL_STRING, },
+	[BINDER_A_CMD_PID] = { .type = NLA_U32, },
+	[BINDER_A_CMD_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0xf),
+};
+
+/* Ops table for binder */
+static const struct genl_split_ops binder_nl_ops[] = {
+	{
+		.cmd		= BINDER_CMD_REPORT_SETUP,
+		.doit		= binder_nl_report_setup_doit,
+		.policy		= binder_report_setup_nl_policy,
+		.maxattr	= BINDER_A_CMD_FLAGS,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group binder_nl_mcgrps[] = {
+	[BINDER_NLGRP_REPORT] = { "report", },
+};
+
+struct genl_family binder_nl_family __ro_after_init = {
+	.name		= BINDER_FAMILY_NAME,
+	.version	= BINDER_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= binder_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(binder_nl_ops),
+	.mcgrps		= binder_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(binder_nl_mcgrps),
+};
diff --git a/drivers/android/binder_netlink.h b/drivers/android/binder_netlink.h
new file mode 100644
index 000000000000..0ef8c91ab319
--- /dev/null
+++ b/drivers/android/binder_netlink.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_BINDER_GEN_H
+#define _LINUX_BINDER_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/android/binder_netlink.h>
+#include <binder_internal.h>
+
+int binder_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	BINDER_NLGRP_REPORT,
+};
+
+extern struct genl_family binder_nl_family;
+
+#endif /* _LINUX_BINDER_GEN_H */
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 16de1b9e72f7..6fb454bcd857 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -423,6 +423,41 @@ TRACE_EVENT(binder_return,
 			  "unknown")
 );
 
+TRACE_EVENT(binder_netlink_report,
+	TP_PROTO(const char *name, u32 err, u32 pid, u32 tid, u32 to_pid,
+		 u32 to_tid, u32 reply, struct binder_transaction_data *tr),
+	TP_ARGS(name, err, pid, tid, to_pid, to_tid, reply, tr),
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(u32, err)
+		__field(u32, pid)
+		__field(u32, tid)
+		__field(u32, to_pid)
+		__field(u32, to_tid)
+		__field(u32, reply)
+		__field(u32, flags)
+		__field(u32, code)
+		__field(binder_size_t, data_size)
+	),
+	TP_fast_assign(
+		__entry->name = name;
+		__entry->err = err;
+		__entry->pid = pid;
+		__entry->tid = tid;
+		__entry->to_pid = to_pid;
+		__entry->to_tid = to_tid;
+		__entry->reply = reply;
+		__entry->flags = tr->flags;
+		__entry->code = tr->code;
+		__entry->data_size = tr->data_size;
+	),
+	TP_printk("%s: %d %d:%d -> %d:%d %s flags=0x08%x code=%d %llu",
+		  __entry->name, __entry->err, __entry->pid, __entry->tid,
+		  __entry->to_pid, __entry->to_tid,
+		  __entry->reply ? "reply" : "",
+		  __entry->flags, __entry->code, __entry->data_size)
+);
+
 #endif /* _BINDER_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/include/uapi/linux/android/binder_netlink.h b/include/uapi/linux/android/binder_netlink.h
new file mode 100644
index 000000000000..fa926ed19507
--- /dev/null
+++ b/include/uapi/linux/android/binder_netlink.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+#define _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+
+#define BINDER_FAMILY_NAME	"binder"
+#define BINDER_FAMILY_VERSION	1
+
+/*
+ * Define what kind of binder transactions should be reported.
+ */
+enum binder_flag {
+	BINDER_FLAG_FAILED = 1,
+	BINDER_FLAG_ASYNC_FROZEN = 2,
+	BINDER_FLAG_SPAM = 4,
+	BINDER_FLAG_OVERRIDE = 8,
+};
+
+enum {
+	BINDER_A_CMD_CONTEXT = 1,
+	BINDER_A_CMD_PID,
+	BINDER_A_CMD_FLAGS,
+
+	__BINDER_A_CMD_MAX,
+	BINDER_A_CMD_MAX = (__BINDER_A_CMD_MAX - 1)
+};
+
+enum {
+	BINDER_A_REPORT_CONTEXT = 1,
+	BINDER_A_REPORT_ERR,
+	BINDER_A_REPORT_FROM_PID,
+	BINDER_A_REPORT_FROM_TID,
+	BINDER_A_REPORT_TO_PID,
+	BINDER_A_REPORT_TO_TID,
+	BINDER_A_REPORT_REPLY,
+	BINDER_A_REPORT_FLAGS,
+	BINDER_A_REPORT_CODE,
+	BINDER_A_REPORT_DATA_SIZE,
+
+	__BINDER_A_REPORT_MAX,
+	BINDER_A_REPORT_MAX = (__BINDER_A_REPORT_MAX - 1)
+};
+
+enum {
+	BINDER_CMD_REPORT_SETUP = 1,
+	BINDER_CMD_REPORT,
+
+	__BINDER_CMD_MAX,
+	BINDER_CMD_MAX = (__BINDER_CMD_MAX - 1)
+};
+
+#define BINDER_MCGRP_REPORT	"report"
+
+#endif /* _UAPI_LINUX_ANDROID_BINDER_NETLINK_H */
-- 
2.48.1.711.g2feabab25a-goog

