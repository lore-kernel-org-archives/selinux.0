Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE3C4742C
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9318F2137B
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FiefZPDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgKPPWz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKPPWy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 10:22:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA09C0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 07:22:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k4so2400840edl.0
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=FjVIw2PMuDGZWH3b3e4jECPKdXmqyP+14Y90u1ATbGg=;
        b=FiefZPDABr2cF3N9zOaiFRN7zQLKc2T/2eQc60ylOq+KBkceBJnQLDRpc2aKGsbRMa
         mGONlNDeZKuVqsnaXwCL29uJHEAZyeb6wKRfVdN8eLjCThkBGZCtPycxJFqlP4kSKINx
         kEuGNgV+E4c1tKJtABk+ytOPjLe2nt963lLVtwZFJGLS2LFfpC/lN/cxj/Ti7HOWNiZS
         F+p3EjHWqf+jG5/Hd2RznoMZBw5C6izh1UPFF+7c4PEqn3ufZmFTwvyUag0oRTgtuq6D
         3+t5I6sx+YeJcEPSjCZcds/lkh5OOC48VF7zqV4tXdrchiPwl3deLPr83X9WuHhBLRoI
         88mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FjVIw2PMuDGZWH3b3e4jECPKdXmqyP+14Y90u1ATbGg=;
        b=PG2L0gwosfa2TwUMxYSxEQbWyoFbIk6REoVJLvzvR5As4/70d+4oLvqxK4PQD5nyrZ
         S+NNIE2HjHjqQmj28/j+y5nKlvAKA7Uddg2Y5QmcUiiY53uLSzR+cigZU2ad2yhZGwp6
         7me5DCRhdwwnrrOLRilw/Vgskp5fABwySqmM8QNnzwKrRFVlCo+k5rxbXBYfRRpefpwh
         H4SDKTrX+qzVJr/3ImvjN6GIU8DadkG+MOBe9goykx3vpY5EnjjgBScVUZBIZipO6NZH
         +1KPov0CScmXSpEGERtWQR3gGDATcKwhgT1GmDMKNHoiuP1nE/dDy3ZUfmvOxG5IE+h/
         Me4Q==
X-Gm-Message-State: AOAM533gAi5GBizel7Iw1tl39HS82FCs8cBNwC9N3AYuUyk1nDcLl2CK
        251gTyu+IJwqHW6xEupUWnuDG7icxDaSs2FM0trlga5ijkpX
X-Google-Smtp-Source: ABdhPJwcjfvAqpmCg9i7p2w9pVfOMOzmuD2PXUqVvnJQ0pO3Oh6kyoq7FCWsPKeOnW5Yn3uKSM4CknTCFp+IQ8bhuK8=
X-Received: by 2002:a05:6402:17ac:: with SMTP id j12mr15876095edy.31.1605540171343;
 Mon, 16 Nov 2020 07:22:51 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Nov 2020 10:22:40 -0500
Message-ID: <CAHC9VhQiUHp1ywBUFFne4DWyApykwJ18zeO4gRDATvxxsH_ppQ@mail.gmail.com>
Subject: Rebased selinux/working-selinuxns on top of selinux/next
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As a FYI, the SELinux namespace branch has been forward ported and and
all of the existing tests are passing.

-- 
paul moore
www.paul-moore.com
