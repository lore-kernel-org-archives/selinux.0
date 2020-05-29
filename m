Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC1C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F65207F5
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7mJkVp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2M6x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2M6w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 08:58:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE8C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:58:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i22so2431609oik.10
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3TeGtiHM3uH/ZWjeOWUq5a6jxIX0YtepPfUxeGXJEU=;
        b=u7mJkVp7+Y7wdjWWxWYmjOBQpkeHTPKVpfv18CSwgi3fXyBlXSdXI0AyouzYeC+X63
         s62Y1gCvZ0PpbxgIGHNC7Ts6rpEDa/3fqERFnabpqaaZTvc12O712aYUy21YzmtW4kaV
         qf7Cq+Ht0XIwIHPtFMqHZPxDe33XaiBx6RT4l3x5qO+qUo/Jz3x2bckMdhPIgd2AIrVe
         5IZbRNsBYcdMnntLjOCnKimtQcmj51Bn2E2RuJryrLTaSVtsBGFnxchq3zfT1Hlcz10N
         v0+O1aLhtx/D9IAUPYNng/LrMH/EztnEheELi0fGR3i+je5GHt2zlJyIW3EuOmBinvZ9
         WQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3TeGtiHM3uH/ZWjeOWUq5a6jxIX0YtepPfUxeGXJEU=;
        b=qO6fFp3rOhoMB+DQfChMWsYGuzUbzCwnZ9ptmLguCzhsVk0YgDX7Dw64AffTrHR4Pp
         TpGktdKcl6rm53I/PEPhKu7dDlLMPy0ryPItcCxIuuHku4jLfljp5RbPuGe/L9Tkvuvj
         bJedlMqTYc/g0D8PJ+ZSjgD6zr+wGCjskJcCqcl7BeAQVgo43Kvjg/36OPseLNXh3lDk
         qZW4EMnkl3FToG2hSrLyliCfntoIlwAwN9s/JT3FK1j0KIfyQHc33Bi2kUA7RmzVlzSW
         EQ/hnjRUZH/21ebBzDvkck6FJNGvJiN4lzFqxIBEdKRq2pg2gNeZ3tazxQgLh4ZM8oww
         x15g==
X-Gm-Message-State: AOAM533fU5CHl+P+ogE8r5YUyz1FZ8clCuqDYWUwfnIY6S0AE4e0EkDU
        F1pUjeB5p+T2odtsvZBzvHJJtr/+W3FR/N/NuFA=
X-Google-Smtp-Source: ABdhPJxuJaGIvrE9uq1SX4zvjtYnSFlNfeIS0I18rRH/PF1YSN67SU7yh35mR0Rb61dbQ2IBJBOyF1sPRssRRDIZuRs=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr5256224oia.160.1590757132004;
 Fri, 29 May 2020 05:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145513.194440-1-jwcart2@gmail.com> <20200522145513.194440-3-jwcart2@gmail.com>
 <CAEjxPJ6UxEaNkZt4sdCfeVd2amr1fxE97d4jWRD=nkDif=oz+w@mail.gmail.com>
 <CAP+JOzTBqkDgqizyLodJk09-Ru3Kr54Wp=gOO-s_K+ZVX=cu+Q@mail.gmail.com> <CAEjxPJ5BHwcAW8hRu3e8EP-VoykBSQiJTcw73EKTAFMRu7d6HA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5BHwcAW8hRu3e8EP-VoykBSQiJTcw73EKTAFMRu7d6HA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 08:58:41 -0400
Message-ID: <CAEjxPJ4tAcaq1L_vuOqhK4L+34-JDD2aSLu9m+MuLp--h=cxWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: Improve writing CIL category rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 3:23 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 1:20 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, May 27, 2020 at 12:44 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, May 22, 2020 at 10:58 AM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > Improves writing of CIL category rules when converting MLS kernel
> > > > policy to CIL. No changes to functionality, but eliminate useless
> > > > checks for category aliases when using the p_cat_val_to_name array,
> > > > find the actual number of aliases before allocating memory, and
> > > > skip the category alias rules if there are no aliases.
> > > >
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > >
> > > This series looks fine to me but do you have a test case that exercises it?
> >
> > See attached.
>
> Ok we should likely try to move some of these out of tree tests into
> the set of tests exercised by
> make test in libsepol or checkpolicy or secilc and thereby get them
> regression tested by travis-ci.
>
> Regardless, for this series,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
