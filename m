Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B297EC678D4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 12:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCCMaG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCMaF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 07:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29C32CCF
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 04:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677846557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWDQf4ktV3fhIy9lUBiE1A6dWx8wyLa0ypOx1hh+rwE=;
        b=S5yo0GU1fgezjFjzH8D4dHLgGZbSTi0kzuu85zP7ByQTi0SYZYPMrNn5h1ZWy6/8I+3F7V
        gLxxbIy8E3QOPyOAyBnIj/ORoj2aEz3AO+l9sLEWn1ueWrzQ7obub7rxOcRrcwCAjvNouL
        CO476glRIm7gyWpmNdC30S0dlUofM+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-1zauLA4YPOC0eOWR_uVdMA-1; Fri, 03 Mar 2023 07:29:14 -0500
X-MC-Unique: 1zauLA4YPOC0eOWR_uVdMA-1
Received: by mail-pj1-f70.google.com with SMTP id q24-20020a17090a2e1800b00237c37964d4so3115537pjd.8
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 04:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677846553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWDQf4ktV3fhIy9lUBiE1A6dWx8wyLa0ypOx1hh+rwE=;
        b=vGHLOdYZg+HdnUYON8UbfRCbg3M/WjiK2Y9lHNdNDdEdlDCXeVfEBXSdmy25U/DCQA
         6jCgCvzXKSXbjRky5GUx+BtkQ0mHKaTNT23R05m9kB9Qpaiqttu9h6sBYpEz0Bv1vBia
         FgCO4tBBiJc9lr8zPwKp7LbQgHR/RR2qacxSel/oZAyWEyMOXVVxusxW3XA8Jki3aJRj
         J+GPBH6oSNQUd4hTdgpfGWSJm5+OwaMqcmulMnzSfPgGDxnPr2zO+4WBSQol2URztOQY
         0RAIeUiwwbtO6JpzKN4+AOdGUZ3E8gD+E6g+ON7a6EuaS3jd2P8GNDwgYnkPvBB8tman
         tYYA==
X-Gm-Message-State: AO0yUKUtCp2B7bKfxuZB3UBOuJ8Baa2u0BMdT5cQqXuJpZT5bu40bvIV
        dS1Sy1O6zIgWtbHOfqFDveIhKjvaIPv26fRA3CVLUdWChKZYen3GPzUlcc8u5LNoaYw2Pw0XKdL
        ddIk4rG5YfK4t51s9QA1tMrULB55hBMYE1A==
X-Received: by 2002:a17:903:4285:b0:19a:9984:558c with SMTP id ju5-20020a170903428500b0019a9984558cmr660500plb.6.1677846553629;
        Fri, 03 Mar 2023 04:29:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/wylH/iS5M2JnMCyx7msJPIwykEO5Y7DZU0Rwluv1PkTjZQmqjBRLUfH2Cy2KSlbum1kf5L2evrPhPmIoMsUk=
X-Received: by 2002:a17:903:4285:b0:19a:9984:558c with SMTP id
 ju5-20020a170903428500b0019a9984558cmr660496plb.6.1677846553306; Fri, 03 Mar
 2023 04:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-2-omosnace@redhat.com>
 <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
 <CAFqZXNuRMpLm1bAij=6VjRk2Ax8XLe_qnnx1n2csVPu+cESQmQ@mail.gmail.com> <CAHC9VhTCwV2cGtBrjVYUKJ-ZETBQ-Pp_sk6mjKkkuH299zYh9g@mail.gmail.com>
In-Reply-To: <CAHC9VhTCwV2cGtBrjVYUKJ-ZETBQ-Pp_sk6mjKkkuH299zYh9g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 3 Mar 2023 13:29:01 +0100
Message-ID: <CAFqZXNt+zn+4ExiYq0ctALiK=fhdqrD4WjmPvM8hn=tLREH3yw@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can
 lock enough memory
To:     Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <pebenito@ieee.org>, selinux@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Mar 1, 2023 at 10:21=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Tue, Feb 28, 2023 at 5:51=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > > >
> > > > The ibv_create_cq() operation requires the caller to be able to loc=
k
> > > > enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-=
8)
> > > > the default resource limits may not be enough, requiring CAP_IPC_LO=
CK to
> > > > go above the limit. To make sure the test works also under stricter
> > > > resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
> > > >
> > > > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  policy/test_ibpkey.te | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> > > > index 863ff16..97f0c3c 100644
> > > > --- a/policy/test_ibpkey.te
> > > > +++ b/policy/test_ibpkey.te
> > > > @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
> > > >  testsuite_domain_type(test_ibpkey_access_t)
> > > >  typeattribute test_ibpkey_access_t ibpkeydomain;
> > > >
> > > > +allow test_ibpkey_access_t self:capability ipc_lock;
> > >
> > > FWIW, I brought this up back in 2019 and have been carrying a local
> > > selinux-testsuite patch for this ever since (it's the only way to get
> > > a clean run of the IB tests).  While it can be fixed in the
> > > selinux-testsuite policy, I believe this is a more general problem an=
d
> > > should probably be fixed in refpol.
> > >
> > > https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsd=
bgxSL1v04mouWw@mail.gmail.com/
> >
> > I don't understand how you'd like this to be fixed in the system
> > policy... I don't think there is any policy interface that would
> > semantically match "any users of the SELinux IB hooks" or "callers of
> > ibv_create_cq()" that we could stick the capability rule into. At
> > least the testsuite policy doesn't use any such interface. Closest to
> > it would be dev_rw_infiniband_dev(), but that doesn't seem like the
> > right place.
>
> Look at it this way, the selinux-testsuite is not doing anything
> particularly unusual with respect to talking over IB; if the tests
> need that permission it seems reasonable that normal IB users would
> also need these permissions.
>
> > Not to mention that the fact whether the capability is required or not
> > depends on the resource limits imposed on the process. If its
> > RLIMIT_MEMLOCK limit is sufficient, a process is perfectly able to
> > create the cq without CAP_IPC_LOCK. Automatically granting it to all
> > domains that use InfiniBand in some way "just in case" would
> > potentially grant it also to domains that don't actually need it,
> > violating the principle of least privilege.
>
> Once again, the selinux-testsuite is not doing anything particularly
> unusual so if we are hitting this it seems reasonable that other users
> are hitting this as well.  If you're concerned about granting
> CAP_IPC_LOCK you could always put it in a dedicated IB/RDMA refpol
> interface as I believe this is just an issue with the IB/RDMA verb
> interface involving CQs/QPs and not the underlying IB protocol layer.
> Say something like "dev_rw_infiniband_rdma()"* which would call
> "dev_rw_infiniband()"* and add the CAP_IPC_LOCK permission.
>
> It would be good to hear Chris' take on this.

Okay, so I guess you addressed your comments more towards refpolicy
maintainer/contributors than to me as the submitter/testsuite
maintainer and I didn't have to react so defensively...

I agree that having better semantic interfaces for RDMA users in
refpolicy and Fedora policy would be nice, but I also wouldn't block
having a working testsuite on that. I'll be happy to switch any new
appropriate interfaces (and replicate them in Fedora policy) once they
are available.

>
> * Upstream refpol appears to have shortened the interface to
> "dev_rw_infiniband()".
>
> --
> paul-moore.com
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

