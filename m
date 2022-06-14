Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E5C43334
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 14:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiFNOut (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiFNOus (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 10:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF72D3137E
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655218245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vyh9tiiTxbsj+ZV0swvA2n1z/qVs5gsat+X9riKC1d4=;
        b=f//Xs27zVxNwo03VrPgmBZuoGmQghkcL+j4EZY07LCcdSTjqXDrMicGZgW61+n41Jt1Fam
        JU/WdH9zNKYmpldSiXflN5/sA+Qy+p6x2jvbFrKdrqGkuNIQl45YuIIrCpAqKXPuHPu9F3
        ANIF0hsOpUw3mmRXDCGlxGXNme43I8g=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-lurqGdiPNHyC0aIDWPBYLw-1; Tue, 14 Jun 2022 10:50:43 -0400
X-MC-Unique: lurqGdiPNHyC0aIDWPBYLw-1
Received: by mail-yb1-f197.google.com with SMTP id q200-20020a252ad1000000b006632baa38deso7804448ybq.15
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vyh9tiiTxbsj+ZV0swvA2n1z/qVs5gsat+X9riKC1d4=;
        b=DwieDfUgQtFlYq0CVAPrCIUihRFLcZAeTMHxigM2k2CLFYKEIsKE96pRsTQ9CdxV8W
         yeWqiMNPOzolWjmPqHj2QrxWTEzrYvC4hbEIsIQUZYQOgomYZX7STKdg6psbRViVXTZu
         xNMpSA4J8R+C/Xb2NZdP7MpACdLPpsRgWyfPIpn+ZekU+LZUdoRJ3XjyoZ6hcT8JQeex
         BG62BZ5dE2KRMJO5poVsMOTIOy/VtXLU31PYZO2JYpqQPeLf8ehJAvzilZgRDf59XKCZ
         JF5a2OciTElRppMboBIE2Vs9b3DL3HLrNZwplTxrmwIQ5p2PBNYuvwCNjRP+1Y1Q4nfI
         vsoQ==
X-Gm-Message-State: AJIora/VgZRIJSujGk3f0lHIHxx9psjpBe6DuTkMH3bzAKGdH5eOZHl2
        wkO1657Xh+RCl91FT5Fla8g+bui4CV81aTTZZjshzb520ZCMgEEKqbYRhTbS92RnZOSR8q60X7c
        vARuC6OW9fnizSI6sLJwMjcKdqemgxPSLEg==
X-Received: by 2002:a25:3810:0:b0:664:4424:e9f9 with SMTP id f16-20020a253810000000b006644424e9f9mr5365507yba.21.1655218242999;
        Tue, 14 Jun 2022 07:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMsYdawDfgmoDnFazx94FFG0eicDxLuCmaJE/gD5WabiZFrXWhtyy1H7sO7xx6cojFV5daFluoqb29d9QdLlQ=
X-Received: by 2002:a25:3810:0:b0:664:4424:e9f9 with SMTP id
 f16-20020a253810000000b006644424e9f9mr5365463yba.21.1655218242426; Tue, 14
 Jun 2022 07:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com>
In-Reply-To: <20220614102029.13006-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 16:50:31 +0200
Message-ID: <CAFqZXNt8rPZR-EdKD_yc6xKY0eQLUh51Kj4EpreF-Gek-pJYGA@mail.gmail.com>
Subject: Re: [PATCH 1/4] support Dash as default shell
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Debian uses Dash as default shell and switching via
>
>     dpkg-reconfigure dash
>
> has become deprecated.
>
> * Use POSIX compliant `> target 2>&1` instead of `>& target`.

I'm fine with this subset of changes.

> * Call runcon directly to avoid a fork within Dash, which breaks tests
>   requiring to not change the PID of executing commands

I don't seem to have such problem when I change the default shell to
dash on Fedora. Can you provide a minimal reproducer?

> * Use bash explicitly for non POSIX read option -t

I'd like to try to find some nicer alternative for this one first...
If I don't find one, then yours will have to do, I guess.

Any specific reason why you used `` instead of system()? AFAIK the
only difference is that `` return the command's stdout as a string,
while system() returns the exit code and forwards stdout.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  README.md                      |  7 -------
>  tests/binder/test              |  2 +-
>  tests/bpf/test                 |  4 ++--
>  tests/fdreceive/test           |  2 +-
>  tests/filesystem/Filesystem.pm | 14 +++++++-------
>  tests/inet_socket/test         |  2 +-
>  tests/ptrace/test              |  6 +++---
>  tests/sctp/test                |  2 +-
>  tests/sigkill/test             |  2 +-
>  tests/task_getpgid/test        |  6 +++---
>  tests/task_getscheduler/test   |  6 +++---
>  tests/task_getsid/test         |  6 +++---
>  tests/task_setnice/test        |  6 +++---
>  tests/task_setscheduler/test   |  6 +++---
>  tests/unix_socket/test         |  2 +-
>  tests/vsock_socket/test        |  2 +-
>  16 files changed, 34 insertions(+), 41 deletions(-)
>
(snip)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

