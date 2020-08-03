Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F66C433E1
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 12:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639BE20678
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0CBXb63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgHCMjp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgHCMjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 08:39:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726C4C061756
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 05:39:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q9so12102749oth.5
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANc7A6RziTYz0b6ayslBQFd0MR0it7flCCVTMS3eh/4=;
        b=C0CBXb63HqtaTbhqzpQRPcMRICycpcRQBId1VsgmL3MGFTiXnB8tb15Nz9hy3Vsiuo
         GVgOZdnIeN7fKJBWCGp5/bsVCW17ka80hYquWpAVG/WEBPbFL1S0O2YNZ0MksbZ7YcWu
         x5hUI0MLgfhBp5n83l4O59F/vb95QRsX4BHOBAhIwduETOQKjNebYk/UhdwsiuYjHxkM
         Fn9MGRHtjy4QKmLlCyKg83exjo6I+4bZ2lto8LW4bBCXwAXzvY9uFa260jDPXBFmze/E
         NM0h7rtJyhIdfJetJ4V1mLcg+wxm94cphntu6ihdv81nuMhUn44qZuM5TmptochOKggB
         3QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANc7A6RziTYz0b6ayslBQFd0MR0it7flCCVTMS3eh/4=;
        b=pNSgQ0qRt6kFSsk9bHEMqBkQl0AZSuSklmriM7nYBrxtzc9dhNQL4OPyaM62GTLAK1
         iWZlDJAndu87+EdPjllW8YA9zf+TXFQ9FOzmMYFxTadVQJ12WN6zToZKHkD045D+8sBb
         DPG7sqt4pBMXCHOqHL1WHfOEmbmdCK3njm+iGrpyB+yC8h1+ptAL9z25IweXPuef05oU
         03a/uaAcr10NlYT5TdxtBJlvY+HbHrACj8QRCx2Wk0csfnLZ/FFOiX8308FDQvQpJ1fQ
         Wwu9tTofr16un27ErZUsETNoHTryFeg2M8M/ovqJVikoornGD/XUlnFQ+komHP43zLPC
         TnzA==
X-Gm-Message-State: AOAM532NOrbssguiIwBRVtZN6EGqj3F3l6yhojsB17QI1ZQqkyhkjW/Z
        G87dfhUFaAL8OVHGs5pwgRXvEOQo5NTWiaqEQe3PxiA5
X-Google-Smtp-Source: ABdhPJwMbl6T9BQ2AiceyFoXdNsXlEsYiScKdrC1HOIa1/KdDPYeGmMJ2R+PZqZnhDlWZCaisu8PnsqXU8MOq0KWeNE=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr13710708otn.162.1596458374779;
 Mon, 03 Aug 2020 05:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200731172538.13393-1-mike.palmiotto@crunchydata.com>
In-Reply-To: <20200731172538.13393-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 3 Aug 2020 08:39:23 -0400
Message-ID: <CAEjxPJ4puCfGWmAjjrDJjtp=ih1e5fNb7G6HrhCu-cOaFqYbZg@mail.gmail.com>
Subject: Re: [PATCH v5] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 1:26 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> /selinux/status") introduced the sestatus mechanism, which allows for
> mmap()'ing of the kernel status page as a replacement for avc_netlink.
>
> The mechanism was initially intended for userspace object managers that
> were calculating access decisions within their application and did not
> rely on the libselinux AVC implementation. In order to properly make use
> of sestatus within avc_has_perm(), the status mechanism needs to
> properly set avc internals during status events; else, avc_enforcing is
> never updated upon sestatus changes.
>
> This commit gets rid of the default avc_netlink_open() in
> avc_init_internal(), replacing it with selinux_status_open(). In the
> event that the kernel status page cannot be mapped, the netlink fallback
> will be used. By default, avc_has_perm_noaudit() and
> selinux_check_access() will now attempt to read the kernel status page,
> which removes a system call from two critical code paths.
>
> Since the AVC thread create/stop callbacks were intended to avoid a
> system call in the critical code path, they no longer need to be created
> by default. In the event that the kernel status page is successfully
> mapped, threads will not be created. Threads will still be
> created/stopped for the sestatus fallback codepaths.
>
> Userspace object managers that still need a netlink socket can call
> avc_netlink_acquire_fd() to open and/or obtain one.
>
> Update the manpage to reflect the new avc_netlink_acquire_fd()
> functionality.
>
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> ---

