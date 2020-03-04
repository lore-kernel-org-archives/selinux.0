Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4CDC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAB321775
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2pHqfCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgCDPSu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:18:50 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42409 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgCDPSt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 10:18:49 -0500
Received: by mail-ot1-f53.google.com with SMTP id 66so2330066otd.9
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D6mWX1ZxeDRMOueNj4ubdYX/fdH5zQH/1qr4Z3MtE+Y=;
        b=E2pHqfCfnPP7rWT4Mu4hnuG3FNykRDIyBlYfDAwSirN0cGhtc+tvtvWRrUrAovd2GG
         HkW9TQawNXAYUaJ3f8zJQ82rkpbUsxY2JFhHF+85KKLSxiyztJrIMZUeeMpR4tvlSDml
         Z/VkQYZdOrW4LDjx5s2h6nRXklMbCnseZkBo4F/naLAPu5gHG1bETgBnpUfF4iaE9asJ
         QkEt2cC0VGuEBZjbAfkTvMB/uGak4CHeeciY9a8qnTtvMXXaAe/qu9oILlhwdF+z9cEo
         SvlXt8o8Z6pMzMGjClJa6ZtLqvGhsjSZjtGrzZoVCuFgMWpkAygmoVHWcN5AuepKZxKo
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D6mWX1ZxeDRMOueNj4ubdYX/fdH5zQH/1qr4Z3MtE+Y=;
        b=e3hqAmA1Ibo99669u9u21ByL2gyA32VcfXTna49LOE4/NtB7/WtauQChpcfPJcPRWK
         e9nqZJxIMUm1J8Z20uE5nW+PkkJ3P7bD5QjyA7TXSNZB/gKQ5Pa4IGq+SYdCXjrF8ZCC
         0VHPDvfPkotXlkyS+4uckIpPvwT5bfahS43SWxEAugXFouKliUouBeOrOfu2PZzj4dqT
         6fWhFZNbHgI+odi+NiUZqelL8xNCnp/2kQV0imfEbRJwx0NDuG25r6AyKpCq85frO7lW
         N7QRaGSKYm18rQ0+oGyesvvd9pT7Vy6CisoMnruEnzxGGXp5BR2fsAS/9nnoCR5g0A0R
         N5Fg==
X-Gm-Message-State: ANhLgQ2eTpr0qs/wxJNTYCe35KEE9dGPr+QNCSQrNFCDuSgjCRGP/7Ja
        zQbIZdW26fJZINqFlJtsi+BpNKz04uFX6NyN3OyXgw==
X-Google-Smtp-Source: ADFU+vufIghoJRai0p1CIYZhLIRtMA19CjjIJnO+PHNryOv8+UnVhNWtCl+PRXelRmNGo5sVBWx2GtjzMMeZdIkVF3M=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr2607853otr.89.1583335129330;
 Wed, 04 Mar 2020 07:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20200304072940.GA1026144@brutus.lan> <CAEjxPJ4qQgoMq6so-qGMm6fL5CKRKxC-TJXjxmEe=Qv2DAHGTQ@mail.gmail.com>
 <20200304144726.GD1032355@brutus.lan>
In-Reply-To: <20200304144726.GD1032355@brutus.lan>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 10:19:54 -0500
Message-ID: <CAEjxPJ5=YT-EttK8iE5h4Z7A59nJd6pTD1sUR=5sR8UajmrsNw@mail.gmail.com>
Subject: Re: strange pam selinux issue
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 9:47 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Practically yes name-based type transitions but other than that it makes the experience much simpler if you have just one unconfined system domain.
> I actually kind of got that idea from you when you mentioned the three domain model.

Not sure that was me but whatever.

> Its also used by pam_selinux env_params (which in turn is used by ssh for "ssh user/role/level@host")
> The problem is that the default_type for ssh and sudo sessions may differ (ie. default_type is not really a default_type)

Fair enough; originally it was only used by newrole and only if a type
wasn't explicitly specified via -t.  Maybe
get_default_context_with_role(3)
would be better since it can take into account the caller context.

> > Probably needs to be converted to using selinux_check_access().
>
> We hit that same isssue when we revisted mdp a while ago. Removing the env_params was a quick fix for that then.

Well, the right fix is to use selinux_check_access().
