Subject: network and module problems
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DQJlqhWy7nxm7ZnObx2Z"
Date: 24 Jan 2002 12:15:59 -0500
Message-Id: <1011892644.1401.0.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DQJlqhWy7nxm7ZnObx2Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello all,

I installed the full lsm package onto a RH7.2 machine and I'm seeing
problems when I try to insmod a module or to get any type of networking
loaded. =20

Network first.  When the machine boots no network interfaces are loaded,
not even the loopback.  If I try to run `ifup lo` or something similar
to raise the interface I get the error:

Cannot send dump request: Connection refused

I know this isn't just a problem with the network driver since the
loopback doesn't raise either, but I have tried loading my nic as a
module and by building it straight into the kernel.  Which brings me to
the module problem.  Dmesg shows that it finds the nic but I never see
the module as being loaded when I run lsmod and when I try to insmod it
I get an error saying that it can't locate the card on the console and
avc errors in the system log.

I'm also running this on ext3 if that might have something to do with it
since I know ext3 isn't properly supported yet.  Anyhow, any ideas are
welcome and I can reload this machine if the need arises.  Thanks.

Timothy,


--=-DQJlqhWy7nxm7ZnObx2Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8UEFOf/PqxrKarmgRAjzEAJsF8MaNBeBb5uHNMTGlwRzYvCVbKgCcD+56
+br6fbnPgKXV6Ac4QD31uUs=
=7gAH
-----END PGP SIGNATURE-----

--=-DQJlqhWy7nxm7ZnObx2Z--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
