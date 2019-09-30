Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14EC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F9E20679
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWGmj4YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfI3PCk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:02:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730809AbfI3PCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 11:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569855758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbGDvz9KInL1nB3wuSCZMjnBQMHBrVWszozYDVIfyO0=;
        b=QWGmj4YOEtriOO2qzR9AG1Fw1goENovlUxuWfDu4fFC+nuqLyc7t2AOIFO+/AIpIF6OjPL
        GZLX7VdC9yZbBV3OaU3BXX2OMn1Cg7OSgsUVyDTRFFL41tOdxEyVvXEHtMJ7I1EDWmDWwZ
        TVp35Sy7c34fKIRWQ6SnUpqWdaZtCeg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-fjU29FyaOD647m7VGQa5Fw-1; Mon, 30 Sep 2019 11:02:35 -0400
Received: by mail-ot1-f70.google.com with SMTP id l21so5659144otr.12
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 08:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx0+YFNq9ItvSxqXQ15m17+6ynsXNjAGoKEoTXESFL8=;
        b=uN5LVpjRmrBaqpBSJclxPOUTm1zlNYxaQQk3kg7tQ53QNfKzyn4WU5xW1HcZOQX4dE
         GCtFXgmBPiT9sPhA0MJwJQgf07kNqYcum17Dt4fvSK64nSBAkn98+9fBBOyRgTmZtILW
         Za5OGGmfVPupuFXRfnpFsaWm/oASDowiyihpvzciPURsld0EYkR0oUAa32SwsrL1AGR3
         gToo0UUJ0IUvIgnBEQgUAzDxyNzq6wGFYz370QoRfznwdZM4tJs2Z8crkqomIhFSkG33
         xuo2N8vSHJAvmpPlj9q9poDhFRQ2gCZ1maE7kmRKtlQem5vGgmD4LeU65KBXVQul54OQ
         NXMg==
X-Gm-Message-State: APjAAAUww7EkaVFhhDll/UyjQi6M0BsRC1NAv/kBuj0RMhlOzQY/bANk
        bkPPay0uUb8DerHN3fl/mq0tMQyLNlYFhUx8bGp/34HRAxrrIgjEQq8TKdZ8b2jMpBgsR1fhcoP
        IlC7xq7HjXmhyby5x3Ba4i/DVWu0JKzLLcg==
X-Received: by 2002:a9d:6849:: with SMTP id c9mr13781777oto.367.1569855754419;
        Mon, 30 Sep 2019 08:02:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmLDR2QJMa16R+LXA3S7Z5/6XF5rqwYut1EfWi71kw+XZ+5Ry749oVb+EcCOd7bxOaTGu2jitj8Pv1EEApQw8=
X-Received: by 2002:a9d:6849:: with SMTP id c9mr13781729oto.367.1569855753890;
 Mon, 30 Sep 2019 08:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190930104850.5482-1-omosnace@redhat.com> <20190930104850.5482-4-omosnace@redhat.com>
 <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
In-Reply-To: <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 30 Sep 2019 17:02:22 +0200
Message-ID: <CAFqZXNsKFb6QJ2jqYM8qS5Mx27sXaztn67-MxC-oanFQB7QaOg@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/3] travis: test building the test policy package
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: fjU29FyaOD647m7VGQa5Fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 30, 2019 at 3:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> > Download, build, and install Fedora policy & refpolicy and try building
> > the test policy package against both of them.
>
> I guess this is a necessary first step to actually getting the testsuite
> to run on travis, which would be the more important goal.  That
> obviously requires actually enabling SELinux on bionic, unless we could
> get travis-ci to offer fedora or centos images.
>
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   .travis.yml                         | 24 ++++++++++++++++++--
> >   travis-ci/enable-policy.sh          | 10 +++++++++
> >   travis-ci/setup-policy-fedora.sh    | 35 ++++++++++++++++++++++++++++=
+
> >   travis-ci/setup-policy-refpolicy.sh | 22 ++++++++++++++++++
> >   4 files changed, 89 insertions(+), 2 deletions(-)
> >   create mode 100644 travis-ci/enable-policy.sh
> >   create mode 100644 travis-ci/setup-policy-fedora.sh
> >   create mode 100644 travis-ci/setup-policy-refpolicy.sh
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index fbbe98d..c8cd44e 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -1,6 +1,6 @@
> >   language: c
> >
> > -dist: xenial
> > +dist: bionic
> >
> >   addons:
> >     apt:
> > @@ -8,6 +8,14 @@ addons:
> >         - astyle
> >         - libselinux1-dev
> >         - libsctp-dev
> > +      - checkpolicy
> > +      - semodule-utils
> > +
> > +cache:
> > +  directories:
> > +    - selinux-policy
> > +    - container-selinux
> > +    - refpolicy
> >
> >   before_install:
> >     # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df5=
2b56
> > @@ -17,7 +25,19 @@ before_install:
> >        perl Makefile.PL &&
> >        make &&
> >        sudo make install)
> > +  # install libbpf from sources
> > +  - git clone https://github.com/libbpf/libbpf
> > +  - (cd libbpf/src && make PREFIX=3D/usr/local)
> > +  - (cd libbpf/src && sudo make install PREFIX=3D/usr/local)
>
> Not packaged on bionic or not recent enough?

