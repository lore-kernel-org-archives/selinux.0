Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDEC43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5058920836
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6IDwqTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfLKTFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:05:13 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33135 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLKTFM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 14:05:12 -0500
Received: by mail-ua1-f65.google.com with SMTP id v19so8543957uap.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2019 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgwto0849vMQ7XPiGsQwkYbhhuHqEESP0KyWWvx0k5c=;
        b=i6IDwqTT1G2UbIHB4p9A/sk27uE1NJxIXwM8Lsf3yVCGeH020K+BNe3CC1ztwrj/f1
         RbNh9k2Rl5BqkM+6T6XuPqo1Vk+jcT7is2+tBHwQFlKFzte+kzsFuz3HzX0cv/F7uu+1
         yRqUCXBAoiozR+caAdBZ1tkLvokM/KzWG7z+jyqEpyulo1lTU0IoQpkmhI3CoYuYnZZh
         pA4BldO1RR/i/YsFtjxWEXpnoTzRbG8FixE28g3okRi+4fq3wf0ZZEoDf8KubCwUxaRN
         JfVW2+bul/KSqFNc38TxrwpYo2t3KOOOCiNduJORnG58ICUTRGaKv85Ib93S258hcxun
         +4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgwto0849vMQ7XPiGsQwkYbhhuHqEESP0KyWWvx0k5c=;
        b=HljM2ktiA5lDHZonAlO+zb4L5tePwBVUR5SvuWdyPyyDo7Xa5V5PpnxI66yKsuYfOW
         gY5/X2YaGuHaVeCu/3D3Zp51kfrHICKfpxOzGQz7iFLeg1AoefSsWXrrXTDEE7cxXxrW
         5LRQeNN5RKlYRKOLXpWUtREK+yN+zkXmeOHm/dXUgZUoE9PuN3wuuspFl9Or8p8gb9cv
         C+f/gDQvcjOyVgcWJtjJ4RE6lQj9MBTDAaiBVk0CW+iiXLQKialI3AyvHfutHDyOwi7G
         vFethRTvv64SrXDf63g/5gZi3AkIkax0Ewl0UTKArn1gLecJ18YVrJnzkYbwZCZ8/V8B
         WAtA==
X-Gm-Message-State: APjAAAXioeyzswPaBmTFfGjLqnRvs0e3JHxQ/+ecCh1YelLk9m1f6/J9
        cxACi3SkZg1imIY1RGG+e4NaDIqbdqjysHUTxvlSvg==
X-Google-Smtp-Source: APXvYqyW67dYgtnGzlxOu7XpE4KbdsNWBkdHNhcwlxjBEvm3nI+aEURnGOWzP1mh8NhsTGWP4fkgakObudXYfpZsAqU=
X-Received: by 2002:ab0:4483:: with SMTP id n3mr4675807uan.63.1576091110883;
 Wed, 11 Dec 2019 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com> <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
In-Reply-To: <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 11 Dec 2019 11:04:59 -0800
Message-ID: <CABPqkBRx8oU=eY9YKy4AcuMMGfhxCxtczzLABxA5wnRuUKa7Tg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 5, 2019 at 9:35 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 12/5/2019 9:05 AM, Alexey Budankov wrote:
> > Hello Casey,
> >
> > On 05.12.2019 19:49, Casey Schaufler wrote:
> >> On 12/5/2019 8:15 AM, Alexey Budankov wrote:
> >>> Currently access to perf_events functionality [1] beyond the scope permitted
> >>> by perf_event_paranoid [1] kernel setting is allowed to a privileged process
> >>> [2] with CAP_SYS_ADMIN capability enabled in the process effective set [3].
> >>>
> >>> This patch set introduces CAP_SYS_PERFMON capability devoted to secure performance
> >>> monitoring activity so that CAP_SYS_PERFMON would assist CAP_SYS_ADMIN in its
> >>> governing role for perf_events based performance monitoring of a system.
> >>>
> >>> CAP_SYS_PERFMON aims to harden system security and integrity when monitoring
> >>> performance using perf_events subsystem by processes and Perf privileged users
> >>> [2], thus decreasing attack surface that is available to CAP_SYS_ADMIN
> >>> privileged processes [3].
> >> Are there use cases where you would need CAP_SYS_PERFMON where you
> >> would not also need CAP_SYS_ADMIN? If you separate a new capability
> > Actually, there are. Perf tool that has record, stat and top modes could run with
> > CAP_SYS_PERFMON capability as mentioned below and provide system wide performance
> > data. Currently for that to work the tool needs to be granted with CAP_SYS_ADMIN.
>
> The question isn't whether the tool could use the capability, it's whether
> the tool would also need CAP_SYS_ADMIN to be useful. Are there existing
> tools that could stop using CAP_SYS_ADMIN in favor of CAP_SYS_PERFMON?

