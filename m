Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54AC433FE
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3E9610A2
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhJUPOO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJUPON (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 11:14:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A1C061348
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 08:11:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so2444438edc.13
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ls3iUZ6dKtQociD6OqW3VtpmcHGMg13OKJ0PA2Nx9WU=;
        b=luGXLJdp6CIy8jt36ccrhP1M+2r8AKm+2YfOI24LHvJrqZrvEDxR3BDRdTc2CxXSev
         w3DSJ7YHN4eYkoGGyELskYfLd3PMW8mELvEhnUIAP8WPtCl4YO4DGiFzXXs3JFlF0KpR
         Zmy82mGG93GniM6kgZUkReSZ4wpdeWcIr3hgUqDw449y1Chv34VbGJuNzkohJhJHRCCS
         qKLZ0O7+/IW6JGFHDslJt97dIgSCe/211VxRZjUgfSNggoMvbe/VXrr33b8LAmy8Uq2B
         xJ6bxjRjOYc3MNfFMKGoR/QXNE6PkapbHwlW/vKhEN5ZAFNXWVims4XaVb9IBGgNX67X
         QNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ls3iUZ6dKtQociD6OqW3VtpmcHGMg13OKJ0PA2Nx9WU=;
        b=vaviChvB8jQ2fQuLqEFUdv8ig4WdxTRE0oYtDIBc49eu/qUN8cvE0p+qUOxY1BOE5e
         6ihM6DEkXsgxSLVLBA+gGf/yNM170fnsVGTYx91PnZlqKwUagjaE8R6qxvl8uylP2gTQ
         F4w9zxRH6HGuYQ4uM49Hxe8X4WPzm0rAA4iNsTHGeej0qPceXu4fbKZEABjgNi7Tfefj
         Aiif7w9f9oQI0yMxxaUXQqBupOhq03OC33il5Y5GTcPrem1kP3jMb7BC9nKfCtZ19yPE
         /AMWXthqeIEcaem48dD5EghSRyPbeX6F78i/WaIsAHJVn0gwa7+cgkbqCgz3F/n19XsO
         Eb7Q==
X-Gm-Message-State: AOAM531SlWYIJyvajvxU40kuS85MtRgjRDnEFGLiiO6HTLoj1C21Yerk
        FiICBq079pSyQTyYkZAPdCbGB1xqvy8WeLhGQzz5
X-Google-Smtp-Source: ABdhPJwW2q6ix1LnCKRmDDwGIBULG3NPy6zvXiObUPK3AYMBtjER+mnArdMxoFg01H6yOgjA9m9ml/gSlrUD7RotY8A=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr8260770edd.101.1634829115770;
 Thu, 21 Oct 2021 08:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211021144543.740762-1-omosnace@redhat.com>
In-Reply-To: <20211021144543.740762-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Oct 2021 11:11:48 -0400
Message-ID: <CAHC9VhRzAzmw9wif=p9N1Ym3sdq4c+0wQx5bXgHPfbtr1RBEWw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: add client peeloff tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 21, 2021 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Currently the testsuite only verifies that SCTP peeloff works on the
> server side. However, it can just as well be used on the client side as
> well, which isn't being tested (and actually is buggy at the time of
> writing).

Can you elaborate a bit on that last part, curious minds want to know ...

-- 
paul moore
www.paul-moore.com
