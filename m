Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839FC433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 13:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9268D2067B
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU85itTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgFINCZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgFINCV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 09:02:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D8C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 06:02:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v13so16525457otp.4
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZUe2Ry3iHI0WxuUjcro2JDoHKiMoIAjdUzJhJ2lwxk=;
        b=SU85itTzhAErEdz73hwMFivf/e96vuC9bDSNLaUc+Wxy6AyIGEeAIQnsvt0d8YfZ15
         HkrKKFdl9mTrvBAdtQxiDHxSs0Ys5UVeyAv1trrgC3t7lutZBlGEaFodRfOtxKc59MNT
         f5I/ABcO2demrKmpo+w2uLq9eYg0mv3R5lG+2FxUk3OG67UoDMG00SC+9XwmpjJG6FPv
         TDfVPdhWl2bEfsMpkj2S05xeOAVDXn+5We7cySV/zYPd132zH2mC9x+YxJPLi38t3tZe
         5NncfUsOwTwhd1fGzMNq0eJMgjXDYMoCN5XE1i9h2O7L7sn+TbmYsYgSeBGDHsDK1LP/
         bt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZUe2Ry3iHI0WxuUjcro2JDoHKiMoIAjdUzJhJ2lwxk=;
        b=g8QiD4E0xFzU9fU4bJCy7Rr1NuJCA4f50FdThNJLwRkkdX1KBwdqqewaP4FecNs6vX
         8o5joqdyM5nd4eCqHOD2W95jXpW68AOSN0M6uP0BEJLO1NR4lw8CzCoLhNfNTRk6suBy
         d4pHO1BMBdYsMKam1xbod3NuhsnEhsZsdJYv9Lx3Ca4bxU5k9aQVu1eZsmKqqJ1Bxz5T
         QuKa9xXvJcqLOuDLjxjOtm8+Wp4NAE5da3eCtISX5ZhRFivk78/FketemN2osO2GI0qa
         J6X8NT9hiFZnspeEW8XMblP+oB89ZQo7EyIFaHBTazZowQMs1ti5WghtgrvMctOe0R5j
         UgXQ==
X-Gm-Message-State: AOAM530op3YMdnyh2PMSb3shBZ5Epoox+vxnnTLWrBEo9JSjFdtM931k
        kBux3PSKQYTaIMi8F/fAD2umUBCXmk4m1VfDl1A=
X-Google-Smtp-Source: ABdhPJyLnDjFsRUdVpukTTXB3g1XXpZatfafuxSfL2esPZ2DbKXTWnHMvEjp4xGwXvOGXGYDdYqYvCbTLBuw4MiADAk=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr20291251otp.89.1591707739012;
 Tue, 09 Jun 2020 06:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
In-Reply-To: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 09:02:08 -0400
Message-ID: <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
Subject: Re: No window opening when running sandbox -S
To:     Cristian Ariza <cariza@collaborative.li>,
        Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 9, 2020 at 4:05 AM Cristian Ariza <cariza@collaborative.li> wrote:
>
> $ sandbox -H sandbox/home -T sandbox/tmp -S
>
> shows a few Gtk warnings (which I am assuming means Gnome loaded
> somewhere) but no window opens. In the man page I can't find much
> information about how sandbox -S actually works so not sure if I am
> missing something or it's just a bug.
>
> I am using Fedora 32 with Gnome.

You are using sandbox as packaged by Fedora in
policycoreutils-sandbox?  If so, please file a bug against their
package.
To be honest, I don't use sandbox myself and I am not sure it is being
very well maintained these days.  It was originally created by Red
Hat.
It seems like it has been OBE by other efforts to sandbox apps on
Linux e.g. flatpak or snaps although I don't know that any of those
are leveraging SELinux.  I'd be tempted to remove it upstream unless
it is getting proper care and feeding.
