Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697BC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1524206E0
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAhq57eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfLPSJ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:09:58 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42112 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfLPSJ6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 13:09:58 -0500
Received: by mail-ed1-f54.google.com with SMTP id e10so5768167edv.9
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zX6tP/nFfwQ6qY0rNkbp/PKOSOUIIWtoIcyTbSPR1vk=;
        b=WAhq57eqT/8yUg4DpCWKozpM9HZ1eRl/B7a2j9+j7AthEBKwr6j1HZZmJ9yZ6ybjUX
         h3DnysVSLY9BwKLyzAY8Y9OQZrN7hTY6+p9mpKlKF9wA5ApKT69C7dik1dkVYw5onZmq
         BFcfnJUIrGzHYoysLDahiYJ0bzTVUp4PUN/tJsy5L3C4BzA7xS7yu8h130J+0t2IMQnP
         6411Mw7lFe5D+LJK1UirO2bV6la0P4TOV9dsblBUoa7x8hb2rtD4y6Reov7k6wAzmIaz
         FwGKdySBlQ4llJF3to216ppmxNZR449+ehEmzcqGuTP90jpl6fyXLsMFx0jshhwAotCB
         o8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zX6tP/nFfwQ6qY0rNkbp/PKOSOUIIWtoIcyTbSPR1vk=;
        b=iUqaTtCMyWgqoRIqH5pOCIQGWQEz/oW4EUzAGOTF/eTXLawsjNZBJGzco1jOxdOvdZ
         WiZh3He9HH1SWTw87ZPpQ8oN0r/x9hRGGFS740SlH0JC3mMvpcYa5fDaETt8LUCxtE6q
         2MYxvLmlPVNoamZXDjE7m56veK/oW/FMtVF9RJr4V7TlTmqzvLICUeAiLQeBh3e6dwXi
         4OIn6O7VOtPvU67pQ8Z84NF7hhY5X2b08ZJyGjkiltt4t93yMx1dfHwsYaWUwagLAQ3S
         963mcJyIoRdAdhaP7X1IP/TGdzy2d0h3J3vHK9pyHS6SFEVLjbcp64LXhDd6R0r4x7J4
         yj7Q==
X-Gm-Message-State: APjAAAV5R8MtbE15v52RXmEqeUdfVd6b3nrjIzHooDXH/BMlMhBI6wBH
        6X1CbUZZ1mC2LLaWHpRn6FVxtdSt
X-Google-Smtp-Source: APXvYqyUzp6jYXEKJ90QIO6bwi+cXjR7TDhjDqUfnFNL3vNlpFs96ogq/zvm51MMHu+lRaGK2o8iTA==
X-Received: by 2002:a17:906:6942:: with SMTP id c2mr310614ejs.12.1576519795875;
        Mon, 16 Dec 2019 10:09:55 -0800 (PST)
Received: from [192.168.1.178] (mue-88-130-57-231.dsl.tropolys.de. [88.130.57.231])
        by smtp.gmail.com with ESMTPSA id o9sm643891eds.75.2019.12.16.10.09.55
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:09:55 -0800 (PST)
To:     selinux@vger.kernel.org
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: mcstrans doesn't translate for s0 level (thus, doesn't work in mcs
 policy)
Message-ID: <43d68a8f-94ce-4201-2d9a-0ce514971aac@gmail.com>
Date:   Mon, 16 Dec 2019 19:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I was trying to use mcstrans with mcs policy on debian and found out
that it doesn't translate anything after s0 level. It works with s1,
s2...sN (N>0) levels with mls policy.

Here is the issue: https://github.com/SELinuxProject/selinux/issues/191

It seems that sensitivity level might affect translation process. When I
change line 1316
(https://github.com/SELinuxProject/selinux/blob/master/mcstrans/src/mcstrans.c#L1316)
in mcstrans from:
int doInverse = l->sens > 0;
to
int doInverse = l->sens >= 0;
mcstrans starts to translate contexts with s0 level.

Why is there this constraint? Would it break something if we relaxed it?
Maybe we should add some parameter to distinguish between mls and mcs,
otherwise, we have a situation when mcstrans doesn't work with mcs policies.

-- 
Regards, Denis Obrezkov
