Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E1AC352A1
	for <selinux@archiver.kernel.org>; Tue,  6 Dec 2022 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLFRqd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLFRqb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Dec 2022 12:46:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266737210
        for <selinux@vger.kernel.org>; Tue,  6 Dec 2022 09:46:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so14650098plk.5
        for <selinux@vger.kernel.org>; Tue, 06 Dec 2022 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6ZSPNQrHxO/4/iW+ali5P+CzqQ0KRqbdxPCedhh2m8=;
        b=ZoNyfNyedDp0DNrLD8d2C3bLznA4KIhApciiecbFZ+d8Ncc3uJipJOxfcbKBzw+od/
         AD6yJ9c4VGVLLU7UtVnnBg0oWAd+cEFRCHYAiFtddLWnhnCid21P0HiM+d4X1zc5mm3X
         nQOHhPyuBLY8j6EQj2x3DvSYgyQkXtazlIyCz6esX6mhAuekuhMdcZhWR8DGTAGx4BYD
         ERwDHmQ4xisJgK52Ne96lg3k2cBlnjE72JvuNhW49x7yQ8oGDWPFiSKxf1CLeiD5z/7M
         lzod/RMqJYiAwB9VT5IHcC6zKh0Ccgk5nlifKdJay7JYnWw68hyKAGmAUY4i8w2pCIGF
         Ycdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6ZSPNQrHxO/4/iW+ali5P+CzqQ0KRqbdxPCedhh2m8=;
        b=dVNXX/eOV3Aezvspj2E6dcY+ruapembOYIhQpPwEBteTRV2BEz8jp/ctaMWKB7hkrN
         xoJIZaJzRDQycCR2IJigPnbVzPs1FXoKCH93w4x6aD8EuIVlRIFMjWXUl0Y342pXrBO0
         v8/VL1DWK4h3WnA0c9Fqcd0UfLMud2b81AYt8EWSvmG5jZLOs/dWI6SnAuD8bG49C1vj
         W8WqkOwrlKLvynAzIhGdQX2u/rBe0HzKNA3Zsps1ATMkNQJpBQsr9EXQLYFhJ085LHLY
         N68OmKArStJwOcdpTI/2LL7LmZSGB5zoR7mZjg7rGsXIzQI39r2tPVrH1QfnC2GA8JFJ
         5jtQ==
X-Gm-Message-State: ANoB5plOSFfr3QJe0d6ifBi0ajqTsv8j0uHs6sGLp282YBL7XsTByfE0
        gmGZ+JNjEwGM4j1rNTXxVCHJAra/jeB+urFAJf3i+Ypm40EL
X-Google-Smtp-Source: AA0mqf5+ZrepAahlzXrqyhBE4OFv9iwcmKTYpRxHuFakrXK54TWB+Eo4Z174SHCQ6PeOcQTHT+vYG3Z+arr410wGa44=
X-Received: by 2002:a17:903:28f:b0:189:8a36:1b70 with SMTP id
 j15-20020a170903028f00b001898a361b70mr45688126plr.12.1670348789137; Tue, 06
 Dec 2022 09:46:29 -0800 (PST)
MIME-Version: 1.0
References: <Y49/EaE6aHZ5Pse9@anduin.perfinion.com>
In-Reply-To: <Y49/EaE6aHZ5Pse9@anduin.perfinion.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 12:46:18 -0500
Message-ID: <CAHC9VhRvgbH+FyeyWLxY-PisDM0f-1X7cASLzoUzi-_Nqvh+5g@mail.gmail.com>
Subject: Re: Intent to release SELinux userspace 3.5-rc1
To:     Jason Zaman <jason@perfinion.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 6, 2022 at 12:42 PM Jason Zaman <jason@perfinion.com> wrote:
> Hi All,
>
> It has been about 6 months since the last SELinux userspace release so
> we're starting the release process for 3.5.
> I will tag the 3.5-rc1 release on 21st Dec 2022, then rc2 will be in the
> second week of Jan 2023. Then most likely weekly after that as needed.

Thanks Jason.

-- 
paul-moore.com
