Return-Path: <SRS0=3b0v=S7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C8FC43219
	for <selinux@archiver.kernel.org>; Mon, 29 Apr 2019 22:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECAA2075E
	for <selinux@archiver.kernel.org>; Mon, 29 Apr 2019 22:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JE/CgKxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfD2Wzi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:55:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36099 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfD2Wze (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Apr 2019 18:55:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id y8so4537795ljd.3
        for <selinux@vger.kernel.org>; Mon, 29 Apr 2019 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fEaW15WXnU2V0dtGDjKdZi5j8WWSKMMheyucMQDKRlE=;
        b=JE/CgKxfVFMT2O4k1B1n9IpLRcpNVbTxLJKQJSEYTPpJej7K0ymOZQzaX1eTgNVVc8
         ODi8F4XgvYkXysUUYeH7U0sX5ATTAhhd81EUxhDrUIpbYuNEdLS8mlfKINsRlSe/dLJs
         b9Yh5BhC8to5SKcjqa+Au0xXW9jjZyxpRAkzl3FiYc9JYpJrrYrCnKdwjt0+PQARyiB0
         0NAV4T6DUMqAoue9U8asntZZ/+Rn1JiITlQdsU5s6V/8GGuE6UX7iz4Q0eV5jC/mi3+0
         e9HFoyzaMDPSCYWCL65VsT9GivSoYsFKzpV/7sU70NgINIwuPaf1+IAUso45bEScsTf7
         dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fEaW15WXnU2V0dtGDjKdZi5j8WWSKMMheyucMQDKRlE=;
        b=UR+/o4Do4YVNfm/YzfMa5Y3qv4e+nr5Ml8EVuL0Ga9X/RvNQ7iW4KGBa5LArMLtvFJ
         zIztwxUBiQ0co8WA4SS9wForWjtENxfVrb0ofjytlsoCZAv/IXFElTspfw9d8kiq59cB
         1s+ZhkJJ4LnFlyMI/mZCbPYmMqTZe+srILyb3cQo6YE/7TuCo28a8Ab1dXUQeLyItliW
         2Ggjq5BhCY8i9g0jUoD6H2hmKDmFSME4Al4L1HyMkwIba5lAm78ZhLIBanX0CZDSU9+k
         sNwNyXvCVojGHB3nZAtv3LAYxlHPxYHKgGIOgqKTTMqXmL1kqdslmjZR09Wiv0ha84nR
         6XoQ==
X-Gm-Message-State: APjAAAU5A7ed4ECNASbTD4po290GhQf33SsXWCwHtKFJNhhHUyDEwa18
        xl6wIaOdacLvOJu83SXxE3LgLKwU91ouzcnvTNx3
X-Google-Smtp-Source: APXvYqwt/xs7gpwOInhsa+VWGGSsdPSzmeyzfTV52zkPVRNXLp2xL9ILBAddJyokIiniKHcZETsfQfqIe5jw/Dtex+o=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr20443582lji.57.1556578532417;
 Mon, 29 Apr 2019 15:55:32 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Apr 2019 18:55:19 -0400
Message-ID: <CAHC9VhQ6QF7LvuFjr2YdYNX-3pW80nm+VJh4jK080JsKOzOVsA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.1 (#3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

One small patch for the stable folks to fix a problem when building
against the latest glibc.  I'll be honest and say that I'm not really
thrilled with the idea of sending this up right now, but Greg is a
little annoyed so here I figured I would at least send the PR.

-Paul

--
The following changes since commit 6a1afffb08ce5f9fb9ccc20f7ab24846c0142984:

 selinux: fix NULL dereference in policydb_destroy()
   (2019-03-18 12:19:48 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190429

for you to fetch changes up to dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e:

 selinux: use kernel linux/socket.h for genheaders and mdp
   (2019-04-29 11:34:58 -0400)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190429

----------------------------------------------------------------
Paulo Alcantara (1):
     selinux: use kernel linux/socket.h for genheaders and mdp

scripts/selinux/genheaders/genheaders.c | 1 -
scripts/selinux/mdp/mdp.c               | 1 -
security/selinux/include/classmap.h     | 1 +
3 files changed, 1 insertion(+), 2 deletions(-)

-- 
paul moore
www.paul-moore.com
