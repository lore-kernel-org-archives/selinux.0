Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2BISkfK022556
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 13:28:55 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2BITLT3028403
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 18:29:21 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o2BISRuf099626
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 19:28:27 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o2BISQo8046762
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 19:28:26 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 11 Mar 2010 19:28:26 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: how to cope with file renames?
Message-ID: <20100311182826.GF24034@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
In-Reply-To: <4B992B72.7070907@redhat.com>
 <1268328422.16780.28.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> SELinux isn't name-based.=20

This is not so much about names but about relationship to the parent
container. I don't care if the file is called foo or bar, but if its
parent dir has foo_t or bar_t context. There already is some coupling
between the file and its directory. For example, to actually do the
rename you need file as well as directory permissions.

So in that regard, why an additional type transition in that operation
would be harmful?

> rename() doesn't change your file mode or ACLs either.

Yes, that's why I said it's an old problem. I hoped that someone would
have solved it in a systemic way.


Daniel J Walsh wrote:
> Just need to walk the tree adding watches for ever directory and any
> time a a new directory shows up you would add it to the watch list.
> I am not sure how much inotify can handle.  We might get in trouble
> with the amount of resoures used.

See the -r in man inotifywait (http://linux.die.net/man/1/inotifywait).
Actually you can use that tool and restorecon in a simple shell script
to make a restorecond of your own. But having this in hand, you don't
need neither inheritance nor type transitions for files. You could just
make any new file with default_t and wait until restorecon labels it.


Michal Svoboda

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuZNkoACgkQg/fU9pp1uX5VtACcD0bhMIByUL65kc7SCfSrH336
ETUAoJgaVkM43TEcGZOjDdyQV7M/2kNt
=OSV7
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
