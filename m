Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C8C433F5
	for <selinux@archiver.kernel.org>; Mon,  2 May 2022 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385559AbiEBOhU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 May 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385518AbiEBOhT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 May 2022 10:37:19 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532705F81
        for <selinux@vger.kernel.org>; Mon,  2 May 2022 07:33:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-ed9a75c453so3897975fac.11
        for <selinux@vger.kernel.org>; Mon, 02 May 2022 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAHMd9Y3KkKmf9ZjCG+s1Ss6l/cI4Ju8NyB+j0mWocw=;
        b=CgKkbNg2D13zkO7krefi2wD63YoUx97iqxCNvjb9sH4kOE+lxhq2hH9iGLJ1vQgLJw
         EdV2fHzgRnqqStwXLvtdZhQGPWICn8s43QoUR73cxs2gD0adryL0REuaqxNGoToQOly5
         sX38UEDJ5qjDOuxBy370m6con6NQkYAcpiY6rhec/UYODKYi478oVG/uznRXm/BFD5dz
         NJ+ecjH8dWSaUAKlZX8YR0xK/o04SsaDwGiKu3jASUtGeic4k8KE37F7GyAPSsMroR4t
         R0QZ6qFe0n1OCFn3IWbLdSZdXhNeEXaaYa5gzkAy7xIKfjFrBpAYRSCe/q/YQ2w8k/Ve
         QRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAHMd9Y3KkKmf9ZjCG+s1Ss6l/cI4Ju8NyB+j0mWocw=;
        b=0brosADpg4RL3hbBMd08xU0AEN6j4kCQymvslbavGJbRa/3LtIanar3PeBTcUU3fNK
         ZX5eFuInp9SaRXK0a0Perwa7T6ClDu4AT8VSsOQM4q9iigi91afM2ipwdZEzJMinI3aH
         QhLCiHTfMroNAMwz//RL3f8sqG4XIQWpF7Ioc4ne5pTEnFM13SHN4r830wy7tYaDmv15
         gXK7DIGuGRRtLSpKxrEY3qF5IJJC04sy/pLTiqNDH5FUSI8vz7gnVdlGaqoc/YTaJrKZ
         cweyVuXjcumFBm9ys3u0UhsQrIbruqQYxO7+OHH4dSkiZ3ieMaE7er5UIl4brKLLTiPz
         9iIg==
X-Gm-Message-State: AOAM531QyyRv8aIftoTw2ce7oUI085TpK8quyOYK+0dIR3noBXoxsQvF
        ZDyBb7Fw4LsTUEXB45nAZxxu55Mzgs++jE744v0OIMPj494=
X-Google-Smtp-Source: ABdhPJzqrNPwwsEOxPw90PzGFksznIJXDvU/mjGJiVhUtMsBJZuaY51LbDC1XkIPEsaqUZEgqxtfI0N3yrBhdqBn8Ok=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr4796764oab.182.1651502028680; Mon, 02
 May 2022 07:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220428162358.396459-1-plautrba@redhat.com>
In-Reply-To: <20220428162358.396459-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 May 2022 10:33:37 -0400
Message-ID: <CAP+JOzQndjcqLA2=QNC-9u4C_Tj04Gd+1xaZfodp43WUYqUf8A@mail.gmail.com>
Subject: Re: [PATCH] Update missing sandbox translations
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 30, 2022 at 4:19 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Source https://translate.fedoraproject.org/projects/selinux/
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> Available at https://github.com/bachradsusi/SELinuxProject-selinux/commit/d108226d3fc6ac2b83d7de61fe9c626877df7870
>
>
>  sandbox/po/cs.po       | 154 +++++++++++++++++++++++++++++++++
>  sandbox/po/da.po       | 176 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/de.po       | 175 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/es.po       | 178 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/fi.po       | 181 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/fr.po       | 183 +++++++++++++++++++++++++++++++++++++++
>  sandbox/po/hu.po       | 158 +++++++++++++++++++++++++++++++++
>  sandbox/po/it.po       | 192 +++++++++++++++++++++++++++++++++++++++++
>  sandbox/po/ja.po       | 178 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/ko.po       | 171 ++++++++++++++++++++++++++++++++++++
>  sandbox/po/nl.po       | 177 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/pl.po       | 178 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/pt_BR.po    | 174 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/ru.po       | 176 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/sandbox.pot |   6 +-
>  sandbox/po/si.po       | 156 +++++++++++++++++++++++++++++++++
>  sandbox/po/sv.po       | 176 +++++++++++++++++++++++++++++++++++++
>  sandbox/po/tr.po       | 182 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/uk.po       | 178 ++++++++++++++++++++++++++++++++++++++
>  sandbox/po/zh_CN.po    | 171 ++++++++++++++++++++++++++++++++++++
>  sandbox/po/zh_TW.po    | 169 ++++++++++++++++++++++++++++++++++++
>  21 files changed, 3486 insertions(+), 3 deletions(-)
>  create mode 100644 sandbox/po/cs.po
>  create mode 100644 sandbox/po/da.po
>  create mode 100644 sandbox/po/de.po
>  create mode 100644 sandbox/po/es.po
>  create mode 100644 sandbox/po/fi.po
>  create mode 100644 sandbox/po/fr.po
>  create mode 100644 sandbox/po/hu.po
>  create mode 100644 sandbox/po/it.po
>  create mode 100644 sandbox/po/ja.po
>  create mode 100644 sandbox/po/ko.po
>  create mode 100644 sandbox/po/nl.po
>  create mode 100644 sandbox/po/pl.po
>  create mode 100644 sandbox/po/pt_BR.po
>  create mode 100644 sandbox/po/ru.po
>  create mode 100644 sandbox/po/si.po
>  create mode 100644 sandbox/po/sv.po
>  create mode 100644 sandbox/po/tr.po
>  create mode 100644 sandbox/po/uk.po
>  create mode 100644 sandbox/po/zh_CN.po
>  create mode 100644 sandbox/po/zh_TW.po
>
