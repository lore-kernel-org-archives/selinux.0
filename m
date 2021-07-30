Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36798C4338F
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1768E60F9B
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhG3OYs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbhG3OYi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jul 2021 10:24:38 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FCC0619C7
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:23:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a19so13412721oiw.6
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KL0MpxMZb1dkEPaeAxFp3oX82UP3NJ2O6CP3ZNudPNE=;
        b=Sjjkg7A/e8N3Uqp7kuPepJpCKYntstpS5dWzaQUgcFzHErykXoxeq3ZFaq8DGT2rZ6
         k/9z3ysaKqgHxDPBpSyX7Q6u36YKejYfygH5P1zkEs46oUZzzVe/PDCnCR7JVJpz1Aa5
         O6VUiFeSiu9cWuRCn2XZrBTcB/CvG8nJwpTzE6OdNBddP1JBUh4jRZkd3hRZC30PH3tE
         MGBZxd0f/6b37SNZmnpxxNe2ln4IL/y8aTSNhfN5kSFneowANrV/f86jmwy/iGQXG9hN
         ay1ypNZjWBS5a3sfqi19fNQAb1H5HyFO6ZJq78Ebk6S5pMtl/5AQ62ZFhe9k4ReZZRdz
         isoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL0MpxMZb1dkEPaeAxFp3oX82UP3NJ2O6CP3ZNudPNE=;
        b=K2ySZ8yZnGMqYhmPr6ia6t083kPZIVOnRps/9LUxHVpnvRN6juBSDcljFkqnBeAmjr
         SYpgK0wTTnUR3aJJPr7dye6/++LxRHbeepooHoif0191COFaKgZ0cNvQAzDP6MZWPGjE
         XMtsKCg8Jb1SvMK8TYKzr9mJSYtkBMPEY51n+gYSd+kQAYStw6cgL+C7Ge+sbCZyHWSX
         XGuW3j3bvmH5pHGXXOwej4c+mOFW71i2bAIWk4PSs1C5/SVZB39DADUCFbZ15RyVnOGv
         4FuMaxmapfaseWfw+1jkafh2Xqugo2E/p94x+2i7d5FrKMOTE0rtMdJZLvbajGCsSvhV
         +SZw==
X-Gm-Message-State: AOAM530JetqrKEoKfPTJBiANM5+VFY59EyyQ26lWucnDP5Vm+BZjziTh
        44s1lvXew9MqXI9GPNCFR8esXCp/ONOxDjDZHEQ=
X-Google-Smtp-Source: ABdhPJwIWG71lz3ARjvq8T2Sa9Ed5U5bKL7PQKO2Fmdd2xDWUytu3WEruHfHRyQ9V4nK1a4AuoNZqNclvQJ24uumE0I=
X-Received: by 2002:aca:a887:: with SMTP id r129mr2064421oie.128.1627654987527;
 Fri, 30 Jul 2021 07:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210728165922.186631-1-plautrba@redhat.com>
In-Reply-To: <20210728165922.186631-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 30 Jul 2021 10:22:56 -0400
Message-ID: <CAP+JOzRGAQy0JCgkn1Bkk9WoKb2CUqJUg36gtZgMmRCabPp4Zg@mail.gmail.com>
Subject: Re: [PATCH] dbus: Use GLib.MainLoop()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 12:59 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
>     PyGIDeprecationWarning: GObject.MainLoop is deprecated; use GLib.MainLoop instead
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

In trying to test this, selinux_server.py seems to work and be waiting
to respond, but selinux_client.py just immediately exits with the
error "org.freedesktop.PolicyKit1.Error.Failed: Action
org.selinux.customized is not registered". I am probably doing
something wrong.

At any rate, this definitely fixes the error.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  dbus/selinux_server.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index b7c9378bcb5d..a969f2268ceb 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -2,8 +2,9 @@
>
>  import dbus
>  import dbus.service
> -import dbus.mainloop.glib
> +from dbus.mainloop.glib import DBusGMainLoop
>  from gi.repository import GObject
> +from gi.repository import GLib
>  import os
>  import selinux
>  from subprocess import Popen, PIPE, STDOUT
> @@ -145,9 +146,10 @@ class selinux_server(dbus.service.Object):
>          raise ValueError("%s does not exist" % path)
>
>  if __name__ == "__main__":
> -    mainloop = GObject.MainLoop()
> -    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
> +    DBusGMainLoop(set_as_default=True)
> +    mainloop = GLib.MainLoop()
> +
>      system_bus = dbus.SystemBus()
>      name = dbus.service.BusName("org.selinux", system_bus)
> -    object = selinux_server(system_bus, "/org/selinux/object")
> +    server = selinux_server(system_bus, "/org/selinux/object")
>      mainloop.run()
> --
> 2.32.0
>
