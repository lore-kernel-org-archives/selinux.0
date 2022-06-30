Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BBC43334
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 21:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiF3VFh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiF3VFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 17:05:37 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6A4D153
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 14:05:35 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8057B564D4F
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 23:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656623133; bh=SbeBqnujYysLnXHGJxdzpgW8B56eqNBsPaimU43DNck=;
        h=From:Date:Message-ID:Subject:To;
        b=GgXSoI9V3scYOEFWjKTevn3NJaVFYWGfeV1+rgMyg/wLd+weVYiYQIUzLI6Dqi8Ng
         nOEzR9uP8Uh9wFxDowTu1aZ4VVBg7MXdCRtC3PEogHvoqot/EsXpR2uUTuZhVSKo2A
         CBzerWaGtapUDZnErEdM18kbUiVNaNwSvaG/WgZE=
Received: by mail-pl1-f171.google.com with SMTP id o18so491163plg.2
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 14:05:33 -0700 (PDT)
X-Gm-Message-State: AJIora9P2lOb+8WGb37wQUN701Ms/ZdfkiXtdRfB2fNmNO5obOieCxpc
        2i0ae3cHu3Hves/3C8TdslNUefoEFSBiYqoSlSY=
X-Google-Smtp-Source: AGRyM1vxnQdjnev+jeDprmSCFzqNaAIn0B4nRdm+x7mqpuX4zfSNxUoG+RIZVKkCKxISP8FMhHzAPmO0d6U2Udd2b6Q=
X-Received: by 2002:a17:902:ea47:b0:16b:997b:5fd6 with SMTP id
 r7-20020a170902ea4700b0016b997b5fd6mr12702889plg.16.1656623132264; Thu, 30
 Jun 2022 14:05:32 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 30 Jun 2022 23:05:21 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
Message-ID: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
Subject: What is "fscon" statement in a base policy?
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jun 30 23:05:34 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

While studying some malloc calls in libsepol and checkpolicy, I
stumbled upon function define_fs_context(), which allocates a
fixed-size buffer in
https://github.com/SELinuxProject/selinux/blob/956bda08f6183078f13b70f6aa27d0529a3ec20a/checkpolicy/policy_define.c#L4631-L4637

    newc->u.name = (char *)malloc(6);
    if (!newc->u.name) {
        yyerror("out of memory");
        free(newc);
        return -1;
    }
    sprintf(newc->u.name, "%02x:%02x", major, minor);

As major and minor are unsigned int (so 32-bit integers) without any
value checking, there seems to be a possible heap buffer overflow
issue. This function is called when parsing a fscon statement in a
"base" policy. So I copied tmp/base.conf from a build of the Reference
Policy, added "fscon 1000 1000 system_u:object_r:unlabeled_t
system_u:object_r:unlabeled_t" right after "sid security
system_u:object_r:security_t" (the order of the statements matters),
and ran:

    $ checkpolicy -o test.pol base.conf
    *** buffer overflow detected ***: terminated
    Aborted (core dumped)

For whatever it's worth, the stack trace of this abort tells that the
buffer overflow occurs in a call to __sprintf_chk(): my gcc compiler
seems to be "smart enough" to find out that the size of newc->u.name
was 6, and it replaced sprintf() with __sprintf_chk() to ensure that
the buffer was not written past its bounds.

Now, I can submit a patch to fix this issue, for example by replacing
malloc()+sprintf() with asprintf() and by checking that major and
minor are below 256. But before doing so, I was wondering: what is
this fscon syntax? I have never encountered it, did not find any
policy using it, and I am wondering whether we could instead drop its
support and remove function define_fs_context() from checkpolicy.

Thanks,
Nicolas

