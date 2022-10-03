Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE6C433F5
	for <selinux@archiver.kernel.org>; Mon,  3 Oct 2022 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJCUpM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJCUpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 16:45:09 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34813D79
        for <selinux@vger.kernel.org>; Mon,  3 Oct 2022 13:45:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso7079525fac.6
        for <selinux@vger.kernel.org>; Mon, 03 Oct 2022 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=GRFNXX+YGfhDX+aHBP2Nz6DfcCY9saOPFr6kWqxKvSw=;
        b=bgZGNnvMfKlPZeCu2f8GtaIjwdo06nqJhgXiyYNQ70/MUamPjQWWzAf65cmL5RILAE
         I7nH4hrqujTzVWRbE2pEXakx6VUL2nOHnb+VNd0x+MB2Y1cl/U5Ht+rO2x1y10PDTlV5
         Z2V7/SXtMOHPEw8abFgHd2Gp0kgJ+wrvHcQXMudNNtVVm559+X3L2IyrvdeiFUU1Gz3o
         o3zUQqtnt1PRlePPqjk7k+JQReKz8lEGTc8XWB5IMmkWYpNvZwtBcXfXhEMm2i/Q5D+w
         W8q1b/cPC8Ehf2hi6u7SErrjisY3JcZVlx+rbaZv/uw5VRfW1gLHmKRuRSeH/zEJAW0N
         6NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GRFNXX+YGfhDX+aHBP2Nz6DfcCY9saOPFr6kWqxKvSw=;
        b=7pOhpHh2D3k805mViGJZ2mS11ru5w91eOiS6m+r7h/tNg1s9Tcg+IAUsxwYdj71YpI
         l/GCORsuIjbRMhTg1Jq3J0nf9ON+13k0bklezgfOz/W0xMez7M8jJTT+l9ieNMptsEtZ
         oWdJjfQ6h+WSjgx1MHtTj0wOqZk1z9JzIuIjkJ7i29DWdTXAG1zdu0T7yvSQwpgo3CO0
         Ro6cFQXdmsPb1EuTyzUcfGPd4sO8Wy0iY+yHMoWu4EvBV4uXaoH6MthL675c8decqC9c
         aMRUWLYqGSyccy3njcfvFQFh49CLEY6FPX9WY1ZcDMTjoV1XJZLvnSv8w6XwRHmX9EZu
         F47Q==
X-Gm-Message-State: ACrzQf37QHYKJQfSF5UOfB6qW03v37t6WekEwlEr7AdGN/OIE/RZ8ILu
        6cb8OSStnDuKeVeQQ4NI1FnJjIB94DzmQiZZkAdY
X-Google-Smtp-Source: AMsMyM6AE4a3eyvYdZWj3InHKQ/Qj8Brq1+zlkvrSHcqTMaSz+NckPDuyvb00NvT+s/IkwROhhSGYn8ZYIUjKuyHlhs=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr6560165oab.172.1664829906962; Mon, 03
 Oct 2022 13:45:06 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Oct 2022 16:44:56 -0400
Message-ID: <CAHC9VhQF6oLGHN=fHSN568iM-mP7yDpMWH=OKwSRADu4Rb5-Dw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Six SELinux patches, all are simple and easily understood, but a list
of the highlights is below:

- Use 'grep -E' instead of 'egrep' in the SELinux policy install
script.  Fun fact, this seems to be GregKH's *second* dedicated
SELinux patch since we transitioned to git (ignoring merges, the SPDX
stuff, and a trivial fs reference removal when lustre was yanked); the
first was back in 2011 when selinuxfs was placed in /sys/fs/selinux.
Oh, the memories ...

- Convert the SELinux policy boolean values to use signed integer
types throughout the SELinux kernel code.  Prior to this we were using
a mix of signed and unsigned integers which was probably okay in this
particular case, but it is definitely not a good idea in general.

- Remove a reference to the SELinux runtime disable functionality in
/etc/selinux/config as we are in the process of deprecating that.  See
<https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-di=
sable>
for more background on this if you missed the previous notes on the
deprecation.

- Minor cleanups: remove unneeded variables and function parameter
constification.

Please merge for v6.1,
-Paul

--
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868=
:

 Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20221003

for you to fetch changes up to 2fe2fb4ce60be9005d7bfdd5665be03b8efb5b13:

 selinux: remove runtime disable message in the install_policy.sh script
   (2022-09-20 14:12:25 -0400)

----------------------------------------------------------------
selinux/stable-6.1 PR 20221003

----------------------------------------------------------------
Christian G=C3=B6ttsche (2):
     selinux: use int arrays for boolean values
     selinux: declare read-only parameters const

Greg Kroah-Hartman (1):
     selinux: use "grep -E" instead of "egrep"

Paul Moore (1):
     selinux: remove runtime disable message in the install_policy.sh scrip=
t

Xu Panda (1):
     selinux: remove the unneeded result variable

ye xingchen (1):
     selinux: remove an unneeded variable in sel_make_class_dir_entries()

scripts/selinux/install_policy.sh |  5 ++---
security/selinux/hooks.c          | 24 +++++++++---------------
security/selinux/selinuxfs.c      | 15 ++++++---------
security/selinux/ss/context.h     | 17 +++++++++--------
security/selinux/ss/ebitmap.c     | 21 +++++++++++----------
security/selinux/ss/ebitmap.h     | 18 +++++++++---------
security/selinux/ss/mls_types.h   |  4 ++--
7 files changed, 48 insertions(+), 56 deletions(-)

--=20
paul-moore.com
