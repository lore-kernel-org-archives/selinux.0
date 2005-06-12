Message-Id: <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sun, 12 Jun 2005 16:20:38 BST."
             <20050612152038.GC31033@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
            <20050612152038.GC31033@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118603922_5642P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 12 Jun 2005 15:18:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118603922_5642P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 16:20:38 BST, Luke Kenneth Casson Leighton said:

>  the underlying SIDs of selinux are 32-bit.

Whoops. I forgot about that. ;)

>  [i do not know about IPsec or IPv6.]

The 'spi' field in the ip_auth_hdr and ip_esp_hdr is a u32, which is what
I was thinking of...

>  ... when you only have 32-bit SIDs, as you do in selinux,
>  how do you merge two departments or two corporations together,
>  _after_ their MLS security has been independently developed?

We just rely on the magic of sidtab_context_to_sid() -  it's basically
handed something that looks like a 'foo_u:bar_r:baz_t' and cranks out a
new SID, which is only used in the kernel.  As long as the merger of the
two systems doesn't require more total SID's than a u32 can represent,
there's no problem.

You however *do* need to adress collisions between two different foo_u ;)

>  ah - but how do you say "a local [to me] user when they log
>  in to the remote domain must be allowed to run program X"
>  when the number for the selinux SID on that remote domain
>  utilises the same SID number - for a different purpose?

The SIDs are locally generated on the fly. It's the *CONTEXT* that might
be in use elsewhere.  You'd basically want to make sure that on-the-wire you
always pass around a context label rather than a SID.

You'll want *some* way of managing the allocation of contexts cluster-wide,
just so you don't have two usages of jdoe_u that refer to two different users..

>  are you intending to add in a prefix of some kind, just like
>  there is in NT / VAX-VMS security?

Might be worth looking into..

> > What information needs to be passed when opening an inter-domain trusted
> > connection, that isn't already available in the IPSec headers?
> 
>  could you possibly help out here by clarifying that we are talking
>  about the same thing?

You already clarified that we weren't.. ;)

--==_Exmh_1118603922_5642P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrIqScC3lWbTT17ARAjJyAJ0SxPgwHTA3qzjf44G1xMK6bk5tgwCeNH5W
tQ5eS44AgMxx4SlfmELprVo=
=YJR1
-----END PGP SIGNATURE-----

--==_Exmh_1118603922_5642P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
