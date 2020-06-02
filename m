Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAADC433E4
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181E02077D
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 09:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAAPHvVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBJ1n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:27:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42184 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbgFBJ1m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 05:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591090059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpCtDz9EDOlt+9nq+d+LCbFJ8nzeXqrdd2gxaP6cbuQ=;
        b=LAAPHvVdy/V8joTDQpiBEa2iedSHxu3CgYI4RB/DZndPcqn43JzTU3yfEJpbaxfPXfr8m0
        Eh80cUbLD8P7IHAfLNmAgzqveZpLutmId4qbr4/7PED/Ieuio4V2HYh5MNCje+Pe9j2iQo
        klv67+jFw1aFHbnNRpk1Ju1KGmc6Z1I=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-2A9X7wZeNgeCnTQjNSGFXQ-1; Tue, 02 Jun 2020 05:27:35 -0400
X-MC-Unique: 2A9X7wZeNgeCnTQjNSGFXQ-1
Received: by mail-oi1-f199.google.com with SMTP id p82so440000oia.13
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 02:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FpCtDz9EDOlt+9nq+d+LCbFJ8nzeXqrdd2gxaP6cbuQ=;
        b=aHoo7TVRfsdG8IU8Sl692Os0oVV0JHFuqv26MiSq74G3hoN5duMrO3tLOpDFyQTovX
         mxSHN6RS1DJ2ZPJlTqkS++1Xicqpuw7z05vh8iZghj2t03pn+ax8baG/6MTn8LQYbGar
         om5EuY/oYJejUTt94FclSQq487Ae6LfHpShMDdhtw9s0+mI38vmsj1qtwYwO4FzvPjVn
         pauROl4ejgRXMGTcCd/X73IolH1a0zLVnBwbpT35LI0Qm5T3KtDwjuMwpY7DUk29kD4S
         iSX7chx3j0VjIwP0f4LMXU7H4I5YPgo9tx8OI5X+gMiX4zsaE4zXPGUsM25CKo+ARHbe
         sAPQ==
X-Gm-Message-State: AOAM531pRSuOTPx7CeHsrMvjRYvx47j1GXtfpShxquyYnhNrJ4StCrk5
        C6l6yDxQPPiTcsKxzPTxTURSyIaDj6+AEjpWMI1mmwv2NPTn4/JHoSFzTTlNhTlrnIzPEarYkRC
        5qSS9U9R1Yc3F2ny44NnXw6UZRVwiAzCXMw==
X-Received: by 2002:aca:230e:: with SMTP id e14mr2344544oie.127.1591090054453;
        Tue, 02 Jun 2020 02:27:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3zzFwLj/bt3tG3QbIDOYxRXGu+iEjs9pgzfl9khrhi2ymOzZ3R++P+4OVd5Sw8VHUoW/JM18UkgbO0x6VQE0=
X-Received: by 2002:aca:230e:: with SMTP id e14mr2344533oie.127.1591090054178;
 Tue, 02 Jun 2020 02:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <cki.F472C8C7F2.AWNOVIOTU4@redhat.com>
In-Reply-To: <cki.F472C8C7F2.AWNOVIOTU4@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 2 Jun 2020 11:27:23 +0200
Message-ID: <CAFqZXNtdwMAiu65Ne0HLyY5JO-QK=cqT-OF_=6mdnGVo8XA9Eg@mail.gmail.com>
Subject: =?UTF-8?Q?Fwd=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E7=2E0=2Df359287=2E?=
        =?UTF-8?Q?cki_=28mainline=2Ekernel=2Eorg=29?=
To:     SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

it seems that the "overlay" subtest of the selinux-testsuite started
failing on the latest Linus' tree - see below. The relevant log is
here:
https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/06/01/5=
90497/selinux_policy__serge_testsuite/x86_64_1_selinux_taskout.log

Pasting in the relevant excerpt from the log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[...]
overlay/test ................
overlay/test ................ 1/119 rm: cannot remove
'overlay/container1/merged/transition': Permission denied

#   Failed test at overlay/test line 429.

#   Failed test at overlay/test line 447.
rm: cannot remove 'overlay/container1/merged/writedir': Permission denied

#   Failed test at overlay/test line 465.

overlay/test ................ 41/119 unlink: cannot unlink
'overlay/container1/merged/writefile': Permission denied

#   Failed test at overlay/test line 582.
rm: cannot remove 'overlay/container1/merged/transition': Permission denied

#   Failed test at overlay/test line 429.
rm: cannot remove 'overlay/container1/merged/writedir': Permission denied

#   Failed test at overlay/test line 465.
unlink: cannot unlink 'overlay/container1/merged/client_nounlinkfile':
Permission denied

#   Failed test at overlay/test line 573.
unlink: cannot unlink 'overlay/container1/merged/writefile': Permission den=
ied

#   Failed test at overlay/test line 582.
unlink: cannot unlink 'overlay/container1/merged/mounterfile': Permission d=
enied

#   Failed test at overlay/test line 600.

overlay/test ................ 113/119 # Looks like you failed 9 tests of 11=
9.


