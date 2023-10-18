Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9949CDB47E
	for <selinux@archiver.kernel.org>; Wed, 18 Oct 2023 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJRUNG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRUNG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 16:13:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9F9F
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 13:13:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4584254276.1
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697659983; x=1698264783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9HzmT/G+1Xafe4wdIjE0N43tneqPtZxMFgQYY/Pd0Y=;
        b=LtMRVJdKIOswQHKvZhn6Qr8eZA3XxDk7xk6kN8pJSp2c34lnOO4VdXAySj/06EoZCf
         gSUV8xFk8/8UUVkY4Ve2UfhtOBUV3q3M2TccAmpmvTHsdAHdlcgZuF6OQucvnA+/UZOP
         Io8ea2CInMxd7fSvhEfv0VLcZSIMhj4xrXKUcQbBKSpf26naZIKuF6HahgxRQ/JjVmOG
         scymO4pBje1muini0TOAgEH52XtOpFKmnAS7us9RaZHCmD5TOE5cTcAqjBmef4or9Q2n
         JgIOzfj0vCCwRWWEFBKPcQY4o37xqUrNJkniRkcnEFHMNurrBX2D/GnnOZ+cqxnMOdDz
         cLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659983; x=1698264783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9HzmT/G+1Xafe4wdIjE0N43tneqPtZxMFgQYY/Pd0Y=;
        b=Df4fWlVHn36JAA+7vPHtji+kD6n9wk1shmjMPFiQfQB0HcGCuXed+VfbKI67iSh37U
         w7gwoPUqN531w0bSIuVidPRX2Tk4xJzh/U+aikJAUGtUM1uKAMt9oRfHpJykBfPAro0v
         tHHE7Jryyy81SQrRmI0WqcZWRZ5RjdyVN43sfGlma8X8cIlgA1UuGT5wHF3Jk89xiJJv
         C0mB5ifWq5/ftURipl3O8nO7pxyyYCV69OmbV9030ZjuxqoYUgyYibJPjAlhDj1Ytkk7
         mt6818yo4Wbw/rA4NZDxnHAIu7KZPrZHhm2vwbVFFL9DLxFTIqqHsmewPtTB6MR/Cn8D
         64IQ==
X-Gm-Message-State: AOJu0YzAGUed3G2wIFgD4Yz3Srtxz1ebpaZ2PZyhoA1lkLzQ1EVlzLqL
        ppUD7CuDqzThO8P/IyC6Wqvj2sOeSXG3/t0ZwTcoSz6oBPzdbY8=
X-Google-Smtp-Source: AGHT+IGqEXTQaKnRRoUPwmZhNBio9ohnWXSw7jO2U89AsGXIPeIURmfwgOSXSWYl0s2kUh/DMak2WyjlvUulDkPBJyk=
X-Received: by 2002:a5b:24a:0:b0:d9a:6c74:49b with SMTP id g10-20020a5b024a000000b00d9a6c74049bmr406107ybp.2.1697659983412;
 Wed, 18 Oct 2023 13:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com>
In-Reply-To: <20230612090145.1059245-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 16:13:02 -0400
Message-ID: <CAHC9VhSyN-0QYmNRKn0qSUC_1sRp5zih6=f8hc=jf-Sdw9b2fA@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, scodar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Currently, SELinux doesn't allow distinguishing between kernel threads
> and userspace processes that are started before the policy is first
> loaded - both get the label corresponding to the kernel SID. The only
> way a process that persists from early boot can get a meaningful label
> is by doing a voluntary dyntransition or re-executing itself.
>
> Reusing the kernel label for userspace processes is problematic for
> several reasons:
> 1. The kernel is considered to be a privileged domain and generally
>    needs to have a wide range of permissions allowed to work correctly,
>    which prevents the policy writer from effectively hardening against
>    early boot processes that might remain running unintentionally after
>    the policy is loaded (they represent a potential extra attack surface
>    that should be mitigated).
> 2. Despite the kernel being treated as a privileged domain, the policy
>    writer may want to impose certain special limitations on kernel
>    threads that may conflict with the requirements of intentional early
>    boot processes. For example, it is a good hardening practice to limit
>    what executables the kernel can execute as usermode helpers and to
>    confine the resulting usermode helper processes. However, a
>    (legitimate) process surviving from early boot may need to execute a
>    different set of executables.
> 3. As currently implemented, overlayfs remembers the security context of
>    the process that created an overlayfs mount and uses it to bound
>    subsequent operations on files using this context. If an overlayfs
>    mount is created before the SELinux policy is loaded, these "mounter"
>    checks are made against the kernel context, which may clash with
>    restrictions on the kernel domain (see 2.).
>
> To resolve this, introduce a new initial SID (reusing the slot of the
> former "init" initial SID) that will be assigned to any userspace
> process started before the policy is first loaded. This is easy to do,
> as we can simply label any process that goes through the
> bprm_creds_for_exec LSM hook with the new init-SID instead of
> propagating the kernel SID from the parent.
>
> To provide backwards compatibility for existing policies that are
> unaware of this new semantic of the "init" initial SID, introduce a new
> policy capability "userspace_initial_context" and set the "init" SID to
> the same context as the "kernel" SID unless this capability is set by
> the policy.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c                      | 27 +++++++++++++++++++
>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>  security/selinux/include/policycap.h          |  1 +
>  security/selinux/include/policycap_names.h    |  3 ++-
>  security/selinux/include/security.h           |  7 +++++
>  security/selinux/ss/policydb.c                | 27 +++++++++++++++++++
>  6 files changed, 65 insertions(+), 2 deletions(-)

Unfortunately we had to revert this due to compatibility issues, but I
was hoping there might be a new, fixed version by now; any updates
Ondrej?

--=20
paul-moore.com
