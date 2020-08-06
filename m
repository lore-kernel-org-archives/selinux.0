Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04546C433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 21:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB98B2173E
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 21:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RzqQz2QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHFVtX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHFVtW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 17:49:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F7C061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 14:49:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so6523831edk.6
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vPvgWO3vXIKi57S/5+HEq8i3xT4+7dX9gSk3O8UTRc=;
        b=RzqQz2QBZFKXg9lgN6MBwm+9PxUGZ01Vb1pvVLVO4/q7Uie4yxGCGPHhFgcMQQ2+UX
         Z2GU9trrE9spL1gzk4FM23QNZdds+UK2ijtMXOgGyBBpdEoC4wLUauEf6BKXJLRJ2xfT
         sXY+XukZsc1aeoOr1T+D/wfa/OpnMcA07L+shCIMj6XCF0SjrtU6NlJ5N+d00mAEkais
         2x5NjOMfbQyuzxvGBCYPpasjQHSfIOW1FMjMBFGX1GR8j+z7c89HXFVcS15L+Flef9UV
         r/N9tr0hx01lUAj50jzEqeuOc/3Qb5LHemh6fMQkEsg2Twml1F4kWjPpnnxhHtVk9Ofr
         MQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vPvgWO3vXIKi57S/5+HEq8i3xT4+7dX9gSk3O8UTRc=;
        b=YQwoJAwBtSPxpHc9bTxea26oPKAcRhqClhAWNhrr8pO5zkEvxMrKFz9nommyaMizus
         GPWhoIPvx8nkpHYu8O0Awi11fE54h9AAbOufzIoStEJLCsw7mpGqR3107qxUzOAT6KSi
         PPxDFFIb17/FNCUG5W7KlH8TZIs9eAHti1Ha0wCI7vbHIiOkIJ6wFdKeLlhxjMQf7jpi
         Xoza+Iasj80cJY3HPvluXA8v+loAh6A3TNd4t91mRGI3dlWb/pR4bBHDiDiE9F1zm0sm
         CwKFdPCoOt50f67OEw7KjlzD7uh5K4zJlxaECH515hbUv4EbSklGZqqoFte0zPFhG05D
         6e7w==
X-Gm-Message-State: AOAM533QkauqqFKB8gWLPavflcvJcHCYA+fdVQzUXoaL2FvcfTEP4Tur
        Cl8gM8xvT+Ett1hJcNWuY18mNcY0DVbmg/L1e+aWgiqBGw==
X-Google-Smtp-Source: ABdhPJxUyU6sC+h0LAETrNH+jNtY+YRCxPkRx3bOYt3Yzc+WCQU9bIqUq+rDVETFkgiyvL+1qgng1T9IvFt7Xd6PK1E=
X-Received: by 2002:aa7:c353:: with SMTP id j19mr6140495edr.128.1596750561128;
 Thu, 06 Aug 2020 14:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <159650470076.8961.12721446818345626943.stgit@sifl>
 <159650482872.8961.7516871249534865160.stgit@sifl> <837e782ff80f69e8e4d44bc49ff2ced54b0aef2c.camel@btinternet.com>
 <CAHC9VhR5ik=yk5Oo=n_B3JhKyJuBVaSa5rUNsPdHMtH78b83mw@mail.gmail.com> <14cc38f023a913d7be8d452c63e6bb3ee8916422.camel@btinternet.com>
In-Reply-To: <14cc38f023a913d7be8d452c63e6bb3ee8916422.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 17:49:09 -0400
Message-ID: <CAHC9VhTOLXEO61C9_O5YbNVSfp75h7ROiYd=FwF6pxWuib8vvg@mail.gmail.com>
Subject: Re: [RFC,selinux-notebook PATCH 05/18] xperm_rules: fully convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 6:07 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-08-05 at 22:34 -0400, Paul Moore wrote:
> > On Tue, Aug 4, 2020 at 12:14 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:
> >
> > ...
> >
> > > > +*rule_name*
> > > > +
> > > > +The applicable *allowxperm*, *dontauditxperm*, *auditallowxperm*
> > > > +or *neverallowxperm* rule keyword.
> > > > +
> > > > +*source_type*
> > > > +
> > > > +One or more source / target *type*, *typealias* or *attribute*
> > > > identifiers.
> > > > +Multiple entries consist of a space separated list enclosed in
> > > > braces \'{}\'.
> > > > +Entries can be excluded from the list by using the negative
> > > > operator
> > > > \'-\'.
> > > > +
> > > > +*target_type*
> > > > +
> > > > +The target_type can have the *self* keyword instead of *type*,
> > > > *typealias* or
> > > > +*attribute* identifiers. This means that the *target_type* is
> > > > the
> > > > same as the
> > > > +*source_type*.
> > > > +
> > > > +*class*
> > > > +
> > > > +One or more object classes. Multiple entries consist of a space
> > > > separated list
> > > > +enclosed in braces \'{}\'.
> > >
> > > I've had a rethink on this and wonder if it would be clearer if the
> > > descriptions were a bullet list:
> > >
> > > *class*
> > >
> > > - One or more object classes. Multiple ...
> >
> > Ooops.  I forgot about this comment in my inbox when I merged the
> > patchset; although I guess even if we go with the bulleted list
> > having
> > the table in markdown first should make this easier.
> >
> > I guess we could give it a try and see how it looks?  My only concern
> > is that sometimes a list with only one item can look a bit "off".  Or
> > an I misunderstanding what you are proposing?
>
> I've posted the SE Android section as an RFC patch that converts HTML
> tables to lists. See what you think.

Okay, I'll take a look.  I'm inclined to merge it regardless just
because it does the HTML->MD conversion.  Once we get it fully into
markdown, especially the tables, it should be easier to edit for
consistency, style, etc.

> I sent the Reference Policy updates yesterday but it never made it to
> the list as I didn't realise it was over 100K, still I guess you had
> your copy.

Yes, I just ran out of energy last night when I was working my way
through the other patches.  Hopefully I'll get through the rest
today/tomorrow.

-- 
paul moore
www.paul-moore.com
