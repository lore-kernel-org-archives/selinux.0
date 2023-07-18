Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5FCEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGRWBR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGRWBP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8319A1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403f65a3f8cso9822411cf.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717672; x=1692309672;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VFdIk0BvNVWoYcBJ7ZJ98kMSLfELMJH5H472QJGTXg=;
        b=A9TM+l85HCHNq7zpcZqNMc3rbC/8lCR4yIFotyS0vKA0QlCMZeAkF/zNuncwsOnw2W
         klAs8xWFilvejg5KYt8CdVteKpT923E7d4g2TYVzMdqtuReJV9H1Mp0DVyIlHEYBCHgU
         uiyTV7hkTH88X9jH96WZAg1KFePFG3WnJ40nKEPYdth2CaCc03WiFHSFbZnGBdy6bif8
         /tsqz98vY9djrJJtZxyy5ZB3G0XwnF57NXbCTSkb4Uu+gJEecF0mbUGv96NVCM3hE7Gk
         +JkcSqsHmXwAcDmy5aFHj74oGxyuta2G49qCck2wAPlt7SKpCLEIB2EWFqMZtRxob/uu
         RRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717672; x=1692309672;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VFdIk0BvNVWoYcBJ7ZJ98kMSLfELMJH5H472QJGTXg=;
        b=ZsfQdccfH3EKipEYDm0cENlyZvvViD510hK/M9rLG38j6RaA2UWKcipHxWlbagmr4F
         OzOUhwPalR2bB6FWOiDKXUqH0Fd52p55iyFUiZP2ztoO9coYojvsMqWxHK4TSdu76Vwq
         Fo13BRHWvFg05H3LX1R+C5oPiogyAxn1a2zVaVPGlBejrEkdlW2w8Sj+yLxIPEa8EhEW
         /iEkGj0uMBji9z6Cc80KzdUiN4J1EivYCXM7U6cvdGZwGjXf2Kjq7Dfw8tHqyHWjwkSq
         W92WIy2N9+LcSyAvkSX0tFDkAIWIOwn2dhTI1+i8l4qjbKyGMSguMayzGmxjp9P6/Wv9
         o0Tw==
X-Gm-Message-State: ABy/qLZI5Zt6aMs3IMzclw1Is4mNWhXlLJzkKWPJRF1J8e7TvPdwvodc
        sFINcZyWHaeCQ9l4neSuPcEA7A4mGVFp+WGJZA==
X-Google-Smtp-Source: APBJJlERJct4N6ZM2ahrMDZI+M8aEZyZBc5wfj2jyYVzZ9bJvEFjqlY6u7w/hM/zPNoR1c+FyimniQ==
X-Received: by 2002:a05:622a:34c:b0:400:9126:3f16 with SMTP id r12-20020a05622a034c00b0040091263f16mr22445850qtw.1.1689717672136;
        Tue, 18 Jul 2023 15:01:12 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f16-20020ac84990000000b00404f8e9902dsm5253qtq.2.2023.07.18.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:11 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:11 -0400
Message-ID: <c789aced1f7d6989af7832c672c7a23b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH RFC 0/20] selinux: be more strict about integer conversions
References: <20230706132337.15924-21-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-21-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 

...

> This patches utilizes the C99 feature of declaring loop iterators inside
> for loops, supported since Linux 5.18.

Unless we have no other choice but to declare iterators inside the
loops, let's avoid doing so until all of the stable kernels have moved
past v5.18.

--
paul-moore.com
