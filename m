Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06283C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28C2207DA
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HHpzc0ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgFDUke (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgFDUkd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:40:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0826C08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 13:40:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so7526249ejm.12
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+szNN0W+uW8OMfDviC3B5c0sv1g1qtzZGCkyRBykqs=;
        b=HHpzc0aemqAHQTkLobMT62/lKn0z9R3z4D1DzSQAH3Nqro8rr6zvLRYhCj4blDOwSK
         TrhWjHZtumU3B0u4Ko7Ygo0lAAVasbkHyV1ivJzeBtxg5qIpKJE68TgY4s95XdGAjVLa
         I5VtznaCOx2ch+I2DQs+RUH1im2h8fAYvYmbGoye9fYrcLPp2621NRoocP77EHJq9ozp
         nAZUDO3AiCI6h0cvkUnf9TTjom6P54fugdIXkg8J6xNzdNDvfONYFb9+t45z3ahhDyhX
         x1OCoR/GwfcTLfRcK2m0k0BxcaB3Dl2rqTxTCpJPjbFKwga6pg0QrRSeeJAvVSk0vArN
         unrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+szNN0W+uW8OMfDviC3B5c0sv1g1qtzZGCkyRBykqs=;
        b=tKRwQnK6HyvqMsKuAJMkxvVlchM30skMv4vHjUuNeIu0nNKmrKgj0dv+xD/0iyUwJw
         9AuzOnQBxfvZFmQ+5AvWk5gIjWPK9RSdWX9dq3cJ3OrLt7pGb2GBPKGyN2qP5RLSvn5i
         1l8TLGkOnVt5gtIOn8pTCQ6VpUzjHZSCSE7IsBo1G20TjP2bCn/2rsoFZ3EQ5a2kp72+
         ZclRC2ADZeNIVGlr+4t8udh9KueMmc7ndfyFbl1HiPlAHiQS2+e69g3eR5nyRtExNLKs
         Rys5g0E+m+lO5YO9lKS97um8DM8Fd+fs+ktBrkQqQC5MM4GO9vdmbvDfbTgfXtZdueID
         XqkQ==
X-Gm-Message-State: AOAM5328iaEjoD8fKW+Mlvipy47aT5am/ZKaCdp0fEjDdM2jziKRlZZb
        SyZfx8R3NH5gqn+bpdx2cRPbC4nRG19yVOpbh/qg
X-Google-Smtp-Source: ABdhPJzhxenXfb3GT9eqy0glQWgE76A7rcFbaqW33E+phKdlul11YfQzjSoaNCjhCKJwgpqeQr8qvKls2PcdMBQF1uA=
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr5135806ejx.431.1591303231584;
 Thu, 04 Jun 2020 13:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141935.24722-1-toiwoton@gmail.com> <CAEjxPJ6t2xyQ54y83AN5bMJuHMRwi=4haEFXCR6Fw9JhdqcqhQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6t2xyQ54y83AN5bMJuHMRwi=4haEFXCR6Fw9JhdqcqhQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Jun 2020 16:40:20 -0400
Message-ID: <CAHC9VhRHHOB+kmpg0tjJ5YNyY5SGnobS=HE_QW8PyVURDKFKCQ@mail.gmail.com>
Subject: Re: [PATCH] Avoid using getprotobyname()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 4:30 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jun 2, 2020 at 10:21 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >
> > At least on Debian, /etc/protocols, which is used by
> > socket.getprotobyname() to resolve protocols to names, does not
> > contain an entry for "ipv4", so let's avoid using
> > socket.getprotobyname() since the protocol names are not used in
> > socket context anyway.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Only concern I have here is that it could change the resulting audit
> record content. Not sure how the audit people feel about that.
> Maybe ask on linux-audit mailing list?

If/when you do, it would be good to show before/after audit records.
However, record formatting is a very tricky issue and it's best to not
change them unless absolutely necessary.

-- 
paul moore
www.paul-moore.com
