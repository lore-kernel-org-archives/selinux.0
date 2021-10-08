Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B184C433EF
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67DB60F6B
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 16:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhJHQIo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJHQIo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 12:08:44 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958DC061764
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 09:06:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o83so6916150oif.4
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPTYcgvrEX6Dlyi+3/8YG95M+Aq2ueYnjN02Eb30JBE=;
        b=b0yq67modc/OmlY6loTewvYPdzfoBKBBFBCb6tpHonVNl3IurSFgoijyu/7JkFeGGC
         1PnEFp4ozJrdxqTv+R+oNUmyN1DiboU7QVru/0TWgM9q1Z4VhOzr4jII3k54v2fR7EPS
         xfazEvKwBHoR7zlf2DJu27sqd696y+f6ACgJiDLq3iwifIdumKztSElAETTXTICf6u00
         5Zo6tl/uUh+2SRxskArYC4H4TdW0XuLqUrgBbKzHMPdXQZ0oI1FGITxvACVbMqv+4rJy
         q9Tq8rOIt0hGwoxI/N5Novqlj+jdQyqR2yef7rOq5ZkACb673XVEGT7xPIz5DQM0GEmr
         OVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPTYcgvrEX6Dlyi+3/8YG95M+Aq2ueYnjN02Eb30JBE=;
        b=y8gmp5skznuMUDIa7I8Mri/iEmshwHtSCByy07vthE2R3sV29GsEIi+rPD6H80jdEx
         OE9Xg6DkIqyl4VLFAqTfu6FpryQzeWvp1IIzhc8VVJANaQck/wjMMZePsJC1HkQZtvns
         UCIs0ePiGtpLkLLSPi0I3E+0lEZP6bVxKMfj8QpRZXK/AuVXH5JN6FPnde7r/ucHaTcw
         hYlB7awPyichTewQBxCbklbZJxGxiElFSgBHowAEfjF1C8WTAZomkUd0oIaEEiwCCW/4
         e6ZSOX4gfW0O7xAa0AmIT6TNIlvXJIvRsm0HyhMg5A7UtthkfhwpVYnDH/Yk/QjP+Fkz
         9bCw==
X-Gm-Message-State: AOAM532VlK5FGjlr6RfK9BDpO961lgL7keOJjZVYjKYJ5oRDja18EiNl
        TM3xxlS8gYeInp/Rr23A7xvaVWlD0Jn4EuCAhmE=
X-Google-Smtp-Source: ABdhPJwtYHZYwPmC24mCgDF/muJCOb4z8K9++pyEEANmjhKInT7WkeJrBN8sBEaK8rEJeCryQ+++w52g5XtGR1qJ3fk=
X-Received: by 2002:a05:6808:58:: with SMTP id v24mr17542996oic.144.1633709208203;
 Fri, 08 Oct 2021 09:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211008144921.377072-1-jwcart2@gmail.com>
In-Reply-To: <20211008144921.377072-1-jwcart2@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 8 Oct 2021 18:06:37 +0200
Message-ID: <CAJ2a_DfvP5GuHqUoe9pmyHgWWcJk1kx9wypJZcXy_PcFG862Qg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix potential undefined shifts
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 8 Oct 2021 at 16:49, James Carter <jwcart2@gmail.com> wrote:
>
> The maximum number of permissions in a class is 32. This is so that
> each permission can be represented by a bit in a uint32_t. In two
> places while building the binary policy from CIL an expression of the
> form "1 << x" is used to set the permission bit. Unfortunately, this
> expression is undefined if x == 31 because the 1 is an int and cannot
> be left shifted by 31.
>
> Instead, use 1U << x, because an unsigned can be shifted 31.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index ec5f01e5..90af430d 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *da
>                         goto exit;
>                 }
>         }
> -       *datum |= 1 << (sepol_perm->s.value - 1);
> +       *datum |= 1U << (sepol_perm->s.value - 1);
>
>         return SEPOL_OK;
>
> @@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
>         cil_list_init(&cp->perms, CIL_PERM);
>         for (i = 0; i < sepol_class->permissions.nprim; i++) {
>                 struct cil_perm *perm;
> -               if ((data & (1 << i)) == 0) continue;
> +               if ((data & (1U << i)) == 0) continue;
>                 perm = perm_value_to_cil[class][i+1];
>                 if (!perm) goto exit;
>                 cil_list_append(cp->perms, CIL_PERM, perm);
> --
> 2.31.1
>

There might be more instances (not in libsepol/cil though), as a
simple `grep -REi "1\s*<<"` shows (false positives removed by hand):

libselinux/src/stringrep.c:                             return
map_perm(tclass, 1<<i);
libselinux/src/stringrep.c:                     if ((1<<i) & av)
libselinux/src/stringrep.c:                     str =
security_av_perm_to_string(tclass, av & (1<<i));
libselinux/src/stringrep.c:                     str =
security_av_perm_to_string(tclass, av & (1<<i));
libselinux/src/mapping.c:                       if (tperm & (1<<i)) {
libselinux/src/mapping.c:                               tperm &= ~(1<<i);
libselinux/src/mapping.c:                               tperm |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                               result |= 1<<i;
libselinux/src/mapping.c:                       result |= 1<<i;
mcstrans/src/mcscolor.c:                        mask |= (1 << i);
mcstrans/src/mcscolor.c:                if (!(mask & (1 << i)))
python/audit2allow/sepolgen-ifgen-attr-helper.c:                if (av
& (1 << i)) {
checkpolicy/policy_define.c:                    node->permissions |=
(1 << (perdatum->s.value - 1));
checkpolicy/checkpolicy.c:                                      if
(avd.allowed & (1 << (i - 1))) {
libsepol/src/conditional.c:                                 (test &
(0x1 << j)) ? 1 : 0;
libsepol/src/conditional.c:
cn->expr_pre_comp |= 0x1 << test;
libsepol/src/services.c:                *av = 0x1 << (perm_datum->s.value - 1);
libsepol/src/services.c:                *av = 0x1 << (perm_datum->s.value - 1);
libsepol/src/avtab.c:   nslot = 1 << shift;
