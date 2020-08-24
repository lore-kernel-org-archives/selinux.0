Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7734C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94644206B5
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilyzWk1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHXNrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXNrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:47:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6ECC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:47:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z18so7310337otk.6
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=576XC3om4ZVPmD54wz6YPM8erRhK8SLR4ZtQa6imqWs=;
        b=ilyzWk1eLJzB51TuLJW4jJgGuvzefo3FZgdbt/WlAIRTvCnrPaWcHNRHF3eusaCB8O
         OL9X5k2JPXmrJkVNz8s+u5bFXltVcI0PTZB6If5wThJVaSTvN1YY9CQfjXn3O1DXq085
         hSCyDZnIf1Qz34OJdRJmQ/hKnAU+y6mDOYGrudMbUCSLiMxWyQiEBgC6gmPvin25/DXw
         Cha3LVs+4d0CtU3ExD5iZJGlBmrl94hDMoGagibyXxeEDjxXbDH0qPWXx2p4WDB6io9+
         Ml3oTvivyrJyJ0u3YZOPIF5ZwQiLRHd86clx/aazqZVk+9VLrMoJ6dUPm8P7A63GacDY
         4yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=576XC3om4ZVPmD54wz6YPM8erRhK8SLR4ZtQa6imqWs=;
        b=D1GTsp5DpWz38NA0l+Nteda7OhRK1dLpmjOrrOqJ+ouPWwgJ314lZRloNRTCwYLYWG
         TS8FhzEyE8sNZmSF/4m0MwgbNqPpPp3uNNn9xNTVEfC0ZQs6Zhk4Bw2ESu8TQZy4hMXP
         QfbvAOAkMpiMF+yF1+8q0gUskvNhrAY7zRYhQBJozzBDRO2q01NFXOdcp965lmgXpu1o
         hcyXMHsY+lJ3ikzbJ2C7kuAKPfIFoV9NsKr7tqhjTBipbrcr2EeFVm/SlSmhWxyNvgqT
         tp9XzLP2R00NZ5pnMBpm2Hd9SajDim3HP6bQxNmcX6f/24RcmdN4reYwDCpzJEuudYuv
         t8aQ==
X-Gm-Message-State: AOAM530T6EKqRmXYLi3UKUwqtq/crnul9Rp8PNDLfRE6pIh+6SBcKHUh
        HaqAp+rtHSv4RFO0c+9Y9w4KmIM8JfwV1BmjGnU=
X-Google-Smtp-Source: ABdhPJxnQMgAEBOtVm3QmW+eLB22scyg7W9sWptvOWsSEcmXC0pBEb7flZdZebtUtL+3DXWuLIOn10MGva6a7kAUzU0=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr3615637otn.162.1598276821635;
 Mon, 24 Aug 2020 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200819150534.18026-1-cgzones@googlemail.com> <20200819150534.18026-2-cgzones@googlemail.com>
In-Reply-To: <20200819150534.18026-2-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 09:46:51 -0400
Message-ID: <CAEjxPJ6Mr3-A8j6+3abwghfQKQ=Q-hCKd4PNSuA_QVCjk6jyJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sepolgen: sort extended rules like normal ones
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 11:07 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently:
>
>     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D sshd_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t ptmx_t:chr_file ioctl;
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t sshd_devpts_t:chr_file ioctl;
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t user_devpts_t:chr_file ioctl;
>
>     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow user_t devtty_t:chr_file ioctl;
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow user_t user_devpts_t:chr_file ioctl;
>     allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };
>     allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;
>     allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x540e=
 };
>     allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x5403=
 0x540a 0x540f-0x5410 0x5413-0x5414 };
>     allowxperm user_t devtty_t:chr_file ioctl 0x4b33;
>
> Changed:
>
>     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D sshd_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t ptmx_t:chr_file ioctl;
>     allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t sshd_devpts_t:chr_file ioctl;
>     allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow sshd_t user_devpts_t:chr_file ioctl;
>     allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x540e=
 };
>
>     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow user_t devtty_t:chr_file ioctl;
>     allowxperm user_t devtty_t:chr_file ioctl 0x4b33;
>
>     #!!!! This avc is allowed in the current policy
>     #!!!! This av rule may have been overridden by an extended permission=
 av rule
>     allow user_t user_devpts_t:chr_file ioctl;
>     allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x5403=
 0x540a 0x540f-0x5410 0x5413-0x5414 };
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
