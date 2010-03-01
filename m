Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o21GuCKw032556
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 11:56:12 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o21GuXiu016236
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 16:56:34 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o21Gu2PN027229
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 17:56:03 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o21Gu2Ln066061
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 17:56:02 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Mon, 1 Mar 2010 17:56:02 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: denials with filesystem associate
Message-ID: <20100301165602.GH3990@myhost.felk.cvut.cz>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
In-Reply-To: <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> On file creation, there is an associate check between the security
> context of the file and the security context of the containing
> filesystem. =20

Is there anything I could read up to understand this mechanism?

> In your particular case though the real issue is that you
> have an unlabeled filesystem type that needs a genfscon or fs_use rule
> added to your policy.   Look for a log message that says something along
> the lines of:
> SELinux:  initialized (dev ..., type ...), not configured for labeling

[    2.780406] SELinux: initialized (dev devtmpfs, type devtmpfs), not
configured for labeling

I think this is the new kernel-make dev filesystem that appears in .32
or so. So I need to recompile the base module to use transition SIDs,
like on normal tmpfs, right?

Regards,
Michal Svoboda

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuL8aIACgkQg/fU9pp1uX7GkQCgqFNS+h4W5jz8K5ySZv3/Kji/
0fsAn0hGilwbjS9zTbYYs5bxr/Wiq+sS
=x9eU
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
