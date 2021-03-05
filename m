Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2DC433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 02:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83A064F4C
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 02:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCECDm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECDm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 21:03:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF44C061574
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 18:03:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h10so492169edl.6
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 18:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bTELJpjfEybOzohvPLykHd1IZELHzzvHDzUEH2tpYr8=;
        b=nWzJCeQ9vglQCMOg/QBtS/+86G0/OEx/ba4pWrRctepmKrNK6cJM3ePBw8EidZgUf5
         qKCwd6iCLeGmn8se3DLMbXQvrq8Lh/gFsb63GT0/qlJaSxqqzy0uz1HUGZw85zo1r30F
         Rr7broRQtZjP05EIKEOniA02kD3eS1wqgdvtpwHpQcB4Bc+EcyqdoYpirP8dCj4M6YFo
         V1MO2qLV2AL/5nUwFmHpq2hSPoqtItPnjWypZw+TytDvPm9uhPee69S7SkeNRY7iEH3M
         cuHwDTKQBcHatJWEkQA1eh8fRk27LywNE6iXg7jm5KBnQtm9AOYyqQuKFwOfITZsqart
         nN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bTELJpjfEybOzohvPLykHd1IZELHzzvHDzUEH2tpYr8=;
        b=kFulThqMXN1VTG2SQ2pk+lPQi2aOxSj8rHQ11m5nSRK6Xho6UAw2D5ABJmoBHYdDwv
         ayAYcE+YHYAObJDBeiOstNtMr/tnd76J2EyP7I68wAalf9qzmqzbtk7G42JP58dyaRru
         KazGkTbJMVVnRASSRajSgkVIL5grT+oHi8dmqdXZ0ePfT5k8rRvFK6yDE/NJtQJdKuTp
         86LD6Y5WRk6VYmm6BoHO5ia8Da8gFAMrr/ddyqYy69vyGFhlC4OoC5qlzVDiLUs/ns+K
         0wULvy/wujXFoCFHI8Rns9eg0sYcZSJck4VTBeLktZVkQjd6nbKuTvcZoFYnJnXrEWBe
         GTuw==
X-Gm-Message-State: AOAM531/qLPIq0gyCF2e/NS2iqT8oXr0Bn0J+KpIJAsbMeLyCBsbuwxw
        yuoUN8ckX8ek6FdAu4UszWiBtczaoFD/Y01yVYCQQiWk3x+H+3I=
X-Google-Smtp-Source: ABdhPJwBZFIZ4JsoFqCXl5kV/7O7okFJgkqjuUwGOuKilkc9d7rLPHZfBvrKfGclr7XHypP8HyfiH/a+Jb6I3yl6vg4=
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr7074598eds.31.1614909820034;
 Thu, 04 Mar 2021 18:03:40 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 21:03:29 -0500
Message-ID: <CAHC9VhTUJAD9KQyb0ibFtCZx1nRRLLRuepbMP_CS3Ni+EQMa0Q@mail.gmail.com>
Subject: Quick announcement on the selinux/next and audit/next branches
To:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

As many of you are aware, normally with the close of the merge window
and the release of -rc1 I typically reset the selinux/next and
audit/next branches to Linus' -rc1 tag.  However, as you may have
heard already, there is a nasty problem with the early v5.12 kernels,
including -rc1, which could result in some fairly serious fs
corruption (see the LWN article below).  With that in mind, I'm not
going to reset the selinux/next and audit/next branches for this
development cycle, leaving them based on v5.11-rc2+patches (basically
the current stable-5.12 branches in each tree).  I don't expect this
to be a problem, but if necessary we can always rebase the -next
branches to -rc2 if it proves safe.

* https://lwn.net/Articles/848265

-- 
paul moore
www.paul-moore.com
