Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE32AC10F1B
	for <selinux@archiver.kernel.org>; Tue, 13 Dec 2022 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiLMRoz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Dec 2022 12:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiLMRon (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Dec 2022 12:44:43 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98684220C7
        for <selinux@vger.kernel.org>; Tue, 13 Dec 2022 09:44:38 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3e78d07ab4fso202937777b3.9
        for <selinux@vger.kernel.org>; Tue, 13 Dec 2022 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=WZ1mKRQBVKmDwustjDGt5j+lf+imbCmjpXPsg1BBATOLjJOwG70Wy78s8BR04q3Gdq
         6x0b8plbylv5t6lB95U7p/M74lW+sMEBPSmdvx4l+L+ANQFN/U8Uyh0ytjcXcuSBjnPC
         jFj5+j3oUZw+Z1DQEPds2syc7iY/qe6YjRUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=E/yELCIrBay90Cf/0CbEGexKA0QoHwq3EYIgqYksVenZz4wPnurVW63TMP6Mdn/nHs
         blTi0x28FFZlWjab6/Hf7gJDMAVWfQINu0W8yPiIsmjWwpkP1Z6JHvJTSa1U1yHHPxO2
         HHZxtihU+ufzWGQkejeOAUz5V8qyUg5HncXOJZZdCle+8ZKj0IWs92xGlYlbmeriH4RJ
         yevDh8XpNpNB7hRIH+SKzOSxgaa4COaFsfvqZMdqKs0kE7DCgm/fgPNHY6rRKOyNG2AB
         Mk4yG4WwtnRK3LjGvWZCNdStl++FcOwPVptX300HLAnBPWeshzbUI+oembXHV3YEcyO5
         +hxg==
X-Gm-Message-State: ANoB5pnC1uLlLC1o8zq0rKRUqvtdqbnnhaffv2f3MocYSkhShiXaj0Om
        e5usAc9cxgDoAhTtm9Yk4TfVTZ+9BWwKjD1/
X-Google-Smtp-Source: AA0mqf7jKuq6xRoXlT5SRQxBik6ovbT5DIETyLamOv46c8EHw11LlbCj8z6I7DzC9HIaz4fBUmPm3A==
X-Received: by 2002:a05:690c:ed2:b0:3bb:ce5f:dd00 with SMTP id cs18-20020a05690c0ed200b003bbce5fdd00mr14676207ywb.19.1670953477235;
        Tue, 13 Dec 2022 09:44:37 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b006ea7f9d8644sm8483156qko.96.2022.12.13.09.44.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:44:36 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id e1so223247qka.6
        for <selinux@vger.kernel.org>; Tue, 13 Dec 2022 09:44:36 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10744372qkg.594.1670953476176; Tue, 13
 Dec 2022 09:44:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
In-Reply-To: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 09:44:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v6.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 12, 2022 at 7:05 PM Paul Moore <paul@paul-moore.com> wrote:
>
>   Unfortunately, this pull request does
> conflict with fixes that were merged during the v6.1-rcX cycle so you
> will either need to do some manual fixup or you can pull the tag below
> which has the necessary fixes and has been sanity tested today.

I did the merge manually, but compared to your version. They were
identical except that you hadn't added the documentation entry for the
gfp_flags parameter.

That said, I'm not super-happy with that merge - it was the trivial
straightforward one, but when I looked at the code it struck me that
the only thing that actually seems to *use* that gfp_flags argument is
that

        if (oldc->str) {
                s = kstrdup(oldc->str, gfp_flags);
                if (!s)
                        return -ENOMEM;

sequence. And it strikes me that this is not the only place where
selinux ends up doing that whole

                str = kstrdup(ctx->str, GFP_xyz);

dance.

It feels to me like that thing shouldn't be an allocation at all, but
that selinux should use ref-counted strings instead (and just increase
the refcount). It's in other places like context_cpy(), but having it
be a refcounted string would also potentially help with
"context_cmp()" in that the string compare could be a "is it the same
ref-counted pointer" and maybe hit that case most of the time before
it even needs to do an actual strcmp.

Hmm?

Anyway, that was just my reaction to resolving that conflict, and
obviously *not* for this merge window. I'm just saying that if you
agree, maybe that could be a future improvement, making the whole
allocation - and the whole need for that gfp_flag - go away?

               Linus
