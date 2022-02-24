Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E4C433EF
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiBXVIY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXVIX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 16:08:23 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880617E34F
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:53 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p15so5022529oip.3
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qdzey2JxtrwlVEFuMpPFkocA6D1zE4Xdrs97A0MGaeY=;
        b=Nfi464v2tlfWKrkVszDDTUbHSQMhz1rDjm2X3i5vL3ONWaGr9av3AOj4VdnN8h4sz5
         hAVb0MTsDL3kulFfaHJZFydmI4Dl2MMLN7s0u96tWlr0zFRCPnCNiyDDsg5rqkXf1BM2
         DrZnEEJvyVDhEIdPQx+cpc2KyTB92CYsm2oHEFc3FtvyY/uIYCSjvahQkL3cWT1zyVFe
         ri7woH2fktrPxQGpNhdArJMw7lG8RWFNIaChPJOqspdEzDn/lYDNwNy6nfNqtbYSyYyc
         tbRXUttfowziPm0b/If48VyJ7v1ceyYAefKbscOGouXD2xIMI3j+S2nOQegLI7GUePLn
         nkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qdzey2JxtrwlVEFuMpPFkocA6D1zE4Xdrs97A0MGaeY=;
        b=7dPThp+9gLeS/priIaaAd5wDzORQzAHebZVdjmsp9pcVyBod8z9oKK21xsJ1ZboxVf
         /ELGQIsovd75VH72DnOE9uuHunQ3MOxwLxWBay0IGA7ppjSe8w491E+fmLg2qx6qcDjl
         nikwGsEb7Hn8PxJ+K/zdschCbiAwYNenfcQr8y6c0B0uCs9ksjZsNZaHkELcUQz+e628
         csk030NDrSFjgJ+M5AoyEgihKUyphhQxs8RQIhPq2kQmWZPd9s4QlK8JhBkwCD9WGe+C
         4mGrvX1cnTh1BjJtLu6hFn4Swy1r6RFTpoxZZOJAPNqJ5EpERAhgZoqr8bf1TxBtkmk8
         7mcA==
X-Gm-Message-State: AOAM533qbtrCh4Bzc4DBMPEO/IwM/gaApR/wKjW1HmQ2Wx4TANEzuQB0
        QN5NSHXeftDMTSmM0xgfCEANDuJG/Z+ch9WpBsynH93E
X-Google-Smtp-Source: ABdhPJyytdZOg9Jq8X7x3mrjqGwc8OXljr37pHHLi6rW6biHCVKA/oUSuqwjLSmpWh7x5L1ztspOuqw6iDAC4WrH5Wk=
X-Received: by 2002:a05:6808:1642:b0:2d4:5a9a:c58b with SMTP id
 az2-20020a056808164200b002d45a9ac58bmr2516974oib.200.1645736872452; Thu, 24
 Feb 2022 13:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20220119163518.93780-1-jwcart2@gmail.com> <CAP+JOzSKEY0YgEwHRedmRa4VyKUsLxLqFX44PEQVnn-QkCMhxQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSKEY0YgEwHRedmRa4VyKUsLxLqFX44PEQVnn-QkCMhxQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Feb 2022 16:07:41 -0500
Message-ID: <CAP+JOzQ4yZo9eRTLHOFCFFnXz2QpeTZA_GXm6QL1GgKajavR6A@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] libsepol/cil: Limit certain error and warning reports
To:     SElinux list <selinux@vger.kernel.org>
Cc:     bauen1 <j2468h@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 4:17 PM James Carter <jwcart2@gmail.com> wrote:
>
> I plan on merging this series next week.

This series has been merged.
Jim

> Jim
>
> On Wed, Jan 19, 2022 at 11:35 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > When reporting some errors or warnings, a search is made to find the
> > original or matching rule. Both neverallow and type bounds violations will
> > use cil_find_matching_avrule_in_ast() to find the rules in violation. For
> > context rules, the AST is walked to find the conflicting rule. If there are
> > a lot of errors or warnings, then this can take a lot of time. oss-fuzz has
> > generated policies that can abuse this reporting, so the desire is to limit
> > the reporting by default.
> >
> > By using the new function, cil_get_log_level(), the error reporting for
> > neverallow and type bounds violations and the warnings for context rule
> > conflicts can be less by default while still allowing for everything to
> > be reported at higher log verbosity levels.
> >
> >
> > James Carter (4):
> >   libsepol/cil: Add cil_get_log_level() function
> >   libsepol/cil: Provide more control over reporting bounds failures
> >   libsepol/cil: Limit the neverallow violations reported
> >   libsepol/cil: Limit the amount of reporting for context rule conflicts
> >
> >  libsepol/cil/src/cil_binary.c | 20 +++++++++---
> >  libsepol/cil/src/cil_log.c    |  5 +++
> >  libsepol/cil/src/cil_log.h    |  2 ++
> >  libsepol/cil/src/cil_post.c   | 57 ++++++++++++++++++++---------------
> >  4 files changed, 56 insertions(+), 28 deletions(-)
> >
> > --
> > 2.31.1
> >
