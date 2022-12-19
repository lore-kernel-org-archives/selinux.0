Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E4C001B2
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 22:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLSWVG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiLSWVF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 17:21:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AD2BF9
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 14:21:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso10281140pjh.1
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgfTMIP5lJrBv3uwYpqC8mJxqxNyHoGIRLp/gDo0WU0=;
        b=q9wfBqPvgnoaY/IYTijOJYSkk6Z8mN4McrMTlKzYt6fxkwpsQMQgLWFn7xKbErXqui
         PsRwr9GwU/GuV9zSMG0J5lKedeQjmDgu3Fmqtu0ZO2dQs3L2tKUSVNnY37fo7D+2gNjf
         Ro87sGx/spXHp1wnNqdXedKwusSREkTl/d9M1HCY0qd3MaMPXAF9PiWDBEMH7n6b6I6F
         qxc8Y9iaJEjuq/AEWIDbjK/E1FOaYxyUgGo0HQNDF1JB0waXKuKRnbDDDaPHipQPJXNb
         BPTc3j39jgyFuIfAWnee+2figiqELFX2JL8xzdvOhoUV7YTXNbjnwBX8KWY+C8DseOeK
         hqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgfTMIP5lJrBv3uwYpqC8mJxqxNyHoGIRLp/gDo0WU0=;
        b=N4dnH0+Vg5E5Uu/KGw1wQqTj8U+y2mXhWz2pjzKV1KjKcAACL4wVgzhLQHr64dmJJ0
         BFdVfFm9tECqUSk2Sc2rt1ZAuerQDORx4CsHXF1NapYuA9N9ICmXv4OSgp5ZdGDqmXUI
         6xfMUvjxmZ3qSEvYO04JmSkwQr2ngAe4k6tb5A2JF9MwzK/ZtnoK9rYRHvM/Wiovx/zu
         rXoAhqQlCvsqS/DiDWoAUCjrUn5zxKsgknYpLbdV59ElkKJbPK/n3JtS4zH5Ng3sboJo
         viAPpvEc+XoMkmvrMcMXOtcocek0TmpkG8VXEQkvGI4kBKGlpVzgTfDDu7bYgASl9iAH
         xaDA==
X-Gm-Message-State: AFqh2kouqIrwd9yJFgo4W/qIBTifjMihn2zoZChxbtM8YgUt1AZMknnL
        qj6gjLiLoTULCeWAEDJQi4esFFoAz6pJtv/D671q
X-Google-Smtp-Source: AMrXdXuEbWAHBH5J2T2oCdnAeEyhUOTHbHmqRHseEqFjoJXuFtoq4ZuY4UotxFDOJ7XuNmmvuIGsVxQWG1CN3IUjvi8=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr1622449pjj.147.1671488461633; Mon, 19
 Dec 2022 14:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20221219180024.1659268-1-omosnace@redhat.com> <20221219180024.1659268-3-omosnace@redhat.com>
In-Reply-To: <20221219180024.1659268-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Dec 2022 17:20:50 -0500
Message-ID: <CAHC9VhQCrFqM33s+W+VXANfY-De-YqH206HjB7E7a8nPvjzDow@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] selinux: provide matching audit timestamp in
 the AVC trace event
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 19, 2022 at 1:00 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In order to make it possible for the users and tooling to associate an
> SELinux AVC trace event with the corresponding audit event, make it
> include the audit timestamp (including the "serial number") of the
> event.
>
> First make audit_log_start() include the timestamp in the audit_buffer
> struct and add a public helper to retrieve it from an audit_buffer
> instance. Then retrieve it in SELinux's avc_audit_post_callback() and
> include it in the "avc:selinux_audited" trace event.
>
> After this patch the even includes the numeric fields that make up the
> timestamp and the text representation includes the timestamp in the same
> format as used in the audit log - e.g. "audit_ts=1671454430.092:1671".
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h      |  8 ++++++++
>  include/trace/events/avc.h | 25 +++++++++++++++++--------
>  kernel/audit.c             | 15 +++++++++++----
>  security/selinux/avc.c     |  4 +++-
>  4 files changed, 39 insertions(+), 13 deletions(-)

I'm not really liking the idea of exposing the audit timestamp for use
in other subsystems, even if it is just for use in a trace event.  I
generally take the approach that audit's charter is to capture and log
security relevant events to userspace where admins and security
officers can use the events to help meet their security goals.  While
audit may have some value to developers as a debugging tool, that is
not its primary purpose, and at this point in time I'm not supportive
of adding additional burdens to the audit subsystem to support a
debugging use case (I view exporting and maintaining a proper
timestamp value/struct an additional requirement on the audit
subsystem).

-- 
paul-moore.com
