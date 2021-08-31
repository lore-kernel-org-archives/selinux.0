Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98CC4320A
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51316056B
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 13:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhHaNvQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhHaNvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Aug 2021 09:51:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BCC06179A
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 06:50:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r7so10918189edd.6
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPX1Cx6i1wGAaNv/FyWRibhoHk490fta5weo1iPmB0Q=;
        b=1dVdeB6E9D4+m134wRVReiHxIto9X5gCIKMBqQuRf87ES60DlT5paBnu3uA0Wer4x2
         ny9wiMkfWtxR/Jww/CTgv66he1SAsLUUk4ZAaPnUDD7UQXXtjtzbdc+HxNbFcOEoioPZ
         sWNnXfuuI79IjoTQAcbKSmuJHP3Pa07T+UStcaM7PpYUDsRZ3uWHw5aadzlmR7mU2GZH
         bnWGy6bUdTewhMMNj8Hj6SXb1IQeqDl6BCCCD4dcaRuCou3iF3gxiKz6qIn1+GeXI9aR
         espETnz/DEToQCnl5tcSCsCNxkJSLAEYfd4DKxlRK25cwk2hHeKRLRS2xX8IbcrVxPCv
         7M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPX1Cx6i1wGAaNv/FyWRibhoHk490fta5weo1iPmB0Q=;
        b=WSx8SpCNRirayX45Sr1+G+kxKBsfy95//TyoxA7QsH1LtdABXu8r8faC6Mi6sgO8Lj
         bP5H/s9hrxtWnmhdHltxbeA/GA8uVcCXPegYLgtO+tmYcDhe9Bh4d8JBAkvESBscm0jR
         3Q5res8woss5eXjtK5Pa3AwOd+30Uogtbty/12y0yq7moSsDDagva48RcPE+Xuecz/wS
         oCUAewnjCrYPAGNGknBMtboxZhYKlW24sfBBeR9Vt75wXfpVgItnWte7sdq8ycPoHfta
         TD4/rstIqorEeWP9SoslPH8Pxf4hrDUJVn5Thfwnn1gAj0r9Z8wkLdVe84ATjkPzMBdx
         MtHg==
X-Gm-Message-State: AOAM533Yu6btzln6GRlreV58m05/4E4YKKWlnrJjXGyjLipfinJStZJA
        CS936cCV/HL6me5QYKR8c5ALxFdrzai83dpsf/ig
X-Google-Smtp-Source: ABdhPJyGDT7sjKnvAaslCh6VU3oeZudwS5qG9rubETPaZxPkqNoONMqbRw1AEONbP0PiecvVT5WPlpdCnWvYhqaPj8Q=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr30404106edw.269.1630417801745;
 Tue, 31 Aug 2021 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <CAHC9VhSr2KpeBXuyoHR3_hs+qczFUaBx0oCSMfBBA5UNYU+0KA@mail.gmail.com>
 <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
In-Reply-To: <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 09:49:50 -0400
Message-ID: <CAHC9VhRdh0uTBur8PHOR4bL38rQozatO7J2fwEzZiLwRXLL7fg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 31, 2021 at 5:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Can we move this forward somehow, please?

As mentioned previously, I can merge this via the SELinux tree but I
need to see some ACKs from the other subsystems first, not to mention
some resolution to the outstanding questions.

-- 
paul moore
www.paul-moore.com
