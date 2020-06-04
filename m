Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8154C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52622067B
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRBSXL2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFDU0x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFDU0x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:26:53 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C6C08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 13:26:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m2so5810306otr.12
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d68JhSMGQiD9TYlRKu88Cv5AANKOLfolliE4B7zRVGM=;
        b=hRBSXL2ocbQNxyI3BqvWr5+o2rJBO9IGHmga+FS2mOkbEV9RKsMeoPyT3Uh1YXwk+D
         YdaJ/tp2zACkhEOE4eyiPT+tpCOhBxGJOD0kTPpBtEkBucE60rD110t3egVUhiDIxR3b
         ib9K4qhtB8N2v3GL+1NVvKLaVWL1/3AXU4T2pnZazbr7+utTStUBSE6jP5mOITmKQkoz
         5uG4ENXcE7zDub26d3e+aCxXQXvDLo+iwAZrr4O/Exq1/icXPHKoDXoryJJrr1QNfU3z
         HPZsHQTm0Ajt1Adyxk+7ExWs3F7JcUAKhvdlrttpSG5CINRINNUopVt65OaH/7t2Ktkr
         aDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d68JhSMGQiD9TYlRKu88Cv5AANKOLfolliE4B7zRVGM=;
        b=esxqCzpT/dAjoWf2KAKZC3OaDxlJvSGZEg73TzlD7OqZNMlbq4+JDMzKf02gC/LJDP
         EeodQM7ufHLf10Lacfe2HJeL7z9axxOu3kLXYKokaGgAp29s5fBvoKIs7Ffgg7IN+WQK
         YM/zFeGXF+PuULp069cyxKijDSvfNJxI8KjPKNaWFoqW3oHjESKJMg9B1xFET9bPlSbK
         mzk3YUM96696MTKtDiDYZwEIUXZjH9ct/4cnhNO+s+Hs+No0Rti8MO+AOuyKaV/Bw94V
         Cem8rDj4QU5+b6q/9VL1va1n+5hFWz9w5Mup8mEOSUMdz38rjRPzVn3rsdmc9yYKg+2X
         1iZw==
X-Gm-Message-State: AOAM530BQ/yWlqhPxMizl0kl3tAinV1Qzbm7sB7aHfFWPQle/8EiIsaE
        XzPbVbyZgPzhIiVyezqxMzAP5pkNOr+ToBH4SGw=
X-Google-Smtp-Source: ABdhPJxRjz7+fJyyAnbBa28/0z7xJuLzsS/VHLqdQ/isXoYWF8mQIESGSeqFo7nKwxHn88zF9VRhneEAPcabq/e4hPs=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr4768919otp.89.1591302412431;
 Thu, 04 Jun 2020 13:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com> <CAEjxPJ5f2r5R3AhZUxdYhO1U-OWdEd_+Mxfh=Q-THAuGF=Q4nA@mail.gmail.com>
 <CAJ2a_Df54uupe42E_Dkcpa-wP+DG+m3bWN-9My_bon=h9RNS9g@mail.gmail.com>
In-Reply-To: <CAJ2a_Df54uupe42E_Dkcpa-wP+DG+m3bWN-9My_bon=h9RNS9g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 16:26:41 -0400
Message-ID: <CAEjxPJ7551r1FNR_i+HV-pVD8nF_kpb8jQX0oJVV2a7UHZXJ-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sepolgen: parse gen_tunable as bool
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 10:52 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Am Do., 28. Mai 2020 um 16:23 Uhr schrieb Stephen Smalley
> <stephen.smalley.work@gmail.com>:
> > Looks like you need to also support the case where no quoting is
> > performed.  Otherwise, I still see syntax errors, e.g.
> > /usr/share/selinux/refpolicy/include/services/apache.if: Syntax error
> > on line 35 allow_httpd_$1_script_anon_write [type=3DIDENTIFIER]
> >
> > 35: gen_tunable(allow_httpd_$1_script_anon_write, false)
>
> I tried to avoid that by modifying Refpolicy[1], but I can include the
> additional grammar.
>
>
> [1]: https://github.com/SELinuxProject/refpolicy/pull/201

Looks like your refpolicy pull request was merged so I guess we can
take this one as is if we don't care about fixing it for older
refpolicy versions.  The third patch in the series still needs to be
reworked or dropped I think as per my comments there.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
