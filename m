Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81G2XrT022127
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 12:02:33 -0400 (EDT)
Subject: DBus session bus -> separate security class?
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov, sds@epoch.ncsc.mil, dwalsh@redhat.com,
   rcoker@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ILiVy8xZI1eOE1x5BdLl"
Date: Wed, 01 Sep 2004 12:03:45 -0400
Message-Id: <1094054625.11084.34.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ILiVy8xZI1eOE1x5BdLl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working on updating the DBus policy to handle the addition of the
user session DBus instance.  However I ran into a problem - if we want
the user session DBus to be a userspace object manager as well (and I
think we do, long term), I think we really need for it to be a separate
security class.  Otherwise, there's no way to distinguish between the
two in the security policy.  For example, we might want to say in the
policy:

allow cupsd_t userdomain:dbus { send_msg };

to allow userdomain control over the CUPS daemon.  However this would
also mean that any session bus would allow the CUPS daemon to send
messages, if the cups daemon somehow got access to it (which is
unlikely, since it would have to have access to user_tmp_t:fifo_file,
but still).

Conversely, we might want to say for the session bus:

allow user_mozilla_t user_networkmanager_t:dbus { send_msg };

to e.g. allow Mozilla to tell the user's networkmanager (all running in
the user session) that it's ready to go offline.  We wouldn't want this
permission to be granted by the system bus daemon (although again this
is likely to be stopped by earlier permissions).

So I think we really want:

allow cupsd_t userdomain:system_dbus { send_msg };
allow user_mozilla_t user_networkmanager_t:session_dbus { send_msg };

I think unfortunately it's a bit late to change this for Fedora Core 3,
so likely what we'll do is just not have the session bus be a userspace
policy enforcer, or just run as user_t.  But long term I think we need
separate security classes.

Thoughts?


--=-ILiVy8xZI1eOE1x5BdLl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBNfLhOIkJWWp2WGURAvgLAJ9h+3E1isAx8w2Kp9V1ldj0U/mInwCfapC4
y5mt0DRk6/CKUZDG1YusY4A=
=UVfg
-----END PGP SIGNATURE-----

--=-ILiVy8xZI1eOE1x5BdLl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
