Message-Id: <200603270754.k2R7s4Zv023257@turing-police.cc.vt.edu>
To: Gaurav Poothia <gpoothia@cs.sunysb.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Query about desktop apps. 
In-Reply-To: Your message of "Sun, 26 Mar 2006 22:14:59 EST."
             <Pine.GSO.4.53.0603262138250.5076@compserv1>
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.53.0603252027240.10215@compserv1> <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
            <Pine.GSO.4.53.0603262138250.5076@compserv1>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143446044_18690P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 27 Mar 2006 02:54:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1143446044_18690P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Mar 2006 22:14:59 EST, Gaurav Poothia said:

> I still dont see it. I assume that there is a vi specific domain to which
> both both sys admin and regular user will have to transition.

No.. the point is that as far as a *security* model goes, what you really care
about is:

1) What is the sysadmin allowed to do?
2) What is the regular user allowed to do?

The obvious answer is "put the sysadmin and all programs he runs in a domain
that has certain access rights", and "put the user and all his programs in a
different domain with different rights".

You see, you don't really need a 'vi' policy, because the policy basically is
"vi can read the files the user can read, and write the files the user can
write".  In other words, no separate policy is needed - unless you *really*
feel like wasting your time and creating a vi policy that says the above, and
then a policy for /bin/sed that says the same thing, and for cp, and for cat,
and for dd, and for perl, and for all the other myriad ways there are to read
and/or write a file on a Linux box - all things that are just better off run in
the invoking user's domain and not worry.  If the user is allowed to do it,
the program is, and if the user isn't, the program usually isn't either.  So
the vast majority of binaries can just be flagged as "this is a bin_t that
should be run under the user's access domain".  Makes things a *lot* easier..

When it gets interesting is when the invoked binary needs access to something
that the calling user *doesn't* already have access to - for instance, if you
change your password, the program will at some point need to have access to the
/etc/shadow file even though the invoking user *doesn't* have that access.
*THIS* is when you need a separate security domain for that program - because
the list of what that program should be allowed is *different* than what the
invoking user is allowed (in particular, the program to change your password
can probably do *without* access to 95% of the things the invoking user *does*
have access to...)


--==_Exmh_1143446044_18690P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEJ5occC3lWbTT17ARAhbVAKCCgDyqVcyHpal3EATjQEuhhMJJRwCgu774
l23svblb9JCRFqPxirWeAtY=
=K566
-----END PGP SIGNATURE-----

--==_Exmh_1143446044_18690P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
