Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88DUrgY001445
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 09:30:53 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88DUqGU016845
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 13:30:53 GMT
Received: by nf-out-0910.google.com with SMTP id b21so420674nfd.4
        for <selinux@tycho.nsa.gov>; Mon, 08 Sep 2008 06:30:52 -0700 (PDT)
Subject: Re: I hope the user guide will explain what to do with a message
	such as this one
From: Dominick Grift <domg472@gmail.com>
To: "Stanley A. Klein" <sklein@cpcug.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1220819121.7524.13.camel@localhost.localdomain>
References: <1220819121.7524.13.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0G6eBLq5jcHXe32k0j0x"
Date: Mon, 08 Sep 2008 15:30:50 +0200
Message-Id: <1220880650.18357.35.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-0G6eBLq5jcHXe32k0j0x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-09-07 at 16:25 -0400, Stanley A. Klein wrote:
> /root

Issues are often:

files in wrong places.
files miss or unlabeled.
booleans.
missing policy.

Best thing in my view would be to learn how to translate AVC denials
into something you can understand. audit2allow can help you with this.

Audit2allow takes a AVC denial as input and translates it into policy
language. /sbin/ausearch -m avc -ts today | audit2allow -R

Audit2why tries to find an explanation for the denials. /sbin/ausearch
-m avc -ts today.

If you translate AVC messages without using audit2allow then you can
also quickly search if any such rule is in policy but maybe not
activated (boolean/tunable policy) seearch --allow -s logwatch_t -t
user_home_dir_t -c dir /etc/selinux/targeted/policy/policy.23

Also make sure that the context of both the source and target are valid.
It looks like logwatch_t is a valid type for this source but the type
for the targeted does not look right to me (/root with context type
user_home_dir_t). Here in Fedora this context is admin_home_t =20

It may be that this location is miss labeled:

/sbin/restorecon -R -v /root

Als you can see if there is a rule for admin_home_t. sesearch --allow -s
logwatch_t -t admin_home_t -c dir /etc/selinux/targeted/policy/policy.23

if you are sure that 1. contexts are correct, 2. there is no tunable
policy to be set for this source, then this is a case of missing policy.

missing policy may or may not signal an intrusion and should be examined
with care. You can try to reproduce the violation. This way you can send
a bug report upstream. if it is reproducible then it may not be a
intrusion but just a bug.

If it is a bug then you can decide to implement a temporary patch to
manage this access. Audit2allow supports a -M function which compiles
policy module for inputted avc denails. One can install,list , update
and remove these and other policy modules with the semodule command.

If you are familiar with SELinux you can also manually write the source
for your custom policy module and compile that with make
-f /usr/share/selinux/devel/Makefile and install the compiled binary
policy module with semdule. Remember to save the sources for your own
modules as you may want to modify these modules later.

I think your issue may or may not be a bug. My quick examination shows
that logwatch_t can get attributes of both directories with context type
admin_home_t as well as user_home_dir_t.

My money say's it is either a miss labeled directory or missing policy.




Dominick Grift <domg472@gmail.com>

--=-0G6eBLq5jcHXe32k0j0x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjFKQIACgkQL00QnzrVtlzrhQCeLaVKePruvmOMQlYdZwoNfhz9
1B4AnRpaX3oFB7zVyrdKbzrWcQLmvk+C
=Ayai
-----END PGP SIGNATURE-----

--=-0G6eBLq5jcHXe32k0j0x--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
