Return-Path: <SRS0=UCTl=DO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB421C4363C
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357BE20870
	for <selinux@archiver.kernel.org>; Wed,  7 Oct 2020 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA/c29Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgJGJuq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Oct 2020 05:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgJGJuq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Oct 2020 05:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602064244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3WfMIzXQygSe3TnOMmEEHp7VgvcTWyPzDMfesyXnm9U=;
        b=XA/c29TgTm9YNvtzX+3aRc0uNvdw0ITMJpam9d6LfEf9j1U4A9coUPiJgbW+xYzyl80BOM
        2vJ7iXzm3lIXoRL/GqNb5BmGxHP0KQgcwK64nInOSUIySbNvLtAPk3UJgqqZeKH+ShfJxv
        XZyMlS8ubw2fSrs0Nno5KKmljcb0Asc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-MtowqLf2MSqW9Vr8aQJfpw-1; Wed, 07 Oct 2020 05:50:41 -0400
X-MC-Unique: MtowqLf2MSqW9Vr8aQJfpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817B157050;
        Wed,  7 Oct 2020 09:50:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFEB755785;
        Wed,  7 Oct 2020 09:50:36 +0000 (UTC)
Date:   Wed, 7 Oct 2020 11:50:33 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Message-ID: <20201007095033.GB194132@fedora.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bcc:=20
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Reply-To:=20
In-Reply-To: <CAJfZ7=3Dm5bwek=3DR_6gObMGdAKXNYSUwZU-rWv7EPAhw8SQU_vfg@mail.=
gmail.com>

On Fri, Oct 02, 2020 at 05:41:53PM +0200, Nicolas Iooss wrote:
> On Fri, Oct 2, 2020 at 4:50 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Oct 2, 2020 at 2:53 AM Nicolas Iooss <nicolas.iooss@m4x.org> wr=
ote:
> > >
> > > Hello,
> > > I have another question: why is bumping the .so version needed? As we
> > > are not changing the ABI of a "linked symbol" (thanks to using
> > > versioned symbols, with .map files), if we do not bump the .so
> > > version, programs that were built with libsepol.so from years ago wil=
l
> > > just stop working due to missing symbols, with an error message which
> > > will be quite clear (and this only if they were using deprecated
> > > symbols). In my humble opinion, bumping the .so version is most
> > > required when the calling convention of a non-versioned symbol
> > > changes, but this leads to unexpected execution paths.
> > >
> > > Nevertheless I did not spend time to search for a document that would
> > > explain why bumping the .so version would be recommended when removin=
g
> > > symbols. If you know one, could you please add a reference to it in
> > > the commit description ("Following guidelines from https://...) and/o=
r
> > > to some documentation?
> > >
> > > >From a "distro maintainer point of view" (for Arch Linux), having ju=
st
> > > spent a considerable amount of time due to breaking changes in the
> > > last release of PAM, I am not eager to spend time dealing with findin=
g
> > > clever ways to smoothly upgrade the system if there is no
> > > easy&straightforward way to do this. Introducing a transition package
> > > for each library which is bumped is acceptable to me, but if the
> > > release after the next one bumps the version again, introducing
> > > another set of transition packages will begin to be quite painful. In
> > > short: I agree to remove the deprecated functions in order to "bump
> > > the .so version only once", as suggested.
> >
> > My original understanding of library ABI compat requirements came from
> > Ulrich Drepper's paper,
> > https://www.akkadia.org/drepper/dsohowto.pdf
> >
> > Looks like Debian's policy is here:
> > https://www.debian.org/doc/debian-policy/ch-sharedlibs.html#run-time-sh=
ared-libraries
> >
> > IIUC, if we follow the rules laid out by both, removing an old symbol
> > version entirely is incompatible and requires a SONAME change.  That
> > said, commit c3f9492d7ff05bdc8581817655ad05bc1e1174b8 ("selinux:
> > Remove legacy local boolean and user code") was technically an
> > incompatible change; it left the symbols in place but made them always
> > fail or ignore no-longer-used parameters, which isn't truly
> > compatible, and we didn't change the SONAMEs then.
> >
> > I'd personally be ok with not changing the SONAME as long as these
> > interfaces were only ever used by the selinux userspace code itself or
> > only by really ancient code that is no longer in use by any supported
> > distribution but I don't think that flies with e.g. the Debian policy.
>=20
> Thanks for the details. Debian policy makes sense and I agree with
> bumping the version in the SONAME.
>=20
> Nicolas
>=20

Thanks, I'll prepare another patchset with improved commit messages.

In the mean time I'm looking into removing deprecated symbols from libsepol=
 as it's
supposed to be required only by selinux components. So far I've found that
deprecated sepol_check_context() is used in chkcon utility. As Fedora doesn=
't ship
this tool I incline to remove it from libsepol as well.

And there's also

/* Deprecated */
struct sepol_handle sepol_compat_handle =3D {
=09.msg_callback =3D sepol_msg_default_handler,
=09.msg_callback_arg =3D NULL,
};

void sepol_debug(int on)
{
=09sepol_compat_handle.msg_callback =3D (on) ?
=09    sepol_msg_default_handler : NULL;
}

/* End deprecated */

which is used on few places internally.


Later I'll check whether sssd uses any on deprecated libsemanage symbol and
decide what to do.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl99j2IACgkQviIJHj72
InVF5g/8DWzk4RQaeH0edVc/2eC8eve0B32TVNwXQa+BtaTDk9QfdE/LBqaSZNaA
4FbzXiouhw23xqc6v0d/Sqro/7b6WHsILlCPojWaS9UFh5lUk6q8N6SbcWiCb/Vs
KxW2sGumH6DLNyq/mVAqsa8aIT52mycDnYsq66GCkypfFa9P44Ma2YcxUW7AAv9A
24qDwgDJZ4cCyM9g55CN/wSeUxtbJPmSMNdwTbn/fKVdFl6TDYyUToKRS8t810Po
mOA26UXjU/nBDl1Sbzy6tKyFeB5pAAMymbKpnN/7uAO3ybw0lIQWxr2Bp+3CYFiB
0Lg3qhLNJ/97FUhxgcsaVanblFhncOqt1f1N5apKzFizDB+0smk5F2D+2txc+U1i
11xJsI4IaQBofAlk1QOQkc58a3d0H/CrQ0k9lsrfXHhOBfQoBIzLXQaSBieZ5O9F
iKVJogl5ha75gsZpoW0l0GqYgdNXiyZ/nzYnpeKp9QCCgC6RkiP3wYUZ3MNmYGqW
KHmVJsv1HU1TEfRYs6G1RtooEnqjHj/PaGXjHg8KbKy2mvLTivk6tA2NS2xYBCST
dkSFc5iny4P5HG8222HZmeRKEas/yrYDSI/xWl3jsOHnIFRWxdF7UKAyCXgdeWUg
oqt8XzEoALNIa1hQY018bIBenojEEwZSD3wgsCMtVMwsW1cGdUU=
=NhHV
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

