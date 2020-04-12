Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50094C2BA2B
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 16:37:14 +0000 (UTC)
X-Greylist: delayed 126 seconds by postgrey-1.34 at mail.kernel.org; Sun, 12 Apr 2020 16:37:13 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFF6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFF6206A1
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLQfG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgDLQfF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 12:35:05 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71614C0A3BE2
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 09:27:07 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BD5F1564702
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 18:26:48 +0200 (CEST)
Received: by mail-oi1-f176.google.com with SMTP id q204so5654557oia.13
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 09:26:48 -0700 (PDT)
X-Gm-Message-State: AGi0PubD9yAt6Sz8Z0Q0B+o3NahkaE+ewc8TwfkVDowSxkdB98KV3VEz
        rl0OOsQiFMzobeEZd6lII47fvyOErBC3dV+J2QY=
X-Google-Smtp-Source: APiQypLeT2+yB384SATlMIzbar84+heFZPC4VtSBuhqKREj6to7HBMwUAiv4Eoykv8PxNZZLt/U19DwwKfB2cDhabmA=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr8985551oig.153.1586708807671;
 Sun, 12 Apr 2020 09:26:47 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 12 Apr 2020 18:26:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k9UsVjai1ZaBQUquQv6X3B-RkPGL4PikhtLyNGiGOnJQ@mail.gmail.com>
Message-ID: <CAJfZ7=k9UsVjai1ZaBQUquQv6X3B-RkPGL4PikhtLyNGiGOnJQ@mail.gmail.com>
Subject: Duplicate versions of libsemanage symbols
To:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 12 18:26:49 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,
Since recent changes in libsemanage.so's linker script, I have been
experiencing issues. As I encountered these issues only when I was
using a build configuration which is slightly different from what is
in the repository, I wanted to spend time to investigate what was
going on before eventually submitting a proper bug report.
The issue I see is the following: when I compile with the gold linker
and a custom set of build options, linking libsemanage.so fails with
[1]:

/usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
'semanage_get_hll_compiler_path' which is also named in version
'LIBSEMANAGE_1.1' in script
/usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
'semanage_get_ignore_module_cache' which is also named in version
'LIBSEMANAGE_1.1' in script
/usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
'semanage_set_ignore_module_cache' which is also named in version
'LIBSEMANAGE_1.1' in script
...

Looking back at a normal build of current git master (that succeeded),
I indeed have:

$ objdump -T libsemanage/src/libsemanage.so | grep
semanage_get_hll_compiler_path
000000000001b9b0 g    DF .text 000000000000021c  LIBSEMANAGE_1.0
semanage_get_hll_compiler_path

The same command on libsemanage 3.0 (last release) gives:

$ objdump -T /usr/lib/libsemanage.so | grep semanage_get_hll_compiler_path
000000000001a3c0 g    DF .text 0000000000000224  LIBSEMANAGE_1.1
semanage_get_hll_compiler_path

In short, semanage_get_hll_compiler_path is defined twice in
libsemanage/src/libsemanage.map [2] and the linker only provides the
first one. In fact, libsemanage.so built from git master has currently
only 2 functions in LIBSEMANAGE_1.1:

$ objdump -T libsemanage/src/libsemanage.so | grep LIBSEMANAGE_1.1
000000000001e1f0 g    DF .text 000000000000010d  LIBSEMANAGE_1.1
semanage_module_install
000000000001eea0 g    DF .text 000000000000011f  LIBSEMANAGE_1.1
semanage_module_get_enabled

These functions changed their API between versions 1.0 and 1.1, so
this is normal (there are .symver macros in the code and they work
properly). The issue is that all the other symbols went into
LIBSEMANAGE_1.0 instead of LIBSEMANAGE_1.1. Is this a bug or did I
misunderstand something? Should the duplicated functions be removed
from LIBSEMANAGE_1.0 in libsemanage.map?

Thanks,
Nicolas

[1] https://travis-ci.org/github/fishilico/selinux/jobs/674002033#L2471
[2] https://github.com/SELinuxProject/selinux/blob/aa40067b7b86d5e4c951fccae1aa98baff148613/libsemanage/src/libsemanage.map

