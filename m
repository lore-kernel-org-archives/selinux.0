Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30821C32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63632075C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjLVJJZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63632075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJKWWw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:22:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43613 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJKWWv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 18:22:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id s69-v6so7260722oie.10
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8JV2kzcSX7/P50786U48vkjv87gTBL+KUfl9XLB/v8=;
        b=HjLVJJZFyvWha+4yyL1ehIyWk+ixQfArodrcaufz2oXuwUP/wWKRKZ3UbrR82q5CVE
         jcIYdbcy0UzZ7gNKSfve2lQctZeEfttQRKlQ+NgmwvSC4NoWaT2tUC5SZWpn7f2y+avd
         GnLLpfxIFDJpadAD19uHQAyxL1yJQ62/ZmgIelU+2hDxpQHYkFxte567eNZIQB5MYy5Z
         kAqjkJ+dtaWqykLpC9CV+mSagLvrWHrfncrGMBgPFEb1M5NBSAYxMGqPi5GLgfGHFIgN
         XyDrVRSywejslZL8PRzY83bR725yU8X/DH5JmzZ4oL8hRULWwAaOuW08VJFW4CoG0aCL
         zjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8JV2kzcSX7/P50786U48vkjv87gTBL+KUfl9XLB/v8=;
        b=b/9PsaMhVcX0P5n3OUjUga9n8WsYRp7EI7N3yJCphfXQHxmkyBitC1clkn9OKFUt4O
         Jjwe+6IzJq3qxtxdEm+jAU5+CR7jffll8V09HZ85fpf12dQRUpxWK0D1wnE2zqDomSNW
         X6WyXUdq/JB4Wxa3ZW04MbOx2g5hGVYrWD2ufgeMOrUJjlPyIjbeLTB9djs41zx/gpY9
         T13cbfOSXclooFBw26nn8OWH4qt8JOOVdd3d/YpUDCBvOgZcA3YHC6FIURrvY52nfjtu
         s9aR7pIT7K+iCGRE5omHwYNHyEeaWGXyh3jTD3v3o/id6T64XphdQSZUJ4dzDGzelRBI
         ME3w==
X-Gm-Message-State: ABuFfogHaeXDIcpHEZOkxnTmhsusU7eCAgm7LJC3A9gsw8AA+ZEYsSq6
        DO22y1CuOJjF90R2VvfoPEoqJujWJG/0ktdNhXnHgOrr
X-Google-Smtp-Source: ACcGV63qeuLzivup9CbHSVzzIWzsRh8pyJKxpaNMv8rK87sq/hvgc7AP2NvB+urS7O45wIn+QjU3JRxh2/i2CTLMTR8=
X-Received: by 2002:aca:af91:: with SMTP id y139-v6mr993075oie.322.1539269720450;
 Thu, 11 Oct 2018 07:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181011134333.16468-1-yuli@crunchydata.com> <20181011134333.16468-2-yuli@crunchydata.com>
 <CAFftDdqagQZbbccJGQ+GB23kF9g_ZuiA3RN9psB7qykt+XhGjw@mail.gmail.com>
In-Reply-To: <CAFftDdqagQZbbccJGQ+GB23kF9g_ZuiA3RN9psB7qykt+XhGjw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Oct 2018 07:55:07 -0700
Message-ID: <CAFftDdqsUvS2X_AT8aaguQX4n4sW1zH_v+y6LyM2DwQk7XMg=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libsemanage: improve semanage_migrate_store import failure
To:     yuli.khodorkovskiy@crunchydata.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Merged: https://github.com/SELinuxProject/selinux/pull/102

Sorry I got over-zealous and did this under the 24 hour requirement.
Considering the
one liner and that v1 had review and no one objected to the change I don't see
it as a big issue. My mistake.

On Thu, Oct 11, 2018 at 7:19 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Oct 11, 2018 at 6:45 AM Yuli Khodorkovskiy
> <yuli.khodorkovskiy@crunchydata.com> wrote:
> >
> > From: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
> >
> > The selinux/semanage python module import error in semanage_migrate_store
> > was misleading. Before, it would report that the selinux/semanage modules
> > were not installed even though they were on the system.
> >
> > Now the import failure is only reported if the modules are not installed.
> > Otherwise, a stack trace is printed for all other errors in the selinux/semanage
> > python modules.
> >
> > Signed-off-by: Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
> > ---
> >  libsemanage/utils/semanage_migrate_store | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> > index 2e6cb278..b789d042 100755
> > --- a/libsemanage/utils/semanage_migrate_store
> > +++ b/libsemanage/utils/semanage_migrate_store
> > @@ -15,7 +15,7 @@ sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
> >  try:
> >         import selinux
> >         import semanage
> > -except:
> > +except ImportError:
> >         print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
> >         exit(1)
> >
> > --
> > 2.19.0
> >
>
> ack
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
