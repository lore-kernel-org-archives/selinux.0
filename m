Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C954C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FC0206C3
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 20:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMc6URrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFDUMw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFDUMw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 16:12:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5FAC08C5C0
        for <selinux@vger.kernel.org>; Thu,  4 Jun 2020 13:12:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g5so5788282otg.6
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dj/aeTjI7AO8uJbQp8Y3xm7lRNo2wv6+wlHyvIdwVWM=;
        b=LMc6URrrT5eWlnHxlypVYsmafQ5jHjo3LpKug2/JbJ3xx9oEqjEugi75rMsk0vGgmO
         ISo5MCYQsYUoUPlxzjbH5Lg+043Jbtd7W1BGy2gUalHDx0hp9Lq5a4citrPipOqxh6Mv
         XFMhAoQcIRyQtEzvKcuV56mjSFktV32GgXaKDJwk6utXKlHFlFobEUKTAOSm4rJvrJ6I
         OMe7Jh/iCX2GgvdAwjKZdYOSokbPbNOzOKDYl7086zMyMK6fVQNVdzdtwualQZQcugxN
         Rp6T1eoAahUSE614G6A59PnlC7BMaQwQ6AROLVXJFrNbw6i40kiszaTzx4zWhTsCJ+ig
         zQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dj/aeTjI7AO8uJbQp8Y3xm7lRNo2wv6+wlHyvIdwVWM=;
        b=mS5CjNrP6wFHzNmAT3ZKLZkRtpN5pxElyJr4Rwlkqq6/vusDWzVcirmo8WbI7MwPNw
         K4q4ik4nRnOt3+eQ/CU1pljP4W1/atD1Ki9bQKr0R0S7dQeDFKzQrebykDfIXMxUOJFa
         1RF9SfD5ohC7Hzox6Vf9nvG6d2lbcJtPvzlb3jWTvASv8/WsyjaTKOdF059YGP93N0Q4
         yyMxJuZ+YXx/FWHPNq4nsKYSH1RGJ6pDpoxDOnrR7NelZvNhqJfGVBKCI5HyN4S7bD3D
         59ztkU5pFus4RvHR9NV8U4Ff6BGxM+UE/HQL3Z8Vnt4UPyK95OpqbJPwRGeJ/jtmVCb7
         n/cg==
X-Gm-Message-State: AOAM530xxFF5o+z9tm+TGI+Vt8SfzmA784CDtvtFC0/XRNBETXgsjpeO
        EgsaubEMAIpWTAVwqUlrF35lxAmQTo0cm3bU36hn+Q==
X-Google-Smtp-Source: ABdhPJxFp4XqVQ59+fJEat+VnUaAn716jmJdAEu+FLNslDRInuo7WpMWTIBVrW8N67w+bLJaGdM3501f27kYk3/j4TA=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr5163060otl.162.1591301571486;
 Thu, 04 Jun 2020 13:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200525131455.634532-1-andrew.shadura@collabora.co.uk> <CAEjxPJ6HpXWgUvOKAvHb8eJXLnuefdgHmh3MeYK3LzjDNaNBWQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6HpXWgUvOKAvHb8eJXLnuefdgHmh3MeYK3LzjDNaNBWQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 16:12:40 -0400
Message-ID: <CAEjxPJ4LJ5u1EsG_eCESqFLdc+_2Dn6bbw7u7Wguihmi=jY=Pg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Minor tweaks to the names of the
 contributors to the manpages
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 9:28 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 25, 2020 at 9:16 AM Andrej Shadura
> <andrew.shadura@collabora.co.uk> wrote:
> >
> > Spell =C3=81rp=C3=A1d=E2=80=99s name with the correct diacritics, put O=
lesya=E2=80=99s first name
> > in front of her last name.
> >
> > Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
