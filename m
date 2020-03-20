Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964CC4332D
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AA32072C
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCTMYz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:24:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:12268 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgCTMYz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 20 Mar 2020 08:24:55 -0400
IronPort-SDR: yItKqDZ39bsWUxYreeZdJJI59RO2OmLUx7OGjoRT+bCTunpezdMqa4vdwhtsgO48a+KXZmv85s
 LUbje9P4Bw4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 05:24:55 -0700
IronPort-SDR: c6OPt5+DAUXhd1iqPAMDsU8JwkRpwJ5TVV4rP0h7SdGKrYH3MnLgUG7OeMyXMcpoUeRIO07T0x
 QOcoypavU3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="264054631"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2020 05:24:54 -0700
Received: from [10.249.224.114] (abudanko-mobl.ccr.corp.intel.com [10.249.224.114])
        by linux.intel.com (Postfix) with ESMTP id 8D252580342;
        Fri, 20 Mar 2020 05:24:49 -0700 (PDT)
Subject: Re: [PATCH v1] perf tool: make Perf tool aware of SELinux access
 control
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <b8a0669e-36e4-a0e8-fd35-3dbd890d2170@linux.intel.com>
 <f5ed60b2-4a61-dc72-bfd5-6d0af74bc152@linux.intel.com>
 <20200319190126.GF14841@kernel.org> <20200319190504.GG14841@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d521a22d-9fa7-1bca-fa60-f23b55953c91@linux.intel.com>
Date:   Fri, 20 Mar 2020 15:24:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319190504.GG14841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 19.03.2020 22:05, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 19, 2020 at 04:01:26PM -0300, Arnaldo Carvalho de Melo escreveu:
<SNIP>
> 
> So I'll try the steps below with/without your patch, and then... what
> are the steps that a tester needs to go thru to have that refpolicy in?
> Install some new SELinux package or library, spelling out in detail the
> steps one needs to go thru helps reviewing/testing,

Yes, sure. Steps to extend FC31 Targeted policy for testing perf_events access control:

* download selinux-policy srpm [1]: selinux-policy-3.14.4-48.fc31.src.rpm on my FC31

* install srpm - it creates rpmbuild dir: 
  [root@host ~]# rpm -Uhv selinux-policy-3.14.4-48.fc31.src.rpm

* get into rpmbuild/SPECS dir and unpack sources:
  [root@host ~]# rpmbuild -bp selinux-policy.spec

* Place patch below at rpmbuild/BUILD/selinux-policy-b86eaaf4dbcf2d51dd4432df7185c0eaf3cbcc02
  dir and apply it:
  [root@host ~]# patch -p1 < selinux-policy-perf-events-perfmon.patch
  patching file policy/flask/access_vectors
  patching file policy/flask/security_classes
  [root@host ~]# cat selinux-policy-perf-events-perfmon.patch
diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
--- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
+++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
@@ -174,6 +174,7 @@
 	wake_alarm
 	block_suspend
 	audit_read
+	perfmon
 }
 
 #
@@ -1099,3 +1100,15 @@
 
 class xdp_socket
 inherits socket
+
+class perf_event
+{
+	open
+	cpu
+	kernel
+	tracepoint
+	read
+	write
+}
+
+
diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
--- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
+++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
@@ -200,4 +200,6 @@
 
 class xdp_socket
 
+class perf_event
+
 # FLASK

  [root@host ~]#

 * get into rpmbuild/SPECS dir and build policy packages from patched sources: 
   [root@host ~]# rpmbuild --noclean --noprep -ba selinux-policy.spec
   so you have this:
   [root@host ~]# ls -alh rpmbuild/RPMS/noarch/
   total 33M
   drwxr-xr-x. 2 root root 4.0K Mar 20 12:16 .
   drwxr-xr-x. 3 root root 4.0K Mar 20 12:16 ..
   -rw-r--r--. 1 root root 112K Mar 20 12:16 selinux-policy-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root 1.2M Mar 20 12:17 selinux-policy-devel-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root 2.3M Mar 20 12:17 selinux-policy-doc-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root  12M Mar 20 12:17 selinux-policy-minimum-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root 4.5M Mar 20 12:16 selinux-policy-mls-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root 111K Mar 20 12:16 selinux-policy-sandbox-3.14.4-48.fc31.noarch.rpm
   -rw-r--r--. 1 root root  14M Mar 20 12:17 selinux-policy-targeted-3.14.4-48.fc31.noarch.rpm

 * install SELinux packages from FC repo [2], if not already done so, and 
   update with the patched rpms above:
   [root@host ~]# rpm -Uhv rpmbuild/RPMS/noarch/selinux-policy-*

 * there are also packages providing GUI interface and visualizing SELinux management
   [root@host ~]# dnf install policycoreutils-gui

 * enable SELinux Permissive mode for Targeted policy, if not already done so:
   [root@host ~]# cat /etc/selinux/config
   # This file controls the state of SELinux on the system.
   # SELINUX= can take one of these three values:
   #     enforcing - SELinux security policy is enforced.
   #     permissive - SELinux prints warnings instead of enforcing.
   #     disabled - No SELinux policy is loaded.
   SELINUX=permissive
   # SELINUXTYPE= can take one of these three values:
   #     targeted - Targeted processes are protected,
   #     minimum - Modification of targeted policy. Only selected processes are protected. 
   #     mls - Multi Level Security protection.
   SELINUXTYPE=targeted

 * enable filesystem SELinux labeling at the next reboot
   [root@host ~]# touch /.autorelabel

 * reboot machine and it will label filesystems and load Targeted policy into the kernel

 * login and check that dmesg output doesn't mention that perf_event class is unknown to SELinux subsystem

 * check that SELinux is enabled and in Permissive mode
   [root@host ~]# getenforce
   Permissive

 * turn SELinux into Enforcing mode:
   [root@host ~]# setenforce 1
   [root@host ~]# getenforce
   Enforcing

 * Now the machine is enabled to test the patch

--- If something went wrong ---

* To turn SELinux into Permissive mode: setenforce 0
* To fully disable SELinux during kernel boot [3] set kernel command line parameter: selinux=0
* To remove SELinux labeling from local filesystems: find / -mount -print0 | xargs -0 setfattr -h -x security.selinux
* To fully turn SELinux off a machine set SELINUX=disabled at /etc/selinux/config file and reboot

~Alexey

[1] https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/31/Everything/SRPMS/Packages/s/selinux-policy-3.14.4-49.fc31.src.rpm
[2] https://docs.fedoraproject.org/en-US/Fedora/11/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-Enabling_and_Disabling_SELinux.html
[3] https://danwalsh.livejournal.com/10972.html