Not packaged, AFAICT.

>
> > +  # install Fedora policy and refpolicy
> > +  - bash travis-ci/setup-policy-fedora.sh
> > +  - bash travis-ci/setup-policy-refpolicy.sh
> > +  # establish a fake "selinuxfs" mount (policy/Makefile just greps for=
 selinuxfs)
> > +  - sudo mkdir -p /tmp/fake-selinuxfs
> > +  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
> > +  - echo 31 >/tmp/fake-selinuxfs/policyvers
>
> Fragile; maybe use checkpolicy -V | awk '{print $1}' or equivalent?

This will get the policy version that checkpolicy supports, but the
policy Makefile also checks the version supported by the running
kernel. Since the policy won't actually be loaded in this case, it
makes sense to just report the highest known version so that the
Makefile tries to build as much as it can with the checkpolicy it has.
On second thought, we might even put in just some "infinity" number
(e.g. 999), since it should be just an additional upper bound to the
checkpolicy upper bound.

>
> >
> >   script:
> >     - tools/check-syntax -f && git diff --exit-code
> > -  - make
> > +  - bash travis-ci/enable-policy.sh targeted  && make POLDEV=3D/usr/sh=
are/selinux/targeted
> > +  - bash travis-ci/enable-policy.sh refpolicy && make POLDEV=3D/usr/sh=
are/selinux/refpolicy
> > diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
> > new file mode 100644
> > index 0000000..ae53fbe
> > --- /dev/null
> > +++ b/travis-ci/enable-policy.sh
> > @@ -0,0 +1,10 @@
> > +#!/bin/bash
> > +
> > +set -e
> > +
> > +# create a dummy /etc/selinux/config
> > +sudo mkdir -p /etc/selinux
> > +sudo tee /etc/selinux/config >/dev/null <<EOF
> > +SELINUX=3Ddisabled
> > +SELINUXTYPE=3D$1
> > +EOF
> > diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-=
fedora.sh
> > new file mode 100644
> > index 0000000..192e234
> > --- /dev/null
> > +++ b/travis-ci/setup-policy-fedora.sh
> > @@ -0,0 +1,35 @@
> > +#!/bin/bash
> > +
> > +set -ex
> > +
> > +if ! [ -d selinux-policy/.git ]; then
> > +     git clone --recursive https://github.com/fedora-selinux/selinux-p=
olicy
> > +     (cd selinux-policy/policy/modules/contrib && git checkout rawhide=
)
> > +else
> > +     (cd selinux-policy && git pull || { git checkout '*' && git pull;=
 })
> > +     (cd selinux-policy/policy/modules/contrib && git pull)
> > +fi
> > +
> > +if ! [ -d container-selinux/.git ]; then
> > +     git clone https://github.com/containers/container-selinux.git
> > +     for f in container.if container.te; do
> > +             ln -s ../../../../container-selinux/$f \
> > +                     selinux-policy/policy/modules/contrib/$f
> > +     done
> > +else
> > +     (cd container-selinux && git pull)
> > +fi
>
> Seem brittle / tightly tied to fedora policy internals - is there some
> more general facility or perhaps they even provide a script for doing
> this that we could just reuse?

No, this is simply how the Fedora policy repos are structured. I
mostly mirrored the logic of .travis.yml from the main repo [1] I
don't think there's a better way to do this.

[1] https://github.com/fedora-selinux/selinux-policy/

>
> > +
> > +cd selinux-policy
> > +
> > +grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.c=
onf
> > +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
> > +     sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
>
> Is this a limitation of the checkpolicy packaged in bionic?  If so,

Yes, I think it is due to checkpolicy/-module being too old. Maybe it
should actually be handled in policy/Makefile with a [MOD_]POL_VERS
check... I'll need to look more carefully into this.

> should we just grab the upstream selinux userspace and build it ourselves=
?

I tried to keep the number of dynamic dependencies on the minimum, but
perhaps that's indeed the better way to go here...

>
> > +
> > +[ -f policy/modules.conf ] || make conf
> > +
> > +make -j`nproc --all`
> > +sudo make install install-headers
> > +
> > +# workaround for different Makefile location in Fedora RPMs
> > +sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
> > diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-poli=
cy-refpolicy.sh
> > new file mode 100644
> > index 0000000..d89b041
> > --- /dev/null
> > +++ b/travis-ci/setup-policy-refpolicy.sh
> > @@ -0,0 +1,22 @@
> > +#!/bin/bash
> > +
> > +set -ex
> > +
> > +if ! [ -d refpolicy/.git ]; then
> > +     git clone https://github.com/SELinuxProject/refpolicy
> > +else
> > +     git pull || { git checkout '*' && git pull; }
> > +fi
> > +
> > +cd refpolicy
> > +
> > +[ -f policy/modules.conf ] || make conf
> > +
> > +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
> > +     sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
> > +
> > +make -j`nproc --all`
> > +sudo make install install-headers
> > +
> > +# workaround for different Makefile location in Fedora RPMs
> > +sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
> >
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

