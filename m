Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A219C33CB2
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 16:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2022220674
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 16:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgA1Q0E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:26:04 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:41110 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgA1Q0E (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jan 2020 11:26:04 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id BF39D132060C;
        Tue, 28 Jan 2020 17:26:01 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:25:58 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     "Lawrence, Stephen" <slawrence@tresys.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: CIL: another segfault producer
Message-ID: <20200128162558.GB36656@brutus.lan>
Mail-Followup-To: "Lawrence, Stephen" <slawrence@tresys.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <20200128122527.GA36656@brutus.lan>
 <486b1ea4-421e-dbf9-430e-db6566028d2f@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <486b1ea4-421e-dbf9-430e-db6566028d2f@tresys.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 02:00:08PM +0000, Lawrence, Stephen wrote:
> Looks to be an ordering issue with how we verify classmaps when they are
> nested. If you define (classmap common_appletalk_socket ...) before
> (classmap all_sockets ...), you'll get this error error:
>=20
> Map class common_appletalk_socket does not have a classmapping for
> common_readwrite_socket_perms
> Map class common_appletalk_socket does not have a classmapping for
> common_create_socket_perms
>=20
> So you're just missing the mapping for common_appletalk_sockets.
>=20
> The right fix for the segfault isn't immediately clear to me--might need
> to change some orderings or maybe even add another verify pass? But
> adding the mapping should resolve your segfault for now.
>=20

Thanks. My bad: overlooked...

>=20
> On 1/28/20 7:25 AM, Dominick Grift wrote:
> > In trying to reduce points of failure in my policy I encountered anothe=
r segfault
> >=20
> > I want to centralize common permissions, for example common create and =
common read/write socket perms:
> >=20
> >  872 (classmap all_sockets                                             =
             |
> >  873           (common_create_socket_perms common_readwrite_socket_perm=
s))          |
> >  874                                                                   =
             |
> >  875 (classmap common_alg_socket                                       =
             |
> >  876           (common_create_socket_perms common_readwrite_socket_perm=
s))          |
> >  877 (classmap common_appletalk_socket                                 =
             |
> >  878           (common_create_socket_perms common_readwrite_socket_perm=
s))          |
> >  879                                                                   =
             |
> >  880 (classmapping                                                     =
             |
> >  881  all_sockets                                                      =
             |
> >  882  common_create_socket_perms                                       =
             |
> >  883   (common_alg_socket                                              =
             |
> >  884    (common_create_socket_perms)))                                 =
             |
> >  885                                                                   =
             |
> >  886 (classmapping                                                     =
             |
> >  887  all_sockets                                                      =
             |
> >  888  common_create_socket_perms                                       =
             |
> >  889  (common_appletalk_socket                                         =
             |
> >  890    (common_create_socket_perms)))                                 =
             |
> >  891                                                                   =
             |
> >  892 (classmapping                                                     =
             |
> >  893  all_sockets                                                      =
             |
> >  894  common_readwrite_socket_perms                                    =
             |
> >  895   (common_alg_socket                                              =
             |
> >  896    (common_readwrite_socket_perms)))                              =
             |
> >  897                                                                   =
             |
> >  898 (classmapping                                                     =
             |
> >  899  all_sockets                                                      =
             |
> >  900  common_readwrite_socket_perms                                    =
             |
> >  901  (common_appletalk_socket                                         =
             |
> >  902    (common_readwrite_socket_perms)))                              =
             |
> >  903                                                                   =
             |
> >  904 (classmapping                                                     =
             |
> >  905  common_alg_socket                                                =
             |
> >  906  common_create_socket_perms                                       =
             |
> >  907  (alg_socket                                                      =
             |
> >  908   (append bind connect create getattr getopt ioctl read setattr se=
topt shutdown|
> >  909           write)))                                                =
             |
> >  910                                                                   =
             |
> >  911 (classmapping                                                     =
             |
> >  912  common_alg_socket                                                =
             |
> >  913  common_readwrite_socket_perms                                    =
             |
> >  914  (alg_socket                                                      =
             |
> >  915   (append bind connect getattr getopt ioctl read setattr setopt sh=
utdown       |
> >  916           write)))                                                =
             |
> >  917                                                                   =
             |
> >  918 (classpermission create_alg_socket_perms)                         =
             |
> >  919                                                                   =
             |
> >  920 (classpermissionset                                               =
             |
> >  921  create_alg_socket_perms                                          =
             |
> >  922  (common_alg_socket                                               =
             |
> >  923   (common_create_socket_perms)))                                  =
             |
> >  924                                                                   =
             |
> >  925 (classpermission readwrite_alg_socket_perms)                      =
             |
> >  926                                                                   =
             |
> >  927 (classpermissionset                                               =
             |
> >  928  readwrite_alg_socket_perms                                       =
             |
> >  929  (common_alg_socket                                               =
             |
> >  930   (common_readwrite_socket_perms)))                               =
             |
> >=20
> > <snip>
> > Building AST from Parse Tree
> > Destroying Parse Tree
> > Resolving AST
> > Qualifying Names
> > Compile post process
> > make: *** [Makefile:21: policy.32] Segmentation fault (core dumped)
> >=20
>=20

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4wYJAACgkQAlFoDzf+
eRP3vxAAo4aC4bPVo+F6xIzOpqMpqNX+r3Dkw2yRBXjUYHJG5Nl+EuepsMiXthcn
VKUoBBz40NgVoB5udud0pkQt3HPpZ1vD4CBmSNSHCwsO9tZbh4AODiQTkWecY65A
ulWn+/PWk/pxTH97jTKA2IrKZRcrDSe8Oa0CEfkH5MOm21VQ1pTGRz1HNE9RKws8
Fu9fuxxX3CVJhhtwwX58UEFxytCja2n5GEHpbQ2yv3W+32EGLt7sYQDytFuyIkrz
NST9GCiUGhnjMbPWS8b/Iu1aFuRk+jbFtDnIkseepEP82mHPttgyahsx9sGBtZom
DaaPubHXRdUb4CTKaZRCSK7Jkt85RSVkJiRw23rdGnMw7iiO8BlPajaa2JMROYMM
clKonIelZGEguQEKWuW4IKUhWtIsk3aMlIKNkfQRe3C0XiQ24tSbdpkqcCjCStkc
MmcWu/6B01oMF8XB0w787o9AL+dhpGvGR9Wwe8Y8Xleyyvnf6ztXNU3pXWU1fyik
rlEVmMar9HxSjVvUeuad5/8pPKWFVrUHET5LuBeC3YCRn+sHt3MNKLhJASuh/TOw
/DG2ZspGc3pMj1hALipm6/lOMhJsrCYJc2VERuZSs1NylMStfOAq+5JcTrNUfoUx
7JlX8M2UwfhkkdupA0qyq+odxZsv87RM6Di/oHyKH1qIu2gf6fE=
=DpZ4
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
