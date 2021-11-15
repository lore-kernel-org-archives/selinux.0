Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB2C433FE
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D108A61BBD
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 22:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbhKOWhf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349512AbhKOWTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 17:19:09 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B94C0613B9
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 13:37:37 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h23so18176479ila.4
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=AcKSBTvLAW0gj40GbXq2aP/U78AStpOkB0MPl9oMU5U=;
        b=v9PY7keA/WOnuwebpkySYYfb3fifjLPflW1uRGH1P1DoaUTZBjG0Fj77dKlFcZBz15
         VFwDd42szs4hKUi1ekn05lhDXx6LUJ4Cg+vLfHz+4p/5cLwocbAXl4HU9j6z9INBDQrV
         n68Dx/GdigRjoOC9V0P+KqOZEjlHkPKG8bMU5Um3gSto+jwrjx119w9gxGn5F4iuPsZL
         yeA+ViWknSnYBuV3RVNrlggI1Heb+6QP0wTmBEP7decqGnbkbU3Xm04jvM/RQ3BX+/ga
         tuAHHUPkulvitg21kNN+HZGty3eZCHgjDUgD1k0sVwIEDgQb+Kv632/Y+nbKO4qu3ZpJ
         H7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=AcKSBTvLAW0gj40GbXq2aP/U78AStpOkB0MPl9oMU5U=;
        b=qrQrTWDKAbKOQwTORQsGRiqULy2T5xtJpOEImGEkGwPifwcC+iQh3UO8OqSq3gHnOm
         Wq8Yq5C2+Oq9G+Rm335i/fsL8if0jaA2EnXxvm7ZgmYowjpnHydOk4MRvR6980uLsV8K
         OqM/yrEBK/GRosJErMWf+PmPxCad9cs/dDDuqrpboDyXZnXnjtESRHYtvHwDI6/kk6Rc
         YfxDBm/OJ50qvOJffI42PZt2yQVGqg2olWBGuzWHFHlnJdsUeBdF5DWvtRU0CHr6DJCi
         DO/B1Ol0dRomXUq69PbqspjOKv46FIbsB9pCuMSToPN7OntrDATTlyklHh/mMdOxM5NM
         idhg==
X-Gm-Message-State: AOAM533NhAPHUEKwGe40NybckJeSScmRXOEkwACdIksVHJq5WJDOkqwc
        XxBwHPgj++t3PCxph+5+cHFtgA==
X-Google-Smtp-Source: ABdhPJwXrMjYdhOuZhYyB1MaOORmDZWRJav/IZApf9RJkatUYCCTo84c2Ob9wG9NDX4eI7z70eI3VQ==
X-Received: by 2002:a05:6e02:17cc:: with SMTP id z12mr1240203ilu.267.1637012256820;
        Mon, 15 Nov 2021 13:37:36 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b6sm11771900ilv.67.2021.11.15.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:37:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Cc:     linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, kernel-team@android.com,
        selinux@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211115181655.3608659-1-adelva@google.com>
References: <20211115181655.3608659-1-adelva@google.com>
Subject: Re: [PATCH v2] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
Message-Id: <163701225573.78831.14755675586127114548.b4-ty@kernel.dk>
Date:   Mon, 15 Nov 2021 14:37:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 15 Nov 2021 18:16:55 +0000, Alistair Delva wrote:
> Booting to Android userspace on 5.14 or newer triggers the following
> SELinux denial:
> 
> avc: denied { sys_nice } for comm="init" capability=23
>      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
>      permissive=0
> 
> [...]

Applied, thanks!

[1/1] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
      commit: 94c4b4fd25e6c3763941bdec3ad54f2204afa992

Best regards,
-- 
Jens Axboe


