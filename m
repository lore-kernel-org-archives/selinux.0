Return-Path: <SRS0=dLD2=QS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1872BC169C4
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA201214DA
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wSUXbe3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBKVVZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:21:25 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:54666 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbfBKVVZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Feb 2019 16:21:25 -0500
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::66])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id D430511C1A9D;
        Tue, 12 Feb 2019 00:21:21 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9ZovjpNCyD-LKTK4o3R;
        Tue, 12 Feb 2019 00:21:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549920081;
        bh=ntrStKsnT+EwOvQEPA48dKPTT12crE0ESf3wmUiCSDo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=wSUXbe3PrCjvNgPCIp9g6Neo/iTgxJN5lnC2+Sh+0lZkO3adtWAahk8dukJSLNSDG
         UYf7VmFowsjYjJ7VsojogMFnAhToOT9JtXjCWDcHlaUp9+1qTURp+TIVQc39ZpOl2g
         PS85Z/X6QrBBxO39J56KvlhNc2jRmHEBDAQOCDvs=
Authentication-Results: mxback15o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt1-06117f29c1ea.qloud-c.yandex.net with HTTP;
        Tue, 12 Feb 2019 00:21:20 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
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
         <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net> <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 12 Feb 2019 00:21:20 +0300
Message-Id: <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi, Paul!
What I need to do for this?

11.02.2019, 23:37, "Paul Moore" <paul@paul-moore.com>:
> On Thu, Jan 31, 2019 at 8:20 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
>>  31.01.2019, 05:10, "Paul Moore" <paul@paul-moore.com>:
>>  > This isn't how the rest of the stack works, look at
>>  > ip_local_deliver_finish() for one example. Perhaps the behavior you
>>  > are proposing is correct, but please show me where in the various RFC
>>  > specs it is defined so that I can better understand why it should work
>>  > this way.
>>  > --
>>  > paul moore
>>  > www.paul-moore.com
>>
>>  Sorry, I was inattentive. ip_options_compile modifies srr option data, only if
>>  skb is NULL. My last message could be ignored.
>
> Hi Nazarov,
>
> Do you plan on submitting these patches as a proper patchset for
> review and merging?
>
> --
> paul moore
> www.paul-moore.com
