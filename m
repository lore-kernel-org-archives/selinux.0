Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10DCEB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGSP2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGSP2s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 11:28:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A4BE
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:28:47 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5768a7e3adbso14179777b3.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689780526; x=1692372526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZqxBoihuKM1j0H2TsOWj7G6busyi2ZI8SrsSezPsfE=;
        b=CumoM3l8kTzsdAFyaztIXyT8ZcwssDPl8N2N8w06F7CytsX+2B45AROLpMZjD3vC1f
         JvO47zotR6CfGQd/BQMCB2OqxLOnxKBRaxyN2ewhmH2CmmRFozdFescbeZliuMkHnnmV
         /OybyXpVWqkVPqWqSs9pYnu0+VCOKPN9h2Zo/Eki9Ls1ETR7uuaIJCuVZA6uSLg61uGJ
         1aTMtSlHurqUO0tYh2gwatNAdJjMa+u0R8lLeKqcO4feQsAD+Qjhz0d2RIaRTW1laheG
         1z0oOnUsFh7+BoaimToMiQnQRy3J/HCqS58w2c4tIy3HKmIUgzajIJbkc8K7/dJxKNd8
         gc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780526; x=1692372526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZqxBoihuKM1j0H2TsOWj7G6busyi2ZI8SrsSezPsfE=;
        b=kekW+SP8+foz9qFhpzBK8A0IpsiQW6GT2+juKDxZ7IPOGwQZNa5ava1h86vpxdYZNd
         e+9+B7L/jrFNY2/xNFpU07VkTue3rxeFKxRDXdXZKolcAQeqHLqyInXRKN/ze5fRbuTu
         trk6VnXkn18JHK3UQtJO62PBBX/jPlhAWJ57sLMGtCUN1ni6AnSbe5PfpmUpZG/Ul3+W
         v1bNPTXtldeyc6cRO7Lm8x2EX81QqrUIA/oDMnLf4ksKeVpY2aGFa3RPxrUAuLfZbnH1
         3bc6K9ZBij2Hi94qhnXvKjroz47H81ZelUPwqrZZHX6V2EFqpow3x45/+120BjIv3Wxk
         vldQ==
X-Gm-Message-State: ABy/qLZAlaaJp4yX0dxmBkKfJlYJIYiiYOwUu/wW/2p9xIy6BIRlhrEX
        GA3uRaJewtHFQ1CJyiRgYmxVE6icS6w9Knm25ja0220qiNpGJRFCjw==
X-Google-Smtp-Source: APBJJlFoNggiajWPcYibr87DY/DfDFaIRlfMac0SIBps3Scv/EKSYiSCqH52sRWjBv6u/Zjts7bFMGB4VAcGhAYquf4=
X-Received: by 2002:a0d:cbd0:0:b0:577:186c:2a3c with SMTP id
 n199-20020a0dcbd0000000b00577186c2a3cmr2516484ywd.19.1689780526575; Wed, 19
 Jul 2023 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230719151249.11818-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230719151249.11818-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 11:28:35 -0400
Message-ID: <CAHC9VhSgtERPhkCzDA6mjbTsKA1h1+O-xszmhY9h1bbLNTYPtA@mail.gmail.com>
Subject: Re: [PATCH] selinux: update my email address
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update my email address; MAINTAINERS was updated some time ago.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c              | 2 +-
>  security/selinux/hooks.c            | 2 +-
>  security/selinux/include/avc.h      | 2 +-
>  security/selinux/include/avc_ss.h   | 2 +-
>  security/selinux/include/objsec.h   | 2 +-
>  security/selinux/include/security.h | 2 +-
>  security/selinux/ss/avtab.c         | 2 +-
>  security/selinux/ss/avtab.h         | 2 +-
>  security/selinux/ss/constraint.h    | 2 +-
>  security/selinux/ss/context.h       | 2 +-
>  security/selinux/ss/ebitmap.c       | 2 +-
>  security/selinux/ss/ebitmap.h       | 2 +-
>  security/selinux/ss/hashtab.c       | 2 +-
>  security/selinux/ss/hashtab.h       | 2 +-
>  security/selinux/ss/mls.c           | 2 +-
>  security/selinux/ss/mls.h           | 2 +-
>  security/selinux/ss/mls_types.h     | 2 +-
>  security/selinux/ss/policydb.c      | 2 +-
>  security/selinux/ss/policydb.h      | 2 +-
>  security/selinux/ss/services.c      | 2 +-
>  security/selinux/ss/services.h      | 2 +-
>  security/selinux/ss/sidtab.c        | 2 +-
>  security/selinux/ss/sidtab.h        | 2 +-
>  security/selinux/ss/symtab.c        | 2 +-
>  security/selinux/ss/symtab.h        | 2 +-
>  25 files changed, 25 insertions(+), 25 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
