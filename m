Message-Id: <200411262244.iAQMiLvE007647@turing-police.cc.vt.edu>
To: petre rodan <kaiowas@gentoo.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Daniel J Walsh <Dan-Walsh@comcast.net>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Still getting random execute permissions on shared libraries. 
In-Reply-To: Your message of "Fri, 26 Nov 2004 21:49:22 +0200."
             <41A788C2.9060609@gentoo.org>
From: Valdis.Kletnieks@vt.edu
References: <41A3EC21.1090200@comcast.net> <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
            <41A788C2.9060609@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-199084579P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 26 Nov 2004 17:44:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-199084579P
Content-Type: text/plain; charset=us-ascii

On Fri, 26 Nov 2004 21:49:22 +0200, petre rodan said:

> I made a patch to the kernel that reverts to the old behaviour. no more execs on random files.
> I find that changing the policy to allow those execs is not a valid solution.

Why is fixing the policy not a valid solution?

> would it be feasible to send upstream a patch that would remove the 'exec on 
> read' behaviour if the kernel has selinux capabilities?

A Very Bad Idea.  Basically, you're disabling a good and reasonable security
measure entirely, just because you can't get it to work with a *legacy* binary
and another security measure..

If you *have* to do something like this, you should make it much more targeted,
so the test is "if kernel has selinux *and* the binary is flagged as a known
problem, *then* disable *for this process".

It's especially bad because you're turning off future security in order to
deal with *legacy* binaries.  What do you do if/when Java gets rebuilt with
a more recent toolchain that adds the PT_GNU_STACK header?  Then your problem
is solved the *right* way, but you're still turning off a security measure
for everything else needlessly.

That's something that's probably OK as a local patch while you find a better
way, but we certainly don't want it merged into upstream....


--==_Exmh_-199084579P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBp7HFcC3lWbTT17ARAhhtAJ9oTwYLv3CJmly/GJ0OGZQlJt1TKgCfa3C4
F/11Kw3jul1/3Of0fresRY4=
=n274
-----END PGP SIGNATURE-----

--==_Exmh_-199084579P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
