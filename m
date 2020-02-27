Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B95C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7702468F
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 20:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1O+Zfhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgB0UW4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:22:56 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43604 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UWz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 15:22:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id p8so416588oth.10
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s61/u+6NZ+mHC8gZV6uYmwwzXQ0X/zgH4IJYPEb15EQ=;
        b=C1O+Zfhdk6NkMo1CqnWcbQvtZT/o/V2x++obM2UXGZnHRWWcg8IHCMNZhxwzDPdWXT
         40wSWLsZx+nOHgYS+MjgTLeyYEFUib8IWEWa/XyX950I3/N7CjAP/7edc/0x6Q995H62
         GJB1toTR5V1L6RdVq5tscfjUZwlUPvbSM4HhalH2tP8aO3lWU6RbaNikTDNljTmgBDiT
         5i1uvyu6o3g7AmmrCrh6OKiU732r1rlhCzJRqjhESvETI5dnuq9MfLTyiF1Vp2F1vPru
         YS4DW5HJAdO+gSb2ko+xOUSDVVLOXqxoUz4eKD+0AcNDFxXosio2+0B8RdfM1LYruZgp
         ba2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s61/u+6NZ+mHC8gZV6uYmwwzXQ0X/zgH4IJYPEb15EQ=;
        b=cuXnJ9KlntiHDJONE4zCefCoYuw/gVWyzq037URVzUMTxvftm5REvsONo4Xw2JdFOM
         sCjov7qM207hDbOG5M9Otpa7aJRuZd5KIvokca5DqdHUyWIqGG1FyfiH0ccvSSpc0iYc
         EKy1DA5OcGfcZJZN3vhozERWZGjfHGn+bJnz1V9QYd9B5UZF7794ITm6txC7C2BoeAxi
         X8Cc/HmCK+OJZvvkFBE7RJijyN7qWJ0YDQUQ2ij8ryX7LwVX4roSryD5/uUpIb/onSSn
         OzbO/TMEk0wL3etDI+hVweh4vc9rRBxfu0+pLhgCWZNlgWnjIJdAMJxoW5xYLlFtpfrb
         39FA==
X-Gm-Message-State: APjAAAWjS3oJTYw4lkmXfn8Qzzubvy/8Od6EDMP0+sq+9UcXOhck9s1R
        oMQHLxQl4D0N3WaL4zQM8QnOgOfYn2cchvgBdv0=
X-Google-Smtp-Source: APXvYqzw4/iMxzwXxREteAB54gMxUaXNldVdpCGgv5LOPLogRFVJvtovgIcaXuk2tFM/j6I5ZmXnGYt7v0YmqaRXA8s=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr476592otk.89.1582834974438;
 Thu, 27 Feb 2020 12:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com> <CAFftDdqhFufuZkA0XYztuHH62KkawfTMjimTCx_cztAq0DH5wg@mail.gmail.com>
In-Reply-To: <CAFftDdqhFufuZkA0XYztuHH62KkawfTMjimTCx_cztAq0DH5wg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Feb 2020 15:24:04 -0500
Message-ID: <CAEjxPJ5Pw7uw1XchF4B6KnoO1jOH2vKOUtuWZfCXfXw+_8AaNA@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 3:11 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> <snip>
> > > The hidden_def/hidden_proto stuff originally came from Ulrich Drepper,
> > > glibc maintainer at the time, to eliminate unnecessary runtime
> > > relocations and PLT entries being used for local symbols.  Per the
> > > comments in https://github.com/SELinuxProject/selinux/issues/204,
> > > these might not be needed anymore and are breaking building with LTO.
> > > Willing to get rid of them if it doesn't produce a significant
> > > regression.
>
> I guess that's my major question, how do we determine this is a regression?
> Obviously a functional break is self explanatory.

The original statistics used to justify it were generated by the
relinfo.pl script available from
https://www.akkadia.org/drepper/relinfo.pl.
