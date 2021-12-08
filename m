Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09EC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhLHUQb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhLHUQb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:16:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E269C061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:12:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so12183962eda.11
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxmHKSwTLIqnBDVtjeG/CDIXRfLaKsCtlIbnR3O3UOM=;
        b=KsUwHZ05I+K1IqkJabbpY92mX+nyaSFG4YE8A5TSgWtMqPnHUanWFfFACYr6Ibq+dN
         4HF7SwIRNoMfiI0f2cY2T93EPSFwlHCJazYr/R8uKyTbcZgkxheJbWHwFT4nV8OqSMdD
         sXVbI5yXyTA9E4IHRJaf2AY8HdmOwULzma4JbZBfMpFwVODBAq2XrDjOaUm0q+WybBwO
         Kf1co2/rLj9ONsnbkWKhZV3F4CDMUqUuMgfPueNjYNOMdsN6LCmqAcy+EmiDMG1uKf72
         Qz0dBmpxSJoSIgJ7iC/7p2oMdiTNOhdLKgge7sZxTjXNTwoSQz09cIn4npc/WKH3Kkf+
         niWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxmHKSwTLIqnBDVtjeG/CDIXRfLaKsCtlIbnR3O3UOM=;
        b=GNl7LI2InC2nO2RGQbotuNzM1aqmHTbn23c3vW6DhJK8Dt5+n4grmGgb6lZRQ/qkHT
         x/F9Ww1WXDZZVEdGvQMBaZRakB+c0Nc7fpYp//iQv5BYebB1BsJwdC1mXhReInH1AXZv
         mwmW9cm6dws+gp2tf1UCD4sxuRCCLIbjr7Z4XDvwys6+Su04kR10+Jr5JkwDCz6Ft0q+
         gi4NKAYCVQCT8FnDyf5kR3FjJY7tCYH9AtY+O0ybJmPcU8tp5KpbcaiKfxYXMBOu99ZI
         WwbXO0wDDq3xJaWPE1RkaMJlyZB1sSYiPKKOL768E3mx2SQnCMYPVnzkQ9SU38ksIo/J
         LOVQ==
X-Gm-Message-State: AOAM531Zm027i9m9MG3Adh81cqDufM310WwfftAhH6E6uPGjTS/G8b7w
        S9RpyPvAYcC2YqWCUE2mXabny9H1IR8P0I2Wi1ZBtOphfQ==
X-Google-Smtp-Source: ABdhPJw3BDFCJpjsTWIgcHpaEaQ9DzlrsLk+Hhk4eXxDvLPdPm/aQJiYw26I6JKjrpIeWmZ5ZhIDo39Zd/Avnwqt3K4=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr9996987ejc.24.1638994377879;
 Wed, 08 Dec 2021 12:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-6-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-6-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:12:47 -0500
Message-ID: <CAHC9VhT38neG1H5hAKRfdrM=JB2egiBHXhmfyAskNRSJ4fROdw@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] policy_config_files.md: Update openssh_contexts contents
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Used by openssh for privilege separated processes in the
> preauthentication phase.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/policy_config_files.md | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Merged, thank you.

-- 
paul moore
www.paul-moore.com
