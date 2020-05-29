Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1CC433E1
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DD520C09
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/dQrg3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2N3J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2N3J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:29:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03260C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:29:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 69so1922583otv.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bapIoAZKLldrU+/FG/FDGImJMRpUc9zt38Y556RbT3w=;
        b=Z/dQrg3QBrwD398mKXRcUilMa16gsNkGSdbygdhdaT1U7/Jn4Qr/UIONRtY03/DWGI
         SomlqMW0liU0VD70sSgVy3zQGxUunoKBcbC3+oBLvcNjvModNLFvi3eEpsQoUZgG+Tfp
         PkTConI7AvZ/X4VXt+cpL0nCj239BwIC6VDPK6l36OKGuwwmRglv8lynK+Avt0yI1Ofi
         FF3ckkl4seOBbPFXwUBng3MJcS5KPLncEKBkENX7wsJiJ8hjtaqrrTBuaR6BYfUIU55E
         r3a70cfhoOb6JVuTYbNO6BpNew3/Ev06adKmHU1StSj3pvfJtDAQBjuGvyCBgn0vyqva
         Zujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bapIoAZKLldrU+/FG/FDGImJMRpUc9zt38Y556RbT3w=;
        b=p5yqe/uXj6Y5QN8hChPMN4h2o3qg6KaUvLJaOAHUSoLHFx5pKnTWMCtDTkkuj7eVHH
         1dezJhMaf5PqYZdxG9bca8dyotDVKZxxhgtsQrfUZhreETCKElA8iTPtsgDj+KQMWfr7
         7ZW7lpaa2qhjO6r60a8KD7NDLmTmgtEl1V85DXUly+Y8V98HwWLzeudVmTdi3MUjbUWM
         OsC2GuOuJ8xIfIT/WTb66lQx2gC6UFOzolXwDkAYFPiw6762qazJ0+MDUFtl4xC69q27
         aXV05Bw7zXmJahSq5EGazbA+gMO0Qg1giZNzXH1MyjEOPOwadTemE33xEXsbctyX1cSa
         BLKA==
X-Gm-Message-State: AOAM5327w/FnNxe5y3KZ6vpeWxKUyAKxF31TxCe2EhUbr2Jp3D7HUIWZ
        LBoGfktP9+Q16FCXoYPamGW0O+n/dnoDxUHTFpYzfFfF
X-Google-Smtp-Source: ABdhPJxeBpNXHLVMW5l5TrpcQ1adsBZ6T9X0S/+XPN53w2y4gswR8yJcIAcyp8wXwRIXbWpbaGhm2Pm2ekQwUndZ5wI=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr6149821otd.162.1590758948402;
 Fri, 29 May 2020 06:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200525131455.634532-1-andrew.shadura@collabora.co.uk>
In-Reply-To: <20200525131455.634532-1-andrew.shadura@collabora.co.uk>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:28:57 -0400
Message-ID: <CAEjxPJ6HpXWgUvOKAvHb8eJXLnuefdgHmh3MeYK3LzjDNaNBWQ@mail.gmail.com>
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

On Mon, May 25, 2020 at 9:16 AM Andrej Shadura
<andrew.shadura@collabora.co.uk> wrote:
>
> Spell =C3=81rp=C3=A1d=E2=80=99s name with the correct diacritics, put Ole=
sya=E2=80=99s first name
> in front of her last name.
>
> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
