Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o17GGqQp029783
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 11:16:52 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o17GGePs009486
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 16:16:40 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o17GGZuo044273
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 17:16:35 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o17GGZ4Q045138
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 17:16:35 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Sun, 7 Feb 2010 17:16:35 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: Selinux in enforcing mode prevent network interface to be
 configured at boot for Debian stable ( 5.0)
Message-ID: <20100207161635.GQ1750@myhost.felk.cvut.cz>
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZaW/dtY/7oMe/vLp"
In-Reply-To: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ZaW/dtY/7oMe/vLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Elko Kuric wrote:
> I decided to move my debian installation to use Selinux, and I
> installed it using
> http://wiki.debian.org/SELinux  howto ( Debian 5 )
> When Selinux is in "permissive" mode, network connection is up and it
> works but when I switch Selinux to "enforcing" mode network interface
> is down after reboot.

=46rom what I can remember this is an issue with the network hotplug.
A short way to solve this is to simply disable hotplug for all your
interfaces in /etc/network/interfaces (see man interfaces). You have
a server anyway so you shouldn't need to plug network cards in and out
while it's running.

For a permanent fix, kindly report this to the debian folk.

You will probably also experience AVC denials for all the scripts in
/etc/network/*.d directories as they are not run in proper context.
Again a quick solution is to disable them.

I also recommend looking at Russell Coker's page [1] as he has created
some packages that fix the most outcrying problems (eg. postfix).

I am successfully running SELinux on debian lenny (5.0), so it can be
done, only it needs some patience.

Regards,
Michal Svoboda

[1] http://doc.coker.com.au/computers/installing-se-linux-on-lenny


--ZaW/dtY/7oMe/vLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktu52MACgkQg/fU9pp1uX7qsQCgjn4APN0XfoS9aseTdjv+jGLT
PMUAn1aM8b86L6czwzpDFxC95VxczigF
=JG7C
-----END PGP SIGNATURE-----

--ZaW/dtY/7oMe/vLp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
