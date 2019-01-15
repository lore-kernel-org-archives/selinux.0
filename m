Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9CC43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D755820866
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nfuZn+eS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfAOWZM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:25:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40134 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfAOWZM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 17:25:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so3758555lji.7
        for <selinux@vger.kernel.org>; Tue, 15 Jan 2019 14:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dj6vgY3k8nkm1VUL5a+6pOxoYs5AQnkaYVo/LiOhr8w=;
        b=nfuZn+eS1rd+3fMpqCjf8Emmp/tKwYDpabKPfmdQg4j9a4q+AAyLiSoJ05UrPEADCK
         n05xC7ZHlW6095IepG436aCOsL8WJp05Ybo0i5VczLHv7e24KtTwUy1DzfXnmwxvoT7c
         hEgAGTbpckU5GJFVxHcwzo1XtYlIKpf3MUa0AGkl7eeBX/PAEvBqmTTKJQGcyOprRQRA
         98pnXK+Ui9jbYX8C74wek5Xgxqwzj6ffr1oH8zOBunhF7R+UEUz37kc8dWog4odWWuro
         Qc1zTC05em2Y8JV/79oxXYbxfOLrJUhEZbyNDa/tNR92bxUPP6FIWoSPwL3air9tiU73
         eztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dj6vgY3k8nkm1VUL5a+6pOxoYs5AQnkaYVo/LiOhr8w=;
        b=uJITnyf78eLiIkvuWIV9Tu26mgq3zOfCtcgspTyZT9aUwIHzTQpiDoVOSaTaehcdW2
         fPkjimjzDPogC2npfFUHfMEO/cwERQjufIVzjxLsE9Gf01pvdBU2BSc6KDQHTsZd5QlB
         svW4WIkXmsjsYqhz6PLDKStTQZMDnuI0fMJZLEwMuHSvfcdTA6mFqqtvbCeE2J9TwKdT
         fJ3IbCH3yEbaWzEdYJMoEqVscAjmKFuW3wXA5nrGCpybrEgoTWyc9hvj+bQ/RvF3TqP5
         YjoMCK1ZkhHUqn2uB9CN3PTP6svY61+phO33oM6hvzr9MUcYiWOalKFdYaviveRmIRPH
         na3A==
X-Gm-Message-State: AJcUukfw0YsZ6CF1sGVj6JgG2wj7YLzBDF2nQcIrKV3G5KrCM7PdqhDV
        7ZNN6LXovdQN/LnOTEU1TI5duE+UM1wgfhWSSJqPvG/yww==
X-Google-Smtp-Source: ALg8bN74dTuejTuXW4vRFDT6TCNDIQJzKyHyM8eQG5uwskKP4DpCQ2pkPbRSHo6v8tGl550zEmFCy57lQI/goIX8wu4=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr4201844ljh.42.1547591109976;
 Tue, 15 Jan 2019 14:25:09 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Jan 2019 17:24:58 -0500
Message-ID: <CAHC9VhSOqYnEPUJhcXTg4yAMw3c1+EOt9CE77JoJkdcz1MJNsA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.0 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

One small patch to fix a potential NULL dereference on a failed
SELinux policy load.  Please pull this in for the next v5.0-rc.

Thanks,
-Paul

--
The following changes since commit ee1a84fdfeedfd7362e9a8a8f15fedc3482ade2d:

 selinux: overhaul sidtab to fix bug and improve performance
   (2018-12-05 16:12:32 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190115

for you to fetch changes up to 5b0e7310a2a33c06edc7eb81ffc521af9b2c5610:

 selinux: fix GPF on invalid policy (2019-01-10 20:23:05 -0500)

----------------------------------------------------------------
selinux/stable-5.0 PR 20190115

----------------------------------------------------------------
Stephen Smalley (1):
     selinux: fix GPF on invalid policy

security/selinux/ss/policydb.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
