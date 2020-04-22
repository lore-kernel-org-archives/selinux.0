Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FC0C54FCB
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0C2076E
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDVOrY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:47:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:14585 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgDVOrX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Apr 2020 10:47:23 -0400
IronPort-SDR: iBMSzdlx8DCHejZkaQfIYmIF6wOFfd7s97pqD/c5hPKdEEUFSMSImCzkZRggUGWDQtJCVZOBlB
 yACB/YhqZK9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:47:23 -0700
IronPort-SDR: pCt+7jfsTQWe2c268eXgsJTi47PzI6nR6VzUoE1WBQ7YOAjc0ehNz5GFveeUFBxDs8LFK24T/l
 vUfyHWV8m6dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="456533198"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2020 07:47:23 -0700
Received: from [10.249.227.181] (abudanko-mobl.ccr.corp.intel.com [10.249.227.181])
        by linux.intel.com (Postfix) with ESMTP id BEDED5802C9;
        Wed, 22 Apr 2020 07:47:19 -0700 (PDT)
Subject: [PATCH v2 4/4] perf docs: introduce security.txt file to document
 related issues
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
Organization: Intel Corp.
Message-ID: <38f3c52f-5ecd-03b1-27a0-12628fd19705@linux.intel.com>
Date:   Wed, 22 Apr 2020 17:47:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Publish instructions on how to apply LSM hooks for access control
to perf_event_open() syscall on Fedora (v31) with Targeted 
SELinux policy.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/security.txt | 236 ++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 tools/perf/Documentation/security.txt

