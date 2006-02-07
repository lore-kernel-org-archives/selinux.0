Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k174VJXf017600
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 23:31:19 -0500 (EST)
Received: from h80ad24e1.async.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k174VFkS013163
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 04:31:17 GMT
Message-Id: <200602070431.k174V6oe010791@turing-police.cc.vt.edu>
To: Goo GGooo <googgooo@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SElinux from scratch 
In-Reply-To: Your message of "Tue, 07 Feb 2006 14:29:55 +1300."
             <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1139286665_3075P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 06 Feb 2006 23:31:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1139286665_3075P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Feb 2006 14:29:55 +1300, Goo GGooo said:

> For now my intent is to harden Apache httpd, prevent it from executing
> all but permitted binaries, restrict access to some filesystem areas,
> etc. I'm running OpenSUSE 10.0 and have found the SElinux-related

You probably want to look at the httpd work already done, which probably
already does most (or maybe all) of that already...

> packages (sysvinit, pam, ...) and basically I'm ready to create
> whatever files in /etc, compile them, load in permissive mode, watch
> the syslog, fix the policies, etc. I just don't know where to start...

Take *careful* note - watch the syslog and fix the policy isn't necessarily
the right way to go about it, and shouldn't be considered a replacement
for actually *thinking* about the design of the policy.

In particular, you are *highly* unlikely to do a good job of testing the error
paths - as a result, in production use the policy will stomp on any attempts at
error recovery.  And trying to debug things at that point is really a hassle -
when it actually hits 6 or 8 months from now, you're unlikely to think that the
second error is an SELinux refusal, and think it's a result of random wreckage
left by whatever caused the *actual* error...


--==_Exmh_1139286665_3075P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD6CKJcC3lWbTT17ARAn7UAKDpImirPc19Y1CScsv9v/jM1n+U1wCgyuQ0
tYzVozdNVdH+HliOuQIgFb8=
=2lcQ
-----END PGP SIGNATURE-----

--==_Exmh_1139286665_3075P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