overlay/test ................ Dubious, test returned 9 (wstat 2304, 0x900)
Failed 9/119 subtests
[...]
Test Summary Report
-------------------
overlay/test              (Wstat: 2304 Tests: 119 Failed: 9)
  Failed tests:  35, 37-38, 51, 93, 96, 108-110
  Non-zero exit status: 9
Files=3D61, Tests=3D811, 165 wallclock secs ( 0.41 usr  0.09 sys +  4.87
cusr  6.68 csys =3D 12.05 CPU)
Result: FAIL
Failed 1/61 test programs. 9/811 subtests failed.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

I haven't tried to reproduce/debug it locally yet. Just posting here
as a heads-up. The last known good commit is c2b0fc847f31 ("Merge tag
'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm"), first known
failing is f359287765c0 ("Merge branch 'from-miklos' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs").

---------- Forwarded message ---------
From: CKI Project <cki-project@redhat.com>
Date: Tue, Jun 2, 2020 at 6:14 AM
Subject: =E2=9D=8C FAIL: Test report for kernel 5.7.0-f359287.cki (mainline=
.kernel.org)
To:
Cc: Milos Malik <mmalik@redhat.com>, Ondrej Mosnacek
<omosnace@redhat.com>, Memory Management <mm-qe@redhat.com>, Jan
Stancek <jstancek@redhat.com>, Fei Liu <feliu@redhat.com>, Jianlin Shi
<jishi@redhat.com>, Jianwen Ji <jiji@redhat.com>, Hangbin Liu
<haliu@redhat.com>

Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
            Commit: f359287765c0 - Merge branch 'from-miklos' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here=
:

  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=3Ddata=
warehouse/2020/06/01/590497

One or more kernel tests failed:

    x86_64:
     =E2=9D=8C selinux-policy: serge-testsuite

<snip>

Compile testing
---------------

We compiled the kernel for 1 architecture:

    x86_64:
      make options: -j30 INSTALL_MOD_STRIP=3D1 targz-pkg



Hardware testing
----------------
We booted each kernel and ran the following tests:

  x86_64:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9C=85 xfstests - ext4
       =E2=9C=85 xfstests - xfs
       =E2=9D=8C selinux-policy: serge-testsuite
       =E2=9C=85 storage: software RAID testing
       =E2=9C=85 stress: stress-ng
        =E2=9C=85 CPU: Frequency Driver Test
        =E2=9C=85 CPU: Idle Test
        =E2=9C=85 IOMMU boot test
        =E2=9C=85 IPMI driver test
        =E2=9C=85 IPMItool loop stress test
        =E2=9C=85 Storage blktests

    Host 2:
       =E2=9C=85 Boot test
        =E2=9C=85 kdump - sysrq-c

    Host 3:
       =E2=9C=85 Boot test
       =E2=9C=85 Podman system integration test - as root
       =E2=9C=85 Podman system integration test - as user
       =E2=9D=8C LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =E2=9D=8C Networking bridge: sanity
       =E2=9C=85 Ethernet drivers sanity
       =E2=9C=85 Networking socket: fuzz
       =E2=9C=85 Networking: igmp conformance test
       =E2=9D=8C Networking route: pmtu
       =E2=9D=8C Networking route_func - local
       =E2=9D=8C Networking route_func - forward
       =E2=9C=85 Networking TCP: keepalive test
       =E2=9C=85 Networking UDP: socket
       =E2=9C=85 Networking tunnel: geneve basic test
       =E2=9C=85 Networking tunnel: gre basic
       =E2=9C=85 L2TP basic test
       =E2=9C=85 Networking tunnel: vxlan basic
       =E2=9C=85 Networking ipsec: basic netns - transport
       =E2=9C=85 Networking ipsec: basic netns - tunnel
       =E2=9C=85 Libkcapi AF_ALG test
       =E2=9C=85 pciutils: sanity smoke test
       =E2=9C=85 pciutils: update pci ids test
       =E2=9C=85 ALSA PCM loopback test
       =E2=9C=85 ALSA Control (mixer) Userspace Element test
       =E2=9C=85 storage: SCSI VPD
        =E2=9C=85 CIFS Connectathon
        =E2=9C=85 POSIX pjd-fstest suites
        =E2=9C=85 jvm - DaCapo Benchmark Suite
        =E2=9C=85 jvm - jcstress tests
        =E2=9C=85 Memory function: kaslr
        =E2=9C=85 Networking firewall: basic netfilter test
        =E2=9C=85 audit: audit testsuite test
        =E2=9C=85 trace: ftrace/tracer
        =E2=9C=85 kdump - kexec_boot

  Test sources: https://github.com/CKI-project/tests-beaker
    Pull requests are welcome for new tests or improvements to existing tes=
ts!

Aborted tests
-------------
Tests that didn't complete running successfully are marked with =E2=9A=A1=
=E2=9A=A1=E2=9A=A1.
If this was caused by an infrastructure issue, we try to mark that
explicitly in the report.

Waived tests
------------
If the test run included waived tests, they are marked with . Such tests ar=
e
executed but their results are not taken into account. Tests are waived whe=
n
their results are not reliable enough, e.g. when they're just introduced or=
 are
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running yet are marked with =E2=8F=B1.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

