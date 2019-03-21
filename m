Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DABC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A93218B0
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YTiaNSmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfCUOJh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:09:37 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:47081 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfCUOJh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 10:09:37 -0400
Received: by mail-lf1-f52.google.com with SMTP id r25so1105001lfn.13
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hbdYyODUiA2Z/YEKGK8SFEu3cURHNgEo3JDMGb+LYxk=;
        b=YTiaNSmOZzvV5n9nwN03ijojlw2rQgoRbOj8M6U08khWxiSg/mmYL/l+YLYx3m7YGL
         E5t6Ka0J4DRe/C2qrcEHVvUrAqSz3j2zDAFbNImtjrTW37XmCEmh4IgLChNDPIk9MKkN
         qA2Te1z1CIwTyiy1bKp2I1hZ1zQynK+yDMZiVi4mFI02hA237buNX9lBg+PwU1U/RTMf
         +m3WoE22GQK9TSevGVzPHxMIhY+l5ZolyVMTX1HvtPvjIbCgBOZiR6hmdbHtIboF9A/F
         P4tKMGR0fgkVM1SqbZfE4koMrxyXvoAkQLjidMJbjXyNkcsg+KzAsWkeC22ozUMdd5SK
         wjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hbdYyODUiA2Z/YEKGK8SFEu3cURHNgEo3JDMGb+LYxk=;
        b=Upjafa6eTi7j9dCV8NzKfdB7OnyesafRR2gCTlqOhg8biKdAlVaaA3tDcOMFdGaXdC
         7m2jp63i4/tRfZkMltTJvsMGDIsKWopgSDsLSa2lcs8R4wIFCyc9AKtppQXo/NdCufpT
         rJ0iuEDbzQ3+UMm63TlQb98XztIx4So9za2/awBRh7bo2BSfvQ7lto4lL0webGHvXEFw
         iZh/ERlQ26UwAY09TPyghspBjlypBvwQM7ZKXocAIAWCqoQL7GLkud2QTm5uUBRtcD0U
         gsFFZM1Iq7fD8XzVqSaR9JYJlru0JrVNDAyAWNlVtuVus77u/ErPiAOdKpQ5EkRimmmv
         1zzQ==
X-Gm-Message-State: APjAAAXHKTZtTotvz6UMJdwudBkQOJvIN3LBLM0aQy402M5Ip3z482ZI
        K+MBZwpX+X7uwqO+xDW4cHpsH+zWiG4imgIrJj+QO4PIDZGm
X-Google-Smtp-Source: APXvYqyKz4a0uhG/MuQigj8sUSve1tqadWavU/DUznbOb7nvpLnNKB8Wnv3y30xOIZIJdt+vtPk43Sgg6hAe62ap+vw=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr1926347lfl.91.1553177375077;
 Thu, 21 Mar 2019 07:09:35 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Mar 2019 10:09:24 -0400
Message-ID: <CAHC9VhRoo4_A0fg+Gp-Qsn_XVkTOQhe1pUShGig-k3ELKeW7XQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.1 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Another small SELinux fix for v5.1, please merge.

Thanks,
-Paul

--
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

 Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190321

for you to fetch changes up to 6a1afffb08ce5f9fb9ccc20f7ab24846c0142984:

 selinux: fix NULL dereference in policydb_destroy()
   (2019-03-18 12:19:48 -0400)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190321

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix NULL dereference in policydb_destroy()

security/selinux/ss/policydb.c | 13 +++++++++----
1 file changed, 9 insertions(+), 4 deletions(-)

-- 
paul moore
www.paul-moore.com
