Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA63C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9153220880
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 21:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKY5eZof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfBTVSD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:18:03 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:39115 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVSD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 16:18:03 -0500
Received: by mail-it1-f171.google.com with SMTP id l15so19226495iti.4
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R68gVSjI0NhmD4RR+ES9SyD7mhfuhv3iIPPgOSGUIog=;
        b=aKY5eZofM/LZGp4U6C3sNaI7NqwQDbQKmfWX1DCd80cbUZc3Bxnl599gB6ogK/z6Po
         YSl0fDkSyxSIhkgyIfETaehpdwkl11FavcsA2UwSD78Pkmpb3LqXEw2LZByhKxsNjL2a
         rt9FzLnNV1tYHc5NNJzhh1KM8WiA0BO+PyMo9zmOhj74LN13Tiue4DqJN3T4CwqX92e/
         oPrkDXFkKdiGfDKUjQ7yUHxlx9ZyiKuDe26/yJ04RUTcumWzw/EeMreMixwf7vcwoY+Z
         jRoqKXbfcyfJOeEbxPDPlEfCOTYbmJC2Ahr1CShqwZ0jIIzcqKKEU7mLRTNbNYm05viM
         dJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R68gVSjI0NhmD4RR+ES9SyD7mhfuhv3iIPPgOSGUIog=;
        b=Utp3KXftUA1S6RQTBCUtgT4aUl7tUuCGNSZbEgOxIjDdVYqUbK76DHfTI6/M1IVRQE
         /L0U9G0bG2Sgr6qR1MuCDV+q+LqeQXCCvpQtoHXt+xHv27TrYu+rjx3b29HJz+ooMV+5
         WUoaTfJKqiStiA470INBQhRdxaqOO7VtrB418zid/g2a5BfEfGIcEHGrX6/V4mzRyu6t
         AOMFm21qPguvbrDmGdF0GdCCIa6/2UcE4VAPt5p95iJQCiI26bShxCRa3OQDpYPvYqkk
         eJfAjLx9IXDDQ3UkYJ2rzKx16uPewLcdMqa3G8ihZ3X5ftNgAw4nj5UgunKRXb1KaA/l
         FQ2w==
X-Gm-Message-State: AHQUAuadwUd1r+6WplfPSa5FnLhFPruWmZE4MXQpbp0K9//9Mk/DwhxL
        3vmVPYftIYXO/wokLQgDfnCD83J/RvmvrXGKt5k=
X-Google-Smtp-Source: AHgI3IbJUHLqDvgKqD1dgJi8DWuNaDcz2uiCFyXhGCvE6BcGPZNV+yOZ6XsYqpnXNJbJNQ9O72Jy1L4QcjpL+Ye6P1I=
X-Received: by 2002:a05:660c:30e:: with SMTP id u14mr6977000itj.13.1550697482183;
 Wed, 20 Feb 2019 13:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20190220160446.23150-1-plautrba@redhat.com>
In-Reply-To: <20190220160446.23150-1-plautrba@redhat.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 20 Feb 2019 16:17:49 -0500
Message-ID: <CAB9W1A3GWkg+hKZVeyH31Trfiz3eiaNAXf3FEH1z=roDoBiqqw@mail.gmail.com>
Subject: Re: [RFC] Switch to Python 3 by default
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 11:05 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> Default instalation seems to be inconsistent a little when PYTHON
> variable is not used during build. Python 2 versions of selinux and
> semanage modules are built and installed, but /usr/sbin/semanage and
> other tools are already changed to use /usr/bin/python3.
>
> I'd like to propose to change to Python 3 by default and leave it on a
> maintainer to use PYTHON=/usr/bin/python2 when they doesn't have Python
> 3 available. They would also need to change shebangs of some tools, but
> this is the same situation as used to be when default was Python 2 and
> maintainers needed to change shebangs to /usr/bin/python3.
>
> Do you have any objections?

Sounds good to me.
