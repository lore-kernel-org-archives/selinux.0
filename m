Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2BH0OKv014746
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 12:00:26 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2BH0sT3015266
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 17:00:54 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o2BH0FoJ091838
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 18:00:15 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o2BH0EK7021222
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 18:00:15 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 11 Mar 2010 18:00:15 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: how to cope with file renames?
Message-ID: <20100311170014.GE24034@myhost.felk.cvut.cz>
References: <20100311081913.GC24034@myhost.felk.cvut.cz>
 <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
In-Reply-To: <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> http://pecl.php.net/package/selinux

Thanks!

> > In short, I was wondering if there was a way for a rename()d file to be
> > subjected to a type transition as if a new file was created? (I tried a
> > type_trans rule but to no avail.) Or any other way to deal with renaming
> > files between variously contexted dirs?
>=20
> No.  The best way of course is to create the file with the right
> security context in the first place, whether explicitly or by uploading
> it to the same parent directory as the final destination.

That's what I do right now. I can do that because there's only one
context. But in a web service your script isn't invoked until the file
is already uploaded. So you can't pre-set the correct context and/or
destination if you have two or more possibilities.

> Alternatively the php scriptlet can use the selinux bindings to
> manipulate the context, or you can configure restorecond(8) to watch
> for the destination file and reset its security context as needed.

Does restorecond handle recursive directory restoring yet? (Last time I
tried it worked only on single files.)

But yes, in principle a cron job with 'restorecon -R' is a way too. But
all those solutions are 'dirty', because they need you to make an extra
effort. There's already a huge infrastructure with type inheritance and
transitions, as to make the labeling independent of the application; but
the rename operation just spoils that and forces you back to square one,=20
to explicitly care about your files' contexts. Is there a fundamental
reason why this is so (and can't be changed)?


Michal Svoboda

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuZIZ4ACgkQg/fU9pp1uX6h/QCeMscHfdo6vvPgwgX2Fxv/fuMR
qGIAnivVSgJYCUCsCv3ypJNZWnmygdwB
=uLss
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
