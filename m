Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC47C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiDLSRR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiDLSRR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:17:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A471B7B1
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:14:58 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6ca46da48so21568450fac.12
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d39wkv4dlBFRt1G8rGNpGXD7kDmEHZK1KlFpuMnsu8A=;
        b=DLP7mB2LLYV/O6Oz4PnNxbfR5CdHA0fksR5GZF7/Zm7U4VbdP+32uoJzQB2ug6HBmK
         q33K0kEoQps4kWdkC4n0yZJgX46+BqYbrkmMLHcmJ5e2wus/YkwPOXjrqOetq9oHtw20
         /xV9WEO9048e/qlVW/Ku+1KR+6vhgNYWcQIYlbEth+3D3hKERHE/W1ci99uAUSsgdAM/
         WwsivljQr5LysVUV8yHWHQuTPTVSaAcpwhRuwNZ4uWKUnwnEnvqvy5QjmiRrB1L2UZ8S
         GmOCwU0E/V1NF3N9fG0kj0gcv7lHYM2g4//B8aNP7Te9aAKY/LZwLs4ulEF4EcSHqc1W
         Uevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d39wkv4dlBFRt1G8rGNpGXD7kDmEHZK1KlFpuMnsu8A=;
        b=bBTkOVCBJbqGIr/F9evyAoJ9sqvTdi/0LkRnERGuLeyla3XaaxbFP4CvImZGhtvIz7
         bx3jph0CxDExppSaNyKLXp48BnAfY+Nw9HpXWj+WAKOwAfCUmHTSuPvviKk0cFhY0uem
         f09Z9PEpFJuKoT0ZcHpPOVkP/wnWALxaQ8En4n0gfJqMtqmd+47TXHpmhLqQaQXc7+gW
         CKIvJCkX6HVU67FTdBNKV9vrvlF/Aino6O1Z4F3P6t9ptWVmjsMLga9azbm8R6Cbxm6Q
         wws/JCC3qGI41eIZhFccJ/wrKRE1InpfPGuwTr7r3rmaUZ44pBGMMQl9T9qvJCceiod+
         aOzg==
X-Gm-Message-State: AOAM531ZFyOS0x0fWqlpE5hidHb/iESf7hiyDiTk6ssLBkMRAWTemkll
        4nWvYr9wr5YNp7uP3zNdamQLh3JOrXd0FhNYw3lQWp5E
X-Google-Smtp-Source: ABdhPJydt6+QgFywXZjh5W8n58BdKF0O83tKYfARdRDZEu4LRfEcTDRpFXyvZ2TKb0rSD56qt7fvwLlykHmJVcCZT6s=
X-Received: by 2002:a05:6870:f624:b0:e1:c071:121c with SMTP id
 ek36-20020a056870f62400b000e1c071121cmr2702721oab.182.1649787298219; Tue, 12
 Apr 2022 11:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com> <20220405133548.51598-6-cgzones@googlemail.com>
In-Reply-To: <20220405133548.51598-6-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:14:47 -0400
Message-ID: <CAP+JOzTT3qqF+qNBtvXQcFvVt=rKwxLWqgg2_6JSZg64OdXD-w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Enable missing prototypes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 9:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check for missing prototypes like file local functions not declared
> static or external functions not being declared to avoid declaration/
> definition desynchronizations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

There are still some problems when making some of the tests, like
libsepol/tests.
Jim

> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 215e313e..2ffba8e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,6 +14,7 @@ else
>                 -Winit-self \
>                 -Wmissing-format-attribute \
>                 -Wmissing-noreturn \
> +               -Wmissing-prototypes \
>                 -Wnull-dereference \
>                 -Wpointer-arith \
>                 -Wshadow \
> --
> 2.35.1
>
