Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964ECC3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6710A22B48
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="b4Tc4CgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCDRLs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:11:48 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35160 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRLr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 12:11:47 -0500
Received: by mail-il1-f193.google.com with SMTP id g126so2467570ilh.2
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GhyKaORaf4yLOMYyF5xDQiSjMUQS+g7f072AF9AzEA=;
        b=b4Tc4CgDV/6NhOkp1MgVdO35zYK2yr35jfxaUB0DC7V05x0bgZl7UOyeNMxPIgKlh2
         pcZCLPWAdzUIhDpEU9JwE+vkD+k9fmMaX08i3qHmn3iUY7aUF3E7W43krAdV44TZh9zW
         Pm+hBjqfzk26+F9fXPl5PwdA9zcwlg1rzyC5CFZWNdlVPoRgnk2ySZH97gTjNJVSr4PE
         KZs/yRQsOC2NrPERePV1KG6EuQPQc1a+JAS9VJ0zJj8mwO9xAOOS5YTXrZcW11b4zF+h
         Hn868b2Up4i804+IUfFCGDBeran4uCdpm0PU3xSCZBnnmQS7kiDk94QW8X6CSwejesvF
         Z6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GhyKaORaf4yLOMYyF5xDQiSjMUQS+g7f072AF9AzEA=;
        b=Cdp86qPpbsj7sw1DTl096hNDcBaX/bbmVR1TBvnvqec//43a3gUgje2AHme4UYucSi
         nA1z2Rx8/qlsSWkSSDPMFyC186PgGfIqaod+L7fgyIJmfCJqQJsfNaP9kBE3dcnNWfn3
         ZPEWDQD6Z//wVJD/Bq0DQg7Su4RRrRHwyzgU6A5trLXyp74ygv/EVFGqvhNPwkIityt8
         kI3hJn8vfxUxZHJZODIIKuYHxttY8TNU7DECcg5x1p+6Ri0EAXyB6g1jDLU0Y4reE+Qq
         6v5nv5tQWS27irKu+NTNf7v0UekXDUsE8iB5g1rOLKgs9GzOTlOwB3m1RxnGLUdEZTAG
         KEgg==
X-Gm-Message-State: ANhLgQ2EPtrTWZzL3UKyfkUV78PzWA0LSKLtbUjL8EvxRGp5VMaVFTmj
        un16ObsgQD82rNyEXMLscfcd1tx4ba34Tt/Y6sVbFw==
X-Google-Smtp-Source: ADFU+vsw0/0/SC6ruH7SS2M3oA+BWQxNlDcrQER5bmat63yUlWq6A1CzAYzPZw8yiqzPSue9jrTt5zLfh9chxNCcCa8=
X-Received: by 2002:a92:1b4b:: with SMTP id b72mr3870448ilb.227.1583341905659;
 Wed, 04 Mar 2020 09:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 4 Mar 2020 12:11:34 -0500
Message-ID: <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 11:54 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 3, 2020 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Adds a basic test for the "glblub" default_range mode introduced in
> > kernel commit [1] and userspace commit [2]. The test vectors are taken
> > from the original commit messages.

I'm confused, I submitted tests at Paul's request. The patch is here
but says superceded:
https://patchwork.kernel.org/patch/11119909/


> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42345b68c2e3e2b6549fc34b937ff44240dfc3b6
> > [2] https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9
> >
> > Cc: Joshua Brindle <joshua.brindle@crunchydata.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
