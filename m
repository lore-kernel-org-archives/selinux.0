Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB7GodIi029184
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2004 11:50:39 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB7Gn2pn024192
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2004 16:49:03 GMT
Message-Id: <200412071650.iB7GoSQs014629@turing-police.cc.vt.edu>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Yee-HAH! 'smartd' issues 70 avc's when it tries to send mail... 
In-Reply-To: Your message of "Tue, 07 Dec 2004 10:24:54 EST."
             <41B5CB46.4020407@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <200412032012.iB3KCjaT030175@turing-police.cc.vt.edu>
            <41B5CB46.4020407@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1430046511P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 07 Dec 2004 11:50:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1430046511P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Dec 2004 10:24:54 EST, Daniel J Walsh said:

> Can you try this patch

Will let you know after I get a chance to test at a reboot, but at first
eyeball it looks close to workable, if not elegant.  Probably be tomorrow
before I have feedback on this one...

> +can_exec(fsdaemon_t, { sbin_t bin_t shell_exec_t }

Definitely more sledgehammer than elegance here. :)

I'm wondering if it would make more sense to push a patch upstream to the
kernel-utils crew.  Reading the smartd manpage in more detail, it looks like
feeding it a '-M exec /usr/sbin/sendmail' (or building with that as the
default) would let us only have to add sendmail_exec_t rather than all those.

I'll try your patch, and then see where I can get with the 'invoke sendmail
directly' route.

I'm not sure what we want to do here - even if we fix the flood of avc's for
the default case, the smartmontools documentation has examples of invoking
arbitrary shell scripts with -M (which of course means the obvious).  What
direction do we want to take here?  Where should sites that need to add
other 'can_exec' entries be putting them?




--==_Exmh_1430046511P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBtd9ScC3lWbTT17ARAimjAKCLkkdZfhz0Je54YsWdAdoDD3UqGgCg6Jys
T0UM9lMFOUyqGQTcLZAMtNk=
=Z0u/
-----END PGP SIGNATURE-----

--==_Exmh_1430046511P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
