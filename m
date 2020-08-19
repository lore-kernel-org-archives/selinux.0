Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E86C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63A3207FF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 17:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrNCrOic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgHSRPZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:15:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726466AbgHSRPY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 13:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597857322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlt04TcZDRKseYO3iYr+n2W8QfZ9oV0oJ4jkF6hKoA8=;
        b=GrNCrOicEjeAsqu0Q6yQlgsMHkqqy6tk54KgbENdIwS3mRNd0Juz7Fv6v5bSKWtEJlrEcz
        PvOq4UmE96hLd9o21P9OYpK9EWIoTl0myybRBvGzizYadl6ge7cIT2svpwZ/f7+VZkF8mP
        7gyo201B/JUQd7sROqGlDM3A17Tzhrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-DYkL8qIGMnm4o4IwUh2g1w-1; Wed, 19 Aug 2020 13:15:05 -0400
X-MC-Unique: DYkL8qIGMnm4o4IwUh2g1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA518100CF6E;
        Wed, 19 Aug 2020 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4DC5D9D5;
        Wed, 19 Aug 2020 17:15:02 +0000 (UTC)
Date:   Wed, 19 Aug 2020 19:14:59 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
Message-ID: <20200819171459.GA57975@localhost.localdomain>
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 03:28:26PM -0400, Paul Moore wrote:
> On Thu, Jun 11, 2020 at 9:29 AM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > Good point about the installer. I have already started working on
> > preparing Fedora for the runtime disable removal, but so far I'm only
> > at the beginning. Updating anaconda to add selinux=3D0 to the kernel
> > params instead of using /etc/selinux/config will be one of the main
> > steps.
>=20
> ...
>=20
> > I also prefer to rather go somewhere in this direction rather than
> > introducing the delay. I was kinda OK with the delay at first, but as
> > Stephen points out, it would punish users rather than distros, even
> > though users are (normally) not the ones that make a conscious
> > decision to use the runtime disable.
>=20
> ...
>=20
> > Yes, I was under the impression that some changes in libselinux are
> > needed before this works transparently, but apparently it already does
> > the right thing now. In that case I'd say that it may be better to
> > skip adding sleeps etc. and just remove the feature at some point. But
> > please let's wait with that for a while longer so we can prepare
> > Fedora for it first. It's hard to tell at this point how long that
> > will take, but it could be several months.
> >
> > Then again, the sleep might be helpful to wake up potential non-Fedora
> > users (if any) and in Fedora we can always apply a revert as a
> > downstream patch until things are sorted. So if you guys really want
> > it, I think we can deal with it.
>=20
> I'm glad to hear Fedora is making changes to move away from the
> runtime disable, please keep us updated about once a month so we know
> where things are at with Fedora.
>=20
> As I mentioned previously, I'm okay with postponing the delay so long
> as Fedora is making progress - and according to Ondrej they are - so
> I'm okay with holding off for now.
>

I've used kernel built without CONFIG_SECURITY_SELINUX_DISABLE from Ondrej'=
s COPR
https://copr.fedorainfracloud.org/coprs/omos/drop-selinux-disable/ and trie=
d few
scenarios:

1. selinux=3D0 on kernel command line

everything works as expected

2. SELINUX=3Ddisabled in /etc/selinux/config

system boots, userspace considers SELinux disabled, /sys/fs/selinux is not
mounted. The only noticeable change
is in process list:

$ ps Z
LABEL                               PID TTY      STAT   TIME COMMAND
kernel                              552 pts/0    Ss     0:00 -bash
kernel                              574 pts/0    R+     0:00 ps Z

If I get it right, SELinux is enabled but it's not initialized and SELinux
checks are not processed - always return 0 as allowed. So there should be n=
o
real externally visible difference between selinux=3D0 and SELINUX=3Ddisabl=
ed

3. no /etc/selinux/config

SELinux is disabled in userspace but /sys/fs/selinux in mounted. It's due t=
o
check in libselinux which doesn't umount /sys/fs/selinux when there's no co=
nfig
file. Maybe this could be improved.


So I my findings are correct, it should be quite straight and easy change f=
or
the distribution. Even though userspace tools like anaconda and ansible sti=
ll
uses /etc/selinux/config to disable SELinux, it will have similar effect as
selinux=3D0. But it doesn't mean we will not try to change them to set seli=
nux=3D0.


So I've started to compose Fedora Change proposal

https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELI=
NUX_DISABLE

It's not complete yet, but I believe it contains basic information. I'd
appreciate if you can help me with text, phrases and references so that it =
would
be easy to sell it as security feature to Fedora community :)


Petr

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl89XgwACgkQviIJHj72
InVjMBAArfu+tROmIvz78nAfNJrVl2rrhWEiQR8aJJnk0kMeSkZz9xnlriKAg24b
H8T7smyAqKIIzpYyrsWTltA7xOZLvwLnDKbtO/hrwSXohM+hoiwn9vh6FkLIm06T
bgxBbwkX/u9ISZYt1RR/slyTnPd1xgIO3lv/qro67anRCcfo6gSU1xp4I6ZzLvOi
cXJuUaZV86Mj1Ci12UESgoI6o/djJmCU/WfgZ1KRktd++eDwF0mHajzcUVwihP3V
IGrfubOMnVJUespp4RJuDO1G4XzeIVWh5MxraUSrw7sfIY7kRovuYWCuhk2MdOgQ
3Fc/8Y+YgLHWqAFe1qmJ7tZeidey5gFPkXYTk5hZS7k+gOnwWAJ5UY5z8oAQYK3c
D89v0isVdLeF8lSjPGJ9pNvdrqF/WsOYJqAkq2o5HhWN1Lij0ZRgiFan3R5suLCh
F4fwfd69SnlGEoNE0W/9gy3uaubYnR3k/Eah8x3DmK3QKHPkySIev3nW6OyQYIxM
zXCf90C+d45zAwdoEfdPU3cnKIaP3E+Zdmv7/DcMgE9AsUQPhI+KCh0++NdBoywF
8k+/9JbYBmcjjIvHNvS9jTxdtCnesH/mSxcwQakNIQXrX+FXrFdNmboNMzeilA8T
Bb4hGG30ytJQv6mlBoGmpdrw44FVEweoqkMHBa6JkLl5/8MZTk8=
=2emH
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

