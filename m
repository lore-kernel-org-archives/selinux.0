Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B92CC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 14:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB2A2166E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APD8Gyp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCBOtL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:49:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35248 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCBOtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 09:49:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so10548472oie.2
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYZi4xZzM8hcEDrZKZ/t4rWtaE2sDGIVkz3Fat8Rpnk=;
        b=APD8Gyp0bl6gKmAs1GWDl1xe7Q050d+UO22CstmDlcTvECevWpnBRU6Y8euTUUnMjQ
         Skfx/q5mE2OyvsQkzGd6WYPGdSb3yX3bvjI7ncBXSG8x8WYmbxLo8R3Wwidoek9JimT3
         VlgaluaL5IZhWjM0BUz8sGqUNCjyp0ml+wyoP+m6mdJjLiuF9BaLL4f760VwvHuC8As6
         xiK4QQE/eLyrJphR+R9NR2xklOUSFD4dP2YxPd3onrSaTHEDRiVtrZ38pjendQ8wc6AB
         FrtcmF4qdL3LT2pEy1VR/b8G4FC61lEm6b138HVsplUHAZbIfKvjmoBnC9RMk20xrg3I
         PO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYZi4xZzM8hcEDrZKZ/t4rWtaE2sDGIVkz3Fat8Rpnk=;
        b=YDDm2QueKudbMU16eB1yuXH+nG1REpR4yalB12QdFSYYQAA2aXDJJeLtpa9WhsX3mn
         pfHz0IO2d+yPqDnNl/GkOVdbtIi/WgKPy9d0GoAgZroSDmXQ2RpjFguFxSSqC3TLc48Q
         VOEz0hc/jSkvryByBXoLOAD+S4qiVllx3IDcvT0HTtiPrI5TGFmrlFEXffg1HUuHPqlJ
         JFY2qfQSgKFFbyMOcPTzHDP1TuLf0/V61xO2oBWuh9nh21OKl3D0pA5cBkd6uE5gXAgh
         xD7qLWN7TWojicEbBZf84A2DbUGcFqLk0SmRn2P+tou69YmsnpEEX2uCezOIRL/BW9aU
         3Kqw==
X-Gm-Message-State: ANhLgQ0br0hwRHTGKuqkn6bWwH72//EeqvNMLlwmtvsoKWqYcGkusKlQ
        W+YBifHnUJQ1cdAFJw5y06XXOoxrBx/XG4YRn5A=
X-Google-Smtp-Source: ADFU+vvz7R7M9nCUV10gS1gk9AT++dXlXFVG7c0KTTz1+iCcZ3xqRUI06iHk2aFu9gg3BltX6ajFf3SlqJVhaI2CUuw=
X-Received: by 2002:aca:3544:: with SMTP id c65mr2950367oia.160.1583160550947;
 Mon, 02 Mar 2020 06:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
In-Reply-To: <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 09:50:56 -0500
Message-ID: <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>, jwcart2@gmail.com
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 1:08 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series contains two small changes (these don't seem to affect
> > performance measurably, but are nonetheless logical) and a patch that
> > changes how the policy optimization "type_map" helper structure is
> > represented, which speeds up the whole process.
> >
> > Ondrej Mosnacek (3):
> >   libsepol: skip unnecessary check in build_type_map()
> >   libsepol: optimize inner loop in build_type_map()
> >   libsepol: speed up policy optimization
>
> Not a comment on the patches themselves, but this made me wonder if
> the optimization support is actually tested by our travis
> configuration.
> Doesn't appear to be (e.g. no usage of -O/--optimize or semanage.conf
> with optimize-policy true).

Adding optimize-policy = true to /etc/selinux/semanage.conf and
running semodule -BN before and after these patches yields different
binary kernel policy files (policy.32).
Is that expected?
