Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D0C001DE
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGSRkK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGSRkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 13:40:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0310CC
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 10:40:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5577900c06bso5397376a12.2
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689788408; x=1690393208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOOfKh8VF2KxQksw4uRuHbrjoMkQ+dvjxk0oAD3QU48=;
        b=ky/DALolj//nIBRKWYnv6fnnxId3Iz88tJFXtupFyKwL79SD6xymxSG+ROyEe+dRcd
         B1hXU2F8CJFRrLLXZQpbJzwg+WmeuYx2R3mui7vd/t2ddEmvXqD+Q3yyWtl9BNUOBp+c
         zSsmi/k/pkhONA520AR0bm5UvH+YfEKTEUGLJroVz7VdT4iau00IC2/zEmRqd24Z9/KI
         xuukNOMXbmVQu/R7PZiQmhIJAFoiCJAx2DuZWhij1c+n9zLY4OH2pndIFdmBv22CHcrT
         sN0sx0W4PYAvsG0pmjX67hGuMCj1yMS72sRMaQjpaaa8YC/kcm4U16xsICHPokA9rjaz
         NVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788408; x=1690393208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOOfKh8VF2KxQksw4uRuHbrjoMkQ+dvjxk0oAD3QU48=;
        b=LHlW3gwTNf9sPYYbN02rDk3Fvds/LY9ku5ow8y2CJhAVRN/5jSEZcLdcEuxA+1ao1N
         jOkQvLKfwRvR7N+lvAo/x81NZk1N14LXbxC53eGtvZOQTjpTzWcKZQdDs3Xh3AijtK8S
         1GKv2uvtmsjk2YKlMDF6MwXM2nugirnh+WEVgn6MSnE1H1d3JmcUWKLVbY9QbftJQrP6
         l7T2K1AemyDpvuyueO9eM4myye9OLX8pjGXZBBzPZE8JBXlXEXGVK445xDadaLN2aJvu
         mfQY5t3Oxx8dX9z2G0FAwid7/1FsTPgH5f5dkqABur1lj85/Vk87ObLLHKnvJyHatJ7k
         2Szg==
X-Gm-Message-State: ABy/qLYPl9a3Yhh4LLktjdoRywTk+YFFR4qrrApk2q8AyJf7WwXvtaNH
        5c+e1Tridx56IuGm/pJkHyDCOZF24IBxhqMuDXqS3Wbu
X-Google-Smtp-Source: APBJJlGB9p8ERzxfFhF+TrXBLALZFqTa0xHBgI8eNopiAIHedKFQAYbvKC4f5cLDpIpb+g0dfesKCMZ9NolBznOymCQ=
X-Received: by 2002:a17:90a:1f05:b0:262:f99b:a530 with SMTP id
 u5-20020a17090a1f0500b00262f99ba530mr17398902pja.34.1689788407811; Wed, 19
 Jul 2023 10:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230719173635.934-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230719173635.934-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 19 Jul 2023 13:39:56 -0400
Message-ID: <CAEjxPJ63j3TjkYrT1yppFm=W39cFq31H1VzDX4-hzRpyTrmazw@mail.gmail.com>
Subject: Re: [PATCH userspace] checkpolicy,libselinux,libsepol,policycoreutils,semodule-utils:
 update my email
To:     selinux@vger.kernel.org
Cc:     jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 1:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update my email address.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Forgot to mention: I dropped the references altogether from the
checkmodule man page because that was wrongly copied from the
checkpolicy man page; I wasn't an author of checkmodule per se (aside
from all the shared code it inherited).
