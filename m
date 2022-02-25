Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A4C433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 00:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiBYAqP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAqO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 19:46:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3796278C85
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 16:45:43 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so7699223eje.10
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAi9Rzuvp5Yj24270pIUOGjPpsZUo6A3XHj3Wrqu90o=;
        b=0BYFWcFRhHapc4dS0kNykBMQ772alzsPQirjb5O+Jln1Ut26gysm8SFs02m7AakRtT
         am2QmP/BziVo4kQEIjdXlnEYFE7z0XukJ9eUzCkTPY8RfuTkpRJkowE7VaJzn8U96Mrs
         1bqKgggTMkiHhebav0k90JnEDEeXxwpft40llDDKnQ9p4dv4vQ4csARKM9eSeYff7S8T
         T4A4ytzHYQ9gC9rg+tJIelUzR0HiHPHRLBt7FHo1PTdcFr3StX+MJ+DG5GQj0r39VAdl
         e/KIahjIt0znhn/ENsFyn0RJE6jSPe3qlIuVMO/BJcNhUOf8bcS8g8esSMau5GP+6X8s
         mn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAi9Rzuvp5Yj24270pIUOGjPpsZUo6A3XHj3Wrqu90o=;
        b=mwyqO91n6FUhc8opViO6awMR0RemAEgflxaIk+0hqY7pqD9X0zde3Kj+LMPbLUEYhc
         VOE2mudrEI8U+QfRtt8FwCdOrdqfCs/rETVv1EUtZl3M3ctwDCFFA9bzilOweGH/ZZRS
         LbYw9jJMX0tW4fyE/ZmHcLQisYqyNq6R+MBuSkCmxi1WGs7MJZxC5RJ0WeEqXuly0kfu
         zr6BGCNWHyaVRtjb68nRNIq7wog4G2LxAPx/M8elGCIrfaJGLgXZRqcDG6Mzojmqmdhp
         xJfiW+zBxxI9ID1qtBirNVNyC39kiR7Ah73NP4aWTaIYzcmWF67fk6s0epi5GgGZpEU1
         3N/g==
X-Gm-Message-State: AOAM532QLAGvysuA1YVI3KPwl15j1nOiZq9SCa/WPWt0ejtvz2zCZl4X
        Bwt7AYuRn4SepYikm/+/wGhKbjLvqA2EYMml89ByYsep3Q==
X-Google-Smtp-Source: ABdhPJxov64s56ykIKAgTQSghl3nE/nGJepZwzJ3YigoBOG6qCl4x6RjGah0gW/SzwjHUnRwK3j3HgbAWib9h8rFXk8=
X-Received: by 2002:a17:907:6e10:b0:6d1:4447:95bc with SMTP id
 sd16-20020a1709076e1000b006d1444795bcmr4054977ejc.610.1645749942187; Thu, 24
 Feb 2022 16:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20220224130719.44424-1-richard_c_haines@btinternet.com> <CAHC9VhRmqeMM3ruPM1-SwTzxB_i4Nez7HNmxNG4hZ8L3Cwq=bg@mail.gmail.com>
In-Reply-To: <CAHC9VhRmqeMM3ruPM1-SwTzxB_i4Nez7HNmxNG4hZ8L3Cwq=bg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Feb 2022 19:45:31 -0500
Message-ID: <CAHC9VhTgWtsviQpUaP1xai11qOykDbXnCsGW7UZAw5MK9Kg7-Q@mail.gmail.com>
Subject: Re: [PATCH Notebook] policy_config_statements.md: How to add a new capability
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 24, 2022 at 6:33 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Feb 24, 2022 at 8:07 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
>
> > ... Did you know there
> > is the "Oxford Comma" song by Vampire Weekend (if you are of a sensitive
> > disposition, don't listen).
>
> Oh, no, I did not know that!  I'm currently "in a meeting" so I can't
> listen to it, but I've got the song/video queued up for later :)

That was worth the listen ... although I still remain convinced that
Oxford commas have value ;)

-- 
paul-moore.com
