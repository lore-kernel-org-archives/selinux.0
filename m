Message-Id: <200404151452.i3FEqjOd013530@turing-police.cc.vt.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans? 
In-Reply-To: Your message of "Wed, 14 Apr 2004 22:29:44 EDT."
             <407DF398.4010405@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com> <200404150219.27857.russell@coker.com.au> <200404141950.i3EJoFSM021953@turing-police.cc.vt.edu>
            <407DF398.4010405@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1470930448P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 15 Apr 2004 10:52:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1470930448P
Content-Type: text/plain; charset=us-ascii

On Wed, 14 Apr 2004 22:29:44 EDT, you said:

> >really silly shell script that does the moral equiv of:
> >
> >for i in unused/*.te; do rpm -qf $i && mv $i .; done
> >  
> >
> There is not a 1-1 relationship between rpm names and policy names.

Right.  That's why I said "the moral equivalent of".  Any other
equivalent means of trimming out .te files for software that isn't even
installed would work too.

I liked Russell's suggestion that we have a separate rpm that contains
the .te for the package - appropriate %postinstall scripting magic
would make all the policy rebuilding/reloading and file labelling happen
when you installed the package....

> I would prefer not to use unused at all, but some macro version to 
> indicate whether to include a te
> file or not.  Moving files around on the fly is not a great solution.

Wrapping all of them in m4 ifdef() blocks and a front end that sets
control variables would be OK too.  If m4 can deal with Sendmail's
.mc/.cf file wierdness, it can do this... :)


--==_Exmh_-1470930448P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAfqG8cC3lWbTT17ARAgLNAKDq2o8gzE0MFIEEaxYWtgvbvxNODACgjfhG
wqR+djT8BBdE8e/2QhSw57Y=
=VCuF
-----END PGP SIGNATURE-----

--==_Exmh_-1470930448P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
