Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oABCrwUC005792
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 07:53:58 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oABCrv5h019889
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 12:53:58 GMT
Received: by eyb6 with SMTP id 6so1026788eyb.12
        for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 04:53:57 -0800 (PST)
Date: Thu, 11 Nov 2010 13:53:52 +0100
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: default to user_u for new logins (on RHEL6) ?
Message-ID: <20101111125352.GB17316@localhost.localdomain>
References: <20101111090744.GA9286@oc1046828364.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
In-Reply-To: <20101111090744.GA9286@oc1046828364.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2010 at 10:07:44AM +0100, Jan-Frode Myklebust wrote:
> Our userdatabase is in an LDAP directory, and home directories for these
> are created on demand by pam_oddjob_mkhomedir on first login. Is there
> any way of defaulting to create all users as selinux user "user_u" --
> instead of the default "unconfined_u" ?


i think you want semanage login -m -s user_u -r s0-s0 __default__

>=20
> It would be preferable to do this trough PAM, so that it only applies to
> users affected by password authenticated users
> (/etc/pam.d/password-auth-ac), and not to any system accounts that are
> created trough f.ex. RPM.
>=20
>=20
>   -jf
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzb52AACgkQMlxVo39jgT8ytQCgoAFUfX8V5mErb+C4eo0GVQKT
EJoAoKheNWMImY6R2ZqcK17MfrvDdnuj
=qxcx
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
