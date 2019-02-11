Return-Path: <SRS0=dLD2=QS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF396C169C4
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465B218FD
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YzBk93Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBKUhj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:37:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34575 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfBKUhj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Feb 2019 15:37:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id v14-v6so247248ljv.1
        for <selinux@vger.kernel.org>; Mon, 11 Feb 2019 12:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPxxgoiGeUW3bM2e1gBLd3NxQfBICR0pS5nUHnn3z18=;
        b=YzBk93VhTK630zM3v6ArPi6q1AHIfLAwdGZuUFmwqOa6bfEvsdoeX6HTJslaUQf6OM
         TPqoAzzlHrf9Gk3+zP9zdpsQo/6AW83843V8b/QvOiK4IsiRK+gOTW1G9XKzYIW6RPnw
         HY7rJTSnCKIiUUwrf3fSxWXdcPQ3kOt/aQ3DqbsnPFl7VeXSSUzVSmU1oBEx9c+rkD8l
         /Sz+jZoQq6xXYmpXCReuXgXR1oFcBoUG9kJZeoOXNpT5t2KHeqxEhstWBJ0/tHVN0kN2
         No3YJNgdwkwkZBMazHksILhqdEQalt2JwqtgylcUsxMmBp5dbfuewSkoFskROXwMQIGf
         YZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPxxgoiGeUW3bM2e1gBLd3NxQfBICR0pS5nUHnn3z18=;
        b=hGFviARfniBSG4IckPiQGKc5RSWa0xmeJQ/bLWAukPBq68uUs0b6oMX1saIPKcFUa1
         PAnjp/ytirrI1qxInFjZskZ/nnjximukLpvjlOJ5xa+KMT3lM2ICbv0STo+EPtUVe3/h
         xH3tRdb/y9V/Cv3+jW0I2iYmFmXzFKoBZCUnnAtiyT4p2TU1NwYC3s7n51/4BO/EVK6A
         NQuJqa9LOGP6dfW+/DzfOuEFmGVrZaaZYpHg0iIyQz1a8JB760EqHXYLdqNejCdjtVp3
         Fxx06AVFizEFbVasmyZ0I2QSjhPmNn6zp3gHVr5HSWS5ivdq2+3RvBpalSQLvcjHXIQL
         owlQ==
X-Gm-Message-State: AHQUAuYNXkqZ0BVqmnKlyRQd8q7+NJe5YWUcuUqHRKDfvOY/YzpjuMPN
        3XpPdKTpkubu4Q+7rVCt/vT6PuH17vix4SSbWIJ6
X-Google-Smtp-Source: AHgI3IbU7IOo1HLH7xNwHrAieTRsjEyuN6//LAkjtYEnROB3FiaB2smUn8/0sDWYl6laKyIJPjpq7U2CtP+/i+nfCv8=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr72942ljc.38.1549917456768;
 Mon, 11 Feb 2019 12:37:36 -0800 (PST)
MIME-Version: 1.0
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
 <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net>
In-Reply-To: <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Feb 2019 15:37:25 -0500
Message-ID: <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 8:20 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 31.01.2019, 05:10, "Paul Moore" <paul@paul-moore.com>:
> > This isn't how the rest of the stack works, look at
> > ip_local_deliver_finish() for one example. Perhaps the behavior you
> > are proposing is correct, but please show me where in the various RFC
> > specs it is defined so that I can better understand why it should work
> > this way.
> > --
> > paul moore
> > www.paul-moore.com
>
> Sorry, I was inattentive. ip_options_compile modifies srr option data, only if
> skb is NULL. My last message could be ignored.

Hi Nazarov,

Do you plan on submitting these patches as a proper patchset for
review and merging?

-- 
paul moore
www.paul-moore.com
