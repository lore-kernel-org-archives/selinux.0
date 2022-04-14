Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C3CC433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 18:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiDNSzd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiDNSzc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 14:55:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7DDE0AC7
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 11:53:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-de3ca1efbaso6149668fac.9
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKvC+NgwoTA2hZccBkMepg59z4RlfvzEy5BiTIHFFKc=;
        b=lK6xJPX/F/p5KXxm4SwWN4yuAtsUQFvQcA+oek4sXimJAv/cJxhTIalJNHcsSg2PqN
         8OAONVIzfjFUMwc03r6gJyLAzTlmrg7icMIlwmFE4QA3foEgKC2K+eqLy+sUBY/kkTOS
         JvQDWGtEpvZcYcKVCbX27TZMViluDwjzWhzozj9VRs5lP2C4dnbmrZbqPha1kfvEX9gg
         c1eumccwemVualZtK6ub7uuCI2kCfYNiW5c9kmm1jgCRqr6WqU9+J3Q1xUG4rM9GN0Cq
         FZtEI7qMta0/5v+N6SMNwmgtdSp9AQBdRO4wP3zX6wisJl0KyShWsbAe6eUXFOEKRWIK
         2Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKvC+NgwoTA2hZccBkMepg59z4RlfvzEy5BiTIHFFKc=;
        b=CNeI5sVr6nkymMnu+Dnlo39I8Ux+S2gPXGPdjBEA/bTkm/egSE5GaanYfsLv8Msc1G
         mnMeDsVb5VpWUfiHiYRyRH2RYeetSJzI++U9mAfKkdEiNSB1uqM4g/05vrEg6Q8fYrI0
         1BNTuUE/dJH9zAP1GEYY5rcfP+bW0j9rW75QMrqLjOjOftcoff6Megres+VyD3I1yne5
         VrWEIvwrpTk9G7voLCT8lTiQLRzA//BFf+hMqOmIVwklvWtnMkyWsWb3g6LUxaA4Dkrp
         npgN3uMIGmvzBepFofqJ/AGRXCsRHOTDa6Gcxlo3/c6x6F445JpnQe+NORMbMiPJdrdZ
         E5QA==
X-Gm-Message-State: AOAM530RHsnH6G5Y9JCnYBzniG7U4isUPp0g0MYhbPb0qoOSy5fOopun
        dNLayWj3gw6hR2mmhq7Yt9eeQztukI06pwZOLMuEBwtdFH0=
X-Google-Smtp-Source: ABdhPJy6oRlwYyj2Az3AK4GQddVZQcm+0iN5/V1tDph4NsDgHdb4ob4cReOPBXB5aeQX2ZWUA602igfdcZZyFeRUWgM=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr7481oap.156.1649962384519; Thu, 14 Apr
 2022 11:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220413155633.62677-1-cgzones@googlemail.com>
In-Reply-To: <20220413155633.62677-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 14 Apr 2022 14:52:53 -0400
Message-ID: <CAP+JOzQrx0OLTdACuMOucJcTAm0pnDFGYeFkV=XibGqHHfSxXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: correct parameter type in selabel_open(3)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 13, 2022 at 1:22 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selabel_open(3) takes an `unsigned int` as backend parameter.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/selabel_open.3 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/sel=
abel_open.3
> index 971ebc1a..c8348ca4 100644
> --- a/libselinux/man/man3/selabel_open.3
> +++ b/libselinux/man/man3/selabel_open.3
> @@ -10,7 +10,7 @@ selabel_open, selabel_close \- userspace SELinux labeli=
ng interface
>  .br
>  .B #include <selinux/label.h>
>  .sp
> -.BI "struct selabel_handle *selabel_open(int " backend ,
> +.BI "struct selabel_handle *selabel_open(unsigned int " backend ,
>  .in +\w'struct selabel_handle *selabel_open('u
>  .BI "const struct selinux_opt *" options ,
>  .br
> --
> 2.35.2
>