The answer is yes. I have recently been alerted to a problem with
paranoid=2 and the
popular rr debugger (https://rr-project.org/). This debugger uses
several perf_events
features, including profiling of PMU events and tracepoints
(context-switches). With
paranoid=2, it does not work anymore. We would need a privilege between regular
user and admin to make it work again. Note that context switches
tracepoint is only
applied to self (not system-wide).


> My bet is that any tool that does performance monitoring is going to need
> CAP_SYS_ADMIN for other reasons.
>
> >
> >> from CAP_SYS_ADMIN but always have to use CAP_SYS_ADMIN in conjunction
> >> with the new capability it is all rather pointless.
> >>
> >> The scope you've defined for this CAP_SYS_PERFMON is very small.
> >> Is there a larger set of privilege checks that might be applicable
> >> for it?
> > CAP_SYS_PERFMON could be applied broadly, though, this patch set enables record
> > and stat mode use cases for system wide performance monitoring in kernel and
> > user modes.
>
> The granularity of capabilities is something we have to watch
> very carefully. Sure, CAP_SYS_ADMIN covers a lot of things, but
> if we broke it up "properly" we'd have hundreds of capabilities.
> If you want control that finely we have SELinux.
>
> >
> > Thanks,
> > Alexey
> >
> >>
> >>
> >>> CAP_SYS_PERFMON aims to take over CAP_SYS_ADMIN credentials related to
> >>> performance monitoring functionality of perf_events and balance amount of
> >>> CAP_SYS_ADMIN credentials in accordance with the recommendations provided in
> >>> the man page for CAP_SYS_ADMIN [3]: "Note: this capability is overloaded;
> >>> see Notes to kernel developers, below."
> >>>
> >>> For backward compatibility reasons performance monitoring functionality of
> >>> perf_events subsystem remains available under CAP_SYS_ADMIN but its usage for
> >>> secure performance monitoring use cases is discouraged with respect to the
> >>> introduced CAP_SYS_PERFMON capability.
> >>>
> >>> In the suggested implementation CAP_SYS_PERFMON enables Perf privileged users
> >>> [2] to conduct secure performance monitoring using perf_events in the scope
> >>> of available online CPUs when executing code in kernel and user modes.
> >>>
> >>> Possible alternative solution to this capabilities balancing, system security
> >>> hardening task could be to use the existing CAP_SYS_PTRACE capability to govern
> >>> perf_events' performance monitoring functionality, since process debugging is
> >>> similar to performance monitoring with respect to providing insights into
> >>> process memory and execution details. However CAP_SYS_PTRACE still provides
> >>> users with more credentials than are required for secure performance monitoring
> >>> using perf_events subsystem and this excess is avoided by using the dedicated
> >>> CAP_SYS_PERFMON capability.
> >>>
> >>> libcap library utilities [4], [5] and Perf tool can be used to apply
> >>> CAP_SYS_PERFMON capability for secure performance monitoring beyond the scope
> >>> permitted by system wide perf_event_paranoid kernel setting and below are the
> >>> steps to evaluate the advancement suggested by the patch set:
> >>>
> >>>   - patch, build and boot the kernel
> >>>   - patch, build Perf tool e.g. to /home/user/perf
> >>>   ...
> >>>   # git clone git://git.kernel.org/pub/scm/libs/libcap/libcap.git libcap
> >>>   # pushd libcap
> >>>   # patch libcap/include/uapi/linux/capabilities.h with [PATCH 1/3]
> >>>   # make
> >>>   # pushd progs
> >>>   # ./setcap "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=ep" /home/user/perf
> >>>   # ./setcap -v "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=ep" /home/user/perf
> >>>   /home/user/perf: OK
> >>>   # ./getcap /home/user/perf
> >>>   /home/user/perf = cap_sys_ptrace,cap_syslog,cap_sys_perfmon+ep
> >>>   # echo 2 > /proc/sys/kernel/perf_event_paranoid
> >>>   # cat /proc/sys/kernel/perf_event_paranoid
> >>>   2
> >>>   ...
> >>>   $ /home/user/perf top
> >>>     ... works as expected ...
> >>>   $ cat /proc/`pidof perf`/status
> >>>   Name:     perf
> >>>   Umask:    0002
> >>>   State:    S (sleeping)
> >>>   Tgid:     2958
> >>>   Ngid:     0
> >>>   Pid:      2958
> >>>   PPid:     9847
> >>>   TracerPid:        0
> >>>   Uid:      500     500     500     500
> >>>   Gid:      500     500     500     500
> >>>   FDSize:   256
> >>>   ...
> >>>   CapInh:   0000000000000000
> >>>   CapPrm:   0000004400080000
> >>>   CapEff:   0000004400080000 => 01000100 00000000 00001000 00000000 00000000
> >>>                                      cap_sys_perfmon,cap_sys_ptrace,cap_syslog
> >>>   CapBnd:   0000007fffffffff
> >>>   CapAmb:   0000000000000000
> >>>   NoNewPrivs:       0
> >>>   Seccomp:  0
> >>>   Speculation_Store_Bypass: thread vulnerable
> >>>   Cpus_allowed:     ff
> >>>   Cpus_allowed_list:        0-7
> >>>   ...
> >>>
> >>> Usage of cap_sys_perfmon effectively avoids unused credentials excess:
> >>> - with cap_sys_admin:
> >>>   CapEff:   0000007fffffffff => 01111111 11111111 11111111 11111111 11111111
> >>> - with cap_sys_perfmon:
> >>>   CapEff:   0000004400080000 => 01000100 00000000 00001000 00000000 00000000
> >>>                                     38   34               19
> >>>                            sys_perfmon   syslog           sys_ptrace
> >>>
> >>> The patch set is for tip perf/core repository:
> >>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip perf/core
> >>>   tip sha1: ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
> >>>
> >>> [1] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
> >>> [2] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> >>> [3] http://man7.org/linux/man-pages/man7/capabilities.7.html
> >>> [4] http://man7.org/linux/man-pages/man8/setcap.8.html
> >>> [5] https://git.kernel.org/pub/scm/libs/libcap/libcap.git
> >>> [6] https://sites.google.com/site/fullycapable/, posix_1003.1e-990310.pdf
> >>>
> >>> ---
> >>> Alexey Budankov (3):
> >>>   capabilities: introduce CAP_SYS_PERFMON to kernel and user space
> >>>   perf/core: apply CAP_SYS_PERFMON to CPUs and kernel monitoring
> >>>   perf tool: extend Perf tool with CAP_SYS_PERFMON support
> >>>
> >>>  include/linux/perf_event.h          |  6 ++++--
> >>>  include/uapi/linux/capability.h     | 10 +++++++++-
> >>>  security/selinux/include/classmap.h |  4 ++--
> >>>  tools/perf/design.txt               |  3 ++-
> >>>  tools/perf/util/cap.h               |  4 ++++
> >>>  tools/perf/util/evsel.c             | 10 +++++-----
> >>>  tools/perf/util/util.c              | 15 +++++++++++++--
> >>>  7 files changed, 39 insertions(+), 13 deletions(-)
> >>>
> >>
>
