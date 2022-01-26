Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD75C433F5
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 21:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiAZVVL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiAZVVK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 16:21:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240AC06161C
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 13:21:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id me13so1224068ejb.12
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfddJG8Ne5pbCi0QrdlrjT/b50oZdx4/kvMtR32BLbo=;
        b=QIsyaeJL52rp+3sMUQ/8G9bavcWiwWOAPwduuNQzSJTmaE0wmWzJTUXcd6yb7OAw9N
         /LvLL61/LhqDvVMoD6KM2ou8xCPrVa4xBjQssw+d+82eO2Oa0qqbrJ92xIiA/Fe297Qa
         zq4y15SlqILN9HRRaHpiVKB2ZQcL2wllShwZl6avz7sIF7hIAEJBO1Mf/xbt3/Q2WHVV
         LhorNt5gACpE8aU7l7t6YWYZI5IwvludQu6R+YzDS910gZAbgs8gXHu0RWtMcnwX7JqA
         TFXPJsCamc9Sfz1aGZ8MmF8L77Hu24LMstwIWZb9AZfC9/6hX88Z9s7yMEg0Ird5Rcfi
         3oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfddJG8Ne5pbCi0QrdlrjT/b50oZdx4/kvMtR32BLbo=;
        b=e6R9Ew0ocIpvDooKK9ocHE4BziRAvt/8IfMmEPTyBfZlvktERIlLKUo/wXyMJ6eu5n
         e6AXYlp57yOT+fvUcn9orX7KcOlM7fgfh+utjrQ7E3YYxBZOQtige2F/7A2Dtd3oUi/N
         0UQ3xKRcGGcDsk0+Xu2O7Mi33hEOQedCLqUtNmh+LVqNZCq5cOPR3DoplL/0ycY2E3Gk
         NpC7JR2rxb0lWoCrQpm9J1xgkm6jFV2glNkXfV+6eh1dIteUhHuTVZ4n/wxG9WTM3Mnr
         2K6eQh7PekcT12FHoWAZayRjYG0ACTJlJYh8/hDVwlabuLa1RmpgkliFsyQEny/TnhJR
         r6Ng==
X-Gm-Message-State: AOAM533JPF26ZUs6gG6yNDHrhKUDJkIPN6eSSj6DulbLE2/SYerWyW/Y
        dmSHVrxYZSTNqquOX57V9OvF56xpGNTV+RDbQGSb
X-Google-Smtp-Source: ABdhPJxw3d5mnv3wPnmpUUVOKLaEA0jO8ZEylbqwXDPVekdv65G/G9q1/pcNh+v3zqOWTeUCasC3T9p1EGRX/t+n1iA=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr414495ejc.701.1643232068672;
 Wed, 26 Jan 2022 13:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-8-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-8-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 16:20:57 -0500
Message-ID: <CAHC9VhSQW3E=K+nDF8tdTi2AxxN91b9Ufk-FSE7XpXimHTA4tA@mail.gmail.com>
Subject: Re: [PATCH 9/9] selinux: drop unused macro
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The macro _DEBUG_HASHES is nowhere used. The configuration DEBUG_HASHES
> enables debugging of the SELinux hash tables, but the with an underscore
> prefixed macro definition has no direct impact or any documentation.
>
> Reported by clang [-Wunused-macros]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 2 --
>  1 file changed, 2 deletions(-)

Merged into selinux/next, thanks Christian.  This macro definition
predates the move to git so there is no quick answer to "why is this
here?", but my best guess is that it is an artifact of a developer
"disabling" the DEBUG_HASHES macro by adding an underscore to the
front.  Regardless of the reason behind it, I agree it should be
removed.

--=20
paul-moore.com
