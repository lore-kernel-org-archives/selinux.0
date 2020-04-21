Return-Path: <SRS0=PkHy=6F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF9C2BA19
	for <selinux@archiver.kernel.org>; Tue, 21 Apr 2020 04:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1D20781
	for <selinux@archiver.kernel.org>; Tue, 21 Apr 2020 04:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="HZ+yTakW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgDUEFe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgDUEFe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Apr 2020 00:05:34 -0400
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B8C061A0F
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 21:05:34 -0700 (PDT)
Received: from liv.localnet (localhost [127.0.0.1])
        by smtp.sws.net.au (Postfix) with ESMTP id D15AE14D53;
        Tue, 21 Apr 2020 14:05:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1587441930;
        bh=lZJVSKAvvfndwCcw32lYERQZn9xJy3G4JS6sTtXJqIQ=; l=6099;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZ+yTakWlORTeMXBjDxAoDlz7FXtQHV1uaPfiqAFigxZ1gCzuWb+yNv7vp6SGIKFc
         uMjJI+/lqq7VbETdra6DvTfl1TDGeiRYjnNFX6HkAjV6ASs4Hd2urPVmQYwxYiZvTS
         1FfN0Qvev+Dnf53LbFr/oxLc7WxMcO80qPxEX4SE=
From:   Russell Coker <russell@coker.com.au>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: semodule -i and load_policy coredumps on version 3.0 - not latest GIT
Date:   Tue, 21 Apr 2020 14:01:45 +1000
Message-ID: <2529366.HMiiFnPMKa@liv>
In-Reply-To: <CAJfZ7==9L2PZkbBO22=RapRKvdiZQ1Fj7jgEhNSUcZ1hTDyKPA@mail.gmail.com>
References: <2203189.X40rEyH0Y1@liv> <CAJfZ7==9L2PZkbBO22=RapRKvdiZQ1Fj7jgEhNSUcZ1hTDyKPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wednesday, 15 April 2020 3:27:38 AM AEST Nicolas Iooss wrote:
> This looks a pretty difficult issue. The facts that it is not easily
> reproducible and that the stack trace changes even though the 2
> modules you are testing do not are interesting. They imply that there

I have done more further testing.

I could not reproduce it on another VM on the same hardware.

I could not reproduce it on the same VM after a reboot of the physical 
hardware (running Debian/Unstable with KVM).

After the reboot I could not reproduce it on saved snapshots of the VM in 
question dating back to when I had previously had problems.  I conclude that 
rebooting the hardware solved the problem.

The problem was either an issue of failing hardware (I am running memtest86+ 
right now) or hostile action.  When testing for issues with libsepol I got a 
couple of coredumps from valgrind, that isn't necessarily an indication of 
anything (valgrind is complex software and it provides information on how to 
report bugs when it crashes so crashes of valgrind aren't unexpected).  I also 
got one coredump from sshd which is very unexpected, sshd is known to be high 
quality software that is well written and well audited.  This makes me wonder 
whether there is some commonality between sshd and semodule that causes both 
of them to have had problems on the system in question.  For background the 
sshd coredump info is below.

# coredumpctl info /usr/sbin/sshd
           PID: 42696 (sshd)
           UID: 0 (root)
           GID: 0 (root)
        Signal: 11 (SEGV)
     Timestamp: Tue 2020-04-14 19:48:42 UTC (6 days ago)
  Command Line: sshd: [accepted]
    Executable: /usr/sbin/sshd
       Boot ID: eec56f683e7b4aeb90a89845bd7920f8
    Machine ID: 384a085cdf4a437cae153168e34245f4
      Hostname: play
       Storage: /var/lib/systemd/coredump/core.sshd.
0.eec56f683e7b4aeb90a89845bd7920f8.42696.1586893722000000000000.lz4
       Message: Process 42696 (sshd) of user 0 dumped core.
                
                Stack trace of thread 42696:
                #0  0x00007f2dfe8da2e7 dl_new_hash (ld-linux-x86-64.so.2 + 
0xa2e7)
                #1  0x00007f2dfe8deaf3 _dl_fixup (ld-linux-x86-64.so.2 + 
0xeaf3)
                #2  0x00007f2dfe8e5383 _dl_runtime_resolve_fxsave (ld-linux-
