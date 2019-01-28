Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692CC282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C559D20880
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 13:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aRk6N3zC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfA1NRx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:17:53 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:53143 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfA1NRw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 08:17:52 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 08:17:50 EST
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 898AB11C15A3;
        Mon, 28 Jan 2019 16:10:55 +0300 (MSK)
Received: from unknown (unknown [::1])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id IbtJOM6kfU-AsYCDF1Z;
        Mon, 28 Jan 2019 16:10:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548681054;
        bh=nAwxL3SDlj1+u9HZn84u2Qjn5WFkptW9nWo7kJ9zNRk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=aRk6N3zC6P1cU/07KQuUJz92UJxfM/WL+cVY5n82ZGRAxikZVxeuOchzdeTDRGsLE
         VqJfbWg1ZraGEZS44Vs1GHuN4WsG4bFCzrFipPNOpb/02Nd4j5yTDiamXnxH9ETzxO
         edzRQE18WmHg1wTRLcr1dq6oRJpw0KiXQpV/9jf8=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-0acfc31d2b43.qloud-c.yandex.net with HTTP;
        Mon, 28 Jan 2019 16:10:54 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
         <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
         <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 28 Jan 2019 16:10:54 +0300
Message-Id: <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

25.01.2019, 19:46, "Paul Moore" <paul@paul-moore.com>:
> Hmm, I think the above calculation should take into account the actual
> length of the IP options, and not just the max size (calculate it
> based on iphdr->ihl).
>
> Beyond that fix, I think it's time to put together a proper patchset
> and post it to the lists for formal review/merging.
>
> Thanks for your work on this.
>
> --
> paul moore
> www.paul-moore.com

Where we can take actual IP options length? Sorry, I'm not so familiar with linux network stack.
And also, ip_options_compile could change IP options data (SSRR, LSRR, RR, TIMESTAMP options),
so, we can't use ip_options_compile again for these options. Am I right?
