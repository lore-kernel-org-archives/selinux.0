Received: from ultraviolet.org ([192.215.175.10])
	by tycho.ncsc.mil (8.9.3/8.9.3) with SMTP id CAA11631
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 02:27:57 -0400 (EDT)
Date: Tue, 1 Oct 2002 23:27:15 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021001232715.A28686@ultraviolet.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <20021002074201.C28663@lemuria.org>; from tom@lemuria.org on Wed, Oct 02, 2002 at 07:42:01AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 07:42:01AM +0200, Tom spake thusly:
> yes, they are. look into the version string, if it has "bam" in it,
> it's the patched version.

Ah, I get it now. I upgraded everything except procps because my apt-get
thinks (rightly so) that the SE Linux package is an older version. I have
to figure out how to force it to do the downgrade.

> /etc/selinux/domains/program/run_deb.te
> /etc/selinux/domains/program/run_init.te

Ah. Actually they were in=20

/usr/share/selinux/policy/current/

and

/usr/share/selinux/policy/default/

What's the difference? But I removed them and now the policy compiles.
Yeay!  Thanks for the help.

Next question: Just for kicks I did avc_toggle. The machine halted
instantly. So...how far is this from being a useable policy? :) I was able
to do this under RedHat and the system still worked properly for the most
part.

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2akcMACgkQ9PIYKZYVAq1sNQCdFrWC7GLLMay4ZpqsOK1J3D7j
efAAnR8Cw0c6PYWyFsPbKtsYeBwphWxt
=WNE6
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
