Received: from ultraviolet.org ([192.215.175.10])
	by tycho.ncsc.mil (8.9.3/8.9.3) with SMTP id BAA11225
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 01:11:05 -0400 (EDT)
Date: Tue, 1 Oct 2002 22:10:22 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021001221022.B18667@ultraviolet.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
In-Reply-To: <20021002014815.GB14890@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Wed, Oct 02, 2002 at 11:48:15AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 11:48:15AM +1000, Brian May spake thusly:
> I think you are looking for the coreutils, fileutils, shellutils, and
> procps packages.

But are those patched for SE Linux?

> Now I get another error though:

I fixed that with Russells help but now I have another problem:

home:/etc/selinux# make
mkdir -p /etc/security/selinux
/usr/sbin/checkpolicy -o tmp/pol /etc/security/selinux/src/policy.conf
/usr/sbin/checkpolicy:  loading policy configuration from
/etc/security/selinux/src/policy.conf
ERROR 'name conflict for type run_deb_t' at token ';' on line 121201:
#
type run_deb_t, domain, privrole, privuser, privlog, auth;
/usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.12] Error 1

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2af74ACgkQ9PIYKZYVAq1mcgCfe20ae7k27gVTWklg6L9Wo0FX
QDkAniYlQR2LczfBrXwImD8cymJiMbZg
=qyaT
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
