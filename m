Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BITCOIN_SPAM_02,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661AAC2D0BF
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24424648
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ScR7YtW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEQtW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:49:22 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:37996
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbfLEQtV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 11:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575564558; bh=cATTb/3yPpybnLKN0leex6/bZJhyfDu+y2cJCZuZ2/o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ScR7YtW/wG/izRm9NhCr9VLELpHyNPYpIZf+06UIJXpXB62QbVhoh4bSNc8lZabNyPCvcmWEpKfN+4p4YcS6YmEIVHVHvXkoOv2jKZU4cft1JE+t2kz5U+V8/F95OXdqOCgSPqJ3FXZgSCszuknUwI7zINz4js0q7XDsNoMkPKIig49+QHTjG3z1Wyg7GzTHjT9L13fIy7KqM2YYmWaeJ3Ooh6tkdN5FmHprATnQ85bgcxv/xJKraIe33JlNRNKiY0kQOrdAjurBaNQ7XckBEc2x1D8Fq61iqp+K8hpEaAy3UAf4v6EiPVEZIknpTRVIlOMGgaI1LUgYNizVKRr1iQ==
X-YMail-OSG: Xs1eQIcVM1l9M47q0lJ4TGdrIk2iS1XQJtwh4FUwg3R7OeWTdyQpno3Zi9F6l89
 MAOGMlq_xQV70ajJF4ZhoEFRq6NWACrp6ZjvOtG88pbuINaki8.f28EBPF6tCjTwAhvxNAZMsbiS
 yvylRrFhcbLu7WFg9WnnZw9L3R14h4Inwm7_I71RMriUzHvSpKD0LvIPaqXtl9.QSF5EHHi8zBkO
 v0jM0NAC2XAmPXg047pR5s_2rkwaIKt129zkvCFZ_Q6RKEylnNue1vWXnVdSibqod9H83B9DvpcK
 DWaD8KvzELq8E_gkmXRGCo9StxABrrTQ.hfCHPndYxbSmVP25C0lVgclXmPI.HA5lF_j4HD7N6mJ
 Vx4DGcRT.fJYhFBePUj1oyodouYRwXabcCzwOv2W0ROS1zstPd9RAe.YzyNUHjh1pfqWEVUw_vdO
 3wWQLH5PCsKA4dUiz.5yD.bDeEZnh0.pwFKuyYuzAN0WEefeZ3Nds_pqz8ELzbZrL1SAXhw7.Z8M
 NUMl3HnggybCJmhDAi.BNZ8yerONHR8tCPgXAYlqBol98NhDV69I7xBHDYDLeBavaRUVdWQu3Pdm
 JoEohNslyvgU1oB9OEMG.N0Sw.j_MR6jDvSDA1uGoR9eYAaVfxPwLSUa5dgOS_q1ERZtIUYPIVpE
 hLewi5OHH__aBcrkSgiBFxvgv5kli5iEAJtGuJ2jlHkO.pPjCV_8bKCD9xFbSw8y36N92UKucg_O
 3TvyZiyvcs7jrYUjUX253FmfH5YFX6vgA4bEafacR9JI2rc_kTnoqaMiZLkt..UWDF26.dmqyWLv
 piM_MyDqR1azgENGvkvbA0U6zb6QOplf0TSO.07OvQL5rJkKawxIG5B5Fp3GEW83rSR76JXmgLTT
 0YrRix7mRX8RmPfZiY1xSL7bd4vK7tABJw7OP1ydFYQtwW_2O07dGXlugcl3G2g3uwTvv8EU3AtS
 rReAeTnA2sipSjt4H.mELKQla_bd9A5C9qqH.BQd54uQqgD4IElCvyWOtcOs9NpS.uylsleGUAQE
 FwJbjFqbYN5nvPv5CzYekiSANg.LHNN9iBxA88RKzmIx3hEbQmenypXvblN2zgCRqJXcL8kfIgYX
 bm33AE86.qvDP2yBim8BD5vp22FcMCo36oa5DHHcGOHWTZ2o9FYJD1JbfmISHhdPupSaSMsPYP4T
 5A9UtXL3sgxV2yEkStryydtK_0tNBnGAZPDxLjt96TUJcViGPFOtjfiu7m7x.4wUBj7MfUThlUjR
 FzTfLsUJ5GddPIUB6McuIGwi2GXN2SucQ7TQw1adHChjiDWCByyLuxI_sOye.MSHqEUx7HYH.jcm
 iEDR0i4ZIlyVrF0FYXk1GxFwHLUcpe4oaVAKaLomG54SSIxhOmHBqi4WuuezgWzzx8qgHhgSYdYZ
 .5ze.ia1R3Zab5btvlwcwoiv3J8XOzI9b5Yn15vXV0qe0fqcVYqeaFPFGNQoQOFJTP7XN
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Dec 2019 16:49:18 +0000
Received: by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b8cde399072ed3df1dba498fa2f274e4;
          Thu, 05 Dec 2019 16:49:15 +0000 (UTC)
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
Date:   Thu, 5 Dec 2019 08:49:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/5/2019 8:15 AM, Alexey Budankov wrote:
> Currently access to perf_events functionality [1] beyond the scope perm=
itted
> by perf_event_paranoid [1] kernel setting is allowed to a privileged pr=
ocess
> [2] with CAP_SYS_ADMIN capability enabled in the process effective set =
[3].
>
> This patch set introduces CAP_SYS_PERFMON capability devoted to secure =
performance
> monitoring activity so that CAP_SYS_PERFMON would assist CAP_SYS_ADMIN =
in its
> governing role for perf_events based performance monitoring of a system=
=2E
>
> CAP_SYS_PERFMON aims to harden system security and integrity when monit=
oring
> performance using perf_events subsystem by processes and Perf privilege=
d users
> [2], thus decreasing attack surface that is available to CAP_SYS_ADMIN
> privileged processes [3].

