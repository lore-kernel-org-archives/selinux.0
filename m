Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE9C433DB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72447207AB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3Jc4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 04:32:56 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41238 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3Jcz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 04:32:55 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B94AC564C3C
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 10:32:13 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id d8so14943872otq.6
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 01:32:13 -0800 (PST)
X-Gm-Message-State: AOAM531W23ihtoc3SK9CNb2VU3WdDDBcHvqBmb1ill8ewxsaj0Bb5TGB
        TLnwVerfvlPWUD2ka6OWBXjOUhP8WVYQth05C5U=
X-Google-Smtp-Source: ABdhPJynyO85pj1Pe84TgV/r1r/xija6jf7p3aAny+jMr8xBHQwrIv83cGmuRrvGj7Vs2moMOfh8gn4dvZhoJ4HJagw=
X-Received: by 2002:a05:6830:1e62:: with SMTP id m2mr38050208otr.279.1609320732597;
 Wed, 30 Dec 2020 01:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20201217145949.1230098-1-jhrozek@redhat.com>
In-Reply-To: <20201217145949.1230098-1-jhrozek@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Dec 2020 10:32:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nY56B_DFpjf1D5SD4E+-r2UM5_tM6dsv5tTgGu1moyKA@mail.gmail.com>
Message-ID: <CAJfZ7=nY56B_DFpjf1D5SD4E+-r2UM5_tM6dsv5tTgGu1moyKA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Free contents of modkey in semanage_direct_remove
To:     Jakub Hrozek <jhrozek@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 10:32:14 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 17, 2020 at 4:02 PM Jakub Hrozek <jhrozek@redhat.com> wrote:
>
> semanage_direct_remove allocates struct semanage_module_key_t on
> stack, then calls semanage_module_key_set_name which allocates
> modkey->name on heap, but modkey->name wasn't free()-d anywhere,
> creating a small leak.
>
> Signed-off-by: Jakub Hrozek <jhrozek@redhat.com>

Thanks for your patch!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I merged it directly.
Nicolas

> ---
>  libsemanage/src/direct_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index d2b91fb2..9a4e7938 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1951,6 +1951,7 @@ static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
>         status = semanage_direct_remove_key(sh, &modkey);
>
>  cleanup:
> +       semanage_module_key_destroy(sh, &modkey);
>         return status;
>  }
>
> --
> 2.26.2
>

