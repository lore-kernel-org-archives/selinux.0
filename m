Message-Id: <200607311510.k6VFAhrw006155@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 0/2] new and improved range_transition statements
In-Reply-To: Your message of "Mon, 31 Jul 2006 10:43:15 EDT."
             <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <44CA2919.4010708@trustedcs.com> <1154351236.26550.14.camel@localhost.localdomain> <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil> <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
            <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154358643_3409P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 31 Jul 2006 11:10:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1154358643_3409P
Content-Type: text/plain; charset=us-ascii

On Mon, 31 Jul 2006 10:43:15 EDT, Stephen Smalley said:

> I agree that it is too late for 2.6.18, but just to clarify - the kernel
> patch preserves backward compatibility for older binary policy
> formats.  
> 
> As far as compatibility is concerned, FC4 will need some kind of
> userland update when it updates to a kernel with the new policy format;
> otherwise, init will give up when it cannot find policy.21 or policy.20
> (older sysvinit selinux patch only tried n and (n-1)), and the policy in
> FC4 was version 19.

Given that Andrew Morton is currently having a cow over the fact that
2.6.18-rc3 includes a change that breaks the udev that shipped with FC3,
we might want to make sure we have all our ducks lined up....

(To be fair, the udev change is one that breaks any udev more than 10 months
or so old...)

--==_Exmh_1154358643_3409P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzh1zcC3lWbTT17ARAvD3AJ0c/t2HbNF/TI2uEgYoGCAK3RH4kACeMeTM
bX0oMFy5aA6AB/vp1BVVsxY=
=XzIv
-----END PGP SIGNATURE-----

--==_Exmh_1154358643_3409P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
