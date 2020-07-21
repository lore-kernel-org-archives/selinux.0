Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA5C433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3028F20720
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2HeHQq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGUSAL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUSAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 14:00:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34231C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:00:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k6so17957684oij.11
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lijJuvZDDCv8lDvEq2sMyHcxcoMZGiPMrDef4a2CHGM=;
        b=U2HeHQq9yFYTQw3zrB5meYVdMl34nEJQOOCrM2ZMn5DLOwhDcT29HxA5GOA89X9SmO
         yrk4rhJu/vdPjdCi6LHdRRxEzRZDOzLXeqb+jqreEFdLGz54S+jd3692XpPv25AfFc3V
         MHNop5xFSIPLPZlKcReC0BHHzzPe6ocsSPqze2ZVV6+DwQ6q1/oYvRnOz+KUjOff8YaS
         CEvJ9kKyl0golN5Thux7SZrEnxG9uBJ3D+NmgjW3DatJH4ONqowwGxA40XyOMDjLrN5X
         FXWCZ7YlRjw+ccZa0BaDA92Pp00/rOUtcs6LY1y3yVdSrcGpulLnkbj71T1RyCH3MBt9
         YNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lijJuvZDDCv8lDvEq2sMyHcxcoMZGiPMrDef4a2CHGM=;
        b=V7Mhez84KNMDxdQOGLjqfdfVLL6KPGIEVZUAEy4fECaaLUeD4Vz4hiZceouc7k42ok
         zbCXGGiSTXmCDI1R0p/MXzKEeG+MMTrs82P9YtoLpUOjSAdsqM6kHaOpBb7Ylh5PwDug
         fQkMd9eTMyPsYxZIlGmj1ompB+8s2Nx17mykG0rz5ah7kIp3mAdpO7FOlaqtE0rlkZ5E
         GqLTS7dwXujPVg3+RMjYVnOAY/w3C7ilGEC3WqeFTJW38VSyEtvjirhzH0pE3lbwTSJr
         4lWpIkfwixZlWsXVpp+r3YgFostqCO6vnjFaMeU+hHn9JJUGcWoUW8vOa53aanLY9oiN
         NMHQ==
X-Gm-Message-State: AOAM532hvn1b32K3UZDUsYJJSUeBCHXI5ZJxy+fnmPKJEbvXqkzB7PmR
        5JB7R8HZtdbdBGA0C00eLHhiOFEJrXzuUzjFaBHCkgx2
X-Google-Smtp-Source: ABdhPJxkP26q648Dix4H3d0tWGgaHAsWgROqeq920atO7TcuCTtRyHmAziEeKFWyoVTVD4v0oVLUoco+wpxJPP6RAnw=
X-Received: by 2002:aca:ecd3:: with SMTP id k202mr2275257oih.92.1595354410474;
 Tue, 21 Jul 2020 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200720074515.1687720-1-dominick.grift@defensec.nl>
In-Reply-To: <20200720074515.1687720-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 13:59:59 -0400
Message-ID: <CAEjxPJ724s91rh1ji114npX3GZ7HH9jvipNUB46fQgp-XO+FqQ@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] object_classes_permissions: describe bpf
 and perfmon capabilities
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 20, 2020 at 3:47 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> These capabilities were introduced with Linux 5.8
> The ipc security class is deprecated (kind of at least)

Trying to remember the final resolution on the ipc class.  I think I
looked at it as part of
https://github.com/SELinuxProject/selinux/issues/57 but couldn't
cleanly remove it altogether.  We are no longer assigning SECCLASS_IPC
to anything but we are using the IPC__UNIX_READ/WRITE permissions in
selinux_ipc_permission().

> Fix a typo in net_broadcast
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  src/object_classes_permissions.md | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
> index 1b183bb..498d872 100644
> --- a/src/object_classes_permissions.md
> +++ b/src/object_classes_permissions.md
> @@ -421,7 +421,7 @@ inherited by a number of object classes.
>  <td>Allows opening of raw sockets and packet sockets.</td>
>  </tr>
>  <tr>
> -<td>netbroadcast</td>
> +<td>net_broadcast</td>
>  <td>Grant network broadcasting and listening to incoming multicasts.</td>
>  </tr>
>  <tr>
> @@ -496,13 +496,18 @@ inherited by a number of object classes.
>  <tbody>
>  <tr>
>  <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
> -<td style="background-color:#F2F2F2;">Description (6 permissions)</td>
> +<td style="background-color:#F2F2F2;">Description (8 permissions)</td>
>  </tr>
>  <tr>
>  <td>audit_read</td>
>  <td>Allow reading audits logs.</td>
>  </tr>
>  <tr>
> +<td>bpf</td>
> +<td><p>Create maps, do other <em>sys_bpf()</em> commands and load 'SK_REUSEPORT' progs.</p>
> +<p>Note that loading tracing programs also requires 'CAP_PERFMON' and that loading networking programs also requires 'CAP_NET_ADMIN'.</p></td>
> +</tr>
> +<tr>
>  <td>block_suspend</td>
>  <td>Prevent system suspends (was <em>epollwakeup</em>)</td>
>  </tr>
> @@ -516,6 +521,11 @@ inherited by a number of object classes.
>  <td>Allow MAC policy to be overridden. (not used)</td>
>  </tr>
>  <tr>
> +<tr>
> +<td>perfmon</td>
> +<td>Allow system performance monitoring and observability operations.</td>
> +</tr>
> +<tr>
>  <td>syslog</td>
>  <td>Allow configuration of kernel <em>syslog</em> (<em>printk</em> behaviour).</td>
>  </tr>
> @@ -2015,7 +2025,7 @@ implementation.
>
>  ## IPC Object Classes
>
> -### `ipc`
> +### `ipc` (Deprecated)
>
>  <table>
>  <tbody>
> @@ -2600,11 +2610,11 @@ Note that while this is defined as a kernel object class, the userspace
>  </tr>
>  <tr>
>  <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
> -<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 6 permissions)</td>
> +<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 8 permissions)</td>
>  </tr>
>  <tr>
>  <td style="background-color:#F2F2F2;"><a href="#common-capability2-permissions"><strong>Common Capability2 Permissions<strong></td>
> -<td style="background-color:#F2F2F2;">audit_read, block_suspend, mac_admin, mac_override, syslog, wake_alarm</td>
> +<td style="background-color:#F2F2F2;">audit_read, bpf, block_suspend, mac_admin, mac_override, perfmon, syslog, wake_alarm</td>
>  </tr>
>  </tbody>
>  </table>
> @@ -2638,11 +2648,11 @@ Note that while this is defined as a kernel object class, the userspace
>  </tr>
>  <tr>
>  <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
> -<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 6 permissions)</td>
> +<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 8 permissions)</td>
>  </tr>
>  <tr>
>  <td style="background-color:#F2F2F2;"><a href="#common-capability2-permissions"><strong>Common Capability2 Permissions<strong></td>
> -<td style="background-color:#F2F2F2;">audit_read, block_suspend, mac_admin, mac_override, syslog, wake_alarm</td>
> +<td style="background-color:#F2F2F2;">audit_read, bpf, block_suspend, mac_admin, mac_override, perfmon, syslog, wake_alarm</td>
>  </tr>
>  </tbody>
>  </table>
> --
> 2.27.0
>
