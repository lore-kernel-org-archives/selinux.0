Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB5C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 08:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLPIzW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPIzV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 03:55:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CC33C3E
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 00:55:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d131so1659730ybh.4
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 00:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujoQFar7e8EhK0hleQffBo5l61YVPxEqblhXpSzXf6Y=;
        b=NAWKq+9V5QtN6jw6NV1MuXe07NOXYTLbH09XnzHceW7V8PhBrwdPizeTGGm+55OiFF
         C5rQrG3MKRsTcQ7dkPK3tJFeQa4SeLa5fY6Q5KfKkgNBM5+ihRNQfhxJxNw9RauSYKp7
         gFfxlegGPYy5Q4xqjncoZjbmR3DAKkhVn4JDNOV506hALDoDfTk2WdVEfKwXvSLkX6b+
         9267w8SlHJhnvxuCkMnXTg5IzFyjVUYwW7GkE+mqxzKlxCk0UC+Xtiqop01OuYlvOTsk
         87iX8SXnckR5Az57NhDBTR/IbJF5Nv2rZQi6qbM2iDah5BZVG/8Ji8Jl0KyVA6DE2BC6
         kskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujoQFar7e8EhK0hleQffBo5l61YVPxEqblhXpSzXf6Y=;
        b=dvmIySpb4jObUiH/n4TZE3MMyY4k10BAtXpvaixIwxxs7P12oSmCnXcJf566emWmVO
         +Tp9CnJSSDDt1eKSdEejsBe8j/JGIz9WhJT6n3/8hsICa7I2wul2WCMdsJ7IXtnlA4bO
         j7Uoj8i3gBCo8DWEhsYl6EzatfflcPCx8NWL78j7oCRhwGhwk9LrKt5VogUTrUI5ti3s
         VIBfwimfd+wJEK6XwckEvORdCGZg+0fnicKiqZMhNmnFQZqO6hIlwZBUvPaAN/9KLMKw
         OOAqtm5nUSq9z5Py7dcBnTQhFo93hRDt+94x2YfnL75AN7jOHGAhnzOUDWIKuJ+B7FJg
         vsfA==
X-Gm-Message-State: ANoB5pliwR8/LFC92NSfpWrWpsr4hdgYw5PjzWws/Akxfx2FJC8EzA46
        19DLmcGkDiKqeCGM6W00a+Sy6yWuPVtkUDTmGiEbzQ==
X-Google-Smtp-Source: AA0mqf7Q7doVn2zPgd2X12L9TM1mY9hzN+l5nm63pay9BTYYVFMpD6QEOmjlos/r8q1FAdRiZqaHJN2Pe0kvY3rFd+U=
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr34984291ybg.36.1671180919171; Fri, 16
 Dec 2022 00:55:19 -0800 (PST)
MIME-Version: 1.0
References: <114ee67a-3349-454e-9387-40f1f29cb822@me.com>
In-Reply-To: <114ee67a-3349-454e-9387-40f1f29cb822@me.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 16 Dec 2022 09:55:07 +0100
Message-ID: <CANn89iJ42uTD+vDqzi_oPj2rPY=kxMSgtdrRd3G-xHozyi9apQ@mail.gmail.com>
Subject: Re: memory leak in inet_create
To:     =?UTF-8?B?7J207LC97ZeM?= <darklight2357@icloud.com>
Cc:     "security@kernel.org" <security@kernel.org>,
        selinux@vger.kernel.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 9:46 AM =EC=9D=B4=EC=B0=BD=ED=97=8C <darklight2357@=
icloud.com> wrote:
>
> Hello, I am =E2=80=9CChangheon Lee" concerned with kernel security.
>
>
> A "memory leak in inet_create" was reported in Syzkaller targeting Linux =
kernel Version 6.1 on December 15, 2022 at 18:36 (KST).
>
>
> I received an email saying that an inappropriate HTML form was inserted i=
nto the email and there was a problem with readability, so we are sending i=
t again.
>
>
> The environment in which the bug was detected is as follows.

I will take a look, thanks.
