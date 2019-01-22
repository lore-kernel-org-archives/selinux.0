Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D360AC282C4
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2921019
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uAXOmo6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfAVRfU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:35:20 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:37991 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbfAVRfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 12:35:19 -0500
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 1B5F81E80024;
        Tue, 22 Jan 2019 20:35:14 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RrGzO2MAcx-ZCTu6eDn;
        Tue, 22 Jan 2019 20:35:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548178513;
        bh=PREM8LWqj4TN5CQ0cpEUQTCu2rscZx9at8AYPay545E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=uAXOmo6+ZWjoxmzHIS6lz5bD0uzNiqAgUC2ibHJ6DNX+n1DZwXLKXSKT0QOXivrCw
         hTrCpvPj0cNSE4ZIUF0RBA4ny9HOe2rfUm6v4tQegkLIJlx+58Gc461Idn0EsnpJrP
         yPrpKgiHqq48W/Dj68ewShScyHFTQf3vgLyvUSsY=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-ea1d14049a51.qloud-c.yandex.net with HTTP;
        Tue, 22 Jan 2019 20:35:12 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 22 Jan 2019 20:35:12 +0300
Message-Id: <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

22.01.2019, 19:49, "Paul Moore" <paul@paul-moore.com>:
>
> Granted I'm looking at this rather quickly, so I may be missing
> something, but why the changes to ip_options_compile()? Couldn't you
> simply set opt->data manually (set the ptr) in cipso_v4_error() before
> calling ip_options_compile() and arrive at the same result without
> having to modify ip_options_compile()? I suppose there is the rtable
> value to worry about, but ip_options_echo() should take care of that,
> yes? No?

ip_options_compile calls icmp_send, if someting wrong. So, we'll go back
to trying to fix. ip_options_compile changes needed to avoid this.

