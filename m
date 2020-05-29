Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA33FC433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D1020814
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toKr1Ky6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2MwO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE2MwN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 08:52:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F11C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:52:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so2403572oib.12
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHyelM82A8/ugWd8jbQbqVD7BLJueSSOrIGOAB8Lfw4=;
        b=toKr1Ky6xfP0wJpaVx+47kNkRiaF4ZVkK6nTnlbbCOmRDEHZEgcsYzPN2+ZJY2SwN3
         Yi4XGOhjgTLwdeI0FLjb8o0tOXpJi/swmW6GZmiCtfNopg/SBa+LOjXGfZG8XfcTD0an
         1prInZF3pWCjMGEUBuwf/aKyurJuA/6srkGhcgQS1wM0Q25gSBtao9Ecwjs+H5gQI4dM
         CWecG7ts+BFQkzfp3udO0+VkaWb/WOlg3ofq16MvpR5/fdSnAO1hx1sKAQZRm8eusTKR
         iTAfBAgjs/f/aEhtk7bktNBRn/nwcFDmm1JOIXWUj8KgMleePvp0QyBpHT8ZhIaIeg2S
         0XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHyelM82A8/ugWd8jbQbqVD7BLJueSSOrIGOAB8Lfw4=;
        b=RygO2Fyl53kd7S3OkjwYnCj3fSNKJElMDs0cvGzrqHhzOAEFzN2NpZGwfZKboUsenJ
         B21Jc1WjgNhCc6MkeWZrs9o/vyp4iMrxpvdo6kjZjScMR+uvSYyV3BfXJ/f2etz2effF
         T+3r8uav1TZAlsa1LeqHcZIZFsvDxuaLTvJWxHJs2JOH6eZL4jxWJyBh39UETjnURec0
         yeI6BwKLthuO8+7E3Kqd5F2BsEcLn1NPcpLKpQc2WQH9vRD3GICTIvRVxE1+yeKHtKiN
         ia62f+o2t3t2mRcFdeWFXTRsTidzVi5iMv3GA5Fi8IC5UEZ/Fdonmx674l5mEGG7DzIA
         aR5w==
X-Gm-Message-State: AOAM531qBkP+JZAnidPVVbjdueh8bZenmfuYI8zN5NpRhzsZGTM4mkGt
        eaRv/+SA2Tk08nJ2r3m3IxuI/Qg40yLuApnFyVI=
X-Google-Smtp-Source: ABdhPJxDlq7wQtKC99WAR3KhKByHNdwLkO40lMAblvP31JDVaD2n1snnBTxi5uLKC6DqBa9biqS8qXbKezYj5pMVM2I=
X-Received: by 2002:aca:a948:: with SMTP id s69mr5556599oie.140.1590756731434;
 Fri, 29 May 2020 05:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200526185058.42827-1-jwcart2@gmail.com> <20200526185058.42827-2-jwcart2@gmail.com>
 <CAEjxPJ4hG5ou+c5BY9g7BMBV1mCcVT5PEpEfuv_4WjNW2+NY_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hG5ou+c5BY9g7BMBV1mCcVT5PEpEfuv_4WjNW2+NY_w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 08:52:00 -0400
Message-ID: <CAEjxPJ6LBzu4PCg5S_cCrG5zKiLKNrWav5v7bFEJUsv9L8=QCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 9:16 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 2:51 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL allows a type to be redeclared when using the multiple declarations
> > option ("-m" or "--muliple-decls"), but make it an error for an identifier
> > to be declared as both a type and an attribute.
> >
> > Change the error message so that it always gives the location and flavor
> > of both declarations. The flavors will be the same in all other cases,
> > but in this case they explain why there is an error even if multiple
> > declartions are allowed.
> >
> > Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
> > Reported-by: Topi Miettinen <toiwoton@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
