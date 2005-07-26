Message-Id: <200507262117.j6QLHVB2005226@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size 
In-Reply-To: Your message of "Tue, 26 Jul 2005 17:03:50 EDT."
             <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil> <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
            <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122412651_2654P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 26 Jul 2005 17:17:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1122412651_2654P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Jul 2005 17:03:50 EDT, Stephen Smalley said:
> On Tue, 2005-07-26 at 16:53 -0400, Valdis.Kletnieks@vt.edu wrote:
> > security: conflicting type rules when adding type rule for true.
> <snip>
> > This ring any bells, or suggest debugging next steps?
> 
> Run checkpolicy -b on the same binary policy file, and see if you get
> the same error from it.  Is your policy a standard one?  If not, is it
> available somewhere for examination?

[/etc/selinux/strict]3 checkpolicy -b policy/policy.19 
checkpolicy:  loading policy configuration from policy/policy.19
security:  4 users, 6 roles, 1589 types, 70 bools
security:  55 classes, 501615 rules
security:  4 users, 6 roles, 1589 types, 70 bools
security:  55 classes, 501615 rules
checkpolicy:  policy configuration loaded
[/etc/selinux/strict]3 checkpolicy -b src/policy/policy.19 
checkpolicy:  loading policy configuration from src/policy/policy.19
security:  4 users, 6 roles, 1130 types, 37 bools
security:  55 classes, 290054 rules
security:  4 users, 6 roles, 1130 types, 37 bools
security:  55 classes, 290054 rules
checkpolicy:  policy configuration loaded
[/etc/selinux/strict]3 rpm -q selinux-policy-strict selinux-policy-strict-sources
selinux-policy-strict-1.25.3-3
selinux-policy-strict-sources-1.25.3-3

Stock FC4-devel from fairly recent, I have *not* put the userspace patches
on.  Possibly an issue with the kernel read-legacy-policy code?

--==_Exmh_1122412651_2654P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5qhqcC3lWbTT17ARAmtAAJ4upLHZ20eygXWO7g4qBoKiAxMQ+QCfdnNI
sgKGvr/FkPzLIxhon5s2ENo=
=bHV1
-----END PGP SIGNATURE-----

--==_Exmh_1122412651_2654P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
