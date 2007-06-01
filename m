Subject: Re: SELinux userspace infrastructure language
From: James Antill <jantill@redhat.com>
To: Stephen Bennett <spb@gentoo.org>
Cc: Joshua Brindle <jbrindle@tresys.com>, Karl MacMillan <kmacmill@redhat.com>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20070531204502.3a667419@maya>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <20070531204502.3a667419@maya>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Wck3ouWvQl8UjTp9eRYg"
Date: Fri, 01 Jun 2007 00:10:15 -0400
Message-Id: <1180671015.7793.22.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Wck3ouWvQl8UjTp9eRYg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-31 at 20:45 +0100, Stephen Bennett wrote:
> On Thu, 31 May 2007 13:54:23 -0400
> "Joshua Brindle" <jbrindle@tresys.com> wrote:
>=20
> > Given all this I think C++ is the best bet, though I'm not adverse to
> > most of the frontends being written in python, it would just be nice
> > if the actual policy representation and accessors are available from a
> > shared library API that most languages can use.
>=20
> From the library side, C++ has the advantage that it can produce
> bindings for any language that C can.

 Do you have a examples of this? From what little I know it's _much_
harder to produce usable bindings from C++, the Qt/KDE bindings seem to
have been in the works for years now and AIUI only very recently[1] got
into KDE's stable branch. With the first non-C++ application being
written in ... python.
 Even assuming everyone could cooperatively write good C++ code from
scratch using just the right C++ features, which is a huge
assumption[2], it then has to be debugged and then after all that work
all you'll gain is that you can then bind to python (and maybe,
Java/ruby) as well?
 Is anyone writing anything in a language other than C or Python?

>  Writing a library in python
> pretty much guarantees that noone will write anything using it in
> anything but python, and on smaller systems the python interpreter can
> get to be a lot of overhead.

 True, but you can still import C etc. into it if you really need the
space savings.

 Just my 2=C2=A2

[1] http://dot.kde.org/1176941846/

[2] A _Much_ bigger assumption than getting python correct, or C string
handling for that matter.

--=20
James Antill <jantill@redhat.com>

--=-Wck3ouWvQl8UjTp9eRYg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGX5wm11eXTEMrxtQRAvIKAJ9Z/UjRQeSF6+fMK+IW64YsT+CMMwCfWlnB
kbp7k90469O3cba0wlpWT78=
=MVyj
-----END PGP SIGNATURE-----

--=-Wck3ouWvQl8UjTp9eRYg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
