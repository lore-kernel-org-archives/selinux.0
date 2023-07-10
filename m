Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F89EB64D9
	for <selinux@archiver.kernel.org>; Mon, 10 Jul 2023 18:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGJS2q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJS2o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jul 2023 14:28:44 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77815AB
        for <selinux@vger.kernel.org>; Mon, 10 Jul 2023 11:28:43 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579dd20b1c8so57717167b3.1
        for <selinux@vger.kernel.org>; Mon, 10 Jul 2023 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689013722; x=1691605722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F2lxdtvzw+liK+OWigYmnE3e+wEUkuiHeKm0+ltpTE=;
        b=XXF1dt2fYgvy33foCdCXfpn/604eiebQ4mp8WYrkca6BefqMAEord3Mg3bINTNB6Cf
         Mg4M8eGc+dZtmyB3eGGz6HOZvbogMpVJOKzreDBBOzCxI2yu6lfr4F4MNQzDOg/SQizl
         VJYCTg1iAl7ZVoDzu3ZCGOkdpiDx4hjQiZY1/mJqlGcQdbufhTKtJfSejqLkBfjKKZJC
         emsmMGC08fELotxPqoSCVtSAMiks6eixajPGSMZcoNpf+8isxoIJo9pQqjojlwdD1VgG
         M9t2GJ0zbh9sWZLpbVkkM7UL9tb3fNLJ5QnHhuSzpzq0VPOOPNJzhQIWjZ7Gd47+Kn4a
         y3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013722; x=1691605722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F2lxdtvzw+liK+OWigYmnE3e+wEUkuiHeKm0+ltpTE=;
        b=fnQk1+u3QDfyiM+AklVK0RHb7nRmdo8/Zx88+RTEFYrp9XbXFHqFA6m81/Rw8Y0UOc
         08CSTKNpFtcgT80s1DGIlNPEzVJ4WPn5BJS44jodgaT0g22+jGU0VUDU7E80HE77GKEg
         pu/xlMzUBl3wpAZUyTlcZ3iEScRXvcfc54ebm08HzFwYP1XCvnqQ/hTWfqNFTTPDchB5
         SZhxCAE4iNRpqCOnflanea6IJK/7jScDvM0pQAxtU8JWnhbFuiX2HS2Wa/l2QCTS5G0Z
         D0MhhXkaymecYus3aWGM2PScnxV0y8Fif1FsRr9xuaFCB9qXdfNDuichDrmW9jJMbMWH
         g//w==
X-Gm-Message-State: ABy/qLZlwa4poiioYxiAAJhK/WnVmoZxm8HC04Ox2j6vQ7xk6s2ndEQD
        682KCUIIiSdsSlSe+smPv/5WQPj6rcHCgBniT9fNpg/DQEf04Uo=
X-Google-Smtp-Source: APBJJlECT5XFPruXn0sayJ3eCsH3A+RNvWtHotlXUYbMs1SNsm3BeLmrjLovizZypjxUCgvnMT7jSw4MJ6Hm8FD0w4I=
X-Received: by 2002:a0d:cccb:0:b0:572:83de:a011 with SMTP id
 o194-20020a0dcccb000000b0057283dea011mr11786861ywd.35.1689013722716; Mon, 10
 Jul 2023 11:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com>
In-Reply-To: <20230620131223.431281-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:28:31 -0400
Message-ID: <CAHC9VhSDg61qxd9MA87MOJVxBT9cS7Fuhv6PDW8T8mUPOUo4kw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 20, 2023 at 9:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
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
>
> v2: apply Paul's style suggestions
>
>  security/selinux/hooks.c                      | 28 +++++++++++++++++++
>  .../selinux/include/initial_sid_to_string.h   |  2 +-
>  security/selinux/include/policycap.h          |  1 +
>  security/selinux/include/policycap_names.h    |  3 +-
>  security/selinux/include/security.h           |  6 ++++
>  security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
>  6 files changed, 65 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
