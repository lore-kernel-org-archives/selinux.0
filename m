Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B9C33CAA
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AC02071E
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAWVQA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:16:00 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:35244 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgAWVQA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Jan 2020 16:16:00 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 19AEE1320607;
        Thu, 23 Jan 2020 22:15:58 +0100 (CET)
Date:   Thu, 23 Jan 2020 22:15:56 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [Non-DoD Source] Re: any reason why a class mapping is not able
 to solve permissionx?
Message-ID: <20200123211556.GA276201@brutus.lan>
Mail-Followup-To: jwcart2 <jwcart2@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200117173448.GA166208@brutus.lan>
 <20200117182405.GA182181@brutus.lan>
 <904dcd8e-9b0b-b444-4931-4dc165e4fb1f@tycho.nsa.gov>
 <b1a48f5e-6b11-ea21-a90a-5ae5fd8a12c5@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <b1a48f5e-6b11-ea21-a90a-5ae5fd8a12c5@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 03:41:30PM -0500, jwcart2 wrote:
> On 1/21/20 11:26 AM, jwcart2 wrote:
> > On 1/17/20 1:24 PM, Dominick Grift wrote:
> > > On Fri, Jan 17, 2020 at 06:34:48PM +0100, Dominick Grift wrote:
> > > > For example this:
> > > >=20
> > > > (permissionx alg_socket_ioctl_except_SIOCGIFHWADDR (ioctl
> > > > alg_socket (and (all) (not (0x8927)))))
> > > > (classmap all_sockets (ioctl_except_SIOCGIFHWADDR))
> > > > (classmapping all_sockets ioctl_except_SIOCGIFHWADDR
> > > > alg_socket_ioctl_except_SIOCGIFHWADDR)
> > > >=20
> > > > (allowx a self (all_sockets (ioctl_except_SIOCGIFHWADDR)))
> > > >=20
> > > > Say's:
> > > >=20
> > > > <snip>
> > > > Building AST from Parse Tree
> > > > Destroying Parse Tree
> > > > Resolving AST
> > > > Failed to resolve classmapping statement at policy/base/class_maps.=
cil:994
> > > > Problem at policy/base/class_maps.cil:994
> > > > Pass 14 of resolution failed
> > > > Failed to resolve ast
> > > > Failed to compile cildb: -2
> > > > make: *** [Makefile:30: policy.32] Error 254
> > > >=20
> > > > Am i doing something wrong or is this unsupported?
> > >=20
> > > Are we supposed to be able to use allowx rules in macros?
> > >=20
> >=20
> > Yes, allowx rules can be used in macros.
> >=20
> > > This works when the tunable is set false:
> > >=20
> > > (tunable no_mac_addr true)
> > >=20
> > > (block bla1
> > > =A0=A0=A0=A0=A0=A0=A0=A0 (blockinherit system_agent_template)
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0 (macro stuff ((type ARG1))
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (tunableif no_mac_ad=
dr
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (true
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (a=
llow ARG1 self
> > > create_except_ioctl_tcp_stream_socket_perms)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (a=
llowx ARG1 self tcp_socket_ioctl_except_SIOCGIFHWADDR))
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (false
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (a=
llow ARG1 self create_tcp_stream_socket_perms)))))
> > >=20
> > > (block blah2
> > > =A0=A0=A0=A0=A0=A0=A0=A0 (blockinherit system_agent_template)
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0 (call bla1.stuff (subj)))
> > >=20
> > > But when the tunable is set true:
> > > <snip>
> > > Building AST from Parse Tree
> > > Destroying Parse Tree
> > > Resolving AST
> > > make: *** [Makefile:30: policy.32] Segmentation fault (core dumped)
> > >=20
> >=20
> > Still trying to figure out the exact issue, but it is the use of the
> > named permissionx that is causing the seg fault.
> >=20
>=20
> There was an error in the code to copy a permissionx. I sent a patch to t=
he
> list to fix this issue.
> Jim

Thanks!

>=20
> > Jim
> >=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4qDQUACgkQAlFoDzf+
eRO8ew//SPR3qfqnT6MrTxLA0eGFdMIHBmPz6c3lsSsAWS4deOgBD4EzsVBcBI/+
HIKpFu9mTVcvEhVLOglvs/v/BRNvuGSy+FT03qmbXiheCg03ZNMnK8oo9L7Znn9k
WFLKVVcVGRFyRe9DjikLMegd6Khf7wdkj6LY/h0BpR2Up7ycBNfGhu1JDwVdGzmh
F6t7zW39/Gk/pwFE79+OeAsjiqiJ8JNL+Bq75a27D3qKe0MukgM2NtUdi+K7THQa
M9QEjyTAELPdoNk06IiPxmVSiHG2aaHAuFLIFJDqYZNP33dAlgqz77yTsmD86Kl2
tAq6SnoN/gV8RZ5iRA6H2zRCQkaZsTXP4Ngdir60UtCVj3F8TazBJSFdnNWg5H10
iYlxQBOjFPLAocW0kKzVwxaLC++Q2YPYlI19N4vXImKFzupnGbUPz3d7PBEb4pCb
yrK/5J1rH2XTwefNy23v7scGFTcPN0SeOon/7IsnE/cxqxprZnb8s9j023+WEiEm
5rA21rUA4JCkjNIOkT4CpThB0HIwysBM+Ndii2H+pKnSjjdPKo+H4j7DuxYRV82v
en5MxV9QYLqMEpftvjwF0HAZ+qTSykBI/0seL+zSR4Jbprr1I2KBRETUdlHMDyB4
6zpfdft0MjyxdnZG46bnZw/aIAnEvBzNbP7PxF9tZE6ogzZ5mM8=
=wInX
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
