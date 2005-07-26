Message-Id: <200507262143.j6QLhBnd006410@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size 
In-Reply-To: Your message of "Tue, 26 Jul 2005 17:26:12 EDT."
             <1122413172.19989.6.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil> <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu> <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil> <200507262117.j6QLHVB2005226@turing-police.cc.vt.edu>
            <1122413172.19989.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122414190_2654P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 26 Jul 2005 17:43:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1122414190_2654P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Jul 2005 17:26:12 EDT, Stephen Smalley said:

> Actually, looking at the code, I think I see the problem; we can have a
> false conflict there due to enabled flags.  Have to also look into why
> it doesn't recover gracefully, as it should just reject the policy in
> that case, not die, of course.

Glad you could find it on the sketchy info I gave you. :)

I assume "graceful recovery" means "issue a useful message, and then refuse
to boot" as opposed to oopsing and panicing? I *want* my box to refuse to come
up if it can't find the policy, just in a nicer manner.. ;)

--==_Exmh_1122414190_2654P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5q5ucC3lWbTT17ARAuriAKCI5KsFstGCCVG0iNMl85n+m3sjSwCg8pds
aEsoXLFfJw72M9pJMa9emUI=
=PI8t
-----END PGP SIGNATURE-----

--==_Exmh_1122414190_2654P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
