Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4CFC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8774C20810
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkysYYSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgFQRHt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQRHs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 13:07:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF2C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 10:07:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n6so2238670otl.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSsvUS1aLJ9hKRKlM8UYilJGM5RwmL3D0IHSzdYgmPE=;
        b=gkysYYSY6cFwKNGlcfxZdtQBhOfb8pS94iS6tz1pT0BenJtSWsCYecsoxHcMbF/I4w
         LaeiN4HvgJaCsfSEJX+ftT3olK04N/97sJvrz923YSXd8mAKj2teL/ShKjc7+V52gdEV
         IduqNhmP1ztgt9Vr6jk7X3dy0/6s82MMes/jpTE0u/6wDpX67YYZ9fPLuKC/Sm+In65Q
         JoEXxCgPyc64piNjv7dpwrd/6pgLTdg50dcOSoqZh6W1jqfdqN3aDJej0nafeGpN24uO
         x6kbe2D2Si4femgEJy80hKRARSoITLn2CYJrRzEI+VBE3OscNuS1JEsiOmIViOcJREAo
         icAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSsvUS1aLJ9hKRKlM8UYilJGM5RwmL3D0IHSzdYgmPE=;
        b=hpZDkIshzYcqMnkcGK3xeNeyPgGltXvlhRHhAncMAVBS8PUOijpGMMUgENIFYxOTbj
         r7Vs8B8RXn0ZVK+JfqlW+bjjUXsIQ31gp6Y+wJbMHDAFYr2/WOs+fHgKVUZaYMMZuVnu
         bxwobi9KcJjQj1nD1AonMoyjRT8cXD5PrIHXqdAv5vmjLVAzvvtGRORApxpCAFQxURUh
         DiX5g5vNuJxcKwaAAb9sfLBqPJh/nw7oR7M4dNhzlrUYUwdK2hQoWI0b1SfyzO3zEt0w
         c0e2JN8ZYzT8Vaos0VTZanpQTHY2TX6Nlb3FeFKw3HuNXrMqYEB0l/UP+QV6Sf+jU0ww
         UTEQ==
X-Gm-Message-State: AOAM5322sgpAGrA9K+rgoFMcF3CNUvn0n5XETT8hDxGyqtZzsWe6GcF9
        ovv6HFPA23xi2DiYyMD58Z3SHBnFp+Qw/ixzshyDTjLA
X-Google-Smtp-Source: ABdhPJyaglgkUslq/a4ulV+efWHmLNGTnvYNxa/nez891Za6kn/qJgQzzosgjLt4cuv/qSpibwl3A5JHXBtG9M9GiCA=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr7743781oti.162.1592413666106;
 Wed, 17 Jun 2020 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
 <20200611173039.21742-1-william.c.roberts@intel.com> <20200612053940.GA540562@localhost.localdomain>
In-Reply-To: <20200612053940.GA540562@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 17 Jun 2020 13:07:35 -0400
Message-ID: <CAEjxPJ7Zs_WY0F=O-gNVY_r8Bn1GcwxezZPXNuard3+9gmhq+w@mail.gmail.com>
Subject: Re: [PATCH v2] ci: dont use hardcoded project name
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 12, 2020 at 1:39 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Jun 11, 2020 at 12:30:39PM -0500, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Not everyone's github project is "selinux" so use the projects
> > name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> > the absolute path to the project checkout on disk, so the
> > basename should be sufficient. The script that runs in the KVM
> > environment also needs to be updated where it can find the
> > selinux project code, so we pass it in through an env variable
> > in the ssh command.
> >
> > Tested on Travis CI here:
> >   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697307824
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Since I saw that you have been creating and testing a 3.1-rc2 branch I
have held off on merging any further patches even ones that have been
acked; I'll wait until you finalize that with whatever set of patches
you have picked up.
