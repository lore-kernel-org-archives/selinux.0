Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B8C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 04:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjKMEHX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjKMEHW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Nov 2023 23:07:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854EC111
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 20:07:19 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso3891549276.2
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848438; x=1700453238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlKWMNmqKqQg2CpijRIn4IqNVg9ZXn04XHUyH28+sa8=;
        b=IDGMlsziV7rWsLxkiK46yrCFC1440sNq9BwbrSxWUgsiAhOAWcsPAFvVGys3BBxPgG
         6gxgVxRS0F7WNv26g38T/D5/wA9kVruPW1/sbDm4EqsVmxIWmqF84r9ZRsbQiZmNWlq3
         ezyBGX05yMdCUXY/L8XFKVDBz4fPl87gjRlP5DC/JRdC6X+Eyc/hQQywRLmEqtXmn4tA
         Tg8f8wgSs77Gc3mEdY3R5tXdqYwRE2vXQeRqpWuWAiNKX6+AUBMg8ozKb7a3obCN+I4F
         8X5xCbmv/FRxf8oDmiYUbJuBO/tZEWnueS++0Oxp/GTvP5JftZegnoEHAcRXH3kDN/8Z
         yTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848439; x=1700453239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlKWMNmqKqQg2CpijRIn4IqNVg9ZXn04XHUyH28+sa8=;
        b=XnjzoDxTDbwVKYw0q24fggsumX8UvkyJbpTB1CKt7KSv58wvNOGY5DbsZ35FtMnoNl
         9h7rUH/s7CVhuSaO6qjtivSQogUJpLvow6JhSb+DpRR3z/kWHtcpdam9tHHTslXd9Phr
         k/lstGBfFPWrVJX3ISVFB97eflK9CUK1BgGfWD3+Hvo0kMDetpK6omH/p0i0tzg2dhga
         zlclz8uzncf1Rge3IP3KIaVL8r359agzylYiT5XMXYdjFmiTbTnAZkQjD295mSO1SNwh
         TY2jZbzbhFM5LlnOhswq+A3WknAY4kD9dC/+k0rDwdgT/LgO9CGxg4bT2X8kUWJEjW2F
         kQ2A==
X-Gm-Message-State: AOJu0YzXcvVi+qFw7ReZMrog7XU75GGIa7tJX+c6id72kOnVptqbvCEV
        hU9G9gNo0LiSYIN2HOox/K/k1BC7QarPv0DrEFGR
X-Google-Smtp-Source: AGHT+IF/j7Tqaps4y/hdfO/N9xzGQuEXV+A/L8AG8eSFc+i50rEykkEU0t7lMJEsJJqSzOYeLS28XY298gXyDunhFbs=
X-Received: by 2002:a25:41d0:0:b0:da0:d0be:ef06 with SMTP id
 o199-20020a2541d0000000b00da0d0beef06mr4547717yba.51.1699848438676; Sun, 12
 Nov 2023 20:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com>
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:07:08 -0500
Message-ID: <CAHC9VhT7DRUZO1RPDwXKXXJ-xsNL6pcMxEgLPsc7JTtBruzLBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] LSM syscall tweaks
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 24, 2023 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Three rather small LSM patches to address some minor issues found during
> the review of the latest LSM syscall patchset that now lives in the
> lsm/next-queue tree.
>
> I'm marking these as RFC patches as they have yet to be properly tested,
> but I'm building a kernel now to do that and I'll report back when testin=
g
> has completed.  In the meantime, reviews and ACKs are appreciated.

These have been merged into lsm/dev.

--=20
paul-moore.com
