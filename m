Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBEC3F2D2
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485DD20848
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgCERjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:39:46 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:47436 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCERjp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Mar 2020 12:39:45 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8BD0A132004B;
        Thu,  5 Mar 2020 18:39:43 +0100 (CET)
Date:   Thu, 5 Mar 2020 18:39:41 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: strange pam selinux issue
Message-ID: <20200305173941.GH1032355@brutus.lan>
Mail-Followup-To: Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20200304072940.GA1026144@brutus.lan>
 <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
 <20200304143650.GB1032355@brutus.lan>
 <CAEjxPJ4OPGWnc1uPDmqSuFnbFhzGYxenSyZ7WmxtnJ3Y2BdAzQ@mail.gmail.com>
 <pjdblpa7lks.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <pjdblpa7lks.fsf@redhat.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 06:33:55PM +0100, Petr Lautrbach wrote:
>=20
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>=20
> > On Wed, Mar 4, 2020 at 9:36 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> >> > Are you using libselinux with or without the commit to stop using
> >> > security_compute_user()?
> >> > If still using security_compute_user(), what does compute_user
> >> > sys.id:sys.role:sys.isid:s0 wheel.id display?
> >> > If you don't have compute_user (it is in libselinux/utils but not su=
re
> >> > Fedora packages it), you can also just
> >> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:=
sys.isid:s0
> >> > and see what it read back from /sys/fs/selinux/user.
> >>
> >> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contexts=
/users/wheel.id...
> >> I am not if my libselinux has or has not security_compute_user():
> >>
> >> # rpm -qa libselinux
> >> libselinux-3.0-3.fc32.x86_64
> >>
> >> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) =3D 3
> >> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) =3D -1 ERANGE (Nu=
merical result out of range)
> >
> > This shows that your libselinux is still calling
> > security_compute_user() from get_ordered_context_list().
> > In this case, because the source context is allowed to transition to
> > many other contexts, the result returned via
> > /sys/fs/selinux/user would exceed the maximum size supported by the
> > kernel interface (one page of contexts),
> > and therefore it fails.  Then get_ordered_context_list() falls back to
> > the failsafe_context.
> >
> > If you update to libselinux git, you will stop using
> > security_compute_user() and hence /sys/fs/selinux/user entirely.
>=20
> FYI I've just built libselinux-3.0-4.fc32 [1] and libselinux-3.0-4.fc33
> [2] with the security_compute_user() patch applied.
>=20
> [1] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474378
> [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1474377

Thanks, trying it out
>=20
> --=20
> ()  ascii ribbon campaign - against html e-mail=20
> /\  www.asciiribbon.org   - against proprietary attachments
>=20

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5hOVcACgkQAlFoDzf+
eROPrA/+LF8lc8OnQa5GTen5peX1blUOx42UYQPq1zlRvc9V4JNBeeGWa9W4gAHz
2bL4yOC6eUfiWKeto8xm6iLl4o8o0gi7YMpu9p5+B6+zfmYTgbWgqapSP0CWdMy6
gzvF0Ai6i6CG8zAncfR89dmkFMCuhvrKGNMBhc2LNbvwDaCCAWUr+EFu06pUHkeU
Ck2BqDxvZi4K1j1aVh+o12nVc4n4dSR07yXQ9JCr7Rz8n+5ZzL74lL1mCoprw0hD
Gomi1Hwr5r5N0yDfA9qKBunox7PAHpzmASoDjLaqG999L7Q0X1RKMyIPWw8VsPTt
J2hDAXmvg9a+nVW0rntRYRN3tQeZrvkOk8+gAWTBWKjvNkooJFfm0T17AZrLwAqk
RxJM+6aITzBioNS5IXfoNH+azkm1BJBBtrNEToTBCp/tq91ELNLM8f3pXoBUP1px
TpjJEAWlv4W0E9oyJHDIkPjVUx8lw8fgckBwOFdthmdtdwP1u/j4PRZ2b44MlRbH
e/yIHR3j12Eox+NaV69e/LF0CATl/Q/77eNCTUPFgZJJuPWDwRyAXv07+7qfYfG5
DD/2XBihapy5PbMdif2UzgEjsTmOq00n3TsykYLE0lk0smCfEaO5WPz5DMgMO4a9
HApduEnhr9svTWNDOcsAVqO8LSt3tqhTWhHie/R/GRzhde/XP2Q=
=K3DA
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
