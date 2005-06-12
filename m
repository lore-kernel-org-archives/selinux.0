Message-Id: <200506122030.j5CKUIp5025196@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sun, 12 Jun 2005 21:25:39 BST."
             <20050612202539.GE31033@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu> <20050612152038.GC31033@lkcl.net> <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
            <20050612202539.GE31033@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118608217_24934P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 12 Jun 2005 16:30:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118608217_24934P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 21:25:39 BST, Luke Kenneth Casson Leighton said:

>  well, if you're going to follow the convention of passing around the
>  context [as a string] then you might as well continue with that
>  tradition...
> 
>  i dunno... say, by adding @hostname or @dns.domain.name
> 
>  e.g. foo_u:bar_r:baz_t@toplevelmlsgroup.mycompany.co.uk or
>  foo_u:bar_r:baz_t@myworkstation.mycompany.co.uk

Much as I hate to admit it, Microsoft got this one right, with their AD
tree structure - you don't want to drag a machine name around, you want to
drag around an 'ou=' type thing that describes the *logical* role of the
entity.  Remember, you probably care more that I'm connecting as "a sysadmin
in this department" than the actual host I'm connecting from (assuming of course
that all hosts I'm connecting from are part of the cluster)....

--==_Exmh_1118608217_24934P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrJtZcC3lWbTT17ARAmCxAJ9plQJrBKpZK7XIoYC+CjoN4AmBdACgluhC
oSjWGukLVKiNYnHjx7onMkw=
=Q0Mx
-----END PGP SIGNATURE-----

--==_Exmh_1118608217_24934P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
