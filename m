Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59811EB64DD
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 08:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHII6U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHII6U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 04:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392F1FD7
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1e0Wt65U4tF+X5Wlz5ZPLccsU8t/PxBlxXrvl2CN/1c=;
        b=iKbino6zRM7xHXaFaX6shefbE4Kyn0mCPsKfdfu9SV1qReBearFzKmjdFfV2sdbeDCI5TC
        8HYT1u4mE0HLm9j1ynFCTBs0z1CcQSkTdgXJEZ00yEclm3tCF74C2NGfKX2LiSbaIzWusD
        1i/EHzW7HeGhc9x+4P/knsHbExo/+Qc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-sJbPHuO2ODyR7_P1q6VYzw-1; Wed, 09 Aug 2023 04:57:31 -0400
X-MC-Unique: sJbPHuO2ODyR7_P1q6VYzw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26824cb0051so6230493a91.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 01:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571450; x=1692176250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e0Wt65U4tF+X5Wlz5ZPLccsU8t/PxBlxXrvl2CN/1c=;
        b=OtT8ih2jWWIPBzWO/9lSCq1zQMRZ/MGCE2+TjdQx9931nFIrf7eRm8Sv5oQqfyScVN
         Y3set6QzgkbLHJeMAJW0PYLrb/BZfUNWMR/1/KRUonuRgVCLGAP/TK8wKnss0xqerewN
         kZe7/icrytsNZx8po8BCpsJQOAL84SNArz7GJH52fD5IDkxrukkY7wCRSFBxjKVGdrEQ
         oVOTP9AtYSeKRiYil1jUvKkE7IC+eUGm07nlS6do+DxzNKxC0ow0C/RyPRlsaQDRqyiU
         +5Oi4qMp1JcYJSkFgN1dtGYjkJNuIosv8rIHxWks77fvqd+DYePrTAg1z810ExNoP+iJ
         IzhQ==
X-Gm-Message-State: AOJu0YyJ82csxllIrChCHkr1JLO02310RrdA3wsdmtr7qlBU/TJkBQ8k
        O67Tsr5ytXCp9SNdr1oFqL2dSWBIkc5iOf/hODRLy8gX4H7vPaAgmbqsnmQobdKLP09pyfDaEgN
        FYYQDr9zEm5D5b62yPkYWEAQ0Fjx6bpsBBY9qMY+0zeAG7aQ=
X-Received: by 2002:a17:90a:ca07:b0:268:d05c:2d7e with SMTP id x7-20020a17090aca0700b00268d05c2d7emr1562162pjt.14.1691571449924;
        Wed, 09 Aug 2023 01:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWysMAT4ZJZCXTz27fkcIfs6v0GuOKeSGrbyWNRtGuifCXNTi0U96bYIsigxwIxjfsSP9/3MaoWHrP5uNTHU=
X-Received: by 2002:a17:90a:ca07:b0:268:d05c:2d7e with SMTP id
 x7-20020a17090aca0700b00268d05c2d7emr1562157pjt.14.1691571449667; Wed, 09 Aug
 2023 01:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230808155010.76584-2-paul@paul-moore.com>
In-Reply-To: <20230808155010.76584-2-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Aug 2023 10:57:18 +0200
Message-ID: <CAFqZXNvMLBrkTy1PAUGGATq+AO_wo3tr6-7ysjLzqK1qgJ2Vfw@mail.gmail.com>
Subject: Re: [PATCH] selinux: revert SECINITSID_INIT support
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 8, 2023 at 6:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> This commit reverts 5b0eea835d4e ("selinux: introduce an initial SID
> for early boot processes") as it was found to cause problems on
> distros with old SELinux userspace tools/libraries, specifically
> Ubuntu 16.04.
>
> Hopefully we will be able to re-add this functionality at a later
> date, but let's revert this for now to help ensure a stable and
> backwards compatible SELinux tree.
>
> Link: https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c                      | 28 -------------------
>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>  security/selinux/include/policycap.h          |  1 -
>  security/selinux/include/policycap_names.h    |  1 -
>  security/selinux/include/security.h           |  6 ----
>  security/selinux/ss/policydb.c                | 27 ------------------
>  6 files changed, 1 insertion(+), 64 deletions(-)

I don't think I'm able to post a fix for this quickly enough, so:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

