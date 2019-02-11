Return-Path: <SRS0=dLD2=QS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822EC169C4
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EC820873
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 23:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FvipdYGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBKXnd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:43:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38618 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfBKXnd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Feb 2019 18:43:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id n15so544340lfe.5
        for <selinux@vger.kernel.org>; Mon, 11 Feb 2019 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5VvjnMzo3j6kCKzN41CHzdQ/j0mYA/UHHzR/LTo6mw=;
        b=FvipdYGIO5KMZCQjj1CIum2rlV5MwnDosiNM2Xy5pcMl05zRJNLobnOef2zB6JqGOB
         ozxhWOJkL4hVXxDkIBpzcnI4F7+z0aLQna1WZsbTgP2Vzx/yjf1mPc0i3mbUMDOrrGXG
         lOkdBduyx8TKqHtI9RY8y+5ks3LHyPXvbNrQzoveHl0xVnTpztzkKu2Bgze80dnA8Hxw
         PEIxoJAADlTbdPsEYAK5xhDI5mhT7tCE41UJSFU66zb4JhP9RqZIkn1xuz56hGcb6xy8
         tOhMJhM2GO9LnfsDVXLUxmZZXG2TyccRiDVIQDP1K/lUL/voNYCTB9xWAjWhQyCcu/u5
         QYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5VvjnMzo3j6kCKzN41CHzdQ/j0mYA/UHHzR/LTo6mw=;
        b=C073qJ1ntpV7Wd8IWTu08VZFIxuylj8FjFDFWJ5O9Cv7IxmKT+294J+a6h815MQ7FW
         Ym9C/EoZPFLh7rLwZLK9JZxQNE2Zz2UIcIz0pdM11zY1MkRY50wiW2lWTfB90UnM1pk1
         keoXNIESzeJYN26g7piLEf9N3XKBPgRJCdvfCZHzLRS5PBNnZdRh+8uu2BvAJHhEJIqO
         NBQvjdzaRxGtnqLUhkYw3gl645H5rSzxWvvz3WbaU5Br37IBcO6y78Xu0FZ/sqSkuczN
         CCniC5BNJISBkeNj1YsDQp8eof+9OhijA1xgZnGafYFPJayD8RG0QVqBKtefmYa5aWpq
         slhw==
X-Gm-Message-State: AHQUAuYnTCXxlVa13nl8903/Afg5WgijD7S2oUyixxX+9t2tUHXNHBy1
        N5HoBr+uNcSYVtIf/Ua5trhA2P4MmBndoxcFEmRE
X-Google-Smtp-Source: AHgI3IZt4wlD+jF3+7d5yLFyaZn9c35XAyiwqmTypBo12uoHa134nyUEHGkXiDl97DwG+O1CoK+Jhwg/wGZYGITO7eE=
X-Received: by 2002:a19:c4c9:: with SMTP id u192mr437653lff.79.1549928611336;
 Mon, 11 Feb 2019 15:43:31 -0800 (PST)
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
 <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net> <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
 <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
In-Reply-To: <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Feb 2019 18:43:20 -0500
Message-ID: <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
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

On Mon, Feb 11, 2019 at 4:21 PM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> Hi, Paul!
> What I need to do for this?

If you haven't already done so, go read
Documentation/process/submitting-patches.rst, that should guide you
through the process.  I would also suggest looking at both the git log
and the mailing list archives to see what others have done in terms of
commit descriptions, etc.

After that, if you have any questions let me know and I can help you out.

Thanks.

> 11.02.2019, 23:37, "Paul Moore" <paul@paul-moore.com>:
> > On Thu, Jan 31, 2019 at 8:20 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> >>  31.01.2019, 05:10, "Paul Moore" <paul@paul-moore.com>:
> >>  > This isn't how the rest of the stack works, look at
> >>  > ip_local_deliver_finish() for one example. Perhaps the behavior you
> >>  > are proposing is correct, but please show me where in the various RFC
> >>  > specs it is defined so that I can better understand why it should work
> >>  > this way.
> >>  > --
> >>  > paul moore
> >>  > www.paul-moore.com
> >>
> >>  Sorry, I was inattentive. ip_options_compile modifies srr option data, only if
> >>  skb is NULL. My last message could be ignored.
> >
> > Hi Nazarov,
> >
> > Do you plan on submitting these patches as a proper patchset for
> > review and merging?

-- 
paul moore
www.paul-moore.com
