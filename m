Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076EC433F5
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 23:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiBVXMB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBVXMA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 18:12:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D931372
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:11:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so47643767ejc.1
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxmneZpWcTsffCdWV4ee1t2GnhZVaJ5YOUC+Ft5dB7w=;
        b=gNrYpdowS/j9Aktza+rUkBy1nTHVRc1x2IKZDRPN+9OO18vgToZf0ukoRCa3wzm3JG
         AGN8WAsqeojXl+GaqxNZzmzS5Ho/iKaqnEq5mQHplUFJ721qVfV/TkCEgagWsvbOJxLH
         S34mJqQCN8QOv6CXctCTpCEtG+8fX2INioHTRRG5DvbxVNWjjCSUbDnPShznIoyls5VM
         foFt1duvWoDgo43MJ2v1k9ztDVfHpebjEeO7iYO9EiMU8XMbePGjYJ/MFfLOQPpjFI4Y
         1NLOB23jgTTfHzswMsbEgrz21iX/aNYHwuEEhb0g6deD4nFJAM9qE8zHhU1S5MraAhEb
         9fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxmneZpWcTsffCdWV4ee1t2GnhZVaJ5YOUC+Ft5dB7w=;
        b=sKAZxTfaflxYeyGXXiOUbkx2WPEK5eJ8ST52xFCWkEcILueJCQdksngjCTBCGUDlV0
         YDK0KTnaN7KN34knyXbNHGPB0XnnOAcm5gNetvyGc3PM1FGUUM8gix9Azj7EhT0+or9U
         vOD7f6zX73Ms7FDtULoEn3VqGlFkECWaartiWXDgM40/7cu2V/8hQlOyg/DF/9wIO7VE
         oaN+BA1VlLW4dOpSw4lTzaM6W1JLuxeI4m3huWkDoWjrpEcASiU2RCGoW5H2FF7xIPE8
         y45Hcu0rXytig2SOfcZFLVAOL8qxW9dlstNiA/1l29HmnC55YiI4XJ0D6JwcqdEQZnRj
         1ezw==
X-Gm-Message-State: AOAM533gYYu5e/wldlC6JHiwqOe/qpXJZTmKsAAP0M4IhmTt18qZyOID
        sCPYVpTa9hMt6mccOHwM8yDJ2TqmZtm6R5NXd8lP
X-Google-Smtp-Source: ABdhPJyVWVIpMCO0kpzLVnHObAll52Hc2SlFENUeB09mbrUKPw5Zd6BLR8uuijq9uxA+Y2Ol63jC439Ec91pj4QoUC8=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr20922299ejp.12.1645571490397; Tue, 22
 Feb 2022 15:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20220221140649.360897-1-omosnace@redhat.com>
In-Reply-To: <20220221140649.360897-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Feb 2022 18:11:19 -0500
Message-ID: <CAHC9VhSiBYqNMmASud9Adi_1P-q0O_Qp_05WvuBEW1vw112yGA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix misuse of mutex_is_locked()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 21, 2022 at 9:06 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> mutex_is_locked() tests whether the mutex is locked *by any task*, while
> here we want to test if it is held *by the current task*. To avoid
> false/missed WARNINGs, use lockdep_assert_is_held() and
> lockdep_assert_is_not_held() instead, which do the right thing (though
> they are a no-op if CONFIG_LOCKDEP=n).
>
> Fixes: 2554a48f4437 ("selinux: measure state and policy capabilities")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ima.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/stable-5.17, thanks.  Assuming no surprises during
testing I'll send this up to Linus tomorrow.

-- 
paul-moore.com
