Message-Id: <200404141950.i3EJoFSM021953@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans? 
In-Reply-To: Your message of "Thu, 15 Apr 2004 02:19:27 +1000."
             <200404150219.27857.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com>
            <200404150219.27857.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1276102797P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 14 Apr 2004 15:50:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1276102797P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Apr 2004 02:19:27 +1000, Russell Coker said:

> For a typical machine compiling only the .te files that we need should get 
> this down to around 2M.  So obviously for space the correct selection of .te 
> files is a much more significant issue than booleans.  However such selection 
> of .te files requires a full environment for building policy on each machine

Would a return to the policy/*.te and policy/unused/*.te split, with a
really silly shell script that does the moral equiv of:

for i in unused/*.te; do rpm -qf $i && mv $i .; done

(i.e. if the program is installed, move the .te out of unused)

be a short-term direction we want to look at?  Longer term,
a similar "tweak the tunables to match the installed software" program
would probably be needed....


--==_Exmh_-1276102797P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAfZX3cC3lWbTT17ARAkWuAKDpxK0UBRxLFVZ2EeQaLRWqOpyuPACfS+sa
JpjEamlX90NYVsOQ3R1htyk=
=m0wj
-----END PGP SIGNATURE-----

--==_Exmh_-1276102797P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
