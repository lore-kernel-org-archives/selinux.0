Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC3C433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345EF60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 22:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJSWRC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhJSWRB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 18:17:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00800C06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 15:14:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w14so17504127edv.11
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HENPjk2/i/iIqGIBkQzglGtaQlBRWZZ5c9dirbLsNI=;
        b=B/lj2hBL+xbHnwwITkT/5usWpOO/SM6xXS4UHK9DgzhRb0Pam1mfZKZf+Y1DAU6Fzx
         Nr8nmXnJOE2J+Z2dz0f5dh3icsrkhI9DfDZk7g2flmR8r2ydMNHMlUkJ/DN3XDIOsotv
         NV/odV2ttapjH+MB+VSctnYpZwWq6NhYWtZSa9qEgMLNtzme+QnlkgfX7Y6wCi+4Kq1c
         A0XnHbmGyPVEUqapmYCLDTuF0ZD5U+CdRE1p3F8FOECm/gg5uuE8at5x3/QQns5maX7Y
         s3Cs+A3EAcOzxWHj1ojOKALOq8aRw69LMGT4II/rlfgkVdgsTCIb/izC7Q5xk/RqTnCg
         On/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HENPjk2/i/iIqGIBkQzglGtaQlBRWZZ5c9dirbLsNI=;
        b=AHoG7PbBOXlny6dWq0isrty3tjTAQHwl1XHNRhCIuqxgCVj9Dj5+mECXevAzIzkT+p
         n/c1O1BijcHloAVjkBOrH4gncfhfTE9v5qTI2kuGK9qslbHylY1cNjCpVeBIeR3NJ8qV
         gt6V36uXfM36Ee2L6dzeYFndTM0l+AgU28z+Wr8YGTiDB6xJ8gg+H32pnErs11ppBLl1
         a2Dz4H95CLogG3FmyelpGWgeEC1LIWwK+FMRH8qgoXyiRSBzMl9fZapOlE5MKrlGd42W
         9NgVkgsGAPYmrXy3ELDB9c7yX3aqKkX6y3/h5WFTal22HHj4TSCC8aDvtFe8L5y3aAqf
         6xlg==
X-Gm-Message-State: AOAM53226jPKHVNclZ0CWiOsh38Tx+rtWk5rYmloKMlrTIC0rheWAT0Z
        b7ZLdG7rR4LhGU0SHqODIjTtvcigLFC4lVQIZ2pbRhU=
X-Google-Smtp-Source: ABdhPJyY8yicW2wbNQhmxkRSzuiWbZ8LHa303I0Ht4/2MIpJn13JYIfHW+4n5BurgK7FeUeYsnsgGsKfdQAbe2VfwkM=
X-Received: by 2002:a17:907:784b:: with SMTP id lb11mr40496004ejc.307.1634681686430;
 Tue, 19 Oct 2021 15:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <163466736648.20044.16531188246866586566.stgit@olly> <CAFqZXNtT0utx5qpcZ9KpvtTsVx5sfiXCQxdHCo1Dy5ue1MQ6gQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtT0utx5qpcZ9KpvtTsVx5sfiXCQxdHCo1Dy5ue1MQ6gQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Oct 2021 18:14:35 -0400
Message-ID: <CAHC9VhSLABGRnuiDG27uMaxK3=J-RHqRd6s-qNDmhxrSzJpoQw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a sock regression in selinux_ip_postroute_compat()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 4:51 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Oct 19, 2021 at 8:16 PM Paul Moore <paul@paul-moore.com> wrote:
> > Unfortunately we can't rely on nf_hook_state->sk being the proper
> > originating socket so revert to using skb_to_full_sk(skb).
> >
> > Fixes: 1d1e1ded1356 ("1d1e1ded13568be81a0e19d228e310a48997bec8")
>
> This doesn't seem right :)

It does seem a little off, doesn't it?  Thanks for catching this, I
fixed it up in my local tree.

In case anyone is interested in my long winded excuse ... I replaced
my old trusty mouse this morning (one of the buttons was starting to
become decidedly un-trusty) and while switching between my Linux
system and my Windows system (employer VPN box) I learned that my new
mouse actually gets reprogrammed on-the-fly by the Windows
driver/config-software such that my middle mouse button was
non-functional when returning the Linux and hence my usual workflow of
"highlight and middle-click" was temporarily replaced with ctrl-c and
crtl-v which was awkward and resulted in some copy-n-paste snafus.  I
wanted to get the patch posted to the list so I did that before
finding a solution to my mouse problems, perhaps that wasn't the best
order :)

-- 
paul moore
www.paul-moore.com
