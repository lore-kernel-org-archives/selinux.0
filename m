Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDBC04AA5
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiHYNWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHYNWk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 09:22:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607336E8B1
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:22:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so39470003ejc.10
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=kEX139J32MOfeTZVsfXML9Bqu0r0XMAzXGv9pc7M61w=;
        b=d0qt+Cb1X2LlSIIjr0De+32zfJaJHPZ0+9mvs21Ljc2O4JCvuzFwYlRYBMTkGF/cet
         oUigvEFuD3/c90+1qbSGPZSyit0Gc3J2zm0jTdK1jDUHTvLhXak1Jrr2kk/FHsBEKdeK
         FbR1l/rxs5y2Pwb9kW8ImH7YpZroAT2LDK2Dd4UPF4yI4Nqldz2vsiop4bw1iUeIVSGn
         VGdh1tDZFtwTf1LohleQjqzTpbDrC+3dGCLEmdcJewyt3bBdNTXNswkQIvdxrekk97ib
         2ou4m+wAcL1c48xFzHS6clSlneH4WnDvD0aNua9Xyo9XdcQ06np4d9HmgyArx4qF4E0V
         lZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kEX139J32MOfeTZVsfXML9Bqu0r0XMAzXGv9pc7M61w=;
        b=i0NYCR2XV7NVYw7MXHsrlOwVz1mQMDAQJqvhgpMKlXED/aqJXJZoswFSMLWU5nDkxu
         2GorrobqWJQztOIJ3ccmdQFhYY8JbF1hgUQmCBPTKO3Dk/eMLmaoPTie5OHEkxPBZmXv
         HMChMHhnDmh6ohqNNiInBgAXcuyounx3iyh/i4xLiSWJ96/zdETb1+29nOZy6/so1+8S
         aJrsuAMKZGgNJZ6007iiSaQaPZxDg/qlTXXm4qgpmiZg7N4QzwwCuVHdNubQJCfaSWwh
         CwtYgmJPNHffRl9SeRiAEa/AOn28Edwz6IEvpEVGe3W8nkrF17AEKN8bzH7LFGrfL/u1
         aZuw==
X-Gm-Message-State: ACgBeo2HHdq/LhTnbCsf0Fp3DhEGsfIN1Xuyx5lXsfQA5yiqH9ANc4ob
        E4Damu+Gjtr2VuKX/KohvincZN3tt6AN3OOcjC38Fx9q
X-Google-Smtp-Source: AA6agR5Sni8bv7Bi6sE/HW7LBlww1PAFc2HnF+GFlekgCOUFkB8RCSeWZjVz2A6awJB6fPdUvC6d3V2DMPR96YvO5h0=
X-Received: by 2002:a17:906:7309:b0:731:5c2:a9a6 with SMTP id
 di9-20020a170906730900b0073105c2a9a6mr2518615ejc.486.1661433757579; Thu, 25
 Aug 2022 06:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login>
In-Reply-To: <Ywc+pjOFkAEswVuQ@gardel-login>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 25 Aug 2022 08:22:26 -0500
Message-ID: <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
Subject: Fwd: [systemd-devel] socket activation selinux context on create
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I asked on the systemd-devel list about enabling systemd to set the
context of a socket and got the answer I've included below. I don't
know how a transition rule can be written to transition tcp sockets to
multiple different target contexts, is this possible and if so how?

---------- Forwarded message ---------
From: Lennart Poettering <lennart@poettering.net>
Date: Thu, Aug 25, 2022 at 4:19 AM
Subject: Re: [systemd-devel] socket activation selinux context on create
To: Ted Toth <txtoth@gmail.com>
Cc: <systemd-devel@lists.freedesktop.org>


On Mi, 24.08.22 11:50, Ted Toth (txtoth@gmail.com) wrote:

> I don't see a way to set the context of the socket that systemd
> listens on. If there is a way to do this please tell me otherwise I'd
> like to see an option (SELinuxCreateContext?) added to be able to set
> the context (setsockcreatecon) to be used by systemd when creating the
> socket. Currently as an extra layer of security I add code called in
> the socket activation ExecStartPre process to check that the source
> context (peercon) can connect to the target context (getcon). If a
> sockets context was set by systemd I would have to perform this
> additional check as my SELinux policy would do it for me.

This was proposed before, but SELinux maintainers really want that the
loaded selinux policy picks the label, and not unit files.

i.e. as I understand their philosophy: how labels are assigned should
be encoded in the database and in the policy but not elsewhere,
i.e. in unit files. I think that philosophy does make sense.

Lennart

--
Lennart Poettering, Berlin
