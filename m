Date: Thu, 19 Feb 2015 12:17:21 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS error
Message-ID: <20150219201720.GE12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <54E63D8A.3040600@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eDyw1yV8HuEtd7LH"
In-Reply-To: <54E63D8A.3040600@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--eDyw1yV8HuEtd7LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 11:46:18AM PST, Stephen Smalley spake thusly:
> Domains with those attributes can override the corresponding MCS
> constraint.  Depending on version, seinfo --constrain will dump the
> actual constraints for you.  In any event, I suspect you need to assign
> the mcsuntrustedproc attribute to your web application domains if you
> want them to be constrained by MCS at all, plus you'd need to run them
> with specific category sets.

How do I assign mcsuntrustedproc attribute to my web application domain? I =
know
how to set booleans, categories, etc. but have not yet encountered needing =
to
set an attribute for a domain. Google for "set selinux attribute" turns up
stuff about setting user, role, type etc. as attributes but nothing about
setting attributes such as mcsuntrustedproc.

--=20
Tracy Reed

--eDyw1yV8HuEtd7LH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5kTQBhSTPg0d/nQRAvzDAKCYAyzA+zwsfzRgFDxgfrRnDDFG5QCfYRRz
r9SR2TV9cl/l4/dbUkANeqs=
=wdKv
-----END PGP SIGNATURE-----

--eDyw1yV8HuEtd7LH--
