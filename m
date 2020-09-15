Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34851C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D4320936
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFoLg8Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIONpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgIONmx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 09:42:53 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7697C0611BD
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 06:34:52 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n2so3887627oij.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMxx0kTjOJSkWx0dj8yMcQ3/F/xn4mCO7OSMCn2owNA=;
        b=GFoLg8OpFOocTnKQx1c4jEzqTN6aWs0EqOsQMPW7Hr01huqhz1vZvjAJqhHQ7LOFmK
         fkR9oRLUBdNxt1wF3jHfV8W3X8zbx84R/S11gXjxuCQYVjcTnk7xkOFhxGa8zPaPNGOe
         Q2gtWeouH1aRD0uzM0TneHE08+YjpWzTvM7McIphLB9wKpYProw7HasaX7EEdC4W5QPR
         jrhZNmflsNWCsfFjv60BVnyfA+MUYOy1gIz0SHJwpHm6YqH0S2SU02348InXhO92kD8o
         knYrQRjbC+HldL0RMplMyI+A4UigyW8Mej0OkiRTxTfsxjRcj7nbwpzZVtq9OtwEMEFy
         H7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMxx0kTjOJSkWx0dj8yMcQ3/F/xn4mCO7OSMCn2owNA=;
        b=dZwMxvdAjE4SlTkbVQUcv/1cW2oA2d6QISMgGmhlo59PgthlQyOytrVpY8cOM+bJ5o
         TwW118eapXtIBLq/NBh5YnSWMEDBsVVgRJR1dw8FpfhQ748xnoSVygnAVZHssrJu2PZ4
         /zwTvFHAbVgwOGawnZbrV4VODPb+XWMDm2KmshnkprYoPx0oJ+WGyvWKBOEVeeYzMgup
         JgG8IuGuhaXBBS+ERSL3lhuahI2MHxlJ1jX1nkX7W/yZCsXTSGz7LDtvKAuHri75634o
         e2lvLcEO+EM+P1TAp8wOzNq386Ofap2T5OO5Sx6MbdP7sGRhXBDWQUgekgUj+C15bSjH
         X9Rw==
X-Gm-Message-State: AOAM533hkKKL0hvvf69rq/YmDILGZq9fxUDusXAVFdkPBk7LYjljRTK/
        +w5bBYafKt/XnV9wGgPiY072DyDMwZDyV59dp4boSY/J
X-Google-Smtp-Source: ABdhPJzjTBKlgHMZOsC6t+DVhTr9yG1yuq3GWlGHxogSvmx8XWvh0VvylhGANDbTA34QBtMVzCt46T6QzMhb2zWYwM0=
X-Received: by 2002:aca:4007:: with SMTP id n7mr3233329oia.160.1600176890934;
 Tue, 15 Sep 2020 06:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 09:34:40 -0400
Message-ID: <CAEjxPJ77s7WHqixbD60LnEOG_+WYc2mOj0cTPMoKXqk8M5zqBg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libselinux: Revise userspace AVC avc_log() for
 auditable events.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 9:11 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> I put up a PR for dbus-broker to revise its auditing:
>
> https://github.com/bus1/dbus-broker/pull/240
>
> Steve Grubb mentioned that there wasn't much useful info in terms of the audit
> message itself, since it isn't key:value pairs.

Does that matter since it is all just stuffed as a string value for
the msg= field?

> I'm looking to revise the avc_log() messages for SELINUX_ERROR,
> SELINUX_SETENFORCE, and SELINUX_POLICYLOAD messages such that they
> more closely reseble the kernel audits.
>
> *This patch is _incomplete*; I implemented a few changes to get early feedback
> on the direction I'm taking.  What seems potentially contentious is the
> 'lsm=selinux_uavc' and op= choices.

Yes, I don't see the point of using a different lsm= value than just
"selinux"; the fact that it is a userspace event should get reflected
in some other way, right?

> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 572b2159..35ea59b6 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -59,14 +59,14 @@ int avc_process_setenforce(int enforcing)
>         int rc = 0;
>
>         avc_log(SELINUX_SETENFORCE,
> -               "%s:  received setenforce notice (enforcing=%d)\n",
> +               "%s:  op=setenforce lsm=selinux_uavc enforcing=%d res=1",
>                 avc_prefix, enforcing);
>         if (avc_setenforce)
>                 goto out;
>         avc_enforcing = enforcing;
>         if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
>                 avc_log(SELINUX_ERROR,
> -                       "%s:  cache reset returned %d (errno %d)\n",
> +                       "%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
>                         avc_prefix, rc, errno);

If we do this at all, I would think the op= would still be setenforce
and this would just be an error for it.
Looking at the kernel, we aren't even checking avc_ss_reset() for
failure and none of the kernel avc callbacks ever return an error.

> @@ -81,12 +81,12 @@ int avc_process_policyload(uint32_t seqno)
>         int rc = 0;
>
>         avc_log(SELINUX_POLICYLOAD,
> -               "%s:  received policyload notice (seqno=%u)\n",
> +               "%s:  op=load_policy lsm=selinux_uavc seqno=%u res=1",
>                 avc_prefix, seqno);
>         rc = avc_ss_reset(seqno);
>         if (rc < 0) {
>                 avc_log(SELINUX_ERROR,
> -                       "%s:  cache reset returned %d (errno %d)\n",
> +                       "%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
>                         avc_prefix, rc, errno);

Ditto.

> @@ -157,7 +157,7 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
>                 return -1;
>         }
>         else if (rc < 1) {
> -               avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
> +               avc_log(SELINUX_ERROR, "%s:  op=netlink_poll lsm=selinux_uavc errno=%d res=0",
>                         avc_prefix, errno);
>                 return rc;
>         }

Not sure what to do with these; arguably they aren't audit events at
all, just error logging.

> @@ -214,7 +214,7 @@ static int avc_netlink_process(void *buf)
>
>                 errno = -err->error;
>                 avc_log(SELINUX_ERROR,
> -                       "%s:  netlink error: %d\n", avc_prefix, errno);
> +                       "%s:  op=netlink_msgtype lsm=selinux_uavc errno=%d res=0", avc_prefix, errno);
>                 return -1;
>         }

Ditto.
