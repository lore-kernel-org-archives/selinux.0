Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A20C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C6D6023D
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJLR7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJLR7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 13:59:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A1C061570
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:57:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d9so2678366edh.5
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOPDsJEdhnGAFejVtwIVOGmwVw7tEnlKzUvhdw8wMoA=;
        b=txyKdDYSHwIWzxHx/zq5q1X6uK6F84dICPPzQSltOlYO2/fKjttulOt8bE8qmUKO86
         /11wtqd81IwrzxApY0WOlCENQ01YqcTnhYvdZL+PbJRpooZ8Td/B8jwKcg2VKVa+pjm6
         8QKGn3uaFP8oudH0dTRqKhKa0GNa9cbbcW+n4hLG8htr+YGUyaLHoXNSE+aaNDbncTNc
         OEYQwT/+0K0c30h9DcQxRNKE2MJ/Tb2Ctwc4G2AK7BnHrzgswPk8XieY/NvKfhCvVt6X
         DV/GRQ2C1lgu1oPtUwKIYg4DpzEHuHJeg94GWJXQs8t8F0N3ffaLmCA5g7h0KYYH7Kx6
         8xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOPDsJEdhnGAFejVtwIVOGmwVw7tEnlKzUvhdw8wMoA=;
        b=Zc2l+WkSqstqBuO42/BDpJlz5lwpvKnwM0WlmTnyIUZwyHGvbz7BLLJ8WjQ840Dw8s
         cG6heHFm3Oa8p5UNc4icF6Y8mosmhfRzNAY0dpGSmm+O2klTH2apXiZrrlqZ9H74jtEx
         cKGQ81Rm+jIVlHqadoZRqELYhvTo7/5AlkxmDTz/Gu0L+eCt0mEOibW8kk8qh6j7yujC
         fXf8HgcxHUxIG1t1HmFRuOGngLTNX7gz0wDbbJAaqznxDy2kH1kzvtlFJlRZkQjJmg1t
         cDTCMylwdM2bz1CqbZyGs1gre5KQpfsw5+pQyshjIHyhFVsK0tGDSMxeIuq3WwhJrFxH
         dppA==
X-Gm-Message-State: AOAM532SXfknU8ZA4cMjPGRNs8nS/9zKbDoGME9t9QJGnAfSsbfkVlbK
        IyHkMe1DCmNMWxMVXwlgG4O509sxYDfeD4lLKuPJkzUmtg==
X-Google-Smtp-Source: ABdhPJy8HSTCanFag+ePKD/scOuHV7VeUf6d6ucsJJ9UbUTmgN3ZWmllvx3zkgDa1othEieN0OFHbFVloLBMYpHwTv4=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr35414899ejc.69.1634061437873;
 Tue, 12 Oct 2021 10:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <163399358463.185926.1386262780774440656.stgit@olly>
 <CAHC9VhQA+RMAGmzBpr6UEAi6EAp5bZ7jWKFSCWpJWZvJuW8Q5g@mail.gmail.com> <CAEjxPJ4gmU_ppLPZ5yNfN-pQ4u979dTo+wjnUV4iEA5PaOXWVw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4gmU_ppLPZ5yNfN-pQ4u979dTo+wjnUV4iEA5PaOXWVw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 13:57:07 -0400
Message-ID: <CAHC9VhS06QJ5yr3LrCTBh_-uxPDTsrvYUaJ1d3GRTkkiCNxoJw@mail.gmail.com>
Subject: Re: [PATCH] selinux: make better use of the nf_hook_state passed to
 the NF hooks
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 1:52 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 12, 2021 at 11:02 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > This patch builds on a previous SELinux/netfilter patch by Florian
> > > Westphal and makes better use of the nf_hook_state variable passed
> > > into the SELinux/netfilter hooks as well as a number of other small
> > > cleanups in the related code.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/hooks.c |   53 +++++++++++++++++++++-------------------------
> > >  1 file changed, 24 insertions(+), 29 deletions(-)
> >
> > FYI, I just merged this into selinux/next.
>
> Don't know if it was this one or the previous one yet but
> selinux-testsuite locks up my box hard during selinux-testsuite on
> inet_socket test.
> Completely unresponsive, no output.

That's fun.  I could have sworn this ran through my automated test,
but let me double check ...

-- 
paul moore
www.paul-moore.com