Looks good aside from man page comments below.

> diff --git a/libselinux/man/man3/avc_init.3 b/libselinux/man/man3/avc_ini=
t.3
> index e26c3be6..656d7e24 100644
> --- a/libselinux/man/man3/avc_init.3
> +++ b/libselinux/man/man3/avc_init.3
> @@ -153,14 +155,74 @@ callback should destroy
>  .IR lock ,
>  freeing any resources associated with it.  The default behavior is not t=
o perform any locking.  Note that undefined behavior may result if threadin=
g is used without appropriate locking.
>  .
> -.SH "NETLINK NOTIFICATION"
> -Beginning with version 2.6.4, the Linux kernel supports SELinux status c=
hange notification via netlink.  Two message types are currently implemente=
d, indicating changes to the enforcing mode and to the loaded policy in the=
 kernel, respectively.  The userspace AVC listens for these messages and ta=
kes the appropriate action, modifying the behavior of
> -.BR avc_has_perm (3)
> -to reflect the current enforcing mode and flushing the cache on receipt =
of a policy load notification.  Audit messages are produced when netlink no=
tifications are processed.
> +.SH "KERNEL STATUS PAGE"
> +Linux kernel version 2.6.37 supports the SELinux kernel status page, ena=
bling userspace applications to
> +.BR mmap (2)
> +SELinux status state in read-only mode to avoid system calls during the =
cache hit code path.
> +
> +Status state is stored in the
> +.B selinux_status
> +pointer to the
> +.B selinux_status_t
> +struct.
> +
> +.RS
> +.ta 4n 10n 24n
> +.nf
> +
> +struct selinux_status_t
> +{
> +       uint32_t        version;        /* version number of this structu=
re */
> +       uint32_t        sequence;       /* sequence number of seqlock log=
ic */
> +       uint32_t        enforcing;      /* current setting of enforcing m=
ode */
> +       uint32_t        policyload;     /* times of policy reloaded */
> +       uint32_t        deny_unknown;   /* current setting of deny_unknow=
n */
> +       /* version > 0 support above status */
> +} __attribute((packed));
> +.fi
> +.ta
> +.RE

Unless this pointer and structure are exposed to users of the shared
library, I don't know why we'd document them in the man page.  The
struct definition is only needed for direct users of selinuxfs that
don't go through libselinux (if any), and that would logically go into
a selinuxfs man page if we ever created one of those.  You can refer
to the SELinux status page as a general mechanism similar to the
SELinux netlink socket without exposing library internals here.

> +Two status types are currently implemented.
> +.B avc_process_setenforce
> +will process changes to the enforcing mode by changing the effective enf=
orcing state used with the AVC, and
> +.B avc_process_policyload
> +will process changes to the kernel loaded policy by flushing the cache.
> +.

Likewise these are libselinux-internal functions not exposed to users
of the library and hence wouldn't appear in the man page.

> +.SH "NETLINK NOTIFICATION"
> +In the event that the kernel status page is not successfully
> +.BR mmap (3)'ed
> +into
> +.B selinux_status,

Can omit "into selinux_status".

> +the AVC will default to the netlink fallback mechanism.
> +
> +By default,
> +.BR avc_open (3)
> +does not set threading or locking callbacks. In this case, the userspace=
 AVC checks for new netlink messages at the start of each permission query.=
 If threading and locking callbacks are passed to
> +.BR avc_init (),
> +a dedicated thread will be started to listen on the netlink socket.  Thi=
s may increase performance in the absense of

spelling - absence

> +.B selinux_status

the selinux status page

> +and will ensure that log messages are generated immediately rather than =
at the time of the next permission query.
>  .
>  .SH "RETURN VALUE"
>  Functions with a return value return zero on success.  On error, \-1 is =
returned and

Does the avc_open.3 man page need updating too?
