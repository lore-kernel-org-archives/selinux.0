Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F1EC6FA99
	for <selinux@archiver.kernel.org>; Mon,  6 Mar 2023 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCFNvm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Mar 2023 08:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCFNvd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Mar 2023 08:51:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CC303C7
        for <selinux@vger.kernel.org>; Mon,  6 Mar 2023 05:51:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so8870630pja.5
        for <selinux@vger.kernel.org>; Mon, 06 Mar 2023 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678110688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/7RBJRNFA/0VUOdFq4e8gNxSeE91VgoB6B1qDGwtOk=;
        b=dSjkIzsnLkXOY2cWK9VWgS8r3CLkfFMhQw7EQH3/jE0+Ad3RXeMVCEOvaYnfpksa9D
         0PRTwXhTPZ4oGznUkK/HYaySI9oVW79zBdYjgWJB+N2+3m4T2ITHMRELojxALqzs2LUN
         CWGYsCN2wRs9bclopeo8ePwOlTMJsQY5fj/1Hg2cyoEvbD3tG/3wALGPAf5FleFGazLh
         wYv6/zuQm2S7xPNl5e08Uw+v4Tf1mWf2w+hgNQdhBaXL4DUpPyMGXcPTWLa+ryNOQNle
         c+EhmYqNfkQKkF9MbCjasb0+Ye322Yf7daf4hmaHLuKEax0EjQuvzSyGB5DNvaD3wfrC
         fO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/7RBJRNFA/0VUOdFq4e8gNxSeE91VgoB6B1qDGwtOk=;
        b=u4lNT/gQ+7SyuAkOAZ8KTsP96Zip//U1Lv5h4wdBkZom7yyl/QP2pcnHH2BU/1XYmP
         jREbiBRrnH7JITBbHkDe3mWuxmqKJ4A3cYVexiwEHIUDy4ssedvn2nwV1wewSjwmg29Z
         PEtbjBesyEOHFJTTnEoxxgkiWalKYOjXJlGgl1OyDOCP8O+0Skg2eLSUq2L7HlDzUsGy
         Kk9J1bMREOQXLUy+jy4EQF/j7RDe5EhndF/3d3UN4HbkwAyufKelMRQswtLli4/Hl3vr
         DbLl22HWVe/pXTIt1r0ZDuSHM9L1Oc3p9902ISOvWPZxUypLL5O2WuNsKFte7MoYLxVJ
         K+0A==
X-Gm-Message-State: AO0yUKWfxnr/vHvsB9MmDvIVBpdZMwgDuXb1Oy8ODqZ6Ag3DrDLD99i0
        6TFxkFB66qdqdV865TUjNMn1e0i5jlZup+WgWfue
X-Google-Smtp-Source: AK7set/5bdnsKn3ALixBzF5YFQpuTZOjb+YdYf7oNdM6hqf6O0Zlio5d/dDZrLfCWO5YNmsHBfKQLr+C6kMGQSbM9JY=
X-Received: by 2002:a17:90b:241:b0:237:ea76:41ed with SMTP id
 fz1-20020a17090b024100b00237ea7641edmr4056582pjb.0.1678110687980; Mon, 06 Mar
 2023 05:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-2-omosnace@redhat.com>
 <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
 <CAFqZXNuRMpLm1bAij=6VjRk2Ax8XLe_qnnx1n2csVPu+cESQmQ@mail.gmail.com>
 <CAHC9VhTCwV2cGtBrjVYUKJ-ZETBQ-Pp_sk6mjKkkuH299zYh9g@mail.gmail.com> <CAFqZXNt+zn+4ExiYq0ctALiK=fhdqrD4WjmPvM8hn=tLREH3yw@mail.gmail.com>