x86-64.so.2 + 0x15383)
                #3  0x00007f2dfe1453e0 n/a (libcap-ng.so.0 + 0x23e0)
                #4  0x00007f2dfe1e9c78 __run_fork_handlers (libc.so.6 + 
0x84c78)
                #5  0x00007f2dfe22ffb8 __libc_fork (libc.so.6 + 0xcafb8)
                #6  0x000055ab9ae2bac9 n/a (sshd + 0xfac9)
                #7  0x00007f2dfe18be0b __libc_start_main (libc.so.6 + 0x26e0b)
                #8  0x000055ab9ae2bf7a n/a (sshd + 0xff7a)

I ran the spectre-meltdown-checker script, it says that the physical hardware 
in question is vulnerable to the following (there doesn't seem to be microcode 
updates for the Q9505 CPU to fix all the issues):

CVE-2018-3640 aka 'Variant 3a, rogue system register read'
* CPU microcode mitigates the vulnerability:  NO 
> STATUS:  VULNERABLE  (an up-to-date CPU microcode is needed to mitigate this 
vulnerability)

CVE-2018-3639 aka 'Variant 4, speculative store bypass'
* Mitigated according to the /sys interface:  NO  (Vulnerable)
* Kernel supports disabling speculative store bypass (SSB):  YES  (found in /
proc/self/status)
* SSB mitigation is enabled and active:  NO 
> STATUS:  VULNERABLE  (Your CPU doesn't support SSBD)

CVE-2018-12126 aka 'Fallout, microarchitectural store buffer data sampling 
(MSBDS)'
* Mitigated according to the /sys interface:  NO  (Vulnerable: Clear CPU 
buffers attempted, no microcode; SMT disabled)
* Kernel supports using MD_CLEAR mitigation:  YES  (found md_clear 
implementation evidence in kernel image)
* Kernel mitigation is enabled and active:  NO 
* SMT is either mitigated or disabled:  YES 
> STATUS:  VULNERABLE  (Your kernel supports mitigation, but your CPU 
microcode also needs to be updated to mitigate the vulnerability)

CVE-2018-12130 aka 'ZombieLoad, microarchitectural fill buffer data sampling 
(MFBDS)'
* Mitigated according to the /sys interface:  NO  (Vulnerable: Clear CPU 
buffers attempted, no microcode; SMT disabled)
* Kernel supports using MD_CLEAR mitigation:  YES  (found md_clear 
implementation evidence in kernel image)
* Kernel mitigation is enabled and active:  NO 
* SMT is either mitigated or disabled:  YES 
> STATUS:  VULNERABLE  (Your kernel supports mitigation, but your CPU 
microcode also needs to be updated to mitigate the vulnerability)

CVE-2018-12127 aka 'RIDL, microarchitectural load port data sampling (MLPDS)'
* Mitigated according to the /sys interface:  NO  (Vulnerable: Clear CPU 
buffers attempted, no microcode; SMT disabled)
* Kernel supports using MD_CLEAR mitigation:  YES  (found md_clear 
implementation evidence in kernel image)
* Kernel mitigation is enabled and active:  NO 
* SMT is either mitigated or disabled:  YES 
> STATUS:  VULNERABLE  (Your kernel supports mitigation, but your CPU 
microcode also needs to be updated to mitigate the vulnerability)

CVE-2019-11091 aka 'RIDL, microarchitectural data sampling uncacheable memory 
(MDSUM)'
* Mitigated according to the /sys interface:  NO  (Vulnerable: Clear CPU 
buffers attempted, no microcode; SMT disabled)
* Kernel supports using MD_CLEAR mitigation:  YES  (found md_clear 
implementation evidence in kernel image)
* Kernel mitigation is enabled and active:  NO 
* SMT is either mitigated or disabled:  YES 
> STATUS:  VULNERABLE  (Your kernel supports mitigation, but your CPU 
microcode also needs to be updated to mitigate the vulnerability)

Given that the system is vulnerable to certain known attacks and that sshd is 
a prime target for any such attack I believe that the sshd SEGV is an 
indication that the root cause might have been hostile action.  I don't expect 
to ever have proof of what was the cause (unless memtest86+ flags an error).  
When hostile activity goes away on reboot then something memory resident is 
likely in which case there's probably no record on disk.

I am convinced beyond all reasonable doubt that the SEGVs and valgrind 
warnings I saw from semodule were not evidence of a bug in libsepol.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



