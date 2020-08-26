Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF4BC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269332078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc6O+HPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHZOPR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgHZOPQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:15:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C17C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:15:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o8so1587766otp.9
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AMaLQ/lvQmridQV7BFam41mBTOEeJbeQMDwZ+ZQiUo=;
        b=Dc6O+HPILjsJ4e8vkRBfl98IZyfWTwRpEnwTXvbjSD4nKJhkMx4ZSFPcnCwDI+oi7T
         +sMlkvZ193cV8RIrbodqUcEtzBYQnLZQjo7YRHV432QFMmHHOwXrdtsqbIic2jOER5Dg
         +vfcfqq70o5Hc/RstX0LkyJuLirFbc5ajNqz2vtFRA7uQfdA9LDf86CklUT1N9EjdOGw
         aQpHuuhALMxpN4TIGUmccRmMcm9icCUBuWFehC4m+wJYw9X63XZCz0cZhAvpnhyi3EYO
         +O4SNred8W/8XGn87D8akI0u/St/KrSYPhC746ME0FgBOGSM0Ep3xw++BkkYe9ckNN8P
         q7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AMaLQ/lvQmridQV7BFam41mBTOEeJbeQMDwZ+ZQiUo=;
        b=TNqs0PDtXjN5pPude1dydebr3w4ozkQzd0Bx5ZcQv/+LPq3YIbN92FduFkK9ntIaxW
         UVPBIZ+iyhWmP0BhiZ8xlJ6MKMrpSwCn/XgeeFJTEVwdhZAA1/ZGfa5itiFmGHUFCi1/
         4N8ydRkfeoThJwBZOG1CSyDTO+Q74OoTbfLCGPMEfyIvEeLr2TB7JqYD0n1g2AJHkRBe
         YvthM3MtssOCXI4MDfL46NT8KUQwO2aHZRxnIhLah5Z7fEm2+GEg+IN7vxj2xVEIFPBp
         I1LXV6OllvfwLaoOnhcNdtG6Lqfo125ZVvuvGq0tnuPJ1oLecsnKTe/oTomQksFzVeKn
         0Nag==
X-Gm-Message-State: AOAM532qanZzwmub493cZ0qStYJnxDape97f2yvE5EExpKgSf5beD1FG
        /MMkTIys3sSPh/Bc3K9v5D3vj+j0hLjglUF2VTMeAnz0
X-Google-Smtp-Source: ABdhPJxXf4F7JG8E0eLD7pZgZrJs5/+Qn7ODXN87L76v7iEcczSbta/HsqBezPZ3EGm03XVSK08QyXnTgAeznls25Fo=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr9652663otr.89.1598451315279;
 Wed, 26 Aug 2020 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-4-omosnace@redhat.com>
In-Reply-To: <20200826135906.1912186-4-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 10:15:04 -0400
Message-ID: <CAEjxPJ5HRQQprNoqe0O7M73Tk3m+kRAqutHY5Ucb-8eH-YUEsQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: remove the 'initialized' flag from selinux_state
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> After the RCU conversion, it is possible to simply check the policy
> pointer against NULL instead.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
