Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65278C4727E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1227E2137B
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTvlfkft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgI3PXm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3PXl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 11:23:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB7C061755
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 08:23:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x69so2089099oia.8
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXbXkYYT/LcMhWgcErJ+ECFD5CEzHf4E4NRHTz39ypM=;
        b=sTvlfkftoklqJYY5CAaJDiBJYmSSkWYA13sWT/sCFYherFU/aLOoszzTMMddRE1fe0
         JCQ6Atb7fh3QxchwpMtZsSjZebAMiBjhnGqz7QEU1PkotLB3YgoYAlpRzmIzO91BMkIx
         /vxRhH8uVEZnyOt5bQffCJRrkBKu58jXcNdw4566uEDwfgejppKa8ayWIZM6deGOlw+h
         W9mWscRHB/NkikjURjmirKvJh4gU4nxWjxUifbKe3lO/C/YlYsjqzW/6LwLQQYxFUK9r
         ygrzMXAF1Cdaubcj8PlkUnoAxjxYATBcuST2u7oqW08mXDrHHZN3G7iH3HfnNzZUchPd
         BhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXbXkYYT/LcMhWgcErJ+ECFD5CEzHf4E4NRHTz39ypM=;
        b=ORAGoaS6CpCCmKkE716jNdehuX53XE6oLpwFmH+FzhVF1/b7vak4cwOFBP6TYmzQuj
         RmIREib0QNPlkt4Ua0Q6/rGrOizXkCcyJE84ly7wHQRS5z/yItnHRLWOMugP/zjUOLJC
         FfT9fhgtAcIukaSD1Ib497QdIOwV7kPoqVCujwUyEL6UEbgc2iHXSWARepuBcd2+djxA
         gQRJERlDKihWZ6n/XDhuBra8ppVAsdBO7SavmnBpll3SmHNTbv0bQUcZRVAaaDB/i0C3
         P+36gsdYWL19gUPKaiX9q+f6OeJtMh4jRxtzHteSVbqQMiWHbh3j/NIWBFSvPoZ3Dt47
         3BeQ==
X-Gm-Message-State: AOAM532PMeY2LZm8+VTmG/YdeHmWozHFAatkx3VLhx1hfrTIkVkL739A
        89masQvleVS7izA1ZjF45voKs1eUTDeBcR+7ann9fwah
X-Google-Smtp-Source: ABdhPJz2cOFLZWIFCvTROkMAAJft/E87sLNvE19UP8CkCR9y2EWdpGDphPfHObk8w9GBCxXZemjZ5bXhtlj0CBtrffM=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr1624518oih.92.1601479421206;
 Wed, 30 Sep 2020 08:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
In-Reply-To: <20200930145031.910190-4-plautrba@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 30 Sep 2020 11:22:21 -0400
Message-ID: <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> It's due to the previous ABI incompatible change
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

My only real question is what are the implications for distros for
this change?  Would Fedora end up having to carry both so versions for
a time?  Or can you cleanly switch from the old to the new without
disruption?
