Return-Path: <SRS0=OFWW=BF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C53C433DF
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BA8206D8
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 16:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGZQIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:08:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54616 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgGZQIp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Jul 2020 12:08:45 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2020 12:08:43 EDT
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1F8E0564ED6
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 18:01:22 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id s144so2405403oie.3
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2020 09:01:22 -0700 (PDT)
X-Gm-Message-State: AOAM5318qBq4DiGbc9Ad+vj/6GwacsSWlhFbBjtIp7Xh85pbZ9uihvl1
        ZwF0qKLgEMxs0eXg4qqT2McMuHAwLEPIr7mSPmE=
X-Google-Smtp-Source: ABdhPJwy0Fz0JqWRpyGMd0IEC9UELL0eJxdVTXTkYYTaSTZtiWgmqZuAujBNAvQxSd+EnbYPLROIGZRJJvEBSGt6Anw=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr14611385oic.20.1595779281062;
 Sun, 26 Jul 2020 09:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com>
In-Reply-To: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Jul 2020 18:01:10 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m7udOgTOcoR3wEEtxnAoaLmBaHSeVzBYxsQhmzmw2qGQ@mail.gmail.com>
Message-ID: <CAJfZ7=m7udOgTOcoR3wEEtxnAoaLmBaHSeVzBYxsQhmzmw2qGQ@mail.gmail.com>
Subject: Re: File context rule not working
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 26 18:01:22 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 26, 2020 at 5:03 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> I'm tearing my hair out trying to figure out why this rule isn't
> matching.
>
>    /usr(/local)?/bin/raidcheck    system_u:object_r:raidcheck_exec_t:s0
>
> The rule shows up in the output of 'semanage fcontext -l', so it's
> loaded, but either /usr/bin/raidcheck and /usr/local/bin/raidcheck  are
> still being set to bin_t.
>
> Is there any way to get restorecon to show the steps that it takes to
> determine the context for a file?

Hello,
I guess this is due the rule 3 documented in
https://manpages.debian.org/experimental/libselinux1-dev/selabel_lookup_best_match_raw.3.en.html
(source https://github.com/SELinuxProject/selinux/blob/master/libselinux/man/man3/selabel_lookup_best_match.3):

    The order of precedence for best match is:
    1. An exact match for the real path (key) or
    2. An exact match for any of the links (aliases), or
    3. The longest fixed prefix match.

I guess that in your policy, there is a rule that states that
/usr/bin(/.*)? is labeled bin_t. As both /usr/bin(/.*)? and
/usr(/local)?/bin/raidcheck match /usr/bin/raidcheck, the order of
precedence is determined by the number of characters before the first
special characters (that indidate a regular expression). As
/usr/bin(/.*)? has a longer "fixed prefix", it is the one that
matches.

Does using "/usr/bin/raidcheck
system_u:object_r:raidcheck_exec_t:s0" fix your issue? If yes, you can
either duplicate the line (by adding both /usr/bin/... and
/usr/local/bin/...), or configure a substitution pattern such that
/usr/local/bin... gets transformed into /usr/bin/... before searching
for patterns.

Regards,
Nicolas

