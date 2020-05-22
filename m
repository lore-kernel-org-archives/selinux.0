Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14335C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95D62070A
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgEVS77 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 14:59:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50248 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgEVS77 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 14:59:59 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CEBEB5612C1
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 20:59:55 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id r25so10198352oij.4
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 11:59:55 -0700 (PDT)
X-Gm-Message-State: AOAM533h+fU7zbDa9NSXTRi6qqXZ5YtEyE878FqCcTLKBTd+cnQ8+c4U
        EHGsaYPrRg3KvsiEnvS9fz5H0ZT8PPOZYDVyLhw=
X-Google-Smtp-Source: ABdhPJxO4mDXpsraXbTfBTfYb8iWAwsQogwRPy7XKnNRezcHnlC78SJampogzksF6SFG7/Losij5zE31h74BMEW8C4U=
X-Received: by 2002:aca:4852:: with SMTP id v79mr3462742oia.20.1590173994846;
 Fri, 22 May 2020 11:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200522074648.24538-1-congdanhqx@gmail.com>
In-Reply-To: <20200522074648.24538-1-congdanhqx@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 22 May 2020 20:59:43 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==OdP23Mh06V=qaktKas3wOkz12=ZELj5vOHsDN1t_5vw@mail.gmail.com>
Message-ID: <CAJfZ7==OdP23Mh06V=qaktKas3wOkz12=ZELj5vOHsDN1t_5vw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: utils: link with shared libfts
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May 22 20:59:56 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 9:46 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
>
> On Linux with musl libc, libfts isn't shipped with libc.
> Hence, we link with $(FTS_LIBS) in src.
>
> Some (most) musl-based distribution choose to ship libfts as
> a standalone shared object because their libfts is licensed under either
> very permissive license or that implementation of libfts requires
> attribution in every usage.
>
> Always link with $(FTS_LIBS) in utils to prevent undefined reference
> problem on those platforms.
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  libselinux/utils/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index aa2d3e1b..1a7da223 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -45,6 +45,8 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
>  override LDFLAGS += -L../src
>  override LDLIBS += -lselinux $(FTS_LDLIBS)
>  PCRE_LDLIBS ?= -lpcre
> +FTS_LDLIBS ?=
> +override LDLIBS += $(FTS_LDLIBS)

Hello,
A few lines above there already is "override LDLIBS += -lselinux
$(FTS_LDLIBS)". Why do you need to add $(FTS_LDLIBS) to LDLIBS again?

Thanks,
Nicolas

