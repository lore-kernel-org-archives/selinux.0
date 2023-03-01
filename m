Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC43C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 18:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCAStP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCAStO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 13:49:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F83D90C
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 10:49:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so201093pja.5
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677696549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0S+3crYF/LWymLhqO5VwywE9upQe+qhQbwjf85HaAA=;
        b=FsktlrdRkyGOO9ftccAFkJG+p3N+hdXVXLQlz6Om4nOcFSRGnVAErACQTYjllckFmD
         J2/2P6CvhISqLG20qfuRpm7poietw5H9jC9OrGb4nuV5ceaBv3OhFfrE3l3g9fC7NccK
         /WYUJ5fgED1aEBPRpLILaEWK7GM0flD1P3fNHzW2kk4VUUg3xruJTRmr0Am0lqsLsNaL
         yewLbPl1QlsLUFBClG6MA4bWKeC3HiYMLkzkSTAPZ4HvMEkPl1rRQwmDL8gt/vqPIiO+
         VE9fXzB0i/37/Xg96CCyPeruWvxcF9Xp2Rs1W5RDnzL20FyAwre5F6E4846i9k4r06Hi
         MV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0S+3crYF/LWymLhqO5VwywE9upQe+qhQbwjf85HaAA=;
        b=z2E1KPxJWmzybjSg705lZEo8BuQ6YU8KEes13sWWrJ1QejDtY5y9wsGCGVc8WwoO3b
         iMOFzkYwrBahv3cCsI5t9nF3iz1M3UulKFkgnXputPId748xsKft4b1wdgbfDAbUzg0e
         TeNel2Yo4VYUekZbLy3HNx5nX4+lt4et70CPX5xq7l14h6otQX47nckbtdRzHLLlpC3n
         R+83faW8iDJDXtqc766vmJgCL1+T2m250LK4uTm+EL6P1UDAMigSRPYMsl3EnJGpdYR+
         jpu4z2KjeMuC+jGOC6rk+bCIWdUpBcHUm0VrAUKSP2qaVkBBUVAk2Z84BCtcWjFY+mKG
         WDIg==
X-Gm-Message-State: AO0yUKX9O+XVFtJNbm4tvKjBpZofxEESTBQkYhk2J4dS8UHAdn3axXYw
        xQL2ejRyVbwA3u01B/8UiCxgce6LFpXnPvuLcAct
X-Google-Smtp-Source: AK7set/pLLV71XXSBYihhv6YcCBYPAYR4e1lscJN0+PuhXdN4O4D2+VWP0/VT4yCCjz0nEMu611Z59GhK+2dQmzoT7M=
X-Received: by 2002:a17:903:41c9:b0:19a:80b9:78ce with SMTP id
 u9-20020a17090341c900b0019a80b978cemr4904616ple.0.1677696548698; Wed, 01 Mar
 2023 10:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-2-omosnace@redhat.com>
 <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com> <CAFqZXNuRMpLm1bAij=6VjRk2Ax8XLe_qnnx1n2csVPu+cESQmQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuRMpLm1bAij=6VjRk2Ax8XLe_qnnx1n2csVPu+cESQmQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Mar 2023 13:48:57 -0500
Message-ID: <CAHC9VhTCwV2cGtBrjVYUKJ-ZETBQ-Pp_sk6mjKkkuH299zYh9g@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can
 lock enough memory
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Chris PeBenito <pebenito@ieee.org>, selinux@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 10:21=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Feb 28, 2023 at 5:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The ibv_create_cq() operation requires the caller to be able to lock
> > > enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
> > > the default resource limits may not be enough, requiring CAP_IPC_LOCK=
 to
> > > go above the limit. To make sure the test works also under stricter
> > > resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
> > >
> > > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  policy/test_ibpkey.te | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> > > index 863ff16..97f0c3c 100644
> > > --- a/policy/test_ibpkey.te
> > > +++ b/policy/test_ibpkey.te
> > > @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
> > >  testsuite_domain_type(test_ibpkey_access_t)
> > >  typeattribute test_ibpkey_access_t ibpkeydomain;
> > >
> > > +allow test_ibpkey_access_t self:capability ipc_lock;
> >
> > FWIW, I brought this up back in 2019 and have been carrying a local
> > selinux-testsuite patch for this ever since (it's the only way to get
> > a clean run of the IB tests).  While it can be fixed in the
> > selinux-testsuite policy, I believe this is a more general problem and
> > should probably be fixed in refpol.
> >
> > https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbg=
xSL1v04mouWw@mail.gmail.com/
>
> I don't understand how you'd like this to be fixed in the system
> policy... I don't think there is any policy interface that would
> semantically match "any users of the SELinux IB hooks" or "callers of
> ibv_create_cq()" that we could stick the capability rule into. At
> least the testsuite policy doesn't use any such interface. Closest to
> it would be dev_rw_infiniband_dev(), but that doesn't seem like the
> right place.

Look at it this way, the selinux-testsuite is not doing anything
particularly unusual with respect to talking over IB; if the tests
need that permission it seems reasonable that normal IB users would
also need these permissions.

> Not to mention that the fact whether the capability is required or not
> depends on the resource limits imposed on the process. If its
> RLIMIT_MEMLOCK limit is sufficient, a process is perfectly able to
> create the cq without CAP_IPC_LOCK. Automatically granting it to all
> domains that use InfiniBand in some way "just in case" would
> potentially grant it also to domains that don't actually need it,
> violating the principle of least privilege.

Once again, the selinux-testsuite is not doing anything particularly
unusual so if we are hitting this it seems reasonable that other users
are hitting this as well.  If you're concerned about granting
CAP_IPC_LOCK you could always put it in a dedicated IB/RDMA refpol
interface as I believe this is just an issue with the IB/RDMA verb
interface involving CQs/QPs and not the underlying IB protocol layer.
Say something like "dev_rw_infiniband_rdma()"* which would call
"dev_rw_infiniband()"* and add the CAP_IPC_LOCK permission.

It would be good to hear Chris' take on this.

* Upstream refpol appears to have shortened the interface to
"dev_rw_infiniband()".

--=20
paul-moore.com
