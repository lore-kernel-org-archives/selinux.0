Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E4C433EF
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 02:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiAMCwx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jan 2022 21:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiAMCwu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jan 2022 21:52:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE9C06173F
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 18:52:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so17657663edd.5
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 18:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yv1Ec1TNugCkAm0UKl2rMhbmOYm2ReHJssNt2X7hD8c=;
        b=PAaKIvXjeqT2v5ZwFqtpelJGr7lkNAuAgNXC/gLyLNMEOCxykdh+vMdT9mKJJKgHfT
         ndUVMJFk/WfyVQQj7urEZCqR7sMdrR/ka0xPrD1SWvgPJlaTF4vf352xLyyhAOZoVkC2
         3OynfyAmRwZ1qcpCnvkQ9TBV+JZeoWOu/iq4WwVSqLyqfl1RTM1QpezUEbc7UmJ4HyXp
         9JdrSEJpaQ5IbIHEUGEc0Pq1poMVhMY2tKGFZZKA5gXm93Qm3hYeA38u3TDuIUWda3OC
         rbeTQYslSiCKZVt2MkeVKfES9S3LZkmPI91QIKzQ2Ko4AzV+ihpamo5lMqFQbs8AY+52
         ng5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yv1Ec1TNugCkAm0UKl2rMhbmOYm2ReHJssNt2X7hD8c=;
        b=J+gxOhXnWINzCbyFO6FQTJktX9EhMCaozoztWOVrrkR/KCGoAtyWYHKLW01RjzIulX
         tW+WwdIOPFk3RG0cpoMsgeQUxiJD8w/XTjtth1LAFKHU1KtdJoKiRugGvY9laYx/LFga
         JNApIATZns08+7vURHFtd0oj36jz64awYYvJjnTo72hlsiKEPKdoXsE+2/xcxWsyo3r5
         bL6R7wxVuZ6W8Gtlan40YdcWHbvPef7VCFdYRq8OVQl3B+2x3XByaQi2dCee5WmnHXKs
         TefxD9w04wxVyHgFGe3l7Orp3t2XiQW8Kz2zRZcCDSuncFhJoO0fhcvrxp9mHQJLdxNc
         eMFQ==
X-Gm-Message-State: AOAM531PB2UABbmbVadZY59b9W/nWpoEZKSQZImLtWX2tZdwsBx9cUKO
        NDWRIwROmGGvkw9/cHua0YhYbtAf2/nkT8595jDt
X-Google-Smtp-Source: ABdhPJwGcg5mFtOEvQWHghfS+jG9gVPxhPyMlLqVJ1YX6t734dh695ZodweeVc+HzkxEXc7cM6elye7VxXngO61Vc3g=
X-Received: by 2002:a05:6402:1388:: with SMTP id b8mr2359638edv.171.1642042368399;
 Wed, 12 Jan 2022 18:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20211213101622.29888-1-richard_c_haines@btinternet.com>
 <20211213101622.29888-5-richard_c_haines@btinternet.com> <CAHC9VhT5hw1JcgqOGZdTxaVWK5mE0gKKWiPLbJ3aZts+qm387A@mail.gmail.com>
 <b9655a10f2864a583ff880c810ea73a10c478c19.camel@btinternet.com>
In-Reply-To: <b9655a10f2864a583ff880c810ea73a10c478c19.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jan 2022 21:52:37 -0500
Message-ID: <CAHC9VhQLcvzWj8ig2AoPpRLaR0vR3VVde3NGt3G0dCM6B4FXZg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] selinux-notebook: Add epub build
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 16, 2021 at 10:37 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2021-12-13 at 20:01 -0500, Paul Moore wrote:
> > On Mon, Dec 13, 2021 at 5:16 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > Build an epub document.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > >  BUILD.md            | 23 +++++++++++++++-----
> > >  CONTRIBUTING.md     | 10 ++++-----
> > >  Makefile            | 48 +++++++++++++++++++++++++++++++++++------
> > >  README.md           |  9 ++++----
> > >  src/cover.md        | 16 ++++++++++++++
> > >  src/cover_epub.md   |  2 ++
> > >  src/metadata.yaml   | 14 ++++++++++++
> > >  src/styles_epub.css | 52
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  src/styles_html.css |  8 +++++++
> > >  src/styles_pdf.css  |  8 +++++++
> > >  src/title.md        | 16 --------------
> > >  11 files changed, 169 insertions(+), 37 deletions(-)
> > >  create mode 100644 src/cover.md
> > >  create mode 100644 src/cover_epub.md
> > >  create mode 100644 src/styles_epub.css
> >
> > I had to do some merge fixups due to the logo change, and I added a
> > few missing oxford commas (*cough*) but like others I had mixed
> > results rendering the EPUB on my Linux system.  Thankfully the HTML
> > and PDF formats still looked good.
> >
> > However, one of the more unfortunate things is that when I tried to
> > read the EPUB on my Kindle it failed miserably; although oddly enough
> > the PDF worked fine, the text was just a bit too small to read
> > comfortably.  I think it would be good to be able to generate a
> > Kindle
> > compatible EPUB before we merge this.
>
> Thanks for merging the first three patches.
> As you have probably guessed I don't have a Kindle, although I did use
> Calibre to convert EPUB to:
>
> AZW3 (KF8) - This was readable using Foliate and Calibre E-Book Viewer
> with no problems (however the links to the examples didn't work with
> the Calibre E-Book Viewer).
>
> MOBI - This was only readable using Calibre E-Book Viewer, however the
> tables lost their boarders.
>
> So this Calibre command converts to AZW3:
>
> ebook-convert SELinux_Notebook.epub SELinux_Notebook.azw3
>
> Will this work on your Kindle with no issues ?? The command format is
> described in [1] and there are many options.
>
> [1] https://manual.calibre-ebook.com/generated/en/ebook-convert.html

Thanks for your patience and your continued work on this Richard.  I'm
testing out the new patchset now and hope to be able to report back
soon, i.e. tonight assuming no interruptions.

As far as Kindles and the various ebook formats go, the reason I
mentioned the Kindle is simply because it seems to be one of the most
popular ebook hardware devices and as such I figure it would be
important that The Notebook render correctly there.  However, I'm well
outside the realm of my expertise, so if anyone can correct me, please
do so :)

It has been my experience, and I'm assuming that of most Linux/SELinux
folks, that if I'm reading something on a proper computer that needs
more formatting than what plaintext can provide a PDF is preferable.
Is it common for people to choose ebooks over PDFs when reading on a
larger computer screen?

-- 
paul moore
www.paul-moore.com
