Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BBC001DF
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377529AbjJTO4e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjJTO4d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 10:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64145D46
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697813744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHcNwLBSXbFPbdSGksEZZQgSyEa5fTxByeBmRe66q80=;
        b=JJqwPMoHKXrsPF5/vLCCaBj4gqvKUbXXbuyuEKVp8L77AlCwOgj9hzerasAYk4zlR/FeBe
        pj/cHAuIsfggK1UaAHMadpU3LL3gJd220gkShji9f7gH5bbIZ7emLJ6HpKGehFeiRP8l6R
        G/SA1hmZQWka9CbfUa7QU8L+7wPJvrk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-dc8d8dh0Pn-b2dFojZGPDg-1; Fri, 20 Oct 2023 10:55:28 -0400
X-MC-Unique: dc8d8dh0Pn-b2dFojZGPDg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9949499edso1337423fac.0
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 07:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813727; x=1698418527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHcNwLBSXbFPbdSGksEZZQgSyEa5fTxByeBmRe66q80=;
        b=RpTdBN1FwBe1JU3lvLekq1130LQjpIdFGWO68GDzG9eKEOXNXHWLR+6tKx/YC5ZD8n
         XJi+Q7kMhQ1YKHEPPDBSPyEQR8cydtZ4qQHkJ+6OfsGZeY+KaYCCREtj0dUUlrStiLEw
         iC3saqDMbNiVYbqcZBQXbKmG+4fIdmUPN1PO/BA4IoSSghG4S+tuTQPEIFRi3Tolb7PD
         WhdfIM19U94WIeJbME8KnavuZ05DwzZ40miFkDTmgrC8zFqsVcSrDtEdG3seSSXJll/j
         n0p+/4mJsWC1K02BaXwWda7bDYYpKtj4OSeyUtR0Cj9sm/G+I5IZ65ZgNhc1gMjE5vBg
         FwVA==
X-Gm-Message-State: AOJu0YxcSj/aFRy+onlVRnB5fXHG+b+FyjMZ2YZcx4q5fuY/mieoaX7l
        ankTCPL2o+mcbry0FkWnLrLYj7Wb++6lF+/IxtvLGcd4pAFux/nx7kbK06JeyM+riXSSFR1nVAi
        WYJ9Pm/dt8z29K77otKCQmqh31M7i/G0d9vUItZZifvuH
X-Received: by 2002:a05:6358:60c4:b0:13a:cb52:4837 with SMTP id i4-20020a05635860c400b0013acb524837mr2399759rwi.31.1697813726813;
        Fri, 20 Oct 2023 07:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmHUv6LR40u9E9OaEi6QQXV+V3XhrM8whi+xpuxyPxZt0wmUaSJlpqrpsfMreHHpipGisUxeDOiwD/Ztil+Jg=
X-Received: by 2002:a05:6358:60c4:b0:13a:cb52:4837 with SMTP id
 i4-20020a05635860c400b0013acb524837mr2399736rwi.31.1697813726468; Fri, 20 Oct
 2023 07:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com> <CAHC9VhSyN-0QYmNRKn0qSUC_1sRp5zih6=f8hc=jf-Sdw9b2fA@mail.gmail.com>
In-Reply-To: <CAHC9VhSyN-0QYmNRKn0qSUC_1sRp5zih6=f8hc=jf-Sdw9b2fA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Oct 2023 16:55:15 +0200
Message-ID: <CAFqZXNsmjWJUX5rx+49W_SX+tO62Xoq9x9LzPy_VHCQuHyRNWw@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, scodar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 10:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
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
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c                      | 27 +++++++++++++++++++
> >  .../selinux/include/initial_sid_to_string.h   |  2 +-
> >  security/selinux/include/policycap.h          |  1 +
> >  security/selinux/include/policycap_names.h    |  3 ++-
> >  security/selinux/include/security.h           |  7 +++++
> >  security/selinux/ss/policydb.c                | 27 +++++++++++++++++++
> >  6 files changed, 65 insertions(+), 2 deletions(-)
>
> Unfortunately we had to revert this due to compatibility issues, but I
> was hoping there might be a new, fixed version by now; any updates
> Ondrej?

Not yet, sorry... Haven't had time to sit down to it yet, but it's one
of my top priorities this quarter and I hope to have a patch posted
around early November (at worst).

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

