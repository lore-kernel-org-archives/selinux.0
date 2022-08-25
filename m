Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1827C3F6B0
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 13:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiHYNbI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiHYNaz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 09:30:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF61AE9C1
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:30:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z8so5501757edb.0
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=KNjA4cQAAO5QQ7PNhhdmyZ23v2evQaBvMUQAkp3nwxc=;
        b=E+OQSMZTzgSWx9eHowcdctMF4cbRMX2BKTI/5+m/YLe7Jl/vgcMCz174HWSVDMkEO7
         oC56Mtt8DZzSSv6o37qUeQcbb+J1VkJDxWwQZd28PPJWgIs1EZqX5S0BqbZDnQFB2p7z
         vy6ybIKFqhQvZI2+2wZgbaIT8RCfcA1eiSltNjPXfeAnjl6q+2Vqh3dqj3f9yOap+nPE
         xZHff/2r4YE8E5Ot6TbyjvwELqMcwt2ExYgo7URG0WlqMBOiz9vUnjYpSW8Ch4xWt4dd
         o38jMOxgrnogJ0izCSuYCe1/beYJthIO5iMj9mD/MAsOg3dqTG41Xhg96SukIi0kTZUO
         T9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=KNjA4cQAAO5QQ7PNhhdmyZ23v2evQaBvMUQAkp3nwxc=;
        b=qli24x+0kLf2+QDY5uYP7YB0jbICxeoVzcVp8YJCLpsNncKl/9pw3Wa/9uCNkwUyLY
         sWzy5qjlCJdxdX/IZFyE5fodP/lrpzVdau/COo6VrfSCI0aA2nuqcAhm+8VIls9swckq
         jk8tBxP/iQv3Yya2Bu1jd9IrHUgkANfQP76niUVHs8RGHNhY6aqOBPuZFgMiKr4iwT/C
         8vbu9en0fVXPWnKdcWjNlXbReZDBhzl+Q+lUeJDQWOTflYim5yrX5RwiCL5zx01u/rWA
         9iBPm3DXRXQ8ZDxDCfOL1DU5aM5SEqMjGWW20Ubjca6CLvnVAKnRdIB3DFfNguN0iqss
         9GGA==
X-Gm-Message-State: ACgBeo169ERmoVNhmH1h7NbZG6UsI5b1u/FOjYcoUeZJPM4HXqGXEhc6
        KV08r9aDI5WZ6yCWXdcuWqHd4aKYl5P70v2Mh+fGvWy8
X-Google-Smtp-Source: AA6agR648sjjsgPZQRo+ZIoBLhb2R6viZFL+u2TA1roRuSF+2RH3tyMj3pZLdNarYMWTNxEVI44UXe+aRp34Vbfe9OA=
X-Received: by 2002:a50:baa1:0:b0:43e:5e95:3eda with SMTP id
 x30-20020a50baa1000000b0043e5e953edamr3355818ede.340.1661434249970; Thu, 25
 Aug 2022 06:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
In-Reply-To: <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 25 Aug 2022 08:30:38 -0500
Message-ID: <CAFPpqQFCjUksVa6YN0uV1-77OB0ZQyrQnDDqjA7LKoyOjZU8tg@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Maybe if I set the port type using semanage then a type transition
will happen automatically?

On Thu, Aug 25, 2022 at 8:22 AM Ted Toth <txtoth@gmail.com> wrote:
>
> I asked on the systemd-devel list about enabling systemd to set the
> context of a socket and got the answer I've included below. I don't
> know how a transition rule can be written to transition tcp sockets to
> multiple different target contexts, is this possible and if so how?
>
> ---------- Forwarded message ---------
> From: Lennart Poettering <lennart@poettering.net>
> Date: Thu, Aug 25, 2022 at 4:19 AM
> Subject: Re: [systemd-devel] socket activation selinux context on create
> To: Ted Toth <txtoth@gmail.com>
> Cc: <systemd-devel@lists.freedesktop.org>
>
>
> On Mi, 24.08.22 11:50, Ted Toth (txtoth@gmail.com) wrote:
>
> > I don't see a way to set the context of the socket that systemd
> > listens on. If there is a way to do this please tell me otherwise I'd
> > like to see an option (SELinuxCreateContext?) added to be able to set
> > the context (setsockcreatecon) to be used by systemd when creating the
> > socket. Currently as an extra layer of security I add code called in
> > the socket activation ExecStartPre process to check that the source
> > context (peercon) can connect to the target context (getcon). If a
> > sockets context was set by systemd I would have to perform this
> > additional check as my SELinux policy would do it for me.
>
> This was proposed before, but SELinux maintainers really want that the
> loaded selinux policy picks the label, and not unit files.
>
> i.e. as I understand their philosophy: how labels are assigned should
> be encoded in the database and in the policy but not elsewhere,
> i.e. in unit files. I think that philosophy does make sense.
>
> Lennart
>
> --
> Lennart Poettering, Berlin
