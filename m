Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D88C433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870EB207ED
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 15:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHZxUaiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgERP7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgERP7k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 11:59:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ECC061A0C;
        Mon, 18 May 2020 08:59:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d7so8449562qtn.11;
        Mon, 18 May 2020 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H7CSoSor8AH8XTaAAo9RAkr/f5FUC1HWB/XdRGHp4xk=;
        b=KHZxUaiXnYsm68HCqGmMtWJSpd636thZAOmNZKgmPt8dRqCwy21w5SkGE0YlhEKalm
         zn0SvUSkl/2nJTJbFjVTnEnoXf8Oot9PhFuwpW4wEx6lC1rmslnYJCaNjhKl2ojRhDNX
         ZA0LSjQ61RMDGdHPWmLWYkDTK+EccJIcUzQq/13i1AHEkReOXeBF22bjcnCDxErBeW0o
         9CMzGqlMKh2wtuBuhrDCyf4zA2SWxkF7Nf9SnRmhcuFCkscIjGeT6Lb5kJhmS0BSYNlW
         RuGiCTJiAD/qvCFvrMttG8zgsAEWS+UuoXS0Albv8zLDqT99wM4AYelF28toVsEzB9WQ
         dWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7CSoSor8AH8XTaAAo9RAkr/f5FUC1HWB/XdRGHp4xk=;
        b=kCkLuWGkl9Z+zqF9aRmrRjntqKmcOepDYWxe6/WeDf+8E+gTlsRAxv2bjAdXfffD1H
         cb/h+BDx6h0rT9fejF5Hobh9ivhS4Np8auDma+hKRMwkfyOAR2VHfYY49imC1NnG7I2a
         p8fdRHJYkS5HguM43qL6PIygZMJ6NUDDysphuGS5joqtmRARZD6TrmqIacQn06XaKJXX
         e09/ibUcRxlXl498czU0OACdTGBYDZMjyxgy1kBQ9ar4IpMBGCoWrVwo9cXAoYliUjbS
         apyuXHjA5GWyD2jUG21t1OWjogrL6FO8cDC4E3QsZlFvxCjw5qLVQVYHTmz+NMvbkYsS
         SKvw==
X-Gm-Message-State: AOAM5306Pjc7kIcqLxEaEEzZnR8/mkai7fbvL4xjEQJ8TV46cQbdJZv6
        gra02/AAUH8/2u4MT6JbhIrpEPt83B+Y0w==
X-Google-Smtp-Source: ABdhPJyLr9wD9buFxv/YK0Tt6xOl9KFUE2+l39l5MNbYJzAIL9vsjsiLIerRVzzdy04mvpwlN/1Y6w==
X-Received: by 2002:ac8:1c67:: with SMTP id j36mr15932752qtk.34.1589817579156;
        Mon, 18 May 2020 08:59:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g11sm8349340qkk.106.2020.05.18.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:59:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69B4640AFD; Mon, 18 May 2020 12:59:36 -0300 (-03)
Date:   Mon, 18 May 2020 12:59:36 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] perf docs: introduce security.txt file to
 document related issues
Message-ID: <20200518155936.GG24211@kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <290ded0a-c422-3749-5180-918fed1ee30f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290ded0a-c422-3749-5180-918fed1ee30f@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Thu, Apr 30, 2020 at 10:16:34AM +0300, Alexey Budankov escreveu:
> 
> Publish instructions on how to apply LSM hooks for access control
> to perf_event_open() syscall on Fedora distro with Targeted SELinux
> policy and then manage access to the syscall.

I'm fixing these up:

[acme@five perf]$ am /wb/1.patch
Applying: perf docs: introduce security.txt file to document related issues
.git/rebase-apply/patch:46: space before tab in indent.
 	wake_alarm
.git/rebase-apply/patch:47: space before tab in indent.
 	block_suspend
.git/rebase-apply/patch:48: space before tab in indent.
 	audit_read
.git/rebase-apply/patch:51: trailing whitespace.

.git/rebase-apply/patch:54: trailing whitespace.

 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/security.txt | 237 ++++++++++++++++++++++++++
