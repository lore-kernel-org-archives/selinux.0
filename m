Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6833C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiF1WBb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1WBa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 18:01:30 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0C2314E
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 15:01:30 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 160295647BD
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 00:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656453688; bh=yFpuiUnljPiCyAKnDKpgldx/9Gc65awI6yo/hx5pi58=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=QbfaKbYZeb0fhdseE3uJiuNdz5fpP0+iLzctly95Snk3my/kPCBB8vR0QPIY39DVH
         dTAdd7ijWG8Nc97tfjUDRWinRL0dy1+ZoadTySCtYF9USiqz0KaDD6Myx6IoE0jV6o
         zX6U0BHq4uNgOWal0IGIWetlPESZTl1+23Y89WC0=
Received: by mail-pj1-f45.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso17321749pjn.2
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 15:01:28 -0700 (PDT)
X-Gm-Message-State: AJIora/tQgdqTX7OKu+fPEnlWFqTO8rDFlVF/KPEm8NMcL4X2S7hfUT+
        MUSp66ZeWCFbK4QAe1dYWfAATqfYRU9o0KF/EVI=
X-Google-Smtp-Source: AGRyM1vHnVLcj9yLxwk3v3nrp6oPOtSeTXyxin4wC5q/QQmoSgrEH1obNAD+9yMaqzTjO6nE3/nzS0DlI7B62ATnVJs=
X-Received: by 2002:a17:90a:590e:b0:1ed:59f0:bc2f with SMTP id
 k14-20020a17090a590e00b001ed59f0bc2fmr63663pji.120.1656453686714; Tue, 28 Jun
 2022 15:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220616131409.23271-1-cgzones@googlemail.com> <20220616131409.23271-2-cgzones@googlemail.com>
In-Reply-To: <20220616131409.23271-2-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 29 Jun 2022 00:01:15 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mxr2k=vZYVFK757bC_BD4a6Yf-pbTFfheMDcaY9mgJDg@mail.gmail.com>
Message-ID: <CAJfZ7=mxr2k=vZYVFK757bC_BD4a6Yf-pbTFfheMDcaY9mgJDg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] libsepol: add ebitmap iterator wrapper with startnode
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 29 00:01:28 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 16, 2022 at 3:14 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Similar like ebitmap_for_each_bit() iterates over all bits of an ebitmap
> add ebitmap_for_each_bit_starting() iterating over all bits starting
> from a specific node and bit, which can be from an outer iteration.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/ebitmap.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include=
/sepol/policydb/ebitmap.h
> index 81d0c7a6..83ff54c2 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -80,6 +80,13 @@ static inline int ebitmap_node_get_bit(const ebitmap_n=
ode_t * n, unsigned int bi
>  #define ebitmap_for_each_positive_bit(e, n, bit) \
>         ebitmap_for_each_bit(e, n, bit) if (ebitmap_node_get_bit(n, bit))=
 \
>
> +#define ebitmap_for_each_bit_starting(e, startnode, startbit, n, bit) \
> +       n =3D startnode; \
> +       for (bit =3D ebitmap_next(&n, startbit); bit < ebitmap_length(e);=
 bit =3D ebitmap_next(&n, bit)) \
> +
> +#define ebitmap_for_each_positive_bit_starting(e, startnode, startbit, n=
, bit) \
> +       ebitmap_for_each_bit_starting(e, startnode, startbit, n, bit) if =
(ebitmap_node_get_bit(n, bit)) \
> +
>  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
>  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitm=
ap_t * e2);
>  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> --
> 2.36.1
>

I find the names "..._starting" confusing: the first bit which is
iterated is the next one after "startnode/startbit". Moreover,
startnode really needs to be not NULL for this to work, and in
practice it works because this macro is used inside a
ebitmap_for_each_bit() loop which ensures that startnode !=3D NULL. To
avoid possible semantic issues, I suggest naming these macros
"..._after" instead: they are about iterating the bits of an ebitmap
after some known bit. (Of course this is my humble opinion and please
feel free to disagree and to keep the name you chose if you do)

Thanks,
Nicolas

