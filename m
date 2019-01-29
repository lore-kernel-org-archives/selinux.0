Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54EC169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 07:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5612147A
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Mj7zZe+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfA2HXf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:23:35 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:34708 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfA2HXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jan 2019 02:23:34 -0500
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::66])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 66B3C1E803CE;
        Tue, 29 Jan 2019 10:23:31 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id MvDyFWlBz6-NTkOq2SE;
        Tue, 29 Jan 2019 10:23:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548746610;
        bh=WtQ7gdzi44CTthlHJ9m5L0x76EU4jNUXdRdghWsgNb8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=Mj7zZe+lR4uaDgordXu7FXtUMkXFdDic7h2wMz7Mtn1N6DqBIXYBPRt+EYCeMrpxW
         GpO+7z5cR2neXwfAXVx4iLnt9+3ngaAvQ859Kdhpta9NGwBb6NFAEZzFYAE2F9DEqP
         VY7faodkaVv7EfIsRKu06lkGXTj8EOc7yljNKwXA=
Authentication-Results: mxback15o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-929fb874f3f2.qloud-c.yandex.net with HTTP;
        Tue, 29 Jan 2019 10:23:29 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
         <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
         <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
        <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 29 Jan 2019 10:23:29 +0300
Message-Id: <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

29.01.2019, 01:18, "Paul Moore" <paul@paul-moore.com>:
> If we don't pass a skb into ip_options_compile(), meaning both "skb"
> and "rt" will be NULL, then I don't believe the option data will
> change. Am I missing something?
>
> --
> paul moore
> www.paul-moore.com

I mean, in cipso_v4_error we copy option data from skb before ip_options_compile call:
+       memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
But skb IP header data could be already changed by first call of ip_options_compile
when packet received.
