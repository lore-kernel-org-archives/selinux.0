Date: Thu, 22 Sep 2005 22:38:55 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050922213855.GY27432@vnl.com>
References: <20050917233111.GA17916@vnl.com> <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil> <20050920181039.GL16888@vnl.com> <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil> <1127418086.19487.171.camel@moss-spartans.epoch.ncsc.mil> <20050922213122.GX27432@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWAbeGC4mMoqIxdF"
In-Reply-To: <20050922213122.GX27432@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uWAbeGC4mMoqIxdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The error in cups.te occurs because a reference to

allow cupsd_config_t rpm_var_lib_t:file { getattr read };

occurs outside of the earlier conditional:

ifdef(`distro_redhat', `
ifdef(`rpm.te', `
allow cupsd_config_t rpm_var_lib_t:dir { getattr search };
allow cupsd_config_t rpm_var_lib_t:file { getattr read };
')
allow cupsd_config_t initrc_exec_t:file getattr;
')dnl end distro_redhat

That looks like a Coker to me ;-)

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--uWAbeGC4mMoqIxdF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMyRvZHES7UL0zXERAvCeAJ9e3trg/GlkaZNX02DBOLfVJztgYACfZ4B+
eydeqTTnwAnvZI4ZdTlFf4A=
=DRPu
-----END PGP SIGNATURE-----

--uWAbeGC4mMoqIxdF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