>  1 file changed, 237 insertions(+)
>  create mode 100644 tools/perf/Documentation/security.txt
> 
> diff --git a/tools/perf/Documentation/security.txt b/tools/perf/Documentation/security.txt
> new file mode 100644
> index 000000000000..4fe3b8b1958f
> --- /dev/null
> +++ b/tools/perf/Documentation/security.txt
> @@ -0,0 +1,237 @@
> +Overview
> +========
> +
> +For general security related questions of perf_event_open() syscall usage,
> +performance monitoring and observability operations by Perf see here:
> +https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> +
> +Enabling LSM based mandatory access control (MAC) to perf_event_open() syscall
> +==============================================================================
> +
> +LSM hooks for mandatory access control for perf_event_open() syscall can be
> +used starting from Linux v5.3. Below are the steps to extend Fedora (v31) with
> +Targeted policy with perf_event_open() access control capabilities:
> +
> +1. Download selinux-policy SRPM package (e.g. selinux-policy-3.14.4-48.fc31.src.rpm on FC31)
> +   and install it so rpmbuild directory would exist in the current working directory:
> +
> +   # rpm -Uhv selinux-policy-3.14.4-48.fc31.src.rpm
> +
> +2. Get into rpmbuild/SPECS directory and unpack the source code:
> +
> +   # rpmbuild -bp selinux-policy.spec
> +
> +3. Place patch below at rpmbuild/BUILD/selinux-policy-b86eaaf4dbcf2d51dd4432df7185c0eaf3cbcc02
> +   directory and apply it:
> +
> +   # patch -p1 < selinux-policy-perf-events-perfmon.patch
> +   patching file policy/flask/access_vectors
> +   patching file policy/flask/security_classes
> +   # cat selinux-policy-perf-events-perfmon.patch
> +diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
> +--- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
> ++++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
> +@@ -174,6 +174,7 @@
> + 	wake_alarm
> + 	block_suspend
> + 	audit_read
> ++	perfmon
> + }
> + 
> + #
> +@@ -1099,3 +1100,15 @@
> + 
> + class xdp_socket
> + inherits socket
> ++
> ++class perf_event
> ++{
> ++	open
> ++	cpu
> ++	kernel
> ++	tracepoint
> ++	read
> ++	write
> ++}
> ++
> ++
> +diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
> +--- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
> ++++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
> +@@ -200,4 +200,6 @@
> + 
> + class xdp_socket
> + 
> ++class perf_event
> ++
> + # FLASK
> +
> +4. Get into rpmbuild/SPECS directory and build policy packages from patched sources:
> +
> +   # rpmbuild --noclean --noprep -ba selinux-policy.spec
> +
> +   so you have this:
> +
> +   # ls -alh rpmbuild/RPMS/noarch/
> +   total 33M
> +   drwxr-xr-x. 2 root root 4.0K Mar 20 12:16 .
> +   drwxr-xr-x. 3 root root 4.0K Mar 20 12:16 ..
> +   -rw-r--r--. 1 root root 112K Mar 20 12:16 selinux-policy-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root 1.2M Mar 20 12:17 selinux-policy-devel-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root 2.3M Mar 20 12:17 selinux-policy-doc-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root  12M Mar 20 12:17 selinux-policy-minimum-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root 4.5M Mar 20 12:16 selinux-policy-mls-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root 111K Mar 20 12:16 selinux-policy-sandbox-3.14.4-48.fc31.noarch.rpm
> +   -rw-r--r--. 1 root root  14M Mar 20 12:17 selinux-policy-targeted-3.14.4-48.fc31.noarch.rpm
> +
> +5. Install SELinux packages from Fedora repo, if not already done so, and
> +   update with the patched rpms above:
> +
> +   # rpm -Uhv rpmbuild/RPMS/noarch/selinux-policy-*
> +
> +6. Enable SELinux Permissive mode for Targeted policy, if not already done so:
> +
> +   # cat /etc/selinux/config
> +
> +   # This file controls the state of SELinux on the system.
> +   # SELINUX= can take one of these three values:
> +   #     enforcing - SELinux security policy is enforced.
> +   #     permissive - SELinux prints warnings instead of enforcing.
> +   #     disabled - No SELinux policy is loaded.
> +   SELINUX=permissive
> +   # SELINUXTYPE= can take one of these three values:
> +   #     targeted - Targeted processes are protected,
> +   #     minimum - Modification of targeted policy. Only selected processes are protected.
> +   #     mls - Multi Level Security protection.
> +   SELINUXTYPE=targeted
> +
> +7. Enable filesystem SELinux labeling at the next reboot:
> +
> +   # touch /.autorelabel
> +
> +8. Reboot machine and it will label filesystems and load Targeted policy into the kernel;
> +
> +9. Login and check that dmesg output doesn't mention that perf_event class is unknown to SELinux subsystem;
> +
> +10. Check that SELinux is enabled and in Permissive mode
> +
> +    # getenforce
> +    Permissive
> +
> +11. Turn SELinux into Enforcing mode:
> +
> +    # setenforce 1
> +    # getenforce
> +    Enforcing
> +
> +Opening access to perf_event_open() syscall on Fedora with SELinux
> +==================================================================
> +
> +Access to performance monitoring and observability operations by Perf
> +can be limited for superuser or CAP_PERFMON or CAP_SYS_ADMIN privileged
> +processes. MAC policy settings (e.g. SELinux) can be loaded into the kernel
> +and prevent unauthorized access to perf_event_open() syscall. In such case
> +Perf tool provides a message similar to the one below:
> +
> +   # perf stat
> +   Error:
> +   Access to performance monitoring and observability operations is limited.
> +   Enforced MAC policy settings (SELinux) can limit access to performance
> +   monitoring and observability operations. Inspect system audit records for
> +   more perf_event access control information and adjusting the policy.
> +   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> +   access to performance monitoring and observability operations for users
> +   without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.
> +   perf_event_paranoid setting is -1:
> +     -1: Allow use of (almost) all events by all users
> +         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> +   >= 0: Disallow raw and ftrace function tracepoint access
> +   >= 1: Disallow CPU event access
> +   >= 2: Disallow kernel profiling
> +   To make the adjusted perf_event_paranoid setting permanent preserve it
> +   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> +
> +To make sure that access is limited by MAC policy settings inspect system
> +audit records using journalctl command or /var/log/audit/audit.log so the
> +output would contain AVC denied records related to perf_event:
> +
> +   # journalctl --reverse --no-pager | grep perf_event
> +
> +   python3[1318099]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
> +                                         If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
> +   setroubleshoot[1318099]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 4595ce5b-e58f-462c-9d86-3bc2074935de
> +   audit[1318098]: AVC avc:  denied  { open } for  pid=1318098 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> +
> +In order to open access to perf_event_open() syscall MAC policy settings can
> +require to be extended. On SELinux system this can be done by loading a special
> +policy module extending base policy settings. Perf related policy module can
> +be generated using the system audit records about blocking perf_event access.
> +Run the command below to generate my-perf.te policy extension file with
> +perf_event related rules:
> +
> +   # ausearch -c 'perf' --raw | audit2allow -M my-perf && cat my-perf.te
> +
> +   module my-perf 1.0;
> +
> +   require {
> +        type unconfined_t;
> +        class perf_event { cpu kernel open read tracepoint write };
> +   }
> +
> +   #============= unconfined_t ==============
> +   allow unconfined_t self:perf_event { cpu kernel open read tracepoint write };
> +
> +Now compile, pack and load my-perf.pp extension module into the kernel:
> +
> +   # checkmodule -M -m -o my-perf.mod my-perf.te
> +   # semodule_package -o my-perf.pp -m my-perf.mod
> +   # semodule -X 300 -i my-perf.pp
> +
> +After all those taken steps above access to perf_event_open() syscall should
> +now be allowed by the policy settings. Check access running Perf like this:
> +
> +   # perf stat
> +   ^C
> +   Performance counter stats for 'system wide':
> +
> +         36,387.41 msec cpu-clock                 #    7.999 CPUs utilized
> +             2,629      context-switches          #    0.072 K/sec
> +                57      cpu-migrations            #    0.002 K/sec
> +                 1      page-faults               #    0.000 K/sec
> +       263,721,559      cycles                    #    0.007 GHz
> +       175,746,713      instructions              #    0.67  insn per cycle
> +        19,628,798      branches                  #    0.539 M/sec
> +         1,259,201      branch-misses             #    6.42% of all branches
> +
> +       4.549061439 seconds time elapsed
> +
> +The generated perf-event.pp related policy extension module can be removed
> +from the kernel using this command:
> +
> +   # semodule -X 300 -r my-perf
> +
> +Alternatively the module can be temporarily disabled and enabled back using
> +these two commands:
> +
> +   # semodule -d my-perf
> +   # semodule -e my-perf
> +
> +If something went wrong
> +=======================
> +
> +To turn SELinux into Permissive mode:
> +   # setenforce 0
> +
> +To fully disable SELinux during kernel boot [3] set kernel command line parameter selinux=0
> +
> +To remove SELinux labeling from local filesystems:
> +   # find / -mount -print0 | xargs -0 setfattr -h -x security.selinux
> +
> +To fully turn SELinux off a machine set SELINUX=disabled at /etc/selinux/config file and reboot;
> +
> +Links
> +=====
> +
> +[1] https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/31/Everything/SRPMS/Packages/s/selinux-policy-3.14.4-49.fc31.src.rpm
> +[2] https://docs.fedoraproject.org/en-US/Fedora/11/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-Enabling_and_Disabling_SELinux.html
> +[3] https://danwalsh.livejournal.com/10972.html
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
