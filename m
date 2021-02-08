Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF70C433E6
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AE164E9C
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 19:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhBHTqg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbhBHTq1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 14:46:27 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68BC061786
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 11:45:42 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id l23so3658384otn.10
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 11:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cctYs0IZ8Rmofj1pAl8DlhmZcJfAMnhU9Nuth+jutfk=;
        b=miUb1lMyXVgZOsxAWg0Q28VxE9IxO5ww8hFWScKF8rVmhj0wPrXfdmgKJLLKcoHCBO
         fpg+3iiMw5JoHzwlKS0LbD8L5E1IxlV4zxHDhKA6YM0XXM8IV3g61ZBdNfq3UlJw2lwf
         MAnl2CExLWQWqe+hHeDhICguN2UHfcfyxd42pbOYZHwtsivhBo0x684AnON9WrEridnV
         +V/n8yMUp5lyzG41PgCxfSJcD1ktJqpSDlaHDnWNlj7VcRnmPAYKUwabgfa8OzZjdSOB
         iDMbMT+XepJsl7kXVOyF5pNS7ydZA2AvUcbsS7QAuzfbnF4F3rrFLpXqvd8iEkOPziyt
         ejyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cctYs0IZ8Rmofj1pAl8DlhmZcJfAMnhU9Nuth+jutfk=;
        b=E/TVGE87D1OrEBhrlMJ2JTMtD0ygf6ktyt6qGw9NaGgPjfln6irBf/R2CfRGO778to
         HqBO1mSRgVwaAPe6o5VE49IWRoCFLhcfH4yhTIeK6lVE7QwYb7qrQgrybKFVteJeCEnp
         K0zIT5kWPDJnv6IOg5NiE9xcImYij6u9Pac+7VZFEZPLORiNo5rKCk4x0iPYrC+5QweK
         ckKw8QINIUt8li2Shovd8oLMjLMlecqygZboludm9zVO0xW+LGe6XbDF2TSbF9lb0S9N
         Q5eTJ0vTesM+USVonrApaOvpo0Mku7xK3j+taMHOeAtwRBzaG7xk3a36fK7vUrPpRCtA
         ey2w==
X-Gm-Message-State: AOAM531Sg/VqIpz4bsGgEi9apQ2LSzA7n6EIpO7Z6TFBIE3twtcypCnH
        88SsvtHDzf1zs4W9ex+G15PnSCGZ5MrYZIxmpNDbTJZcZTI=
X-Google-Smtp-Source: ABdhPJz80eerJ5Z6wzm48U9zhRjohj6IlzJ4TAC8Qgkk0LHIpWSEemXrdjnVQjXz8AbUkn7i51REMpS3hZG8Q0bGOtg=
X-Received: by 2002:a9d:32e2:: with SMTP id u89mr13363729otb.196.1612813542325;
 Mon, 08 Feb 2021 11:45:42 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
 <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com> <CAP+JOzQBiEHBS7TFAGpyJJ0+G3u2aGKpkDRTxH_PgU7pQrogVA@mail.gmail.com>
 <79fcad29-da9c-7084-c081-b5d4b529f04f@gmail.com>
In-Reply-To: <79fcad29-da9c-7084-c081-b5d4b529f04f@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Feb 2021 14:45:31 -0500
Message-ID: <CAP+JOzRfjADCvS==-5bA4nvpaFGeC0JqUPvfNogw+Hkjn9Cz6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] secilc/docs: add syntax highlighting for secil
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 8, 2021 at 2:35 PM bauen1 <j2468h@googlemail.com> wrote:
>
> On 2/8/21 6:43 PM, James Carter wrote:
> > On Sat, Feb 6, 2021 at 4:05 PM bauen1 <j2468h@googlemail.com> wrote:
> >>
> >> +    <list name="function">
> >> +        <item>blockinherit</item>
> >> +        <item>call</item>
> >> +        <item>in</item>
> >> +        <item>macro</item>
> >> +    </list>
> >> +
> >
> > I am not sure it adds a lot to have these as separate colors.
>
> I would at least like to have `macro`, `call` and `blockinherit` as separate colors, as these behave very differently from "normal" keywords / statements and more like function calls from a programming language.
> They are usually also quite important when looking over policy so I think it's warranted.
>
> I'm less sure about the arrangement of `in`, but due to its special interaction I've also included it.
>

I can live with it.

> > Also, when call is used as a permission, it is highlighted. It would
> > be nice if that could be fixed.
>
> I don't think this could be fixed easily, the same is also true if e.g. `allow` (a keyword) is used as permission, e.g.
>
>  (allow t1 (file (call)))
>  (allow t1 (file (allow)))
>
> This is harder to fix as currently the syntax has no concept of what a "permission" is and I don't want to make things too complicated.
>

It's pretty minor, so don't worry about fixing it.

Thanks,
Jim


> --
> bauen1
> https://dn42.bauen1.xyz/
