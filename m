Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D67C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828E52074B
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyFzCmg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgFHP2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgFHP2n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:28:43 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A8C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:28:43 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z145so3534481ooa.13
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Naa9IOMru7r7iO5HmWJICGoj8jKy8Qy5xPJqoqGv8dE=;
        b=iyFzCmg9XcJOUZ0NUTGBkyGKYtEPJDD8pK90V13AiPc3CaPIRnKp72p+qVfwelomvS
         E3mdBHicOUMdNahuT3ejQ43YxphJwuTwP7a6Gk/azj7GkGnvTIBhGgS1PSZYpietX3CC
         0wWICLFV3kZGgeS9ja8TgnhE1UC1msBvrUjNbvcmxQDZHtDxMqhCXmvddez2KzV3w6Z/
         MryevenYnebsWArzXxQgoTqeMJVIYZTVcPnab4XwcHOpyahcio8qcbZlmralei5ggXE9
         CbK4VFtwj66EJFozBwnYowHfq7FSkjaXONWpQKpx23xEKxDDsoUYiMM+rAv4fgZnyJzE
         TKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Naa9IOMru7r7iO5HmWJICGoj8jKy8Qy5xPJqoqGv8dE=;
        b=BetPE7/hSTEKD+rnzbZ+q3MV6tbfTJqYL69zyqYlXh5QonV6+NA6hjLZUsxdP4y/uW
         DUiBRssxulhczqPIbb1vs1G3gnm1ZOsOEleSEPkR/qJbcmbJ9BQscQ00KiqhbHq5qRua
         J11rF5zH1gnw/e7G/Bz64/233InhBHpQDCr9TNhdObUx79dwIAxw3S4lQS+sb7gUGzDG
         rcuMO4eqkElcQqx/1EfZnWFZ0tsDU7fp+fiHxyIfbJaAvsPNoKDlBZ5AeAKi6pBU7wBx
         GFwLnNAPk+N+8w80rmtco2tMRD4IoraXxPv1s9CzSzqm+ujVlfvirhXUpIZAFZ8TEH0r
         Aazw==
X-Gm-Message-State: AOAM53283okdP33/r5odR+LcImGuYrDOTsi48tuivZ3FbXUgmHCg3duS
        JWuQYUBX9M1ek+9NRQvqQRa4hdnPk634liUJ1Xw=
X-Google-Smtp-Source: ABdhPJyPZ2Z9XWQJ+8nLxZ62rNNc+LR1AMVZ00mzzX0Erhwq7cHf+xnhrjJho718/6sfB9wSG11S0kQwTLQp+WCeHyM=
X-Received: by 2002:a4a:abcb:: with SMTP id o11mr15145320oon.58.1591630123085;
 Mon, 08 Jun 2020 08:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200605144912.22522-1-cgzones@googlemail.com> <20200605144912.22522-2-cgzones@googlemail.com>
In-Reply-To: <20200605144912.22522-2-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 11:28:32 -0400
Message-ID: <CAEjxPJ7KcdKcvaGO3QJutSM-rDgJ1w9VzBVcn7Y=ZVcWQ-NTNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] refparser: add missing newline after error message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 10:49 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
