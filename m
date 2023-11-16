Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E3AC47071
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 04:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjKPEpu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 23:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPEpt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 23:45:49 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315719D
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 20:45:45 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so366978276.1
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 20:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109944; x=1700714744; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5NQZRzhd8QMbuaaiYzohTnfVf0XJkKfZNL+MfVhwfA=;
        b=AP60ARjiCq1Ekiu7SnErfzFRTcqvDVJimmVbcn1Cog8HOZroavdvVTW8VWEL/zGGPT
         dUza7RplBTXFCDtcZT0Ho8FVZPz6M7DxzcCmJ4vJl9sPhDpkIC08RSuROk9HuBj12GpS
         gTJKV6Lj5P/qF6Hlkc0U62ilhpiTF8eisDjhLAM2VfawGFOTVOpGBwgHdNz8yAuU7ZBu
         qj+I5QQ3CJ+CAwhS31bbcASiJ/2HxGTZ/2LWzK57EaB1hnK4rToHkk5+gKVW4annYgun
         7mfJhH8QZjLEJ+U0C7jIg+gAdYdKrE3i5y04DqifVN1UKX5vbJ+6S2sWwXpn/+oxniru
         ua6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109944; x=1700714744;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5NQZRzhd8QMbuaaiYzohTnfVf0XJkKfZNL+MfVhwfA=;
        b=rOZmoq2chmnoZKL9V4lcx9NfuRbqxbYF/5dixMQFMXMMEJhnTn2DF/yMwSOGI0bEps
         wzJmFCPowFuKYaVQ2d7KYTzIbhR+t1HrQYy2f3BjAsZwmsD+Eh1Sp/2mA7Jwqps5GDAl
         zYqC8fMKzdbknWDY83nH0OB5Ulm4+TXHgNTebcF+uQtuinwNmUJStglPpErA2Km/5p+t
         HMcngpP1P7iCM48hBqLdh4Q9ALZnJKk8GVrcdy2TmNDWWNcVq6WOy9V1L8DLfaR2H4yI
         9g7r2wA0J/lDIFr1FzgiTNbnnw2gnct6ZVGK/reO4gx/FMjyHq4CM/UrsZaOqxLb88st
         N87A==
X-Gm-Message-State: AOJu0YzU6ffWPbTJex5vmxtFY/uriMAlkIybpJqjVQGol49yMgzXFUiy
        9BJySPYMrGUnj6Z+mQQXDSJ+P3X0gptKdqdgFW3HeTUr95atgJE=
X-Google-Smtp-Source: AGHT+IETTNS48zUlZZe2PWhvR+pKQarV0fxyNCnSK/ooaDTUs26hdOM2hmGpMXxToZRQTEWF5RqR1fiWJNGTI0U/JN4=
X-Received: by 2002:a25:1844:0:b0:db0:366a:73ab with SMTP id
 65-20020a251844000000b00db0366a73abmr3329258yby.57.1700109942854; Wed, 15 Nov
 2023 20:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20231115170405.113117-2-paul@paul-moore.com> <CAHC9VhSnpjTBdDvJuF9cH6_s+AtOYStrvqaXTRpbDBSPSpvAyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSnpjTBdDvJuF9cH6_s+AtOYStrvqaXTRpbDBSPSpvAyQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Nov 2023 23:45:32 -0500
Message-ID: <CAHC9VhT+qMazD2B4b4ZTZ41wQ3x1o3yYf-XHbVbZxUw4zqODCQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the SELinux entry
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 15, 2023 at 12:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Wed, Nov 15, 2023 at 12:04=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Bring the SELinux entry up to date with the following changes:
> >
> > * Remove the selinuxproject.org link.  The wiki located there is in
> > read-only mode and exists primarily for historical reasons.
> >
> > * Add our patchwork link.  I'm not sure this is of much use for
> > anyone but the maintainer, but there is a provision for including it
> > here so we might as well include it.
> >
> > * Add a bug report URI.  I suspect most everyone knows to send mail
> > to the mailing list if they hit a bug, but let's make it official.
> >
> > * Add a link to the SELinux tree process/management documentation.
> > While the doc exists both in the canonical kernel.org location and
> > the GitHub mirror, provide a link to the mirror as GitHub does a
> > better job rendering the Markdown.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 97f51d5ec1cf..e5d289eaba83 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19520,8 +19520,10 @@ M:     Stephen Smalley <stephen.smalley.work@g=
mail.com>
> >  M:     Eric Paris <eparis@parisplace.org>
> >  L:     selinux@vger.kernel.org
> >  S:     Supported
> > -W:     https://selinuxproject.org
> >  W:     https://github.com/SELinuxProject
> > +Q:     https://patchwork.kernel.org/project/selinux/list
> > +B:     mailto:selinux@vger.kernel.org
> > +P:     https://github.com/SELinuxProject/selinux-kernel/blob/main/READ=
ME.md
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selin=
ux.git
>
> Unfortunately I didn't realize this until the patch hit my inbox, but
> I should also update the tree location to use https instead of git.
> I'll fix that when I merge the patch.

Merged into selinux/dev.

--=20
paul-moore.com
