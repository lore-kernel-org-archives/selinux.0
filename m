Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835A4C6FA9D
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 15:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCAPJs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCAPJs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 10:09:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FAF46A5
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 07:09:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p6so7927176pga.0
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677683387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhC6DDi/LiFwiE2kT6M86KyVmeUSvgilsaR80ESZotc=;
        b=W+sVu1qFTWgtE9PxtNHb1fTD3emeXEDCzIaAFSnf6+tzs1IWLGzHIozgCEnwIfrmgV
         NV/l3IdWgYW5LonxQZDVqWWQ2udFxUzbk4kx5XCoG7n4tR/aUD6pGhlDoweh4ULXeSCU
         r34TQrr/29WPtIJSLN8gwNlA+70YNkmsLPrtcxYVgM2A4edyjBchrtFIzaU6Sv4Qnbjj
         SjLmIabgOk48od7oJZDsmESIfvhU5prE1UnU6BYaG6xDTxCp2J7nkjUDqOXdzWkdb549
         g8PczTdm8ktqviuqFJPCM9h57qbG1cCgV04Vb/7yVy9Gwr2XhKwjrdnAossJxrGEYk4c
         0W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677683387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhC6DDi/LiFwiE2kT6M86KyVmeUSvgilsaR80ESZotc=;
        b=4QUHuifwo1T1o/C1kHVCHN3e3KBXRWaZT/Bn4SLLVlufps900e4Ic/pG4kRTDjkB+N
         jzXXl1vIJPxF94QDUiNxZR7ytzaTCnKM5vHyfABxD2sYK6K1cUEIIeFls5SXzAARn4mZ
         r5G0pLsJfaruPNH1uAQKHsLStRnoJnkRjw2oteqsMH0H2pYorEBatuxFrkGGVob0xZfD
         itRTG+vWfcRFvezS3GXqLDTQ9lAo9p5yfrwVGy7BR9vEyheHc+01R11UrvVACsvFXdmT
         vjIWdiAWlXk0mp1T7VX1PsL7laBi/uLWzCO/2Ssr8+H/HXpCfYBGYKwZFyLZ8YnkDEe7
         BPMQ==
X-Gm-Message-State: AO0yUKXFYR1qKdP0PrUl06uHGYfAL5LYUuM9FjGppoJzSdVarsicpJKc
        Ke53+kTAqKdNjPen834kEAKsWhHsJ40wvwaxwHgepUt4poug
X-Google-Smtp-Source: AK7set/lI2KvhSuHclBFgjurk582mhQWj2kIT5wgjbuYwfNEEq1CMCmrYFjrV1LLL9pHRwDOKYLst/g64UOyq967GRk=
X-Received: by 2002:a63:3388:0:b0:4f2:8281:8afb with SMTP id
 z130-20020a633388000000b004f282818afbmr2255842pgz.4.1677683386641; Wed, 01
 Mar 2023 07:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20230301094130.736231-1-omosnace@redhat.com>
In-Reply-To: <20230301094130.736231-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Mar 2023 10:09:35 -0500
Message-ID: <CAHC9VhSomYYm00wAixn1SfO3H+aSrAsUezJsgBv=jPFLgyAD4w@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file: make the SIGIO tests work with CONFIG_LEGACY_TIOCSTI=n
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 4:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Adjust the test to temporarily set the dev.tty.legacy_tiocsti sysctl to
> 1 if it is 0 and re-enable the SIGIO tests.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> The dev.tty.legacy_tiocsti sysctl fix is now in mainline as commit
> f1aa2eb5ea05 ("sysctl: fix proc_dobool() usability"), so we can use
> it to re-enable the SIGIO tests.
>
> Passes the CI with the latest kernel-secnext kernel.
>
>  tests/file/test | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Thanks Ondrej.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
