Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C4C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494CF206B6
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGJDQ/S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494CF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLDQDl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:03:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46989 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQDl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 11:03:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so9881951qkf.13
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p2F8fyXuElDI7npuOJI+uxWIKLbW5Hi5tyzCdDaWFoI=;
        b=uGJDQ/S1PF36YgLC3Z5SdR+x1utPsBgp9NOTrbSl0qoeBVao35QYPO1x8HmGY2cB7X
         wbBcfxihs+nJRAfsXkn58NZBEFc2n+t2/ntHU45EImBSN3tt235f3imhmzEJIEQT0bhc
         PGhZiUd6FK9od3J9WDLB/AIn+64w8paBpxzg9203Z9TK+z3V7U4jMlXJIJA1i/zrA1z9
         oFvqYvToKnhPKmADzZ44FCkO1egtxOn/fBhYjk6sa13fKdWsYhgUZlyFuZJjQqxum+K2
         3hqNHrH0NQ7XiuUu6hby5q5Hxh7B9Zefdj1up1uz9eR77AOSJVIOYMGx6UEcm3EBT3/u
         axvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p2F8fyXuElDI7npuOJI+uxWIKLbW5Hi5tyzCdDaWFoI=;
        b=kksapaMdsqVL3eCpT7xHiPx1c3q3T4uKvc2prCb0nQ5D00qS+vJWSEL63gKJ6U0NlN
         7nIyHhMkPBQujxfvDaXl5MCAHdW0jVUabSZoz/pSV5vCskmczuize+pKybhzNKtjcaIt
         UXdNM+wVVBnGR0TcoKlla3JTpQ+3QSNB6eyUFPUw6JJWmhUS3I1i4hkpapg9qDtKmOw0
         gw4UGNfeO3Cn7KKitmvfZsC1eOm8o64EgUkgu6yQQ5J43BhEncYISqLmazrvwzxGQFon
         K2UfMzAGNn2eA8zu8bZvhT9W8vWWiYhdWF3irSPL4WbI+EvaMM1+OSa4U1zopE3+BTO+
         0lJA==
X-Gm-Message-State: AA+aEWYQqe1pukbsLBakkn5rpsXr4Plmts/unVLaQPGIyFFqSlmQNJnw
        d0IWbs1tlwzZ06+fxx5sbeD+HyyO+7ZrBdvBgpb3GVjY
X-Google-Smtp-Source: AFSGD/U2vHn9NM18f1yP43ApC7dxfebsG66n8+fVW30oncYDZfpv39xnV+MAFjXiEeAYzvXYRjPT/BGn53e/AFHQzuc=
X-Received: by 2002:a37:9b82:: with SMTP id d124mr18539472qke.172.1543939420766;
 Tue, 04 Dec 2018 08:03:40 -0800 (PST)
MIME-Version: 1.0
From:   BMK <bmktuwien@gmail.com>
Date:   Tue, 4 Dec 2018 17:03:29 +0100
Message-ID: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
Subject: SELinux logging problem
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I am currently struggling with a strange SELinux problem,
for which I am not able to find an answer by reading the documentation
and researching online.

The problem is, that some AVC denial log entries seem to get lost in
permissive mode,
in other words, they are not logged...
I've already deactivated all dont audit rules and I know for sure that
the denial actually occurs, because I can trace it via strace...
Although I can't see a corresponding entry in the audit.log.
By the way, in enforcing mode I can see suddenly the missing denial entry...
If the permissive mode lacks/drops some denials which we can only see
in enforcing mode,
then this would be truly terrible for the policy writers...
Otherwise I am out of ideas, what other things could cause the loss of
SELinux denials...

I hope you can point me to right direction with this matter and
I thank you in advance for your help.

Best regards,
BMK
