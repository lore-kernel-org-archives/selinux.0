Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F865C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 21:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EEB20760
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 21:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AK0sRXsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgFHVfa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVfa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 17:35:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF2C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 14:35:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so20005984ejb.11
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlisB7CXjLE8jXMZcZFa61raoNPeWoWN8Mog+3lbxlU=;
        b=AK0sRXsFNj/rK7/Ta5FhgPCn1nUSTONrgzwvuFLBOJ1//TOmoWkeOp3W+TsBuvkitI
         XOmfQst7wzEBUF8vGrY666nVnu0DzvRJNJ0BswOV+WwtUOAe/HXOhXzuxyVjTQL5VRur
         irtY6rQeTo5PeMh1I27sEMAf0JU48PlBJ23XT92lIj4PiWXjbncnwBiGjfz3lc3fbnEL
         SNeY5q3Uj9W/D4GczglixN/3gO9G+mryI1Y6ZvHaJ/DleRi35Efr6Cr1CLB91jlGHj9S
         OOkW9sBKtHbmqDeaQP9gJNKfQmwdt4gMS5l6sPnfLf9Glf//ZT5ehjzt50Oo+cf9qzh7
         YF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlisB7CXjLE8jXMZcZFa61raoNPeWoWN8Mog+3lbxlU=;
        b=TJwDN7t5rHd6kQqStJK51CwKisJ88yJhnhR0JghXU9fi2WY5mUWJBTyhpmFmCEy3sV
         v8qKZNVyYnmptOkt1s0MxaKeHEEE3bWTgoTrHQBVUxX4PtguVk2XTMg+bIJwZgc+17L0
         Uou8tIwpUaO1l7eOGmj5G0Lme8p8HYh3sipD7/AjNzgFUdQnpKxIOm3BNbVydG4qLUOg
         vDD3iH6IsrMRmrtdKAcuVXSF5IrJ8DfSDHovTLaE5p+luITAb3wMmtzP15VYcEbuPJf1
         z5e/ecfFmCnYUlKD/h4lreMVpy9qHPi98DCcr01Fu1zsIWa4cMHsQtC3Qj8Rwzk1r1Ec
         Oz4A==
X-Gm-Message-State: AOAM530tf/kwMZ6fZu/osEO4fcSgjvXDmx6CAUS5BTKM2hQc76doTJD+
        2lGudbw9ZE2lqnxx6oYpRP+++9u46r5HHV8Cg6gu
X-Google-Smtp-Source: ABdhPJztdB/Vp8F3YJbGASGEqwLdEyrfZGnezLTULFKCgjJTyPlrqWl7NpKNBd4Q1He72v/PeYmpFKpF0gs2F6pDeDU=
X-Received: by 2002:a17:906:e257:: with SMTP id gq23mr21446716ejb.398.1591652128363;
 Mon, 08 Jun 2020 14:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com> <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
In-Reply-To: <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Jun 2020 17:35:17 -0400
Message-ID: <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 10:49 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jun 2, 2020 at 8:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > We deprecated the SELinux runtime disable functionality in Linux
> > > v5.6, add a five second sleep to anyone using it to help draw their
> > > attention to the deprecation.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/selinuxfs.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Warning: while trivial, I've done no testing beyond a quick compile
> > yet.  I'm posting this now to see what everyone thinks about starting
> > to make it a bit more painful to use the runtime disable
> > functionality.
>
> I'm concerned about how users will experience and respond to this
> change (and Linus too).  Currently SELinux runtime disable is the
> method used by distro installers (at least Fedora/RHEL and
> derivatives) when SELinux-disabled is selected at install time and it
> is the approach documented in distro documentation for how to disable
> SELinux.  Hence, we'd be inflicting pain on the end users for what is
> essentially a distro choice.

I delayed my response in hopes the Fedora folks would also comment,
but I'm not seeing anything.

All this patch does is start executing on the deprecation path we laid
out when we marked the functionality as deprecated.  When we decided
to do this we had buy-in from the Fedora folks (the only ones who
still use this option);  if this is a problem for them then I would
like to understand what changed, and why.  If it is a matter of this
coming too quickly, that's okay, we can push this out another release
or two.  We can even drop the sleep down to a second or two.  Both the
timing of introducing the delay, and the length of the delay itself,
aren't important to me; it's the fact that we are adding a delay and
moving forward on the deprecation (just as we said we would).

What were you envisioning when we marked this as deprecated Stephen?
If not this, what were you thinking we would do?

-- 
paul moore
www.paul-moore.com
