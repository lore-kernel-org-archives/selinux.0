Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98FC001B0
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjGZPdb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjGZPdb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 11:33:31 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647CB5
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 08:33:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so7478955276.2
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690385610; x=1690990410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjfRFTtLTwuOwQaDRF2WUF+prHDZXG6s1rD4JDcmzSA=;
        b=F286KToGmPdQiNyf43PhC0Ax8rgy1Y8lNu+8JkYP+h1G0cAyDJSh8pM57DJD/214Ze
         VkdQsKQuGzAN4EOqmGqOGTtlAHhcUv/WRDYWuxtc/rGavcE4OwIXMMj1YfI2mjUs2XGc
         ismXMQ8B6NR9dhEtz/HlLDnoG5akK8bWnbNEg3c9mMqFLzMK4mhO1GA45Ql9wW98bmHG
         28MIx5Ib6TEl2HaMedLF6mduHCfCQTmzlIa2tIRRAh3XikRZAVrMU0poLhJ/dYSSN3BI
         h0D1LfyTBNtzQgh/leVGLjSJD23OSIOuQdlvyQNCnJGtnI0gYsk/NgfuUzKy7ayUz8Ju
         EbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385610; x=1690990410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjfRFTtLTwuOwQaDRF2WUF+prHDZXG6s1rD4JDcmzSA=;
        b=e7ByKasQcwjIfdB29VmbaIjwMiOLc69EBCWQQPmST/MHaJ2yZmYqhoGOsg6w/pzYrw
         adqFvnsYSCInTS3jSZLPywomBkDtoFb2FBq3j+XKgXbJiuFraGK1GNSf/36s4/j9HTxz
         qAkk9gP4HeJtdH9kPKc5ZnNGD/nMAZ8QYhUBCjzDeQzfQr4N/uIgkxo5KZujUE6iVbYE
         kF7Ko/QVtiW/J5hQgwmphdKQEOyDH0f2rRgGCtxW6G++pRnRSA/9bSO5GckkglW4CsUk
         gqywyuvAyF5ehtLe1Sd1J6/0U4ZBaeqPvM6phW/9pTzfuT8SPWtD52pNRJvkSlkqwp+8
         Gndg==
X-Gm-Message-State: ABy/qLaHw9EZReYi2KNyJaZNf1Yd/8JUm8LTOMNfCqW+GFJJ+6rcvFvN
        1EigB0UtSC818tzL4JfxGAcyjmZBL6Yl2NDWc0Kmvu9O3G1pT7s=
X-Google-Smtp-Source: APBJJlHbAcZg6uUYCcbO9RtLUiwcnVpnk6KRRgg6At38n/oiVDhc6pmtVTmond4F4IDlpV6bnzlfdvPjibgRz3HHbh4=
X-Received: by 2002:a81:7242:0:b0:583:4f9b:27d7 with SMTP id
 n63-20020a817242000000b005834f9b27d7mr2057893ywc.52.1690385609752; Wed, 26
 Jul 2023 08:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142549.94685-1-jwcart2@gmail.com>
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jul 2023 11:33:18 -0400
Message-ID: <CAHC9VhR2MdM1nvb=8+HWuwuwA99-zbj=pEsMZ94ewhaW-b1aPQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Revert the prefix/suffix filename transition patches
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org, juraj@jurajmarcin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 26, 2023 at 10:25=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> Since the kernel patches have not been accepted yet, it seems better to
> revert these patches while they can still be cleanly reverted just in
> case the kernel patches are not accepted.
>
> If the kernel patches get accepted, then I will re-apply these patches.

Thanks James, I think this is the smart move.

--=20
paul-moore.com
