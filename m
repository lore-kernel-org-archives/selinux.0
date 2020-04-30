Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA1C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B6624954
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="u43mV+hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgD3VYe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbgD3VYd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 17:24:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB6C08E859
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 14:24:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so5743385edy.9
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZoHEfmnTDcYESuGHbMmk2jQ8V1rJF9rmlj/si8zVjxI=;
        b=u43mV+hGSTT4+UwN7S5H34Rl13o9HAwNg3reMvcv91FGB3/J/PQKAaZFJ/nQeimszj
         THdwtNIqmHQ0JM/vyg7n58WK7i+eO6w6ei1Eha2OHMyHSK2yNuB1ZQxeg374ux1IgYzI
         vRmwvziesLZIYRTX0nTIzUc5dB5xBETPxmwQ66CdMuXnJ1ISnquymOV5aWGUCxILtguO
         2/V7AYrHZvKXQ/Tlp8jziBb0p/Q0813u8Vwdg4bF/yT5sE4Ho0EVXaNPW2F0YAfac6cf
         GFZJpTwp/3KlgkjkAz141tqNE1prHqV5Nio3IiZ1VKSmruzUiA9PW9wkiLQF5K6yZdh1
         FTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZoHEfmnTDcYESuGHbMmk2jQ8V1rJF9rmlj/si8zVjxI=;
        b=Ar5U3Sv5jjc6h207MEOZGXyGVRlwvvBwZN7MBMYNUYD7Za3+dHPCLu/QVENTBWMj6p
         DJelBZYfZ/bGWOJc731MsJJDYR3L6IZOMcJgWLYTBykr8uKKmZ3F8a4geyJi3hGaKjxo
         ZDXLPbgg9IHVVkbu4q6K3hYWad9VhaT/JeqemUOAplJxH2JessYHOUi4P09/74NNk72q
         +s+i36SdNgHlPNfz3GSV5Y1gCFlFPhfNYQLhEloSrbn6CkfrZSUR4ds6Si8edDyOsG2Y
         xt3rqoi2bqMNyi/kmq2/uJGb8sXR/zwp6VEMAXd56ptrK5vA4h2SuZUnn+OAtMSIE/8a
         qQgg==
X-Gm-Message-State: AGi0PuZhcWLzqZGKJikOu3+aoy3hlPf4xtelwbKYmwlCyl7MsWl1CTPv
        LF4sQVc3okhRvrtlIGhYfryvZP0BBj2IJ7yYDTES
X-Google-Smtp-Source: APiQypI6YkJcQVy9dVwcQVWuwmfdhb49nrj1ejVM0ZNVwEg0+5MtwD5WvMB0rhXXebaqXN/7l4V5Ld230nhh48E9fV8=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr865134edj.196.1588281871459;
 Thu, 30 Apr 2020 14:24:31 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Apr 2020 17:24:20 -0400
Message-ID: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.7 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Two more SELinux patches to fix problems in the v5.7-rcX releases.
Wei Yongjun's patch fixes a return code in an error path, and my patch
fixes a problem where we were not correctly applying access controls
to all of the netlink messages in the netlink_send LSM hook.  Both
patches pass our tests without problem and currently apply cleanly on
top of your master branch.  Please merge for the next -rcX release.

Thanks,
-Paul

--
The following changes since commit af15f14c8cfcee515f4e9078889045ad63efefe3:

 selinux: free str on error in str_read() (2020-04-15 17:23:16 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200430

for you to fetch changes up to fb73974172ffaaf57a7c42f35424d9aece1a5af6:

 selinux: properly handle multiple messages in selinux_netlink_send()
   (2020-04-30 16:18:37 -0400)

----------------------------------------------------------------
selinux/stable-5.7 PR 20200430

----------------------------------------------------------------
Paul Moore (1):
     selinux: properly handle multiple messages in selinux_netlink_send()

Wei Yongjun (1):
     selinux: fix error return code in cond_read_list()

security/selinux/hooks.c          | 70 +++++++++++++++++++++----------
security/selinux/ss/conditional.c |  2 +-
2 files changed, 46 insertions(+), 26 deletions(-)
-- 
paul moore
www.paul-moore.com
