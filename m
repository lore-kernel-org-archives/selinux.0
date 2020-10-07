Return-Path: <SRS0=UCTl=DO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8AC4363D
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAB7207EA
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 12:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6YkDcUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgJGMft (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Oct 2020 08:35:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D3C061755
        for <selinux@vger.kernel.org>; Wed,  7 Oct 2020 05:35:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f37so1953962otf.12
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2020 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q76Z7xRCjeM5gskagIISBLRpTgRTKcc7itgve17XDVQ=;
        b=U6YkDcUwqZ1rb3pu2yHXVSTNfxNl2rV2B/Fl2/MkDGWaOvN3TNwZnwQrzD5IBtE3XO
         De9BddKSW5i0XtOqg90ko9iS7XK4Zj7Ko0D8WBDn9znT+1ePdbW8HPak3o12am8i0snI
         4Vs0ewX6/VrKn0IbQ+iezRrqwNYMIJaIBD79lLMxKdWo/ID6V3ayltyyqs4DNLQFoxyt
         dOAtnF71aSMsRvntEwFKoFhIR8ctyCFPI6w3D6LoGE5eAMkqh4En6hl539ytsEFqMbkH
         kWTK1JjPPCz4LmrdA13LMZ6NsNgN61Kmv3E1El613p5KZF2Ofb5WexgxaRtjQF7wpisg
         e+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q76Z7xRCjeM5gskagIISBLRpTgRTKcc7itgve17XDVQ=;
        b=iXNybnrZrPGbejAH4jb832yzI5ifzURRDXtu0nZ4O/r/Oty7w7xOGBkU3Y3IQxXFB6
         b6G7/m7LfIbu3NDDKGkRH8ioPhLH74IXE77+wGdZBFwV1fIOWXSfXSg/ajZ9TpKyjEte
         ZC6j3n3fWjrs3UAWa07SQ32ImD2myl8UlqdY+L2qCBdcMFhu94/EYM1lqcXPfGU9DcF3
         iOb9UNqDLFigUGrMWHR0YDgbFj1f+FLcURVt+hE5W+AfW9dV+d9VSZdThwrk/LiCknOg
         cbe5wSsDVn9ojZx3oB+5aXG8v3nTlSK5EoHKeQx9v0balfJ7C1tsch3U4op/19A6byt7
         bbqQ==
X-Gm-Message-State: AOAM531UptlD6bE4gqCNl8j00mD2Vs2zOn2tX21SyYl/5LcV9cKY9rsl
        M8Azo/y4LRh8u9OW8XnChahRSMTIuLepygVbllQ=
X-Google-Smtp-Source: ABdhPJzwaYpOgfBkhyAVuEDqDpPWc6n63ME2HLnf3zJuFmezXum1jeRd7L2U/dnRzAM48KqytQJ48j0NXq6FWGNpeGs=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr1624548otc.368.1602074148708;
 Wed, 07 Oct 2020 05:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201007095033.GB194132@fedora.redhat.com>
In-Reply-To: <20201007095033.GB194132@fedora.redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 7 Oct 2020 08:35:37 -0400
Message-ID: <CAEjxPJ630EuLcg3PUTKM51S7y=PjO-8=AUOBMKsLOi7jboTQ_w@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 7, 2020 at 5:50 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> Thanks, I'll prepare another patchset with improved commit messages.
>
> In the mean time I'm looking into removing deprecated symbols from libsepol as it's
> supposed to be required only by selinux components. So far I've found that
> deprecated sepol_check_context() is used in chkcon utility. As Fedora doesn't ship
> this tool I incline to remove it from libsepol as well.

Looks like it is also used by setfiles and sefcontext_compile at
least.  Might have been copied into external packages as well, e.g.
busybox.  So that one might need to stay.  The reason it was
deprecated was because it predated the introduction of the use of
sepol handles and relied on global state set previously via
sepol_set_policydb_from_file(), so I think the idea was to convert
over to using sepol_context_check() instead (but this requires a much
longer sequence of calls, ala h = sepol_handle_create();
sepol_policy_file_create(&pf); sepol_policy_file_set_fp(pf, fp);
sepol_policy_file_set_handle(pf, h); sepol_policydb_create(&policydb);
sepol_policydb_read(policydb, pf); sepol_context_from_string(h,
string, &ctx); sepol_context_check(h, policydb, ctx);).  Probably not
worth the trouble now.

> And there's also
>
> /* Deprecated */
> struct sepol_handle sepol_compat_handle = {
>         .msg_callback = sepol_msg_default_handler,
>         .msg_callback_arg = NULL,
> };
>
> void sepol_debug(int on)
> {
>         sepol_compat_handle.msg_callback = (on) ?
>             sepol_msg_default_handler : NULL;
> }
>
> /* End deprecated */
>
> which is used on few places internally.
>
>
> Later I'll check whether sssd uses any on deprecated libsemanage symbol and
> decide what to do.

The main ones in libsepol that I was referencing were the ones in
libsepol/src/deprecated_funcs.c.
