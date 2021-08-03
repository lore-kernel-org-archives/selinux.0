Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F918C4338F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E09260EC0
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhHCOFC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbhHCOFB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 10:05:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFBC061757
        for <selinux@vger.kernel.org>; Tue,  3 Aug 2021 07:04:50 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so20805973otq.3
        for <selinux@vger.kernel.org>; Tue, 03 Aug 2021 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmI8e7rbTKggWMO6lz9y9GyondUZjgsG9PeMkZKQNBc=;
        b=BepHL2eq3vnFMVhDVRINAKoWW1uEvGHPZESx9qAVdVPi3AO9UcmKVYgbfkLgF6elsi
         sfvDIrN9pmuuBiWnJJn5lqfdBdSB/nVv8rbGEX8t6v+a3VVwZLhrYeq00ZTrWezn3XCu
         pCs83L3t9e5Qe2UQsa6QZw5rrlNNq0U8rpJl2M1dBLSV/1nC6o5Uqjk4tD+u0FzrLkkl
         qtcksaBRO6lNV8q0+rnkbMfp+fzNGxRq5vzxDp2E+e1/VTsUGzHTrsvMNnhMC17RKHgM
         wegHd+MPdD+6Ww+TvKI/2SWnEi72y4rfK3wg02eXQ2EV/7Tbj0aUa5unQoreEc11/sKi
         ZvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmI8e7rbTKggWMO6lz9y9GyondUZjgsG9PeMkZKQNBc=;
        b=YMdCB+uRnsLKkAp0p7GXV5XuhMITYvTwuTGB+D6ffj3viI7egWxKtg6dcSvjIfysaj
         xgE00A2i8oX7DlXO68h9Nz5epFB3xClfRMN8oKwYl0WGEpSMNg3OyUtM16FCtK6VxkeX
         ikdJFulwvOH3QCOHwQHaqed/2HyXxVKD3WGkDZQTcPtSRAUhoDGiO+z19hfwe+4HpT/Z
         kOzsHCnvx1uyyFznub30UfutOTiv4kzlITQF8Od6iW9oYjhbauBWrK2J5Q+RfruStID8
         MxoWNFjFaNqn+nEtFAYvberwmbdDWgLpAeBsnLqjM3xMKqJWfSEKHX3eUzScMpuFDSZ2
         UMrg==
X-Gm-Message-State: AOAM531Q9Rlm08ZzDxI1LDwDUYuT3HOC/Iikd35WBlQDfbHGDx88VPfv
        BlnUn8gvSA15guuUIHw1sBdfmUEzrPuai5nhna0=
X-Google-Smtp-Source: ABdhPJx12Huh4TJQzyMOyo8EsXFduPNDnC96ya9VoFudsKzGGVWypijX9twm2RvMd6zi2PJRIP5kR6W0t1TiT99Mbzw=
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr15487321otl.295.1627999489901;
 Tue, 03 Aug 2021 07:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210728165922.186631-1-plautrba@redhat.com> <CAP+JOzRGAQy0JCgkn1Bkk9WoKb2CUqJUg36gtZgMmRCabPp4Zg@mail.gmail.com>
In-Reply-To: <CAP+JOzRGAQy0JCgkn1Bkk9WoKb2CUqJUg36gtZgMmRCabPp4Zg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 3 Aug 2021 10:04:39 -0400
Message-ID: <CAP+JOzSW1CHjDOcrOUvL+e_sPpXh-+n6dWCT-NHDhtA+bGv=og@mail.gmail.com>
Subject: Re: [PATCH] dbus: Use GLib.MainLoop()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 30, 2021 at 10:22 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 28, 2021 at 12:59 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Fixes:
> >     PyGIDeprecationWarning: GObject.MainLoop is deprecated; use GLib.MainLoop instead
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> In trying to test this, selinux_server.py seems to work and be waiting
> to respond, but selinux_client.py just immediately exits with the
> error "org.freedesktop.PolicyKit1.Error.Failed: Action
> org.selinux.customized is not registered". I am probably doing
> something wrong.
>
> At any rate, this definitely fixes the error.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  dbus/selinux_server.py | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> > index b7c9378bcb5d..a969f2268ceb 100644
> > --- a/dbus/selinux_server.py
> > +++ b/dbus/selinux_server.py
> > @@ -2,8 +2,9 @@
> >
> >  import dbus
> >  import dbus.service
> > -import dbus.mainloop.glib
> > +from dbus.mainloop.glib import DBusGMainLoop
> >  from gi.repository import GObject
> > +from gi.repository import GLib
> >  import os
> >  import selinux
> >  from subprocess import Popen, PIPE, STDOUT
> > @@ -145,9 +146,10 @@ class selinux_server(dbus.service.Object):
> >          raise ValueError("%s does not exist" % path)
> >
> >  if __name__ == "__main__":
> > -    mainloop = GObject.MainLoop()
> > -    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
> > +    DBusGMainLoop(set_as_default=True)
> > +    mainloop = GLib.MainLoop()
> > +
> >      system_bus = dbus.SystemBus()
> >      name = dbus.service.BusName("org.selinux", system_bus)
> > -    object = selinux_server(system_bus, "/org/selinux/object")
> > +    server = selinux_server(system_bus, "/org/selinux/object")
> >      mainloop.run()
> > --
> > 2.32.0
> >
