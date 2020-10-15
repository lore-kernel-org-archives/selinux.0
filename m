Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC2C43457
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AAB22261
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klrRX9fW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbgJOR74 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgJOR74 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:59:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65227C061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:59:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h10so4040813oie.5
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpT8zYftlcoEnQE9OIlWol3g1Ekzq7Zq+VNKgssibhk=;
        b=klrRX9fWImcEsmi0liLccmBaTzzselfvEEb5Uese9pXFPA58i8Dc69hS8isDxZQT2j
         vZcRmKI+PWNaP2I+Bzo5/yFaRZmCXSyiHaYlZuSVFyGEgR2HfY6ryXovZirfl62kapg6
         PdyGsZZz6RBUt+CJeEQnBMaFLGTnbuziUa5nqW9LHLrHX15tvsx8O8zCIIq6qkQE/RgG
         Z4rxI53ySb35pjCXpY6+0l5eHQliNW6S/Y7CCc0e4CSnRah68gfK+lntGngXSMmWlSGY
         qSkdQVtRGPpCUAaHGZLWhr3AD/T/l3BTHI92DwkZMGRB9nsZlWTumnb0x3tYTUmMLmWn
         0x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpT8zYftlcoEnQE9OIlWol3g1Ekzq7Zq+VNKgssibhk=;
        b=pfFl3aQSXlvOVkAuGPvjkXePtHeaTOtm6zHBJgUrIEGhy/xVRgm5bofFpgVx4hkzFU
         fb8uaKcbK95iObFs5Bf0xSY/AMD4pnkPym1c7XJBKo36tlq8o4MbapCEuYtmT/Sxog/y
         QJV8i4yxNwgpsttMLd5RUCi2mwfhrlMx7HfN4Uo5MX/hXgItSexX7WqL+qreMF/icwVm
         G63PBEaCtTHpq0m78hZm2xvMEa/lHzYc7TbIeO7Q2dVp3O4Wmpzisc3X4hjaTB0Q7nyq
         ZJjPQTMwStZMSj8ZZHXGozFZMoagKrMsmbtCKm/wySNnQiLh7k471IBshN5q+I6nRu4g
         dX/Q==
X-Gm-Message-State: AOAM5312H1RFyVBCI++eDZ4jHaX4q4hIgAddmn8AdLaA5uMu8NDIohQc
        waUf0RA20gad8d2gpVwN++ItQxhArtETO3rNIayl7rlR
X-Google-Smtp-Source: ABdhPJxwo25Ma361EryC6gzV8YejK+8HPYVSNC+7Jm4lY8o48XEOd9UCSl/VNByni79H/3CkmpYBH35zI6so8zqFVJg=
X-Received: by 2002:aca:498b:: with SMTP id w133mr17230oia.138.1602784794312;
 Thu, 15 Oct 2020 10:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:59:43 -0400
Message-ID: <CAP+JOzTSbTZnDEeAkAvUOMAwOdDgc3J52JauH=yfxshbBpDLbQ@mail.gmail.com>
Subject: Re: libsepol, libsemanage: drop duplicate and deprecated symbols
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:49 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> This is followup of
> https://lore.kernel.org/selinux/20200930145031.910190-1-plautrba@redhat.com/T/#t
>
> Change against 1 version:
>
> - improved commit messages with references to Debian and Fedora guidelines
> - drop deprecated functions from libsepol/src/deprecated_functions.c and
> - semanage_module_enable/semanage_module_disable from libsemanage
>

I am not an expert in library versioning and such, but everything
looks ok to me.
Jim
