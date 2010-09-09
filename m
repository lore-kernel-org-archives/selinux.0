Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o89HKtwX017004
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2010 13:20:55 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o89HKqUa009628
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2010 17:20:52 GMT
Received: by eyf6 with SMTP id 6so1204083eyf.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Sep 2010 10:20:52 -0700 (PDT)
Message-ID: <4C891767.1060207@gmail.com>
Date: Thu, 09 Sep 2010 19:20:39 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] refpolicy: hadoop
References: <4C88F6BC.6080605@tycho.ncsc.mil>
In-Reply-To: <4C88F6BC.6080605@tycho.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF79E7305320D623DCB1488C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF79E7305320D623DCB1488C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/09/2010 05:01 PM, Paul Nuzzi wrote:
>  Added policy for the hadoop stack to refpolicy.  All major components
> of hadoop have been separated and confined (namenode, datanode,
> jobtracker, tasktracker, secondarynamenode, zookeeper).  Since many of
> the domains use the same executable to transfer into their domain, the
> init scripts were labelled with a custom initrc domain.   From there a
> domain transfer can occur using the same executable.  Since the domains=

> share the same directory for logging and data files, type transfers wer=
e
> only done on files not directories.  JMX and the rest of hadoop can
> continue to run without a problem.  The policy was tested against
> Cloudera's version of hadoop CDH2 and CDH3.  An unconfined role
> transition was also needed to get hadoop in the correct domain.  Not
> sure if we want to add the zookeeper and namenode ports to refpolicy or=

> use semanage.  I added them to refpolicy.
>=20
> Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
>=20

Was this policy developed on and for the EL5 system? I am wondering why
unconfined_t is in the mix here. Remember that strict and mls policy do
not ship with the unconfined domain, and that in recent refpolicy, the
interaction with the unconfined domain should be optional, so that it
can be de-installed.

I am wondering why it is unconfined_t that is domain transitioning to
the rc script domains and not init. I guess the transition from
unconfined_t to initrc_t is not happening automatically. In that case i
would use the run_init command to domain transition to initrc first and
then let that domain transition to your rc script domain, probably using
the init_script_domain() interface.


--------------enigCF79E7305320D623DCB1488C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyJF3AACgkQMlxVo39jgT/iZwCfVzxXoA64gZforzII4+V5n4/u
nDQAoKAXUedVcCC/cyGsA/6Qz/uQZa8P
=EyV9
-----END PGP SIGNATURE-----

--------------enigCF79E7305320D623DCB1488C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