In-Reply-To: <CAFqZXNt+zn+4ExiYq0ctALiK=fhdqrD4WjmPvM8hn=tLREH3yw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Mar 2023 08:51:16 -0500
Message-ID: <CAHC9VhTmME_GZ3oPECu1HVK7KK8ia7SP77QCc99-mCcuMCyqkw@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Wed, Mar 1, 2023 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Mar 1, 2023 at 10:21=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > On Tue, Feb 28, 2023 at 5:51=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@r=
edhat.com> wrote:
> > > > >
> > > > > The ibv_create_cq() operation requires the caller to be able to l=
ock
> > > > > enough memory (RLIMIT_MEMLOCK). In some environments (such as RHE=
L-8)
> > > > > the default resource limits may not be enough, requiring CAP_IPC_=
LOCK to
> > > > > go above the limit. To make sure the test works also under strict=
er
> > > > > resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
> > > > >
> > > > > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  policy/test_ibpkey.te | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> > > > > index 863ff16..97f0c3c 100644
> > > > > --- a/policy/test_ibpkey.te
> > > > > +++ b/policy/test_ibpkey.te
> > > > > @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
> > > > >  testsuite_domain_type(test_ibpkey_access_t)
> > > > >  typeattribute test_ibpkey_access_t ibpkeydomain;
> > > > >
> > > > > +allow test_ibpkey_access_t self:capability ipc_lock;
> > > >
> > > > FWIW, I brought this up back in 2019 and have been carrying a local
> > > > selinux-testsuite patch for this ever since (it's the only way to g=
et
> > > > a clean run of the IB tests).  While it can be fixed in the
> > > > selinux-testsuite policy, I believe this is a more general problem =
and
> > > > should probably be fixed in refpol.
> > > >
> > > > https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWM=
sdbgxSL1v04mouWw@mail.gmail.com/
> > >
> > > I don't understand how you'd like this to be fixed in the system
> > > policy... I don't think there is any policy interface that would
> > > semantically match "any users of the SELinux IB hooks" or "callers of
> > > ibv_create_cq()" that we could stick the capability rule into. At
> > > least the testsuite policy doesn't use any such interface. Closest to
> > > it would be dev_rw_infiniband_dev(), but that doesn't seem like the
> > > right place.
> >
> > Look at it this way, the selinux-testsuite is not doing anything
> > particularly unusual with respect to talking over IB; if the tests
> > need that permission it seems reasonable that normal IB users would
> > also need these permissions.
> >
> > > Not to mention that the fact whether the capability is required or no=
t
> > > depends on the resource limits imposed on the process. If its
> > > RLIMIT_MEMLOCK limit is sufficient, a process is perfectly able to
> > > create the cq without CAP_IPC_LOCK. Automatically granting it to all
> > > domains that use InfiniBand in some way "just in case" would
> > > potentially grant it also to domains that don't actually need it,
> > > violating the principle of least privilege.
> >
> > Once again, the selinux-testsuite is not doing anything particularly
> > unusual so if we are hitting this it seems reasonable that other users
> > are hitting this as well.  If you're concerned about granting
> > CAP_IPC_LOCK you could always put it in a dedicated IB/RDMA refpol
> > interface as I believe this is just an issue with the IB/RDMA verb
> > interface involving CQs/QPs and not the underlying IB protocol layer.
> > Say something like "dev_rw_infiniband_rdma()"* which would call
> > "dev_rw_infiniband()"* and add the CAP_IPC_LOCK permission.
> >
> > It would be good to hear Chris' take on this.
>
> Okay, so I guess you addressed your comments more towards refpolicy
> maintainer/contributors than to me as the submitter/testsuite
> maintainer and I didn't have to react so defensively...
>
> I agree that having better semantic interfaces for RDMA users in
> refpolicy and Fedora policy would be nice, but I also wouldn't block
> having a working testsuite on that. I'll be happy to switch any new
> appropriate interfaces (and replicate them in Fedora policy) once they
> are available.

Yes, the test suite needs to be functional even if the reference
policy is missing important permissions, I was hoping to see some
comment from Chris or perhaps some of the other policy folks about
this but it looks like that isn't going to happen in a timely fashion.

--=20
paul-moore.com
