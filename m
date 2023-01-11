Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55261C54EBC
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAKPxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjAKPxG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:53:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0D2652
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j16so22926986edw.11
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcdM3bAGfeml5hGh6aNbycXC6WRcZclz8yrAqF4sGkc=;
        b=QJgRi9MgIUdm7Y4dQysdWF1qILZG5XDyUc7KkKpBximHKU7XTnwLgd3Ly4JCsnSIul
         gGl8w8Y0pGfd1srPruTQKdoSGApTweq/3/P58aDeJ5WMRtWMFrvrSlNifp1PA6m3Njwm
         eyj51biDXcIxxj+Hiu0cCzcAzeksyNs0PnW5cXt2W0chM12hikHlJMqgwQ5tj2uVH7nF
         O3ViPlsQZZvlG7vzxD6cnc9rnXKQ6uRYnjFJQQuCn1OK1S9dcrRsCfFUleEHl2Q5lq7v
         8SbnYvHfCq0C0zJ/1nGiZTsrEiXb/fbwr3ucFt+Xo9Y4RXOHXh039k+W5XWWQajsO98f
         urPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcdM3bAGfeml5hGh6aNbycXC6WRcZclz8yrAqF4sGkc=;
        b=o4VD7C45jDP2lTeZd6s/AKnBZKEfGposh72p4EsS83IzdyA2IcaIEH5qmfpSvlCBsh
         /6fmEbFRekj3uLd8Ex1rY4eWkiKdYkIENVjYkc29kSlF4CDkvwQg5yaLEDVdVz+MEAaa
         z3txN0NUNCjZbxgnZc/D4KKZPtucin5lLrk7jGz9UNFWXzPFlJX6GlwPopbBYYtkUItw
         5hL6nxRFAZqbBsVHQG2RT+t4rHCgeMmW4iPblHqcyBB5qZLIWucdkxYv4broCVQpZRZE
         djgfUkqydPcYJkQph/WrsB0/ftyoUYhdcZ1y+Okfx6U6ZZ/M1t9L8OGTQG8HDHEdlF4u
         AlPA==
X-Gm-Message-State: AFqh2kqswIK3zQ6mAWzamQNW+4PY3NHRos+aGHz3CfF59HjNdQlLLsvK
        F75lVdy+3P6u6jxGIELtbs9ZLIWGYb6FO6i+4PcRb1uT
X-Google-Smtp-Source: AMrXdXtOXdD3jj0GYT+0uA43DHj+2rZ4D0OnYRtAtq3WYnU9B91DwUt5k9AEk5CGUdOeiot9vr0MAwGyoT+3yQ1eaB4=
X-Received: by 2002:aa7:de82:0:b0:485:2bdf:ca28 with SMTP id
 j2-20020aa7de82000000b004852bdfca28mr8069860edv.251.1673452384057; Wed, 11
 Jan 2023 07:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20230103083200.168385-1-lautrbach@redhat.com> <CAP+JOzQfZqXcdwNd6STsEAZ_Up+NZM34-YjJQ6Ws4ken5X8Wrw@mail.gmail.com>
In-Reply-To: <CAP+JOzQfZqXcdwNd6STsEAZ_Up+NZM34-YjJQ6Ws4ken5X8Wrw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:52:53 -0500
Message-ID: <CAP+JOzRoz6eAYce4Wwk_q8GH71wvZ8WihKAnzCsuonH+5rb++g@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: Make generated boolean descriptions translatable
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 4, 2023 at 4:11 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jan 3, 2023 at 3:40 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  python/sepolicy/sepolicy/__init__.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 68907a4f9759..be89dd2f9928 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -1222,7 +1222,7 @@ def boolean_desc(boolean):
> >          return _(booleans_dict[boolean][2])
> >      else:
> >          desc = boolean.split("_")
> > -        return "Allow %s to %s" % (desc[0], " ".join(desc[1:]))
> > +        return _("Allow {subject} to {rest}").format(subject=desc[0], rest=" ".join(desc[1:]))
> >
> >
> >  def get_os_version():
> > --
> > 2.39.0
> >
