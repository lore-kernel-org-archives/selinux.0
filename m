Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D2C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A50B64E20
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhBXU3I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhBXU3H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 15:29:07 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB1C061788
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 12:28:27 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id y21so820656oou.13
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD6sVI2jN0ay81VbvhWa+WG15NhmBmZpDDSfz7d4Wic=;
        b=km8pMnpMFtmQBl/rN2ACivcYTxz38oPDPryEg+lDEDTIKaOkj9mAmh9eAu8i9Ld8CR
         aFkzwi8K+t57QpCLyd9leOLwV+2A3QH+X4BQItjOHOhd7vhcPsMtrqlFLV8hXYjqC41U
         wbDveabgeQQDhwxRtWaIU/4Wrb/4SgBcKdTFLbxEOPOA11UqkP4+PK3vT+rdBdu/FzRw
         4n0F06lESCL3wYJSR/SAUg0dmsk6Z4GD1Dn8Pz2eq387LIX+yHfpuqb4HxkvFiW1LgmT
         8ecoeR9KL2m7CFYbFDM2tXSv2cmNP1nCgUxn5eL665uNz7DugSHc4He6GiYq/oIDBhgx
         bHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD6sVI2jN0ay81VbvhWa+WG15NhmBmZpDDSfz7d4Wic=;
        b=W9lXMj+nYBrj4E3lIRf6ubCJFBaUx6zVGEDh+c/flX6ODjhghX32se7ZMUwE/xm6Lg
         lbUTQltAZx9HQWFtPPMzlu5NS9Tf7ll1LeKLr8wB70Sh+T34lXKFBd+M4h6RKwdC4TiL
         CrnDMysqpomLuzo6Ts+LzB+oPO9QG19o46nJqsmpyFPL4XUEcoGOL5qjpLVdqnUp8Cn/
         ClkUGZwXDYJ6hvJmarqNtXGlUexQfoGxSGer8xT5J8/L/8pNtpqYvh38OHZWhrByPN7V
         9OulSsuOAwIzpwdzgi1i0tt8Z+sY1L71r0L1acX2soiGgk4uUg2N5R7+ON3GwTk2X1Yt
         J/Lw==
X-Gm-Message-State: AOAM532+6RijJmkz1Ygtn00r6Tr00Ef/JgFL2+LDNnsbrdlx5cKr7kIz
        HGzCfklmJV19L31A/CCQQ7oicCIja77hI3TtcRQ=
X-Google-Smtp-Source: ABdhPJwmCJrzyhnMdCZrdIK3ZfESM4ZCeAquh6BpwbNb8Ii4AjKdcec5GOU/SkkwG5R2ZOS6knBjBZ+yvWB+oTiBAjU=
X-Received: by 2002:a4a:aacd:: with SMTP id e13mr25027398oon.35.1614198506997;
 Wed, 24 Feb 2021 12:28:26 -0800 (PST)
MIME-Version: 1.0
References: <87mtvt1c40.fsf@redhat.com>
In-Reply-To: <87mtvt1c40.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 24 Feb 2021 15:28:15 -0500
Message-ID: <CAP+JOzRaTYQy35v-eZgNkvrce5B0kPW2DCCdzTBEh+VnuYXUyA@mail.gmail.com>
Subject: Re: Rename 'master' branch to 'main'
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 24, 2021 at 2:49 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> would there be any objection if 'master' was renamed to 'main' after 3.2
> release?
>
>

I have no objection.
Jim

> Thanks,
>
> Petr
>