Are there use cases where you would need CAP_SYS_PERFMON where you
would not also need CAP_SYS_ADMIN? If you separate a new capability
from CAP_SYS_ADMIN but always have to use CAP_SYS_ADMIN in conjunction
with the new capability it is all rather pointless.

The scope you've defined for this CAP_SYS_PERFMON is very small.
Is there a larger set of privilege checks that might be applicable
for it?
=C2=A0

>
> CAP_SYS_PERFMON aims to take over CAP_SYS_ADMIN credentials related to
> performance monitoring functionality of perf_events and balance amount =
of
> CAP_SYS_ADMIN credentials in accordance with the recommendations provid=
ed in
> the man page for CAP_SYS_ADMIN [3]: "Note: this capability is overloade=
d;
> see Notes to kernel developers, below."
>
> For backward compatibility reasons performance monitoring functionality=
 of=20
> perf_events subsystem remains available under CAP_SYS_ADMIN but its usa=
ge for
> secure performance monitoring use cases is discouraged with respect to =
the
> introduced CAP_SYS_PERFMON capability.
>
> In the suggested implementation CAP_SYS_PERFMON enables Perf privileged=
 users
> [2] to conduct secure performance monitoring using perf_events in the s=
cope
> of available online CPUs when executing code in kernel and user modes.
>
> Possible alternative solution to this capabilities balancing, system se=
curity
> hardening task could be to use the existing CAP_SYS_PTRACE capability t=
o govern
> perf_events' performance monitoring functionality, since process debugg=
ing is
> similar to performance monitoring with respect to providing insights in=
to
> process memory and execution details. However CAP_SYS_PTRACE still prov=
ides
> users with more credentials than are required for secure performance mo=
nitoring
> using perf_events subsystem and this excess is avoided by using the ded=
icated
> CAP_SYS_PERFMON capability.
>
> libcap library utilities [4], [5] and Perf tool can be used to apply
> CAP_SYS_PERFMON capability for secure performance monitoring beyond the=
 scope
