Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C5C61D92
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 12:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjKUMJW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 07:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbjKUMJU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 07:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A220138
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 04:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700568555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+iU6orKaTdEVEWMG/xqqhRqfoiA8kbyUScrb7GUo6/4=;
        b=EGjhxzdmNBAxnmVyhNgY5m5BAHDQuiXI2N8vlvbJupplTOgHkhs/erCw+qoEgwQMpQOR2q
        /OUeFUZU430fa+yx5mqWgvB20XEXNIN7AmAbbasD8mM5rS2mXduh0gLdYaM7G6528SmCN0
        tBVJ/VH6TP607a2MS8PUblbyvPkHQwg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-NBmhxzDXM5aVNoq0pcywCQ-1; Tue, 21 Nov 2023 07:09:14 -0500
X-MC-Unique: NBmhxzDXM5aVNoq0pcywCQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28515f4cd74so3375235a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 04:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568553; x=1701173353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iU6orKaTdEVEWMG/xqqhRqfoiA8kbyUScrb7GUo6/4=;
        b=xLRciKSIn3lbGVE6moaXAlA3D23NlTPusjY9QLhbUzO9RLWEnLUJRFxCNHBKhQhdN/
         eG8SHLXiRrRoFV3pUYpR8/z/lLx+NOiVeM3dTW1gyG1R8JruN723vzvIrNj7QfUN2AAX
         o8hcE7314pnVuoiOS0AuziN90nwBFgxYlmBAi3g2CEJc/AhTr5chgKCPR/0cGHw7POxP
         RCmqbi13bnr//n9HfqYJgaUPRuSHbkRv6bZW0omZ1eYwG2d4ea6mhxLKxaaHqgxHWa6k
         oNsuI4RYQVYQtz/mp2TBpM9GMDV94XbcBtxGtQtoRCJUDuE4Zrut/lYT7GwBZg5uPGK6
         ACsg==
X-Gm-Message-State: AOJu0YwMzu18y2S6iDLm3oAbM81wwLdneQW9TwFEdCAVACSlT6NJCEH1
        HbIpYuWBOKDgu4p3JWDYgSJfzHmuXa3gibfEg+fbxARCWf3CSQuDQ9TPIRGMzwcvAqssvPcjZQ8
        w24ZICZqESn0hsC5NR2QnUE5s0UeJYtiV+g==
X-Received: by 2002:a17:90b:314e:b0:27d:4282:e3d2 with SMTP id ip14-20020a17090b314e00b0027d4282e3d2mr8681495pjb.30.1700568553054;
        Tue, 21 Nov 2023 04:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY7bFoHBV1HflmE4cl1+NsMK1WJwSHUxAngIuJ0H7AYgq21iqJKFNYHJ8Du4hLC/gOfjb4nNWUkxMTnLPkLLk=
X-Received: by 2002:a17:90b:314e:b0:27d:4282:e3d2 with SMTP id
 ip14-20020a17090b314e00b0027d4282e3d2mr8681481pjb.30.1700568552770; Tue, 21
 Nov 2023 04:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20231114155116.462883-1-omosnace@redhat.com> <CAHC9VhTWYeMzr99HPOp43Q_gVrQg6JSPNWH5y11irqZB89X6eg@mail.gmail.com>
