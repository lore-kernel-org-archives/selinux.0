Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D3C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 05:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5440D20757
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 05:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXM6lU7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgEVFzY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 01:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727903AbgEVFzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 01:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590126921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rLKxeVDwjfxiw38I4xWn7gigjYTT0PUzgJGXylCWNk8=;
        b=DXM6lU7hLmCtEQo7LO05uHeocdPu33gQ8/OXPfV2BHssu6oD/2KapJuFUQhvJK7l97ZZAM
        UlUy6KNpdYOLcxkiIJy7bgXsmBjbali5Eyn7w72uv8La6doxhi6ysH819ERQARqGedplvf
        kGXvMmTu0B72Wgu+zTwwNxSwUTfwby8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-TieoHGhBNBeZcN6oR4X9RA-1; Fri, 22 May 2020 01:55:17 -0400
X-MC-Unique: TieoHGhBNBeZcN6oR4X9RA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30836EC1A0;
        Fri, 22 May 2020 05:55:14 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-157.ams2.redhat.com [10.36.112.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB8166248F;
        Fri, 22 May 2020 05:54:59 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] capabilities: Introduce CAP_RESTORE
Date:   Fri, 22 May 2020 07:53:50 +0200
Message-Id: <20200522055350.806609-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This enables CRIU to checkpoint and restore a process as non-root.

Over the last years CRIU upstream has been asked a couple of time if it
is possible to checkpoint and restore a process as non-root. The answer
usually was: 'almost'.

The main blocker to restore a process was that selecting the PID of the
restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.

In the last two years the questions about checkpoint/restore as non-root
have increased and especially in the last few months we have seen
multiple people inventing workarounds.

The use-cases so far and their workarounds:

 * Checkpoint/Restore in an HPC environment in combination with
   a resource manager distributing jobs. Users are always running
   as non root, but there was the desire to provide a way to
   checkpoint and restore long running jobs.
   Workaround: setuid wrapper to start CRIU as root as non-root
   https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
 * Another use case to checkpoint/restore processes as non-root
   uses as workaround a non privileged process which cycles through
   PIDs by calling fork() as fast as possible with a rate of
   100,000 pids/s instead of writing to ns_last_pid
   https://github.com/twosigma/set_ns_last_pid
 * Fast Java startup using checkpoint/restore.
   We have been in contact with JVM developers who are integrating
   CRIU into a JVM to decrease the startup time.
   Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel
 * Container migration as non root. There are people already
   using CRIU to migrate containers as non-root. The solution
   there is to run it in a user namespace. So if you are able
   to carefully setup your environment with the namespaces
   it is already possible to restore a container/process as non-root.
   Unfortunately it is not always possible to setup an environment
   in such a way and for easier access to non-root based container
   migration this patch is also required.

There are probably a few more things guarded by CAP_SYS_ADMIN required
to run checkpoint/restore as non-root, but by applying this patch I can
already checkpoint and restore processes as non-root. As there are
already multiple workarounds I would prefer to do it correctly in the
kernel to avoid that CRIU users are starting to invent more workarounds.

I have used the following tests to verify that this change works as
expected by setting the new capability CAP_RESTORE on the two resulting
test binaries:

$ cat ns_last_pid.c
 // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nslastpid.html
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/file.h>
 #include <sys/types.h>
 #include <unistd.h>

int main(int argc, char *argv[])
{
	pid_t pid, new_pid;
	char buf[32];
	int fd;

	if (argc != 2)
		return 1;

	printf("Opening ns_last_pid...\n");
	fd = open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);
	if (fd < 0) {
		perror("Cannot open ns_last_pid");
		return 1;
	}

	printf("Locking ns_last_pid...\n");
	if (flock(fd, LOCK_EX)) {
		close(fd);
		printf("Cannot lock ns_last_pid\n");
		return 1;
	}

	pid = atoi(argv[1]);
	snprintf(buf, sizeof(buf), "%d", pid - 1);
	printf("Writing pid-1 to ns_last_pid...\n");
	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
		printf("Cannot write to buf\n");
		return 1;
	}

	printf("Forking...\n");
	new_pid = fork();
	if (new_pid == 0) {
		printf("I am the child!\n");
		exit(0);
	} else if (new_pid == pid)
		printf("I am the parent. My child got the pid %d!\n", new_pid);
	else
		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);

	printf("Cleaning up...\n");
	if (flock(fd, LOCK_UN))
		printf("Cannot unlock\n");
	close(fd);
	return 0;
}
$ id -u; /home/libcap/ns_last_pid 300000
1001
Opening ns_last_pid...
Locking ns_last_pid...
Writing pid-1 to ns_last_pid...
Forking...
I am the parent. My child got the pid 300000!
I am the child!
Cleaning up...

For the clone3() based approach:
$ cat clone3_set_tid.c
 #define _GNU_SOURCE
 #include <linux/sched.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <unistd.h>

 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))

int main(int argc, char *argv[])
{
	struct clone_args c_args = { };
	pid_t pid, new_pid;

	if (argc != 2)
		return 1;

	pid = atoi(argv[1]);
	c_args.set_tid = ptr_to_u64(&pid);
	c_args.set_tid_size = 1;

	printf("Forking...\n");
	new_pid = syscall(__NR_clone3, &c_args, sizeof(c_args));
	if (new_pid == 0) {
		printf("I am the child!\n");
		exit(0);
	} else if (new_pid == pid)
		printf("I am the parent. My child got the pid %d!\n", new_pid);
	else
		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
	printf("Done\n");

	return 0;
}
$ id -u; /home/libcap/clone3_set_tid 300000
1001
Forking...
I am the parent. My child got the pid 300000!
Done
I am the child!

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 include/linux/capability.h          | 5 +++++
 include/uapi/linux/capability.h     | 9 ++++++++-
 kernel/pid.c                        | 2 +-
 kernel/pid_namespace.c              | 2 +-
 security/selinux/include/classmap.h | 5 +++--
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index b4345b38a6be..1278313cb2bc 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -261,6 +261,11 @@ static inline bool bpf_capable(void)
 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
 }
 
+static inline bool restore_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_RESTORE) || ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index c7372180a0a9..4bcc4e3d41ff 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -406,7 +406,14 @@ struct vfs_ns_cap_data {
  */
 #define CAP_BPF			39
 
-#define CAP_LAST_CAP         CAP_BPF
+
+/* Allow checkpoint/restore related operations */
+/* Allow PID selection during clone3() */
+/* Allow writing to ns_last_pid */
+
+#define CAP_RESTORE		40
+
+#define CAP_LAST_CAP         CAP_RESTORE
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 3122043fe364..bbc26f2bcff6 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			if (tid != 1 && !tmp->child_reaper)
 				goto out_free;
 			retval = -EPERM;
-			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
+			if (!restore_ns_capable(tmp->user_ns))
 				goto out_free;
 			set_tid_size--;
 		}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0e5ac162c3a8..f58186b31ce6 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	struct ctl_table tmp = *table;
 	int ret, next;
 
-	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
+	if (write && !restore_ns_capable(pid_ns->user_ns))
 		return -EPERM;
 
 	/*
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 98e1513b608a..f8b8f12a6ebd 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -27,9 +27,10 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
+		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
+		"restore"
 
-#if CAP_LAST_CAP > CAP_BPF
+#if CAP_LAST_CAP > CAP_RESTORE
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 

base-commit: e8f3274774b45b5f4e9e3d5cad7ff9f43ae3add5
-- 
2.26.2

