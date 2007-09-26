Message-ID: <46FACCF8.2060500@redhat.com>
Date: Wed, 26 Sep 2007 17:19:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Todd C. Miller" <tmiller@tresys.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: I am concerned about putting genhomedircon changesinlibsemanage
 into Fedora 8.
References: <200709262020.l8QKKDX7025382@tex.courtesan.com>
In-Reply-To: <200709262020.l8QKKDX7025382@tex.courtesan.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

That change works for me.


xguest looks like it has only its valid contexts and they all seem to be
there.

Differences that I see, between genhomedircon script and new way of
doing it are.

  diff /tmp/xguest.old /tmp/xguest.new
27a28,29
> /tmp/gconfd-twalsh    -d      xguest_u:object_r:xguest_tmp_t:s0
> /tmp/gconfd-xguest    -d      xguest_u:object_r:xguest_tmp_t:s0


Looks like the old way did not pick up /tmp contexts.

/root was labeled system_u the old way and user_u the new way.



But
/usr/sbin/semanage login -m -s guest_u __default__

Is causing a segfault in genhomedircon line 627
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG+sz4rlYvE4MpobMRArnwAJ4qsMrDubqqc+H0xEd12mmA/vmzSACgs8WM
GiEUGaXIbHE6h6B4cZJ4K5s=
=0BW0
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
