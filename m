Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59BEirT018774
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 07:14:45 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i59BEgTV019237
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 07:14:42 -0400 (EDT)
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 9 Jun 2004 13:14:41 +0200
Date: Wed, 9 Jun 2004 13:14:28 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: How to handle tmpfiles under /home ?
Message-Id: <20040609111427.GA2006@jmh.mhn.de>
References: <20040607234412.GB2073@jmh.mhn.de> <200406091505.52603.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <200406091505.52603.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-06-09 08:20]:
> On Tue, 8 Jun 2004 09:44, Thomas Bleher <bleher@informatik.uni-muenchen.d=
e>=20
> wrote:
> > I recently ran into a problem with tmpfiles in my homedir. I have
> > configured mutt to store mails I write under ~/.mutt/tmp/.
> > Unfortunately, current policy only allows postfix to read user_tmp_t.
> > This leads to postfix sending totally empty mails in enforcing mode.
>=20
> What version of the policy allows postfix to access user_tmp_t?
>=20
> user_mail_t is allowed access to files of type user_tmp_t.  But apart fro=
m=20
> that there should be no access of postfix to user_tmp_t.

Yeah, I was unclear here. The denial occurs in user_mail_t.

> user_tmp_t generally should not be used for files under the user home=20
> directory, so ~/.mutt/tmp should be labelled as user_home_t.
>=20
> If you create a file on /tmp and mv it to ~ then if ~ and /tmp are on the=
 same=20
> file system then it will get the type user_tmp_t, is this the case with m=
utt? =20
> What does that have to do with Postfix anyway?  Postfix should not be=20
> attempting delivery to ~/.mutt anyway.
>=20
> Your message didn't clarify what your problem is, or what your objectives=
 are,=20
> so I can't give any advice until I get more information.

Apparently my mail wasn't clear so I'll try to restate my problem:
I'm using mutt to read mail over IMAP, sent mail goes through a local
postfix. mutt can be configured where to store mails which are being
composed. I chose ~/.mutt/tmp which means that newly created messages
have type user_home_t. mutt then calls /usr/sbin/sendmail which
transitions to user_mail_t. sendmail wants to read the new message,
fails to do so because it isn't allowed to read user_home_t; as a result
a totally empty message is sent.

I have fixed this particular case in my local policy already but I
posted it here because I think that this is a more general problem:
I think it is generally encouraged for users to set $TMP and $TMPDIR to
some directory which is under their control and not world-writable.
This can be done under /tmp (I think Bastille-Linux had a script for
this) but it is much easier for users to do this in their homedir.
The problem however is that setting $TMP to something under ~ breaks
with current policy.
This is OK on systems with only a few users who can easily be educated
but presents problems on systems with a few thousand users.
So my hope is that there will be some generic solution (like ~/.tmp) as
I still see some security benefits to private homedirs, even with
SELinux.

>=20
> As for Steve's message about putting the MUA into it's own domain, the pr=
oblem=20
> with that is that the MUA is usually expected to be able to attach files =
=66rom=20
> any directory and save received attachments to any directory.  It wants t=
o=20
> run gpg and store the gpg pass-phrase, so unless the usage patterns are=
=20
> significantly changed there's little ability to lock things down.
=20
I agree with this. Additionally I'm reading mail over imap, so my mail
reader needs network access.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxvETxWIrrrL0q+cRAnEuAKCZpQIczA1LC6dH9VSA0d9nXTOTygCcD5Nc
RMZ7TOrspzcAqbPIl5hm2kE=
=RwdO
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
