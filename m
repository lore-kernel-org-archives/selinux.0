Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962DAC433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiGAI7T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGAI7S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jul 2022 04:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BD8F18B0B
        for <selinux@vger.kernel.org>; Fri,  1 Jul 2022 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656665955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml7wCj/9ZuM62c7wvT8A0FmUomnk8kXPN0fXAec7qys=;
        b=BI775+EO/l96K0EGnMttF5soesvi0WaAeigjOBRlJph5jCBG6SfUruMRKPjNmdr0rTnIgg
        5+HQgqqN7Jp93nGVV0jydvhwR46D31P7qxYp+kZBh9mwUMzc9PrjUZgfN/FmfvqM3Ga1J8
        cyQAWticPW8vQX+vPtiNJPqEBsMA1IQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-Lej-k2JdPCaW2L8CvJCmrA-1; Fri, 01 Jul 2022 04:59:14 -0400
X-MC-Unique: Lej-k2JdPCaW2L8CvJCmrA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-31797057755so14628937b3.16
        for <selinux@vger.kernel.org>; Fri, 01 Jul 2022 01:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ml7wCj/9ZuM62c7wvT8A0FmUomnk8kXPN0fXAec7qys=;
        b=bghTHmv50TKfZAZKOqjL+HF7/Pu2Z+ORgbpdmPBmG/JLw5B2ncMtcrBQAo53QMXZ2e
         RSyAgQuNC0ceQ2aUiakcvrymPgwinL8OXxKbI+IC7RfhcGdpe9duIBXjqDeeFP3VBo7O
         xWvCfXHT+rhYhSE1XiubtTu78wNawmztqFvL8x3dVsyNQCQWVuWsN5n2R5wSHF+sVW8P
         6qdfFaO3HHeCh3/nMbuJcZcnMyaV1gKobsnLn6Ihzq3mJrb4NfqzbxPNde2avyDdCBpA
         mwX+e6EixTw7vRlpBnlVIxk/OxS8YsOoaVnsaO5PZwH096Qbl1gfaTo7NBpr62y9wOSf
         /Prg==
X-Gm-Message-State: AJIora/fXvDTvZn8FLQAgw7xVPs0bLXrFiLXRpPQk2Cep6TB5fer4Xdl
        uspgzx6KVl7TOJ7Za1wIFGWp9rKqZ6fmoKkfC4nlUBaa3HfMF8EV3nOGlnwEQOAE1n8+vR+DboV
        LK8SOKRmUf/SAPJIys8NMDFwp4DyLvIL29w==
X-Received: by 2002:a25:df15:0:b0:66c:8c2d:7897 with SMTP id w21-20020a25df15000000b0066c8c2d7897mr13748004ybg.445.1656665953721;
        Fri, 01 Jul 2022 01:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8T2vLjFKhbkxcXUyaKsMgjzSkEsgmdb5V7rvb2ryYSUf1FTx/D5FkJtHuSoz0EBrFmjuAirvbqwpkGjmnzU0=
X-Received: by 2002:a25:df15:0:b0:66c:8c2d:7897 with SMTP id
 w21-20020a25df15000000b0066c8c2d7897mr13747986ybg.445.1656665953465; Fri, 01
 Jul 2022 01:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220615122711.9895-1-cgzones@googlemail.com> <20220628143408.76329-1-cgzones@googlemail.com>
In-Reply-To: <20220628143408.76329-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 Jul 2022 10:59:02 +0200
Message-ID: <CAFqZXNupuiCX2A1rDv1aQbmtRsyVEVrCNLp=690BnJdePfddWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] support Dash as default shell
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 28, 2022 at 5:20 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Debian uses Dash as default shell and switching via
>
>     dpkg-reconfigure dash
>
> has become deprecated.
>
> * Use POSIX compliant `> target 2>&1` instead of `>& target`.
> * Call runcon via exec to avoid a fork within the Debian version of
>   Dash, which breaks tests requiring to not change the PID of executing
>   commands
> * Use bash explicitly for non POSIX read option -t

I came up with this alternative Perl-native implementation of the
`read -t` idiom:
https://github.com/WOnder93/selinux-testsuite/commit/36c072871f82960f51035a=
3fcd60db2c7adaf339

It is more code, but OTOH it gets rid of the dependence on bash
completely. What do you think about that approach?

In case you have no objections, feel free to pick that commit and
rebase the rest on top. I'd say you can skip emailing the patches and
just update the GitHub PR, since it's really just the two of us
discussing this anyway :) I'm fine with the rest of the changes in
their current form, so if you do this, I'm ready to merge the PR.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>    perpend runcon by exec instead of splitting arguments
> v2:
>    use system("bash -c ...") instead of `bash -c ...`
> ---
>  README.md                      |  7 -------
>  tests/Makefile                 |  2 +-
>  tests/binder/test              |  2 +-
>  tests/bpf/test                 |  4 ++--
>  tests/fdreceive/test           |  2 +-
>  tests/filesystem/Filesystem.pm | 14 +++++++-------
>  tests/inet_socket/test         |  2 +-
>  tests/ptrace/test              |  4 ++--
>  tests/sctp/test                |  2 +-
>  tests/sigkill/test             |  2 +-
>  tests/task_getpgid/test        |  4 ++--
>  tests/task_getscheduler/test   |  4 ++--
>  tests/task_getsid/test         |  4 ++--
>  tests/task_setnice/test        |  4 ++--
>  tests/task_setscheduler/test   |  4 ++--
>  tests/unix_socket/test         |  2 +-
>  tests/vsock_socket/test        |  2 +-
>  17 files changed, 29 insertions(+), 36 deletions(-)
[...]

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

