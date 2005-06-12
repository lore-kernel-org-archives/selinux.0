Message-Id: <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sun, 12 Jun 2005 12:44:21 BST."
             <20050612114421.GA31033@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com>
            <20050612114421.GA31033@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118579985_5642P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 12 Jun 2005 08:39:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118579985_5642P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 12:44:21 BST, Luke Kenneth Casson Leighton said:

>  btw i should also raise - again - the wisdom of only utilising
>  a 32-bit security descriptor in a networked environment.

Should be sufficient in an IPv4 environment, since it's only identifying
the other end.  I'm not awake enough yet - does IPsec on the IPv6 side only
carry 32-bit identifiers too? I'd consider *that* a design whoops...

>  only 32-bit means that if you want to merge or join two secure
>  environments together, well.... you basically can't: you have a clash
>  of 32-bit SIDs.

Oh - the old "merge 2 1918 spaces" problem.. ;)  I suppose suggesting
creative use of a NAT and RFC3489 would get blunt objects heaved in my direction. ;)

>  with NT / VAX-VMS style security descriptors (comprising 4of 32-bit
>  "SIDs" for a domain and a 32-bit "RID" - relative ID) you can at least
>  start creating inter-domain trust relationships.

Once you've established a secure connection to an identified host, there's
nothing stopping you from passing more info down the pipe if the IP 4-tuple
isn't sufficient to provide all the info needed..

>  now's the opportunity to ensure that MLS will be future-proof.
> 
>  are there any other alternate solutions to merging two MLS secure
>  environments together?

I think a useful rephrasing is:

What information needs to be passed when opening an inter-domain trusted
connection, that isn't already available in the IPSec headers?


--==_Exmh_1118579985_5642P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrC0RcC3lWbTT17ARAh+NAKD9Qv3dFCfU4hIgK58rHLtMUlnEmQCdHj8m
Hqkdbv4ks51iydB5rCb7tCM=
=az63
-----END PGP SIGNATURE-----

--==_Exmh_1118579985_5642P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
