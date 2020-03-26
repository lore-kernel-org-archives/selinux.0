Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E39C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792F72073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glAccMRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCZQqc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:46:32 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45807 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQqc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:46:32 -0400
Received: by mail-il1-f169.google.com with SMTP id x16so5968153ilp.12
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMllKqdkzNBtidTUAnCBKpvoSyanzbfWZVJrPbBRdpA=;
        b=glAccMRQpiL08uj0P3HMl1DWwOByPfoAx4MnagmzYtroglSo+I5M06BNZu1OHAm4wF
         FM2lC5wXpv6X/53j/BosEM4lj22LXeMVZFlO/fT5wQtO6pHTmlmKNUre17ebiBd1dZIz
         Uvk+wGHJDcjymuO1JGBQboet7bfgmIhTeR03lJTzmc/vTl3e5Rt4g0XmdsaUWT6YEEFf
         UpT+p2tgaP6PM7QPl+DGr9RmA7K8PEK3GdC7qvWkmKaxTk09gJo6Hwh+iLS4PAt/uZyj
         GyBV+JfSQJJ1SRo4B0qKRp1oS6x+hvzHtqB3tUzy9htyyYK4f5ml4jFQJYHF6GVOUPz7
         IU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMllKqdkzNBtidTUAnCBKpvoSyanzbfWZVJrPbBRdpA=;
        b=NprPqXI47RhZ545g9U76ZC32VFybzsOGFDNpcx7W6pL9s48t1cVAc5nWsiVPdIDyi3
         ETE10H+8iQxOT0VSM3skFEqY1ibiq6CjZgAv8hRnaOQ8iNfk7bA8ARywEIMuCAVQg6wH
         iXbiAjZaP1qz6VGZGMc3lxelx03oZN3WAiKHW2Dt4+r/+PaBi4vyHbPK23AuXAR0p5ca
         USNh1Ywf7svazzM94H6tBayk5gUUv1s6636QzJDpn6tAlZBquIIXkrCYQnwuRXyaNnA7
         dHUz5D+NyJr4V8XCCvpbvkyEw4nSrwJa6xTQTtyf01ejAvGTPeFczXQIYeIN6Wdg7Lwi
         aP+Q==
X-Gm-Message-State: ANhLgQ0zIAAq74+TMHgXa1G8Fri18oOOOARhDha1gd2xOObiXbXiX4K1
        b+DVukqGRKMu3Vq3uAeqDyF1eRSyxAj+V9cCCGw=
X-Google-Smtp-Source: ADFU+vtMW6tHvrmSkimh+oYwM+MhNjxYS1r9JUdXNJC4X+4G3rnPADRpgK1NpLZ3L3B/ESVpRXaLf7LkcS9R2e1kv70=
X-Received: by 2002:a92:d687:: with SMTP id p7mr1673753iln.163.1585241188024;
 Thu, 26 Mar 2020 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
 <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 11:46:16 -0500
Message-ID: <CAFftDdrqHVgzNx75g2UfQwwzrp+uEnOmht+Lvp3A1svt3BJn1Q@mail.gmail.com>
Subject: Re: PR 193 sitting for uClibC fix
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:44 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 12:22 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > This PR:
> > https://github.com/SELinuxProject/selinux/pull/193
> >
> > Has been sitting forever. I looked through the mailing list and didn't
> > see any patches hit the list,
> > we should either close it, or merge it.
> >
> > Thoughts? If we need it to hit the list, can I grab it and sign-off on
> > it and post it?
>
> You can't sign-off on someone else's patch without them first signing off on it
> or otherwise certifying to you that it falls under clauses (a), (b),
> or (c) of the DCO.

For some reason I just assumed it had a signed-off line, it doesn't though.

> You could create your own patch to achieve the same end, especially
> since this one is trivial and seems
> to be modeled after an existing commit,
> ab0e27003ef245f20512d1808b1dfee662ab8f41, so it
> seems like it is relatively safe.

I thought about creating it, but it's like how do I create such a trivial patch
and not get hit with I copied it.
