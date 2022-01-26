Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1CC433F5
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiAZU7N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiAZU7M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 15:59:12 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC3C06161C
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:59:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so1257142ejc.4
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9eB3sinujdfOKjw1Rq4Yv5m0jvLygDYT+UfsakVwvFY=;
        b=hWc0SIhSU692E7TeE3QERHKR5x+Uc2JnoSd39zct3wR6ZvZdOU20Q/bEetUWnZH2qv
         k8Y87WwX4DNOZDY7hoIHLsc9RzoCzuP16c0Mu+JCrku3P3474tOJQ88YTSgwbgLVQOT+
         p17Rn52sDgl4b9IJo4cMCYZa4M7HXtY7gejYzswVMJo7wrdHQ9ep16fmYu3RxZQdUzfZ
         vbB9+epHe00IVsZhW5xqE5F+iIEAgrwaQry0tFSp3SRgrGpEemNiJ0xnUbptAQCNgexX
         lKuc1tIxApWOC8mTKsWuY1RGL78bfxNndcg3XKtb+4eUvrpLhDstJvA1Ol1ZPla5q89D
         6b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9eB3sinujdfOKjw1Rq4Yv5m0jvLygDYT+UfsakVwvFY=;
        b=t+tzOgYwWCJ1aaCJDQfL0ts3pjEJge9O64A4rcKEA5XW+DaYa942Y+MPzJCzdbwZ/H
         3PgfNIHfs23vPUz5fPOdMjtgjNfi88KidvWY6tA8FsjCwz0YVLZK5Sj0HzkZRuWqtrfE
         mC/2fpuCPWlGynV6i9PKoW2GmAt1adSJ2KGrkqNUviMt7DIM9aHZ4aRCA9gihwLUVrqI
         AUHkwxY9/7xo4rrYITAPOsJZ9djo7ci5llV7aMCLgRE4dXyYTbP5UhvRZyL7lfK7ka9x
         XbUS9prZM2SeKQl1M8Ss+rdKvFub6/QX18bJTXcdFYKKlbJzOuYyctY+dWy/tg9B9IKP
         WS3w==
X-Gm-Message-State: AOAM530CMRSeUsy4QqqS4M5Pv/30B3SiNa2bqtTiSwKDpdJ9gbCTaL6I
        NHSJhMWINEXGXjvJSUZp3xqGbfOFygA/A6Oe9AFS
X-Google-Smtp-Source: ABdhPJwbGFpX8vGoi0YEZndNed80nrB6pQPwjTtQxv2+KG/+YKLLOPVzvOVF4GemKeM4hVP+ZFNtczQgBVPkJvmYazE=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr396367eji.327.1643230750765;
 Wed, 26 Jan 2022 12:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-7-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-7-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:58:59 -0500
Message-ID: <CAHC9VhTJpeb37sOkvKHO7REUJ4K3YMGK6ZY_ptLjVVAkEKdpfA@mail.gmail.com>
Subject: Re: [PATCH 8/9] selinux: simplify cred_init_security
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
> The parameter of selinux_cred() is declared const, so an explicit cast
> dropping the const qualifier is not necessary. Without the cast the
> local variable cred serves no purpose.
>
> Reported by clang [-Wcast-qual]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

--=20
paul-moore.com
