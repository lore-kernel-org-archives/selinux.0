Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C8FC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B312076A
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQbHhKI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCZPsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:48:01 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39135 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgCZPsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:48:01 -0400
Received: by mail-io1-f51.google.com with SMTP id c19so6525678ioo.6
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVrvvPKZDDcbKbGiPeHo32rc3IBtGGpL6LPPeh+r320=;
        b=vQbHhKI2QrubDpv3ZdM14dlsPTpoxp+p0MD5+gwfDhZsCFTbXKpmjLhejNEDCp2OcF
         AuqDrpRZ53ky4hZjBIqthlb70zsU/GmvZQV9tuaD4OPAX7/aqm4QqM8ct3rVqUsXUK+5
         ZwM4WHrB6EjyqKe9vtsjo+V9sAmM0A1hNLe02UnrHlW9qijedz4MZ3oA19O9UMD0qZmK
         2XMQ7/QKfPUd30cT1RFbWW8OcGuyGH1h4VMARQAd8caAUdLVaT1syh1Ycwb8fIki/r/1
         uSgStZK4juh8H/eBggEIEauSgXWz8J2j/t215V4ymEkBkuaEqP18q1rb8u52q6BaJCcL
         FxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVrvvPKZDDcbKbGiPeHo32rc3IBtGGpL6LPPeh+r320=;
        b=RaB4yCyNMwqnt6EZjqqqy7wXhkwH5HI+239L/XE3GirvdJDIqHubNuCHJAEzjcdOxz
         +6aMaEIqBE3slSUoM8B90boD5LNUSlOnX17LZAO2/vkFKjg9yhOEREzObzi6FEBvytwZ
         GXtMFGM0QuKKKEMCybxmIsQxs+kk22V6w+Qz7J6b/9XI6JQDBSuAiKnQ48M69/4NgRw4
         7qQx+fTgyNIU3U2YUtqZvKykodf8wmltOr1nAFK/YoXFCjq45ScQW1+f+2Ioh3RwRht4
         3ClNAoJyEO/yrHFQpPIZheLAqyCc3lN/elyRrSPurhx77Fz7111Izh4BCHqtyJEANqwE
         R/mQ==
X-Gm-Message-State: ANhLgQ3cNqwxmpNXpqyQ4unlHsc2TJ5Dtj7eL9xt3MM0YVVQhOnNEty5
        K76dwqO8sGanyPYqIWO0gJJzcNeoTAmR9QEtn6M=
X-Google-Smtp-Source: ADFU+vvsWaoL1g99EvbTDNOIcucRirP4k9XW6vxR/lFX1bcax2mzZU8w2M/CU4739tnMcw+1Z3J1tbdEpnnQ05Tj0tY=
X-Received: by 2002:a02:bb11:: with SMTP id y17mr8733404jan.130.1585237678563;
 Thu, 26 Mar 2020 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com>
In-Reply-To: <20200326154641.7253-1-william.c.roberts@intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 10:47:47 -0500
Message-ID: <CAFftDdp8Us2aSmAD5Q+MR3y6WvR2QAbC+_tFGmCwZbWh+0CBTA@mail.gmail.com>
Subject: Re: cil: Fix DISABLE_SYMVER support and drop last dso.h
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Josh can you run this on Mac build, I don't have one anymore.

On Thu, Mar 26, 2020 at 10:46 AM <bill.c.roberts@gmail.com> wrote:
>
> I missed a dso.h file in cil code, and broke the DISABLE_SYMVER support.
> this deletes that file and restores DISABLE_SYMVER support.
>
> Sorry...
>
> [PATCH 1/2] cil: rm dead dso.h file
> [PATCH 2/2] cil: re-enable DISABLE_SYMVER define
>