> permitted by system wide perf_event_paranoid kernel setting and below a=
re the
> steps to evaluate the advancement suggested by the patch set:
>
>   - patch, build and boot the kernel
>   - patch, build Perf tool e.g. to /home/user/perf
>   ...
>   # git clone git://git.kernel.org/pub/scm/libs/libcap/libcap.git libca=
p
>   # pushd libcap
>   # patch libcap/include/uapi/linux/capabilities.h with [PATCH 1/3]
>   # make
>   # pushd progs
>   # ./setcap "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=3Dep" /home/use=
r/perf
>   # ./setcap -v "cap_sys_perfmon,cap_sys_ptrace,cap_syslog=3Dep" /home/=
user/perf
>   /home/user/perf: OK
>   # ./getcap /home/user/perf
>   /home/user/perf =3D cap_sys_ptrace,cap_syslog,cap_sys_perfmon+ep
>   # echo 2 > /proc/sys/kernel/perf_event_paranoid
>   # cat /proc/sys/kernel/perf_event_paranoid=20
>   2
>   ...
>   $ /home/user/perf top
>     ... works as expected ...
>   $ cat /proc/`pidof perf`/status
>   Name:	perf
>   Umask:	0002
>   State:	S (sleeping)
>   Tgid:	2958
>   Ngid:	0
>   Pid:	2958
>   PPid:	9847
>   TracerPid:	0
>   Uid:	500	500	500	500
>   Gid:	500	500	500	500
>   FDSize:	256
>   ...
>   CapInh:	0000000000000000
>   CapPrm:	0000004400080000
>   CapEff:	0000004400080000 =3D> 01000100 00000000 00001000 00000000 000=
00000
>                                      cap_sys_perfmon,cap_sys_ptrace,cap=
_syslog
>   CapBnd:	0000007fffffffff
>   CapAmb:	0000000000000000
>   NoNewPrivs:	0
>   Seccomp:	0
>   Speculation_Store_Bypass:	thread vulnerable
>   Cpus_allowed:	ff
>   Cpus_allowed_list:	0-7
>   ...
>
> Usage of cap_sys_perfmon effectively avoids unused credentials excess:
> - with cap_sys_admin:
>   CapEff:	0000007fffffffff =3D> 01111111 11111111 11111111 11111111 111=
11111
> - with cap_sys_perfmon:
>   CapEff:	0000004400080000 =3D> 01000100 00000000 00001000 00000000 000=
00000
>                                     38   34               19
>                            sys_perfmon   syslog           sys_ptrace
>
> The patch set is for tip perf/core repository:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip perf/core
>   tip sha1: ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
>
> [1] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
> [2] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml
> [3] http://man7.org/linux/man-pages/man7/capabilities.7.html
> [4] http://man7.org/linux/man-pages/man8/setcap.8.html
> [5] https://git.kernel.org/pub/scm/libs/libcap/libcap.git
> [6] https://sites.google.com/site/fullycapable/, posix_1003.1e-990310.p=
df
>
> ---
> Alexey Budankov (3):
>   capabilities: introduce CAP_SYS_PERFMON to kernel and user space
>   perf/core: apply CAP_SYS_PERFMON to CPUs and kernel monitoring
>   perf tool: extend Perf tool with CAP_SYS_PERFMON support
>
>  include/linux/perf_event.h          |  6 ++++--
>  include/uapi/linux/capability.h     | 10 +++++++++-
>  security/selinux/include/classmap.h |  4 ++--
>  tools/perf/design.txt               |  3 ++-
>  tools/perf/util/cap.h               |  4 ++++
>  tools/perf/util/evsel.c             | 10 +++++-----
>  tools/perf/util/util.c              | 15 +++++++++++++--
>  7 files changed, 39 insertions(+), 13 deletions(-)
>

