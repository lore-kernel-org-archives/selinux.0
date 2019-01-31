Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E3C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F67218D3
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 13:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nkhZBbo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbfAaNUp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:20:45 -0500
Received: from forward501j.mail.yandex.net ([5.45.198.251]:42383 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbfAaNUo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 08:20:44 -0500
Received: from mxback21g.mail.yandex.net (mxback21g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:321])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id E72A133802DB;
        Thu, 31 Jan 2019 16:20:41 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback21g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0rvd3jPRdh-KeJCFVc3;
        Thu, 31 Jan 2019 16:20:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1548940841;
        bh=oB/E2AJU2WzP09fte2H+pLpD91cHyn8nHoMf2IS81yI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=nkhZBbo5LrkWeb9JqSou9p0ipcsIwnXhh7bzF5U+m5pThSUo0jgW0lRtvum689sRu
         4GDqVVH49eYmRS96lte/q+sHrzJCSfnm6Sao37hz/xJl/D1/xMW9c6nNjxUYM4BWkz
         x3/k04ppJN2D72IyFgOEHDMy2FdFKm9xyx7crmM4=
Authentication-Results: mxback21g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-8d7a47df0521.qloud-c.yandex.net with HTTP;
        Thu, 31 Jan 2019 16:20:40 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQcrnXmjcVw_ppwM-fGcwhJq9SafTnZKjgpQpxK0ie+Jw@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
         <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
         <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
         <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
         <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
         <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
        <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
         <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net> <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
         <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net> <CAHC9VhQcrnXmjcVw_ppwM-fGcwhJq9SafTnZKjgpQpxK0ie+Jw@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 31 Jan 2019 16:20:40 +0300
Message-Id: <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

31.01.2019, 05:10, "Paul Moore" <paul@paul-moore.com>:
> This isn't how the rest of the stack works, look at
> ip_local_deliver_finish() for one example. Perhaps the behavior you
> are proposing is correct, but please show me where in the various RFC
> specs it is defined so that I can better understand why it should work
> this way.
> --
> paul moore
> www.paul-moore.com

Sorry, I was inattentive. ip_options_compile modifies srr option data, only if
skb is NULL. My last message could be ignored.
