Date: Thu, 22 Sep 2005 22:31:23 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050922213122.GX27432@vnl.com>
References: <20050917233111.GA17916@vnl.com> <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil> <20050920181039.GL16888@vnl.com> <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil> <1127418086.19487.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzUyxqdXrKJm2YZW"
In-Reply-To: <1127418086.19487.171.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MzUyxqdXrKJm2YZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Further hacks to get Debian policy to install.

These are missing:

touch file_contexts/program/dante.fc
touch file_contexts/program/winbind.fc

These file contexts are duplicated

/etc/selinux/contexts/files/file_contexts: Multiple same specifications for=
 /usr/lib(64)?/netsaint/plugins(/.*)?.
/etc/selinux/contexts/files/file_contexts: Multiple same specifications for=
 /usr/lib(64)?/nagios/plugins(/.*)?.

In these files:
file_contexts/program/nagios.fc:/usr/lib(64)?/netsaint/plugins(/.*)?       =
     system_u:object_r:bin_t
file_contexts/program/nrpe.fc:/usr/lib(64)?/netsaint/plugins(/.*)?      -- =
     system_u:object_r:bin_t

file_contexts/program/nagios.fc:/usr/lib(64)?/nagios/plugins(/.*)?      sys=
tem_u:object_r:bin_t
file_contexts/program/nrpe.fc:/usr/lib(64)?/nagios/plugins(/.*)?        -- =
     system_u:object_r:bin_t

These may have just been fixed since I last updated... I=20
will have to reload policy from scratch to confirm that.

Cups.te has an error:
domains/program/cups.te:245:ERROR 'unknown type rpm_var_lib_t' at token ';'=
 on line 140828:
#line 245
allow cupsd_config_t rpm_var_lib_t:file { getattr read };

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--MzUyxqdXrKJm2YZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMyKqZHES7UL0zXERAifwAJ4sUZhMXmA+/N04HL04F4QS1EUuaQCfXELl
BU+niA11cujfG++TscJqdaA=
=OpH9
-----END PGP SIGNATURE-----

--MzUyxqdXrKJm2YZW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
