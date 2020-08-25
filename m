Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A4C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32322071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="J4Jle6BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHYNP7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYNPr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 09:15:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC422C061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:15:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so16452799ejb.11
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4tlvmMf8Ri9U2id5zm75aoa13E4HS8iZL7kTcDdx+c=;
        b=J4Jle6BCBEuwhSoFQswk8RrrllGRuHOlDtBCY2uHYC1RFrL1nPQSxQiOo600IO/0qp
         Ra+CCj95ZdUHMqm8hi5B8jzQuj+r7s0r2O2fJqS2V1K8dLgh8zAWu5+CZVwykd5p/1h+
         ORRhoSMAabqf6ckFM2L7q3gL+bMgqYfReHZkDJM6U4Nk6Xu7ba3FOrwdW+Sswoa7fP5F
         2IeviYSyvr9z0qsWNobQuEasfmXsMqaU3VBkYgoy/PNGs1U37aPbDXsKHWOgHTVkahup
         HzFmTpVzb1lGSPsnyhLisPQU5JjzuBvjghRAZOaRW0WXE4Dhup3DovB2oTb3y5+ut3Sk
         sJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4tlvmMf8Ri9U2id5zm75aoa13E4HS8iZL7kTcDdx+c=;
        b=jUVlP0Qi/I60HpIXLFB2GeeYHwcYgwoiyiQ5g+PIQUlnV3nmcJRVQo1rBpg4Gjwtvv
         47YWGxdPspskBaiRhGdpo/9gEPS4QjZkPliJqvDt5ijUzkUGGFrlfGPW39MKgNe8Qmie
         1hHfx8utj9GSpcpvalhQWtGyjZdj/t5k6lrGuc1GNxDA/wamH7Lne+qYANsQIzaWNaj2
         gQ91KUeuLBWBvIDcg0TwQ/gvKZzap6DjViDi8ylcCWkzr0LOLRYp5mvmuOcrG+a3wr9Y
         /Ui2CGcb+dTye2jsoVrPaGU3oIaU5N0owZaxfRq/zUnsi9v8jblPTFoKYE1/U2h4GEsW
         Hk/Q==
X-Gm-Message-State: AOAM530ZNbdIiEZkV+UC3tkj2GrONOvo6GOKcgNCVjIEv6Fg0CNDz2cG
        bpl/j+WCQyXuR2wyarXoFOSHHC5dcUZSMzUwoTrjqvAizteC
X-Google-Smtp-Source: ABdhPJzdnFYtK33LtWDxWfuzloHDCoz9ODMhK7aF5iTbOpLqjK4O65XtFJtNyAqYpzD/XvyVWnuF8WqO0Pn3aT7Njqk=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr10315395ejb.91.1598361339709;
 Tue, 25 Aug 2020 06:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
 <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com> <CAEjxPJ5NhStOyzA9ea4HoGDAj1Y93T=f5iqdpbB8K_-kh3Ck+w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5NhStOyzA9ea4HoGDAj1Y93T=f5iqdpbB8K_-kh3Ck+w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 09:15:28 -0400
Message-ID: <CAHC9VhSomY6oUG2q-w9ek1iuDcQymOsye4-VKH+n3sr4qPdX9g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: enable proper lockdep checking for policy
 rcu access
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 8:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 21, 2020 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Aug 20, 2020 at 4:19 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > In the previous change to convert the policy rwlock to RCU,
> > > the update code was using rcu_dereference_check(..., 1) with
> > > a comment to explain why it was safe without taking rcu_read_lock()
> > > since the mutex used to provide exclusion was taken at a higher
> > > level in selinuxfs.  This change passes the mutex down to the
> > > necessary functions and replaces rcu_dereference_check(..., 1)
> > > with rcu_dereference_protected(..., lockdep_is_held(mutex)) so
> > > that lockdep checking is correctly applied and the dependency
> > > is made explicit in the code rather than relying on comments.
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > This is relative to the convert policy read-write lock to RCU patch,
> > > https://patchwork.kernel.org/patch/11724997/.
> > >
> > >  security/selinux/include/conditional.h |  3 +-
> > >  security/selinux/include/security.h    |  6 ++--
> > >  security/selinux/selinuxfs.c           | 12 ++++---
> > >  security/selinux/ss/services.c         | 45 ++++++++------------------
> > >  4 files changed, 26 insertions(+), 40 deletions(-)
> >
> > Thanks for trying this out! I indeed like it more this way. The only
> > thing I'd suggest is to perhaps name the mutex argument a little more
> > descriptively, e.g. "check_mutex" or "rcu_mutex". I understand it'll
> > make it harder to wrap some of the long lines, but I tend to think
> > it's worth it in this case.
>
> I considered calling it policy_mutex but wasn't sure it was
> necessary/worthwhile and also thought it might be confusing (obvious
> question becomes why isn't that mutex part of struct selinux_policy,
> but that's a layering thing).  I'll wait to see what name Paul prefers
> before spinning another patch.

As I mentioned in the RCU patch thread, my preference at this point in
time is to address this with comments and not pass the mutex into the
security server.

> > Speaking about wrapping lines... I noticed only now that in this and
> > earlier patches you align wrapped argument lists only by tabs (without
> > extra spaces to align to the first argument). I'm not sure what is the
> > preferred kernel style in this case, but I personally find the finely
> > aligned argument lists much nicer to read (and I have always been
> > aligning them like this in my patches). Obviously, I can't enforce my
> > preferred style here, but I thought I'd raise this, since I had the
> > impression we were trying to follow this style previously for new code
> > (could be just confirmation bias on my part, though) and it might not
> > have been your intention to change it (changed editor/settings?).
>
> I'm using the emacs mode settings from
> Documentation/process/codingstyle.rst.  I don't see anything in the
> coding style document to suggest use of extra spaces for aligned
> argument lists; if anything use of spaces rather than tabs for
> indentation seems discouraged.  I don't really care either way but
> would like editor settings to ensure consistency.

FWIW, my preference is for aligned argument lists, for example:

  void write_program(char *language,
                     char *description);

... with the understanding that tabs are used as much as possible and
that spaces are only used to make up the difference when the gap is
less than a tab (8 chars).

However, I don't feel quite as strongly about this as other things,
e.g. 80 char line widths, so as long as the code passes checkpatch.pl
I'll merge it regardless of the argument alignment.

-- 
paul moore
www.paul-moore.com
