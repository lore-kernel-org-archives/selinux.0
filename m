Return-Path: <SRS0=OFWW=BF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC1C433DF
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 18:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103AD206D7
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGZSwU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:52:20 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35182 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZSwU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Jul 2020 14:52:20 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 202F3564C48
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 20:52:17 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id q4so806178oia.1
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 11:52:17 -0700 (PDT)
X-Gm-Message-State: AOAM533nFzg+9fci4DQ+hPI7ieNqq1uwkqlcU/iQQpFwhDqB6yGQ7L/K
        NgYNuvbXxs5jJaen9WIN8qdTvazJHXeNpgac91k=
X-Google-Smtp-Source: ABdhPJw47fYFkE8ABvNd2HK2h3fxSSXQnyPn2WtWsOCsOaQ38Dn7NkZIpvsR5J0cQW6ePHXBGaOuBYNv6CHwBJ5/UGA=
X-Received: by 2002:aca:c70f:: with SMTP id x15mr16299628oif.40.1595789536074;
 Sun, 26 Jul 2020 11:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com>
 <CAJfZ7=m7udOgTOcoR3wEEtxnAoaLmBaHSeVzBYxsQhmzmw2qGQ@mail.gmail.com> <35b8c022-3c40-4005-b188-9f004556e927@gmail.com>
In-Reply-To: <35b8c022-3c40-4005-b188-9f004556e927@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Jul 2020 20:52:05 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nuMzgD1ceVnr_3D1VJ=awD6yx1FBdAezY26RK9iUqF9g@mail.gmail.com>
Message-ID: <CAJfZ7=nuMzgD1ceVnr_3D1VJ=awD6yx1FBdAezY26RK9iUqF9g@mail.gmail.com>
Subject: Re: File context rule not working
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 26 20:52:17 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 26, 2020 at 8:01 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> On 7/26/20 11:01 AM, Nicolas Iooss wrote:
> > I guess this is due the rule 3 documented in
> > https://manpages.debian.org/experimental/libselinux1-dev/selabel_lookup_best_match_raw.3.en.html
> > (source https://github.com/SELinuxProject/selinux/blob/master/libselinux/man/man3/selabel_lookup_best_match.3):
> >
> >      The order of precedence for best match is:
> >      1. An exact match for the real path (key) or
> >      2. An exact match for any of the links (aliases), or
> >      3. The longest fixed prefix match.
> >
> > I guess that in your policy, there is a rule that states that
> > /usr/bin(/.*)? is labeled bin_t. As both /usr/bin(/.*)? and
> > /usr(/local)?/bin/raidcheck match /usr/bin/raidcheck, the order of
> > precedence is determined by the number of characters before the first
> > special characters (that indidate a regular expression). As
> > /usr/bin(/.*)? has a longer "fixed prefix", it is the one that
> > matches.
>
> I can't find a '/usr/bin(/.*)?' rule.  'semanage fcontext --list' should
> show it, right?
>
> [root@n5550 files]# semanage fcontext --list | egrep '/usr/bin\('
> /usr/lib/debug/usr/bin(/.*)?                       regular file
> system_u:object_r:bin_t:s0

Yes, on my system (that uses refpolicy):

# semanage fcontext --list | egrep '/usr/bin\('
/usr/bin(/.*)?                                     all files
system_u:object_r:bin_t

> But I suspect that your reasoning is still correct.  I wasn't aware of
> the precedence rule.  The first "special character" does come pretty
> early in my rule, so it's likely that something that's considered more
> specific would match.
>
> > Does using "/usr/bin/raidcheck
> > system_u:object_r:raidcheck_exec_t:s0" fix your issue? If yes, you can
> > either duplicate the line (by adding both /usr/bin/... and
> > /usr/local/bin/...), or configure a substitution pattern such that
> > /usr/local/bin... gets transformed into /usr/bin/... before searching
> > for patterns.
>
> '/usr/bin/raidcheck' and '/usr/local/bin/raidcheck' both work, so I'll
> likely just go with that.

Great! Glad I could help fix your issue.

Cheers,
Nicolas

