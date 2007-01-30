Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0UHRWnJ007530
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 12:27:32 -0500
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0UHSXph017148
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 17:28:34 GMT
Message-Id: <200701301728.l0UHS9uc012480@turing-police.cc.vt.edu>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Steve G <linux_4ever@yahoo.com>, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: missing avc message field names
In-Reply-To: Your message of "Tue, 30 Jan 2007 12:06:06 EST."
             <45BF7AFE.1000701@tresys.com>
From: Valdis.Kletnieks@vt.edu
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com> <200701291749.21897.sgrubb@redhat.com> <45BF5AE3.6030602@mentalrootkit.com>
            <45BF7AFE.1000701@tresys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1170178089_27151P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 30 Jan 2007 12:28:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1170178089_27151P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Jan 2007 12:06:06 EST, Joshua Brindle said:
>
> This is fairly off topic here (selinux list) but I agree with Karl. As a 
> recovering admin I think I can say that admins expect to be able to use 
> various unix utilities to inspect log files, particularly tail -f.

As a counter-example - lastcomm and last.

If you want to use tail -f, don't run auditd, and use syslog-ng(*) or similar
to send the msgs you're interested in to a file that you can tail -f.

Or you *can* tail -f the file, just be ready to deal with the fact that it
contains binary data, same as the process accounting file and the last-login
file.

(*) syslog-ng can route to logfiles based on a regexp, so you don't have to
send all kernel output to the same file...

--==_Exmh_1170178089_27151P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFv4ApcC3lWbTT17ARAijSAJ9eeeDeRIYHspd5QBFfFy3b98xzogCdEzpp
5JK5k+JT+K33uj4KDeshRds=
=apPR
-----END PGP SIGNATURE-----

--==_Exmh_1170178089_27151P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
