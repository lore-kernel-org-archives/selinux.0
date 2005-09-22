Date: Thu, 22 Sep 2005 23:43:06 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050922224306.GZ27432@vnl.com>
References: <20050917233111.GA17916@vnl.com> <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil> <20050920181039.GL16888@vnl.com> <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil> <1127418086.19487.171.camel@moss-spartans.epoch.ncsc.mil> <20050922213122.GX27432@vnl.com> <20050922213855.GY27432@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEpdcbHbO3kvNF3k"
In-Reply-To: <20050922213855.GY27432@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--PEpdcbHbO3kvNF3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Okay, I've got the debian selinux-policy-default package to install
finally. These are the hacks I used:

	cd file_contexts/program/
	touch dante.fc winbind.fc
	#This is not required, but gets rid of an error msg
	#edit nrpe.fc and comment out two lines:
	# #/usr/lib(64)?/netsaint/plugins(/.*)? -- system_u:object_r:bin_t
	# #/usr/lib(64)?/nagios/plugins(/.*)?   -- system_u:object_r:bin_t
	cd ../../domains/misc
	#edit kernel.te, make line look like:
	#	type kernel_t, domain, privmodule, privlog, sysctl_kernel_writer, etc_wr=
iter ;
	cd ../programs
	#edit rpm.te and put conditional around line:
	# ifdef(`rpm.te', `
	# allow cupsd_config_t rpm_var_lib_t:file { getattr read };
	# ')

I won't guarantee my hacks are right, but they
get me through dselect at least.=20

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--PEpdcbHbO3kvNF3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMzN6ZHES7UL0zXERAj4eAJ4gwtpejXMLTJs1P5CqIHFaTLWWHACaAs2S
xYaFEMgLz1vZoS8+owtfI9s=
=aAS4
-----END PGP SIGNATURE-----

--PEpdcbHbO3kvNF3k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
