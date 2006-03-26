Message-Id: <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
To: Gaurav Poothia <gpoothia@cs.sunysb.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Query about desktop apps. 
In-Reply-To: Your message of "Sat, 25 Mar 2006 21:29:11 EST."
             <Pine.GSO.4.53.0603252027240.10215@compserv1>
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.53.0603252027240.10215@compserv1>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143345096_4291P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 25 Mar 2006 22:51:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1143345096_4291P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Mar 2006 21:29:11 EST, Gaurav Poothia said:

> Q1. Is the there a need for 2 different policies for an app like vi or is
> there something I am missing?

You're missing something.

> Additionally it seems to me that we need a way for the regular users vi
> policy to prevent him from overwriting other user's data (that probably
> a solvable problem given the constructs,)

The sysadmin invokes vi while already in a sysadm_t or similar context that
is allowed to poke at the files in question.  The user is invoking it
in user_t or similar..

And remember - if the *regular* file permissions don't allow it, the SELinux
ones won't matter.  So as long as userA doesn't chmod 777 the file, userB
still can't get at it..

> Q2. How do you make an app like vi when invoked by a regular user stick to
> that particualar user's data?

File permissions still work.

And if you're *really* paranoid, you can always define separate SELinux
identities  usera:user_r:user_t and userb:user_r:user_t and add rules that
prohibit a usera process from using userb files and vice versa.

Or use the MCS stuff to add categories, and define userA and userB with
separate default categories that each other can't read (this doesn't scale
well past 256 users, however).
 
> Q3More importantly how do you prevent a malicious vi binary from modifying
> any of the users own file on the sly (afterall the user can use vi to
> modify ANY of his files, so no
> policy should really stop vi from doing so)

Fix the system so a malicious vi binary can't be installed in the first place.

If there's a rogue 'vi' on your system, you have *bigger* problems than the
fact it can ruin a user's data.


--==_Exmh_1143345096_4291P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEJg/IcC3lWbTT17ARArzbAJ9tX1LVLbVwWITJhQgwcIZg8ilXIQCcCpTz
PUSvsVEuKS3H0SVSH8Ux3uk=
=LVFi
-----END PGP SIGNATURE-----

--==_Exmh_1143345096_4291P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
