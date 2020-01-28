Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56AC2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 17:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98424681
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H2uoDT+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgA1R3d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:29:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42367 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgA1R3c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 12:29:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id e10so15512297edv.9
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Itubj3wCd88V9nT3tAeTBYkE6xJQ1VQ9eREikhnfNPg=;
        b=H2uoDT+Nsm1ldbsEWOxGoUe35NmZeaFL4LxspAArXM0Xj3hpzBum4DJdPdXrGTJ1C6
         Ib651SmRSgy+ksTu8zaIMU2/EbNVxBALV829asZ12twYZMS2ZASk5eE+F7vyfdPs5tzm
         hPMZ36r/i7VtmPFwutMON7ZgAlct9m2v78KPqzYKmHYNHISnPAb3ak7ebXpWIsF99abG
         G8OlXKGkbRni6O8+b2U6BEHI8gM1aJ1DXE9ZdSxJ4MQ5wsJZegtBACqrl0lWN2QLXMMo
         ylqTZ6SEJ1IyEjoZ90E7IZfh+WzFDMqYGecqft0VQ4a6hvB/KZrd72qusvs85SOfCAu+
         WDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Itubj3wCd88V9nT3tAeTBYkE6xJQ1VQ9eREikhnfNPg=;
        b=uSsaij0EWc271YkzgCzyCmusfbscO0vFuMRgMLXUZFFZgt1f46NaugbjZ4XsxpyeSG
         UMFaFJTnmW70yAQw+u9nkwtFv/cFpX5uKljxz9N680Cfqb3Giiel3Lcs/7X1H3JWw4U4
         86wVs1pwADEJ/EK8lnnHMEGtV/5m0/mGKBda21n8d6UiAOK9a0iKhHF6pqs8CS9iKfSu
         +CpkBpyNvfTes2b33Al7j/LechP3UgDGYs8PAjE8ma2kVDl3iV0RJ+afSokTibJ6dou7
         fdH+2stz7AOPNE4eSUzYtLLSKKX5+nALkn58x6egFSxq0ig0mejHovJSnsWs5ljjtnPs
         AcLw==
X-Gm-Message-State: APjAAAWJdMtKcVNbrEfS8NAZlRwUvEKFEO7zobae2g1jxjQH8uOe+tgh
        qkIutTdDEpqdPBrAOQN/FcsmxnpEZfoM8s8ZgJcP
X-Google-Smtp-Source: APXvYqx104uBSDEa7X9PfMB9Iz+fOAlx7B3tbnc3c+sO//QfUCyZIxfw2j7nC0XklgQFi+l6TYCx07io1GQgQEavEpY=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr4313343edr.164.1580232570877;
 Tue, 28 Jan 2020 09:29:30 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
 <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov> <CAFqZXNuxFTKXVZDpPGCTHifn_AeCdVmP+PZrMDKDOYiLOWtsUA@mail.gmail.com>
 <CAHC9VhR9a1xEB3gXUkb4KRVkwXUAo-701ZumN2OTOmJ7r5ez8g@mail.gmail.com> <CAFqZXNv77JHa-6BPzEomZaj2uJqGrBRXrK68cTL0N0--Kz_PkA@mail.gmail.com>
In-Reply-To: <CAFqZXNv77JHa-6BPzEomZaj2uJqGrBRXrK68cTL0N0--Kz_PkA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jan 2020 12:29:19 -0500
Message-ID: <CAHC9VhTHUjdYujta-bOd=AG+XLic6rAZbp2sEpC86vVnpkmBVA@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 28, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> ... the current rawhide 5.5.0-1 kernel seems to have some bug
> that prevents it from booting on anything with more than one core.
> I'll see if I can work around it somehow...

I'm not sure how you are building your kernels, but gcc v10 is causing
a lot of problems, I would suggest compiling with an earlier gcc for
the near future until things get sorted (I'm doing the kernel-secnext
builds on stable Fedora, not Rawhide, for now).

-- 
paul moore
www.paul-moore.com
