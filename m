Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168EDC432BE
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F1B60FC3
	for <selinux@archiver.kernel.org>; Tue, 31 Aug 2021 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHaSZg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhHaSZf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Aug 2021 14:25:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CCDC061575
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 11:24:40 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i3-20020a056830210300b0051af5666070so263636otc.4
        for <selinux@vger.kernel.org>; Tue, 31 Aug 2021 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=igCKDcqLYOJqvXJx0jklWON89oaebqVN2+05PLU0ofM=;
        b=EMWVl5hw40wPMTdRPWH9GcuZ9G7+6iLmkV1ckkmS2XPR87LuF1hzg2a3TUisGBQSR7
         DSUOmxR6/gUFDD9G4wNZTaeqe0M2wXBTrUioxSqWeck97RnG4EQP/urDJu7TD1ZD00tf
         xgrBLG7p5FHAiUurtlNISl2T7WWr607OaBMkXuVC9bkbEWT+wVsibHwGBOMW+GU0ofS8
         ILEE3tvP4fLoY7l3XjIvB8tjPiMO7DGjXfeyJ4jH2mtvwO4iDD9OWtHpdkqoH4bZ3UTH
         O+DK7IgGinYWAv8q/McuzWWCA/0e43tjtIPs7mPnrKiIitsT38DvPYffDIVLr6NYXdTk
         jjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=igCKDcqLYOJqvXJx0jklWON89oaebqVN2+05PLU0ofM=;
        b=AtMePPg2IzKWCjdGsz/ylI1vd/B+QOlCiZY8kk3ML2rZoySVL0be/RI5E5T83YTutF
         B8u5yRHdWS4qb4bEb8xF69hQZdnOPs0hkBDSyd53ahvGOchn7a2q/jX442iCyxqC+6AE
         b1r/1llfAivLolO3wXpvpZzkb4gHjxNruGkNLKHVxPiLYRR4xz1HVPDjwCGWVZCy+wvw
         wn+iyPgQeo6aIN8r1TtDEyZthx2IBGLKiPDI6rIhtf++BfqwFECYYgFEDCU+8cfJwMAF
         5VMgu+05Wa2mieqVAWiKJwt9ZWHr0sgVv5pOHsNg5TrEX1AY/AQ6rj0pOTEvGmbh09nw
         2Jvw==
X-Gm-Message-State: AOAM530Y7lOMLAVoM0NebsYZ5qc0C0UP7VX2lqpo4ZeP8GEXt+zWllsM
        2v+6qNxelayX44gx7rBdcPKAuP50d8d87X+HSsjxvCMOpII=
X-Google-Smtp-Source: ABdhPJxH8X1wLjREgYKbFUbJeapl9PctKuarHArnV30ZBkGdy/C6x+FXkmrZQwIdX13Ajxi/wILp303ONH3XW7HSM/Y=
X-Received: by 2002:a9d:36d:: with SMTP id 100mr24728692otv.237.1630434278906;
 Tue, 31 Aug 2021 11:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <87czpthm7x.fsf@defensec.nl> <878s0hhlwp.fsf@defensec.nl>
In-Reply-To: <878s0hhlwp.fsf@defensec.nl>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 31 Aug 2021 20:24:27 +0200
Message-ID: <CAJ2a_Dc+YG0v3tMzXKYoFNfQykHwnhr9yE9+MxfAE1JTQSQ=Mw@mail.gmail.com>
Subject: Re: libselinux issue
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 31 Aug 2021 at 13:51, Dominick Grift <dominick.grift@defensec.nl> wrote:
>
> Dominick Grift <dominick.grift@defensec.nl> writes:
>
> > We can get into a state where selinux is enabled without a policy.
>

While testing a potential fix several questions came up:

I. What are the expected/desired outcomes after the following
configuration setups:

    * invalid SELINUX=, valid SELINUXTYPE=  (currently permissive,
except cmdline contains `enforcing=1` then system halt)
    * valid SELINUX=, invalid SELINUXTYPE=  (currently disabled if
SELINUX=disabled, system halt if SELINUX=enforcing or `enforcing=1`,
else zombie state)

II. When does the kernel considers SELinux to be *enabled*? After the
mount of a selinuxfs or after the first policy load?
    With SELinux being unable to disable at runtime in the near future
and SELinux being initialized after a selinuxfs mounting, that
probably needs selinux_init_load_policy(3) to check for a valid
SELINUXTYPE= before mounting a selinuxfs.

Also selinux_init_load_policy(3) libselinux should probably reset its
state via `umount(selinux_mnt); fini_selinuxmnt();` after a
selinux_mkload_policy(3) failure.
