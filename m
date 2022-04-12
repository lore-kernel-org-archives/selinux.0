Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D5C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiDLSHU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiDLSHS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:07:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023D20BC2
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:05:00 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a19so15336188oie.7
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pBgit8AV6JsCjTKSET81l+JFFNDIoyac2B+Dcg93zI=;
        b=L3qu/uxL2KyUHdrF5dGCImI0FnuCBbY8eFadiCdX6uli3OSHfQi+5ERrtm1CdwcmgN
         mriJ/LkRXp76AuGGiGiSF1wOC+nIRm6ppmff4lxibinXZiESMmUneosaS/bhtvsuwAFN
         QenCwJljBtdGRYv1c8uh3kfELH+clqixto40UBXAdsjXmZDu2IJarF91KD6L27dtnrSK
         tcbWHl4vZThDPbIaibK+raUTO1UE4gvWy9mFG3dd9u8UT9KrYOaf9rh0vSRD+UsYcMPY
         8scQm57yUpBXIg0kCslvf/qGJ8Lp4NmAoGG8dIGtMR4AcSAr+34n2hb2ARdQl0OIuUjw
         p46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pBgit8AV6JsCjTKSET81l+JFFNDIoyac2B+Dcg93zI=;
        b=y/Zg85Oal+byVizl6x4eTfATu0LWiHuhEmnGx8b+zcWDS4wM1BiGpnNwCccCc0La4y
         hu4mzxMqGaYX2H6/TWFbPB44oxEsXy9jPH7hqA+6R6zkh+GPL7BiqtRBbvq4JBg+XEW2
         DZ6aPl4BKXlbMUFz/0eb+dAUSkZVwjhcpi1NivzPVhB0IBfYfMNGQzg0NqSFwl1GWDsV
         hUghgVeyX5ckUR7AuVNhuIoc5qsHWBk4M3bXtACqhzJl22Hz3ouSCq7S8o8hDfD1mvqV
         r3ucc2QtcXT9NEfUP64xkzpRGNDYanhPfwj0VqK50cZhPAvcpuT7nLY6uYVOAwac0+Cq
         Hf+g==
X-Gm-Message-State: AOAM533qxiBw7ZMeX6cyZUcyLDbStRKIp2wiqIl0McSPAeao62p1a034
        n99ViUAbhu3LfzzYmJ76XpSFXUwXsofXqjiIAhA=
X-Google-Smtp-Source: ABdhPJxZPGBDUoumUHFq4LjkJ1Z5IYp456/ACB5lq1VAxnvJG6yCtBUuKYV99lMmEOfgoQ9veK1NeQ0DUfER8aCY3QM=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr2378464oiw.182.1649786699764; Tue, 12
 Apr 2022 11:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220405071735.251995-1-plautrba@redhat.com> <20220408085907.463960-1-plautrba@redhat.com>
 <CAP+JOzRWPuA2eG15ZyUcb2k67d=dEUTtn+7afshN95V=fiXTCA@mail.gmail.com>
In-Reply-To: <CAP+JOzRWPuA2eG15ZyUcb2k67d=dEUTtn+7afshN95V=fiXTCA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:04:48 -0400
Message-ID: <CAP+JOzTtRL5Hggds+QcSmd8Kk19LJ4R4OGQz8jmmDvBhCXYAUQ@mail.gmail.com>
Subject: Re: [PATCH v3] setfiles.8: -q is deprecated and has no effect
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 11, 2022 at 8:39 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 4:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > From: James Carter <jwcart2@gmail.com>
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/setfiles/setfiles.8 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> > index 15f939d1bee0..19b59a2cc90d 100644
> > --- a/policycoreutils/setfiles/setfiles.8
> > +++ b/policycoreutils/setfiles/setfiles.8
> > @@ -124,7 +124,7 @@ and
> >  options are mutually exclusive.
> >  .TP
> >  .B \-q
> > -Deprecated, was only used to stop printing inode association parameters.
> > +Deprecated and replaced by \fB\-v\fR. Has no effect on other options or on program behavior.
> >  .TP
> >  .BI \-r \ rootpath
> >  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
> > --
> > 2.35.1
> >
