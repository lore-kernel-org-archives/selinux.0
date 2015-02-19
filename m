Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1JJXNa0021845
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 14:33:24 -0500
Received: from tracyreed.org (wsip-98-175-106-200.sd.sd.cox.net
 [98.175.106.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.copilotco.com (Postfix) with ESMTP id E5E2A64C71
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 11:33:20 -0800 (PST)
Date: Thu, 19 Feb 2015 11:33:37 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150219193337.GC12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PUgybOivvlPvn0/l"
In-Reply-To: <20150219154047.GA11807@linksys-wireless-usb.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--PUgybOivvlPvn0/l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 07:40:48AM PST, Dominick Grift spake thusly:
> The MCS implementation has been changed a bit over the years on the polic=
y side.

Is there a RHEL 6 version of the link I pasted below with up to date info?
Lack of documentation and frequent changes rendering documentation obsolete
combined with the inherent complexity of something like this are the main
issues holding back SELinux adoption.

> Back in the earlier day's MCS was enforced on all proceses in redhat dist=
ro's by default

Yeah...I actually had it working in a test setup in RHEL 5 but never got it
deployed widely. Now we are trying to redo it with RHEl 6 and running into
issues.

> Nowaday's that is no longer the case, and you need to opt-in for it by as=
sociating the mcs_constrained_type type attribute with the type of the proc=
ess to constrain.
>=20
> In rhel6 this attribute name does not exist i suspect. It was renamed to =
aforementioned later.
>=20
> A seinfo -a | grep mcs might reveal the type attribute used for the same =
in RHEL6. (i think its something with trusted or untrusted, dunno for sure)

I don't follow this part... The seinfo output is:

# seinfo -a | grep mcs
mcssetcats
mcswriteall
mcskillall
mcsreadall
mcsnetwrite
mcsuntrustedproc
mcsptraceall

How do these type attributes relate to MCS?

--=20
Tracy Reed

--PUgybOivvlPvn0/l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5jqRBhSTPg0d/nQRAvmfAJ9T553yfBYE+bHJH49L0N7ZO26TkgCgqCn9
S5ELkVySluF8T3zuNetcNQA=
=49fg
-----END PGP SIGNATURE-----

--PUgybOivvlPvn0/l--