In-Reply-To: <CAHC9VhTWYeMzr99HPOp43Q_gVrQg6JSPNWH5y11irqZB89X6eg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 21 Nov 2023 13:09:01 +0100
Message-ID: <CAFqZXNuU+O=wUNAjeXVacquX=UMndDz2s+N8SfmW264FGY6gGw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 21, 2023 at 2:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> >
> > Currently, SELinux doesn't allow distinguishing between kernel threads
> > and userspace processes that are started before the policy is first
> > loaded - both get the label corresponding to the kernel SID. The only
> > way a process that persists from early boot can get a meaningful label
> > is by doing a voluntary dyntransition or re-executing itself.
> >
> > Reusing the kernel label for userspace processes is problematic for
> > several reasons:
> > 1. The kernel is considered to be a privileged domain and generally
> >    needs to have a wide range of permissions allowed to work correctly,
> >    which prevents the policy writer from effectively hardening against
> >    early boot processes that might remain running unintentionally after
> >    the policy is loaded (they represent a potential extra attack surfac=
e
> >    that should be mitigated).
> > 2. Despite the kernel being treated as a privileged domain, the policy
> >    writer may want to impose certain special limitations on kernel
> >    threads that may conflict with the requirements of intentional early
> >    boot processes. For example, it is a good hardening practice to limi=
t
> >    what executables the kernel can execute as usermode helpers and to
> >    confine the resulting usermode helper processes. However, a
> >    (legitimate) process surviving from early boot may need to execute a
> >    different set of executables.
> > 3. As currently implemented, overlayfs remembers the security context o=
f
> >    the process that created an overlayfs mount and uses it to bound
> >    subsequent operations on files using this context. If an overlayfs
> >    mount is created before the SELinux policy is loaded, these "mounter=
"
> >    checks are made against the kernel context, which may clash with
> >    restrictions on the kernel domain (see 2.).
> >
> > To resolve this, introduce a new initial SID (reusing the slot of the
> > former "init" initial SID) that will be assigned to any userspace
> > process started before the policy is first loaded. This is easy to do,
> > as we can simply label any process that goes through the
> > bprm_creds_for_exec LSM hook with the new init-SID instead of
> > propagating the kernel SID from the parent.
> >
> > To provide backwards compatibility for existing policies that are
> > unaware of this new semantic of the "init" initial SID, introduce a new
> > policy capability "userspace_initial_context" and set the "init" SID to
> > the same context as the "kernel" SID unless this capability is set by
> > the policy.
> >
> > Another small backwards compatibility measure is needed in
> > security_sid_to_context_core() for before the initial SELinux policy
> > load - see the code comment for explanation.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > The last version of this patch has been applied [1] and then reverted
> > [2] because of a regression breaking userspace before the policy is
> > loaded [3]. This version fixes it using Christian's suggestion [4].
> >
> > Paul's suggestion from [5] isn't really viable because both existing
> > users of security_get_initial_sid_context() need the current behavior.
> >
> > As for security_context_to_sid_core(), it doesn't seem desirable to
> > remove the ability to e.g. write "init" to /proc/self/attr/exec to
> > get the exec_sid to SECINITSID_INIT as that shouldn't affect backwards
> > compatibility. However, the caveat is that after setting something to
> > SECINITSID_INIT via "init", a query for the string form of the context
> > will return the "fake" value "kernel" instead of the expected "init".
> >
> > [1] 5b0eea835d4e ("selinux: introduce an initial SID for early boot pro=
cesses")
> > [2] 817199e006e5 ("selinux: revert SECINITSID_INIT support")
> > [3] https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse/
> > [4] https://lore.kernel.org/selinux/CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9=
qdhb2x5uSej-MaRA@mail.gmail.com/
> > [5] https://lore.kernel.org/selinux/CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8Aan=
MvMh8KXG-PuPTVAQ@mail.gmail.com/
> >
> >  security/selinux/hooks.c                      | 28 +++++++++++++++++++
> >  .../selinux/include/initial_sid_to_string.h   |  2 +-
> >  security/selinux/include/policycap.h          |  1 +
> >  security/selinux/include/policycap_names.h    |  1 +
> >  security/selinux/include/security.h           |  6 ++++
> >  security/selinux/ss/policydb.c                | 27 ++++++++++++++++++
> >  security/selinux/ss/services.c                | 13 ++++++++-
> >  7 files changed, 76 insertions(+), 2 deletions(-)
>
> Ondrej or Michael, can either of you confirm that the regression found
> in previous revisions of this patch have been resolved in v3?

I did test it, yes, but of course independent confirmation from
someone else would be welcome :) (It's easy - just boot with
SELINUX=3Ddisabled in /etc/selinux/config and try to log in via
console.)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

