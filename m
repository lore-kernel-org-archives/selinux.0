Message-Id: <200603180532.k2I5Wuhe004158@turing-police.cc.vt.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to policycoreutils. 
In-Reply-To: Your message of "Fri, 17 Mar 2006 16:39:07 EST."
             <441B2C7B.7050307@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <441B2C7B.7050307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142659941_2829P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 18 Mar 2006 00:32:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1142659941_2829P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Mar 2006 16:39:07 EST, Daniel J Walsh said:

> This will give us the ability of instantly labeling the ~/public_html 
> directory.  So if a user logs in and does a
> mkdir ~/public_html to tool will label the file correctly.

Do you have an estimate on how fast "instantly" is?  A few second's delay in
relabelling ~/public_html is probably not a big thing, but a delay in
relabelling a just-created file to a more restrictive context may be opening a
timing hole (for instance, allowing the grabbing of a just-created GPG or SSH
key before the door is closed).

I'm suspecting the answer is "there's a small hard-to-hit hole" that people
find acceptable risk (which I'm OK on, as long as we're honest about the size
of the risk and how it works....)


--==_Exmh_1142659941_2829P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEG5tkcC3lWbTT17ARAu/xAKCgXjj1nzZP0obQsA2mNJzAoSWWEgCguEcu
GKvHYUFAJlTU3hWIrvi8Rw0=
=q89Z
-----END PGP SIGNATURE-----

--==_Exmh_1142659941_2829P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
