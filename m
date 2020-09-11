Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F46C433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769FF20770
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oqr1kcUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgIKPP0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgIKPNV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:13:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD1C061757
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 08:13:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so14279997eja.5
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfILp3cHFohaPb0/xhMlXcP9+sPGJeGrRj86Qnw8Q6o=;
        b=oqr1kcUVx7ZhbYQcZe5EVAyRq4WyKBjwXttPsLgs9/32kb39dwoNkc9StJ6dIiDwFu
         yn82Nbs2hXHffedoCx05Z99ULF0l6nB3TGRP3nxnmNswRGl83TzS+VgHeKahftm66nkB
         /BzcpwhcCb/2NCT1/S5KbF0irmQdEx7m7Pod5E3fvIw9EtCrYldJIpA7OcAnfKk34t0m
         35SzFZtwy1jI3/sV1BZZvEAGJuwCVQi5uKDETKZgLpQp889GH17dzB6gQjmsOPiaoYyg
         TNtiL6Ack3hTIsZuXbNV6hm9AkXeEYuul+xmgZP96JJmCnG7vvunFDkkVKlk/ko+bD1t
         EAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfILp3cHFohaPb0/xhMlXcP9+sPGJeGrRj86Qnw8Q6o=;
        b=GyiNKldPdrBxWeGuR76q042Qv1X2zYY9hHRb5x9xxES8tEC16EbE0evojo8z6eGM4x
         87ctB8R2YMCl69IwhUGYl73PgA5B2qQIJWqDHfP9KlsAadpRTzrD70jJ+BmYVdsvR4Dc
         FUo1r3Rtq4s0e0ygVOVVqrkVUduGOAHrYv2YmMNKTJjMCGlAQ8/rtouH1c1eWMBGuW1x
         NacUumRhveZV98MSMdgNsVF8qskIMSZ1KNNDCPw1aID+mo8tzjknRbsPYJnHFtWAy9L8
         hyekZdSo7fK8OI/PM4Goq55N0oa5G0U4PPU8ttIGP4NNWK4y+/wnaLXmDvzBoDUIHsJn
         kbuQ==
X-Gm-Message-State: AOAM533QMB5zuzC6OlB+YUOb0P+79EC8ABb2Jyt+mDvTHssvVaXargsC
        rpra5z3geeBTus1XxwrqGa7OVzPZPYyS9yymss6O9GfChg==
X-Google-Smtp-Source: ABdhPJx7lNmegV+YpIUxtvFSOx6qkh/hxlt3CxiJeybjHT3b5Abj6GU/S98s3OqebL1S1gG95RJ+guVZ2Lj0TGJ64WE=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr2347421ejz.431.1599837182353;
 Fri, 11 Sep 2020 08:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200908074003.3526-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200908074003.3526-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 11:12:51 -0400
Message-ID: <CAHC9VhSAynQwuaMXiqfmds=eygw-5ybjuhYBjDfRS-PdD7o5uQ@mail.gmail.com>
Subject: Re: [PATCH V2] network_support: Update LibreSwan configuration
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 3:40 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Update ipsec.conf file that describes the labeled ipsec entries.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change: Update encryption algorithms and add note as suggested by
> Topi Miettinen.
>
>  src/network_support.md | 45 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)

Merged with the one small fix noted below ...

> diff --git a/src/network_support.md b/src/network_support.md
> index 36af1f4..1103c70 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -452,11 +452,52 @@ Context type identifier has never been defined in any standard. Pluto is
>  configurable and defaults to '*32001*', this is the IPSEC Security
>  Association Attribute identifier reserved for private use. Racoon is
>  hard coded to a value of '*10*', therefore the pluto ***ipsec.conf**(5)*
> -file must be configured as follows:
> +configuration file *secctx-attr-type* entry must be set as shown in the
> +following example:
>
>  ```
>  config setup
> -        secctx-attr-type=10
> +       protostack=netkey
> +       plutodebug=all
> +       logfile=/var/log/pluto/pluto.log
> +       logappend=no
> +       # A "secctx-attr-type" MUST be present:
> +       secctx-attr-type=10
> +       # Labeled IPSEC only supports the following values:
> +       #   10 = ECN_TUNNEL - Used by racoon(8)
> +       #   32001 = Default - Reserved for private use (see RFC 2407)
> +       # These are the "IPSEC Security Association Attributes"
> +
> +conn selinux_labeled_ipsec_test
> +       # ikev2 MUST be "no" as labeled ipsec is not yet supported by IKEV2
> +       # There is a draft IKEV2 labeled ipsec document (July '20) at:
> +       #   https://tools.ietf.org/html/draft-ietf-ipsecme-labeled-ipsec-03
> +       ikev2=no
> +       auto=start
> +       rekey=no
> +       authby=secret   # set in '/etc/ipsec.secrets'. See NOTE
> +       type=transport
> +       left=192.168.1.198
> +       right=192.168.1.148
> +       ike=aes256-sha2         # See NOTE
> +       phase2=esp
> +       phase2alg=aes256        # See NOTE
> +       # The 'policy-label' entry is used to determine whether SELinux will
> +       # allow or deny the request using the labels from:
> +       #   connection policy label from the applicable SAD entry
> +       #   connection flow label from the applicable SPD entry (this is taken
> +       #   from the 'conn <name> policy-label' entry).
> +       # selinux_check_access(SAD, SPD, "association", "polmatch", NULL);
> +       policy-label=system_u:object_r:ipsec_spd_t:s0
> +       leftprotoport=tcp
> +       rightprotoport=tcp
> +
> +# NOTE:
> +#   The authentication methods and encryption algorithms should be chosen
> +#   with care and within the constraints of those available for
> +    interoperability.

Missing a '#' in the line above.

> +#   Racoon is no longer actively supported and has a limited choice of
> +#   algorithms compared to LibreSwan.
>  ```
>
>  The Fedora version of racoon has added functionality to support

-- 
paul moore
www.paul-moore.com
