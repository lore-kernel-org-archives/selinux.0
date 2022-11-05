Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A2C4332F
	for <selinux@archiver.kernel.org>; Sat,  5 Nov 2022 02:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKECu4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKECu4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 22:50:56 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D093FB80
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 19:50:53 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13be3ef361dso7410356fac.12
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8krmgY0yeq9uIqC8seEknqN9k2rr1a/uYkUy/ycjg3c=;
        b=ditrLtdqSF7zxePkhkUKW/ULMU/Jx7oaEKQFu3VRWU/j5Z1gbnNdj57CNGrgKJNSyD
         XbTIefW3fDd0gQDco5pYChyW1goxDbnQqVHH3qYvyXFy1fUFvCX92xcVJVMnI3nV5qlu
         QUviKkEMVA8SpDw5uickenpVx5Re4q/yRX2op1xJ4OpyZD7A2ynChyEiQDkiJ6akshnp
         8oUHJ/PRjyCKPH9jScKgOyZaLnDbo58mZOXDTLKWy2X6wtPFut7YX8LfGHgGo4SX6mDo
         JJsBfhh/bqWqsp6vTHfT8JVDm9xoJnyWsz7CnZ6cwKPxGmVO9tAv167UO0ckMc0KtuOW
         5tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8krmgY0yeq9uIqC8seEknqN9k2rr1a/uYkUy/ycjg3c=;
        b=D6dYJ3A7NkEC3EtO2UMeEKC7g7lsWw99gLUst9oVTPWweiT1dRXpEi295J6wO1ojQD
         CaQRTbtjSjQB13TUE62vBLK/6uPSzfXHB0uo42XZrhHzzSzYKp/3Sa1Gnt/PekYjabr0
         tq61rC/7LzyaJCFuOUe1MN9qW1mNDqGZR67eeKYbxQZ1vjOc6AhklovQI3yQXO6o1c+M
         lrtOl2lhXvdih08pdd+ixhN0mvne2ki2ZbZhNR/fA3tFKrKy7tYU9HS/pvZPqQhfhCWP
         m95+k7NIXEhMJjuJNhv8SugrQxYlZNKP41TdUlftjPgOunZOF2W/v018Yeev8DFxUJ6O
         B+Uw==
X-Gm-Message-State: ACrzQf14Mc6EkhK9cZPvwIP3aJHKEtYnw/44eNOV9o6yc7s0DyTZNTpB
        1Uds8EgICEEHcgMsYkkq15n7SUiFSfOcCSbxStvmlVbDGJJi
X-Google-Smtp-Source: AMsMyM4OgVaf+PBsZuYyWN8yqMp7k/YUncnUJM9uW2jfkFPOByE86+jLRFRoJfxXM0k87iGYF1iIiQ0kWBFIhYYdq7M=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr23346671oap.172.1667616652428; Fri, 04
 Nov 2022 19:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <166480484056.9276.9459961157065300430.stgit@olly> <871qqjdlx3.fsf@redhat.com>
In-Reply-To: <871qqjdlx3.fsf@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Nov 2022 22:50:39 -0400
Message-ID: <CAHC9VhTugAhgcM7bJOXzKcFq8w7Zu4KR2d1onTKtbsy+kCQY3w@mail.gmail.com>
Subject: Re: [PATCH v3] docs: update the README.md with a basic SELinux description
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 4, 2022 at 7:00 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > This is to help meet the OpenSSF Best Practices requirements.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks Petr.

> > ---
> >  README.md |   19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index 74b0a0c3..f54e0555 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -7,13 +7,18 @@ SELinux Userspace
> >  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
> >  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
> >
> > -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> > -
> > -Subscribe by sending "subscribe selinux" in the body of an email
> > -to <majordomo@vger.kernel.org>.
> > -
> > -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
> > -
> > +SELinux is a flexible Mandatory Access Control (MAC) system built into the
> > +Linux Kernel.  SELinux provides administrators with a comprehensive access
>
>                 ^^
>
> I was wondering, is the double whitespace intended? Is it something
> related to typography?

It was intentional, although the "correctness" is of some debate these
days, or at least that is what I've read.

Back when I was first learning to type the rule was two spaces after
the end of a sentence, presumably to help make it easier to read,
especially in print using older typefaces and machines.  I've read a
few articles that now indicate this method of typing is somewhat "out
of style" and in fact most (all?) HTML/MD renders don't render the
double whitespace unless an explicit "&nbsp;" or similar token is
used.  However, as I've been typing this way for many, many years,
typing a double space after the period at the end of a sentence
happens naturally ... good or bad :)

Setting my typing habits aside, we *should* be consistent within the
README.md file; if you would prefer me to respin the patch with a
single space at the end of a sentence just let me know.  Otherwise
please feel free to make whatever changes you feel are necessary.

-- 
paul-moore.com
