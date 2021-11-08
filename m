Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFCBC433F5
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC9461361
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhKHVlW convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Mon, 8 Nov 2021 16:41:22 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51168 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbhKHVlU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 16:41:20 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 14A42565BAA
        for <selinux@vger.kernel.org>; Mon,  8 Nov 2021 22:38:32 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id e65so16382348pgc.5
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 13:38:31 -0800 (PST)
X-Gm-Message-State: AOAM53287ymNWLa/NZJ8sCiSZBg0zeP2I+pl++oo5tMGjq/Fz8ZU+KDM
        dKFc60jeJu4M6/ah6zwtEBqHQijZKnO8zJBWGa8=
X-Google-Smtp-Source: ABdhPJzYW/32kOjCYxa6RjHBXIYeRu5/0B2ddm5HlVBzDfm5uLMb3EzpGpO+5NGPwpRQSAGiY9iXNZ9iOO/aoUnWVsQ=
X-Received: by 2002:a05:6a00:1a01:b0:44d:af99:19c9 with SMTP id
 g1-20020a056a001a0100b0044daf9919c9mr2147490pfv.36.1636407510636; Mon, 08 Nov
 2021 13:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com> <20211019151123.10335-1-cgzones@googlemail.com>
In-Reply-To: <20211019151123.10335-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 8 Nov 2021 22:38:19 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mtO=1qyQPWGnpgOYU5K_3EFN4UVP09aF=SYpE3Sy5AUA@mail.gmail.com>
Message-ID: <CAJfZ7=mtO=1qyQPWGnpgOYU5K_3EFN4UVP09aF=SYpE3Sy5AUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: do not pass NULL to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  8 22:38:32 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 5:13 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
> use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
> be annotated with the function attribute nonnull and UBSan then
> complains:
>
>     link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

For these 3 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Sorry for the delay, I have been busy with other topics.

Thanks!
Nicolas

> ---
> v2:
>    drop realloc rewrite, just check for 0 size
> ---
>  libsepol/src/link.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 7512a4d9..b14240d5 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -190,8 +190,9 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>                         ERR(state->handle, "Out of memory!");
>                         return -1;
>                 }
> -               memcpy(newmap, mod->perm_map[sclassi],
> -                      mod->perm_map_len[sclassi] * sizeof(*newmap));
> +               if (mod->perm_map_len[sclassi] > 0) {
> +                       memcpy(newmap, mod->perm_map[sclassi], mod->perm_map_len[sclassi] * sizeof(*newmap));
> +               }
>                 free(mod->perm_map[sclassi]);
>                 mod->perm_map[sclassi] = newmap;
>                 mod->perm_map_len[sclassi] = perm->s.value;
> --
> 2.33.0
>

