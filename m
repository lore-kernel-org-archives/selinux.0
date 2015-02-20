Date: Fri, 20 Feb 2015 14:07:58 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MCS error
Message-ID: <20150220220758.GJ12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
 <54E738EF.8070601@tycho.nsa.gov>
 <20150220165628.GI12937@tracyreed.org>
 <54E769FA.8010801@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Qx89ETaB+CVBQ6X0"
In-Reply-To: <54E769FA.8010801@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Qx89ETaB+CVBQ6X0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 09:08:10AM PST, Stephen Smalley spake thusly:
> So I'm guessing user_t has mcsreadall?  What does seinfo -tuser_t -x |
> grep mcs show?

# seinfo -tuser_t -x | grep mcs      =20
      mcsuntrustedproc

That's all. No mcsreadall.

--=20
Tracy Reed

--Qx89ETaB+CVBQ6X0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU57A+BhSTPg0d/nQRAo2pAKDBcxY1Jn2+TpNG+uOdakENKfwWvACeNZWT
jpfidN+rDene59fceRtfUMA=
=/4Tp
-----END PGP SIGNATURE-----

--Qx89ETaB+CVBQ6X0--