diff --git a/tools/perf/Documentation/security.txt b/tools/perf/Documentation/security.txt
new file mode 100644
index 000000000000..7ca9377c1526
--- /dev/null
+++ b/tools/perf/Documentation/security.txt
@@ -0,0 +1,236 @@
+Overview
+========
+
+For general security related questions of perf_event_open() syscall usage,
+performance monitoring and observability operations by Perf see here:
+https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
+
+Enabling LSM based mandatory access control (MAC) to perf_event_open() syscall
+==============================================================================
+
+LSM hooks for mandatory access control for perf_event_open() syscall can be
+used starting from Linux v5.3. Below are the steps to extend Fedora (v31) with
+Targeted policy with perf_event_open() access control capabilities:
+
+1. Download selinux-policy SRPM package (e.g. selinux-policy-3.14.4-48.fc31.src.rpm on FC31)
+   and install it so rpmbuild directory would exist in the current working directory:
+
+   # rpm -Uhv selinux-policy-3.14.4-48.fc31.src.rpm
+
+2. Get into rpmbuild/SPECS directory and unpack the source code:
+
+   # rpmbuild -bp selinux-policy.spec
+
+3. Place patch below at rpmbuild/BUILD/selinux-policy-b86eaaf4dbcf2d51dd4432df7185c0eaf3cbcc02
+   directory and apply it:
+
+   # patch -p1 < selinux-policy-perf-events-perfmon.patch
+   patching file policy/flask/access_vectors
+   patching file policy/flask/security_classes
+   # cat selinux-policy-perf-events-perfmon.patch
+diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
+--- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
++++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
+@@ -174,6 +174,7 @@
+ 	wake_alarm
+ 	block_suspend
+ 	audit_read
++	perfmon
+ }
+ 
+ #
+@@ -1099,3 +1100,15 @@
+ 
+ class xdp_socket
+ inherits socket
++
++class perf_event
++{
++	open
++	cpu
++	kernel
++	tracepoint
++	read
++	write
++}
++
++
+diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
+--- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
++++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
+@@ -200,4 +200,6 @@
+ 
+ class xdp_socket
+ 
++class perf_event
++
+ # FLASK
+
+4. Get into rpmbuild/SPECS directory and build policy packages from patched sources:
+
+   # rpmbuild --noclean --noprep -ba selinux-policy.spec
+
+   so you have this:
+
+   # ls -alh rpmbuild/RPMS/noarch/
+   total 33M
+   drwxr-xr-x. 2 root root 4.0K Mar 20 12:16 .
+   drwxr-xr-x. 3 root root 4.0K Mar 20 12:16 ..
+   -rw-r--r--. 1 root root 112K Mar 20 12:16 selinux-policy-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root 1.2M Mar 20 12:17 selinux-policy-devel-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root 2.3M Mar 20 12:17 selinux-policy-doc-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root  12M Mar 20 12:17 selinux-policy-minimum-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root 4.5M Mar 20 12:16 selinux-policy-mls-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root 111K Mar 20 12:16 selinux-policy-sandbox-3.14.4-48.fc31.noarch.rpm
+   -rw-r--r--. 1 root root  14M Mar 20 12:17 selinux-policy-targeted-3.14.4-48.fc31.noarch.rpm
+
+5. Install SELinux packages from Fedora repository, if not already done so, and
+   update with the patched rpms above:
+
+   # rpm -Uhv rpmbuild/RPMS/noarch/selinux-policy-*
+
+6. Enable SELinux Permissive mode for Targeted policy, if not already done so:
+
+   # cat /etc/selinux/config
+
+   # This file controls the state of SELinux on the system.
+   # SELINUX= can take one of these three values:
+   #     enforcing - SELinux security policy is enforced.
+   #     permissive - SELinux prints warnings instead of enforcing.
+   #     disabled - No SELinux policy is loaded.
+   SELINUX=permissive
+   # SELINUXTYPE= can take one of these three values:
+   #     targeted - Targeted processes are protected,
+   #     minimum - Modification of targeted policy. Only selected processes are protected.
+   #     mls - Multi Level Security protection.
+   SELINUXTYPE=targeted
+
+7. Enable filesystem SELinux labeling at the next reboot:
+
+   # touch /.autorelabel
+
+8. Reboot machine and it will label filesystems and load Targeted policy into the kernel;
+
+9. Login and check that dmesg output doesn't mention that perf_event class is unknown to SELinux subsystem;
+
+10. Check that SELinux is enabled and in Permissive mode
+
+    # getenforce
+    Permissive
+
+11. Turn SELinux into Enforcing mode:
+
+    # setenforce 1
+    # getenforce
+    Enforcing
+
+Opening access to perf_event_open() syscall on Fedora with SELinux
+==================================================================
+
+Access to performance monitoring and observability operations by Perf
+can be limited for superuser or CAP_PERFMON privileged process.
+MAC policy settings (e.g. SELinux) can be loaded into the kernel and
+prevent unauthorized access to perf_event_open() syscall. In such case
+Perf tool provides a message similar to the one below:
+
+   # perf stat
+   Error:
+   Access to performance monitoring and observability operations is limited.
+   Enforced MAC policy settings (SELinux) can limit access to performance
+   monitoring and observability operations. Inspect system audit records for
+   more perf_event access control information and adjusting the policy.
+   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
+   access to performance monitoring and observability operations for users
+   without CAP_PERFMON capability. perf_event_paranoid setting is -1:
+     -1: Allow use of (almost) all events by all users
+         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
+   >= 0: Disallow raw and ftrace function tracepoint access
+   >= 1: Disallow CPU event access
+   >= 2: Disallow kernel profiling
+   To make the adjusted perf_event_paranoid setting permanent preserve it
+   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
+
+To make sure that access is limited by MAC policy settings inspect system
+audit records using journalctl command or /var/log/audit/audit.log so the
+output would contain AVC denied records related to perf_event:
+
+   # journalctl --reverse --no-pager | grep perf_event
+
+   python3[1318099]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
+                                         If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
+   setroubleshoot[1318099]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 4595ce5b-e58f-462c-9d86-3bc2074935de
+   audit[1318098]: AVC avc:  denied  { open } for  pid=1318098 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
+
+In order to open access to perf_event_open() syscall MAC policy settings can
+require to be extend. On SELinux system this can be done by loading a special
+policy module extending base policy settings. Perf related policy module can
+be generated using the system audit records about blocking perf_event access.
+Run the command below to generate my-perf.te policy extension file with
+perf_event related rules:
+
+   # ausearch -c 'perf' --raw | audit2allow -M my-perf && cat my-perf.te
+
+   module my-perf 1.0;
+
+   require {
+        type unconfined_t;
+        class perf_event { cpu kernel open read tracepoint write };
+   }
+
+   #============= unconfined_t ==============
+   allow unconfined_t self:perf_event { cpu kernel open read tracepoint write };
+
+Now compile, pack and load my-perf.pp extension module into the kernel:
+
+   # checkmodule -M -m -o my-perf.mod my-perf.te
+   # semodule_package -o my-perf.pp -m my-perf.mod
+   # semodule -X 300 -i my-perf.pp
+
+After all those taken steps above access to perf_event_open() syscall should
+now be allowed by the policy settings. Check access running Perf like this:
+
+   # perf stat
+   ^C
+   Performance counter stats for 'system wide':
+
+         36,387.41 msec cpu-clock                 #    7.999 CPUs utilized
+             2,629      context-switches          #    0.072 K/sec
+                57      cpu-migrations            #    0.002 K/sec
+                 1      page-faults               #    0.000 K/sec
+       263,721,559      cycles                    #    0.007 GHz
+       175,746,713      instructions              #    0.67  insn per cycle
+        19,628,798      branches                  #    0.539 M/sec
+         1,259,201      branch-misses             #    6.42% of all branches
+
+       4.549061439 seconds time elapsed
+
+The generated perf-event.pp related policy extension module can be removed
+from the kernel using this command:
+
+   # semodule -X 300 -r my-perf
+
+Alternatively the module can be temporarily disabled and enabled back using
+these two commands:
+
+   # semodule -d my-perf
+   # semodule -e my-perf
+
+If something went wrong
+=======================
+
+To turn SELinux into Permissive mode:
+   # setenforce 0
+
+To fully disable SELinux during kernel boot [3] set kernel command line parameter selinux=0
+
+To remove SELinux labeling from local filesystems:
+   # find / -mount -print0 | xargs -0 setfattr -h -x security.selinux
+
+To fully turn SELinux off a machine set SELINUX=disabled at /etc/selinux/config file and reboot;
+
+Links
+=====
+
+[1] https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/31/Everything/SRPMS/Packages/s/selinux-policy-3.14.4-49.fc31.src.rpm
+[2] https://docs.fedoraproject.org/en-US/Fedora/11/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-Enabling_and_Disabling_SELinux.html
+[3] https://danwalsh.livejournal.com/10972.html
-- 
2.24.1


