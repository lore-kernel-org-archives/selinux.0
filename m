Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2JUiXZ009252
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:30:44 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2JTN8r003684
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 19:29:24 GMT
Message-Id: <200411021930.iA2JURrg028137@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: Re: dynamic context transitions 
In-Reply-To: Your message of "Mon, 01 Nov 2004 22:58:20 GMT."
             <20041101225820.GP9643@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com> <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
            <20041101225820.GP9643@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-876842421P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 02 Nov 2004 14:30:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-876842421P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Nov 2004 22:58:20 GMT, Luke Kenneth Casson Leighton said:

>  any process which uses either mls_upgrade or mls_downgrade must contain
>  within it [usually by accident] resources that are being passed over to
>  the other context after the mls change.

Right so far - if it isn't dragging a resource along, there's no point to
doing the up/downgrade call.

>  by exec()'ing a process, that just simply cannot occur: the
>  most you pass over is the command-line arguments, environment
>  variables and um... according to man exec that's it.  [oh, and
>  man execve says it respects setuid and setgid bits on an executable.]

Not true at all - just because the only things passed to the execve()
syscall are the argv[] and envp[] arrays doesn't mean that it's the
only resources passed to the post-exec code:

1) Open file descriptors, unless flagged as close-on-exec
2) ulimit/umask settings
3) Posix 1.e attributes (modulo the active/permitted/inherited changes)
4) The current working directory
5) Any namespaces created by mount --bind, clone(CLONE_FS), and friends.

And probably a bunch of other stuff I'm forgetting.  There's PLENTY of
places to accidentally leak stuff up/down across an exec() call....

--==_Exmh_-876842421P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBh+BQcC3lWbTT17ARArSHAJ9ZStD60h/e4rIGVnZCqfdUYXK5vQCgkv5Z
ImVP27NIgJDRET+LfM8zrL4=
=Dl81
-----END PGP SIGNATURE-----

--==_Exmh_-876842421P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
