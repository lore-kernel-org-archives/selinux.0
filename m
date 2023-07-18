Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6FC001E0
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGRUQq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRUQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 16:16:45 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E791993
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 13:16:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so68509239f.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689711403; x=1690316203;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVimXmbmZTbISW+7n71WjspppK5V6kmtNbt/YEu7vIA=;
        b=XQBKteELQXQuORaGgRT8MImSS86ueNUmG6KmdfwU/IYB/3xX2bftT3kU9krYco4iBf
         2EY8gyAq93spVBZSeqNYbMhhVAusjsvMI1i+kW9/79nxRDHJWUZIUOeXBLQUo4ITiaKl
         hN8dttzbEUwpb9easpzanAVhKCsCH1l3TletOmmAzhY0OFJkRLieHyvIBykbFUElb0ey
         TEyR95wK6S7ITaK/cyhFaVEkXNH5ouo6FD5Ijo1bJ8LI7BXHVca0G0EVijlMgl2+bk7e
         b6nyPVioInukFXEV/ytCqgQ5BKwCPXvEK6nzq5B/tYyL2ovFrPSa6xDzNIFvb7ztxnEk
         pByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689711403; x=1690316203;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVimXmbmZTbISW+7n71WjspppK5V6kmtNbt/YEu7vIA=;
        b=Uwp+i/BQoxrFxhu75bZGTUH6SXik4WIzGAOWixbXat3utA08yjpstKISbWbvTcUpXP
         tQYiVUIrJYWGoPw2rZqTzihtV2pq16IBbqX/0tyh3yemnV054DVbV4uU90vzKhjnd5mD
         2rjwyu90h1nqHBzcuLe3r/7dwrxLfEnAdyRXKrowaHTvOdcR/mu7pCvUNxI0fc/rSDlu
         /SgVzYtBekzh4QPCjcpeeh1KsV7fTdrfD2e64Dq/Qyp/0EuwrJX8NRnyb48dKiUYcaX+
         GMgG0DRG/cKJP6W6qWhQoCW2/dKmyp5BDoSDGmhpcG30aCs+YP7vsbkWRgMi5fALJUGn
         XlIg==
X-Gm-Message-State: ABy/qLZSjoHmzb1wbP7vDBm8E2073lftkkmuvPC6iEnQj9yIeBEOCvHT
        who40Ju1+z0OyBanXIcpL7T1PA==
X-Google-Smtp-Source: APBJJlG3LsH0V59+W63s/Sd5XTnlN8wuLVAG/nWDa1vOSLOvAlH/dGdy3BqBw/xqRu9m5tl1VqoSyg==
X-Received: by 2002:a05:6602:3f04:b0:780:d65c:d78f with SMTP id em4-20020a0566023f0400b00780d65cd78fmr3674323iob.2.1689711403339;
        Tue, 18 Jul 2023 13:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a5e8f47000000b00785cfdd968bsm845993iop.5.2023.07.18.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 13:16:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230718115607.65652-1-omosnace@redhat.com>
References: <20230718115607.65652-1-omosnace@redhat.com>
Subject: Re: [PATCH] io_uring: don't audit the capability check in
 io_uring_create()
Message-Id: <168971140212.1482414.1220631096211660246.b4-ty@kernel.dk>
Date:   Tue, 18 Jul 2023 14:16:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On Tue, 18 Jul 2023 13:56:07 +0200, Ondrej Mosnacek wrote:
> The check being unconditional may lead to unwanted denials reported by
> LSMs when a process has the capability granted by DAC, but denied by an
> LSM. In the case of SELinux such denials are a problem, since they can't
> be effectively filtered out via the policy and when not silenced, they
> produce noise that may hide a true problem or an attack.
> 
> Since not having the capability merely means that the created io_uring
> context will be accounted against the current user's RLIMIT_MEMLOCK
> limit, we can disable auditing of denials for this check by using
> ns_capable_noaudit() instead of capable().
> 
> [...]

Applied, thanks!

[1/1] io_uring: don't audit the capability check in io_uring_create()
      commit: 6adc2272aaaf84f34b652cf77f770c6fcc4b8336

Best regards,
-- 
Jens Axboe



