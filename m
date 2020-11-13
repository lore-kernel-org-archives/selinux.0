Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F9C63699
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369452225D
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 23:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZEWrlqZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKMX3j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKMX3i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Nov 2020 18:29:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDCC0617A6
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2020 15:29:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w13so16116950eju.13
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2020 15:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=t/qZm+FmOV7fcrGuKM74tPZpmLFufkl+cYUDyl8sKjE=;
        b=ZEWrlqZtfDE9MXM93iwSO6Hsrg4uifO8GvUjrPmcSMuPr6VYJKlHpAsn3EU2NMUmb6
         gY7+eEPPOY1tKQ3mS5kQEYtQg7S5neA5MvaeD+s0f5W3ZwKK/lH4A2H/XnNFcn9ASJ6Y
         5uJh5c1WFIKNge7njSMVHHAqL6Z/h9YVcAKIBCt9z0sWxoXYbZ1OrS9s+zhHu9RhVV6q
         eYL9gwizQHEyX2ZkvLLtB/KO/R209D8dPwh8DTKkQQn0DV8/eChaJRm8nbeksSgwuVnI
         S47ovJW0E4DU3C9s0cHGtPjJ+F6Yl1rpu2XABYs/myj77eaD+f4PoXC2wXt9YaP3axrf
         i8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=t/qZm+FmOV7fcrGuKM74tPZpmLFufkl+cYUDyl8sKjE=;
        b=ENfK6PWEi0ht8DJjkud5bvA3mjwaEZFaTdVVbiuhqy2CItEN67R/UyLYvMkGl1Oz2X
         +IlbJC2ucgHnVRzwj+XGV0/K05OjG+0DHbGS2GWgKQWDbjkOQCuvXQbRG00AoyPAml+z
         oakUJ+GYpqYqSZdU2jE/LL1m185jV2noxsAUYt7QpibbnDjSgyS0TmPaKx/qQCzT26Oy
         KHZwEehy7l550VO2myNf+vNdF0ENc3PwepE5u7Ph//z/qcnVhhdi6nlSsvyCFHOdmIsZ
         xaJg3+8ELYhd7/kgSeTEclpqQ510qHhol/YU4STwbyYmUDZfH2sXCfw0YFQuqm2xy/yc
         o9jQ==
X-Gm-Message-State: AOAM532xlYw2RTrAEMFA7HvyMBq3bfKXpkgjqH7AF0GeKDTh8YL+46/L
        3NJo+5/42s1pnPSwzx/BCbTM13beHoiGiiRTa2mx
X-Google-Smtp-Source: ABdhPJxamGXwgRKFOprxSFaRdh+ouv37lES+1fjEDVj39NZwgn0zQWnhAsv4C70CMT3n5kCBXarPNFhPd5QqXHqNWZ4=
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr4268775ejz.488.1605310175763;
 Fri, 13 Nov 2020 15:29:35 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Nov 2020 18:29:23 -0500
Message-ID: <CAHC9VhSrJLtasTbE+smvHYMxD3B018TCLx74y9RQ0pk8jDaX4w@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.10 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

One small SELinux patch for v5.10-rcX to make sure we return an error
code when an allocation fails.  It passes all of our tests, but given
the nature of the patch that isn't surprising.  Please merge during
the v5.10-rcX cycle.

Thanks,
-Paul

--
The following changes since commit 0d50f059c4cdc9e436f6f4db8779ac0795bfdadf:

 selinux: provide a "no sooner than" date for the checkreqprot removal
   (2020-09-29 16:50:57 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20201113

for you to fetch changes up to c350f8bea271782e2733419bd2ab9bf4ec2051ef:

 selinux: Fix error return code in sel_ib_pkey_sid_slow()
   (2020-11-12 20:16:09-0500)

----------------------------------------------------------------
selinux/stable-5.10 PR 20201113

----------------------------------------------------------------
Chen Zhou (1):
     selinux: Fix error return code in sel_ib_pkey_sid_slow()

security/selinux/ibpkey.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
