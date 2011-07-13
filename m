Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6DHjGRe000572
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 13:45:29 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6DHjFj9006912
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2011 17:45:15 GMT
Message-ID: <4E1DD9A7.80007@redhat.com>
Date: Wed, 13 Jul 2011 13:45:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Matthew Ife <deleriux@airattack-central.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
References: <4E1CB8A5.2010707@redhat.com> <1310577633.19434.6.camel@home.localdomain>
In-Reply-To: <1310577633.19434.6.camel@home.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/13/2011 01:20 PM, Matthew Ife wrote:
> I dont think that will work. According to my strace systemd performs
> the work completely on behalf of the user when calling systemctl.
> 
> It might be more elegant to solve the problem in software.. ideally
> with some selinux object manager for systemd that systemctl can be 
> intercepted with.
> 
> Say classes of target and service and permissions like start, stop 
> reload, restart etc.
> 
> That could take a while to implement though.
> 
Right, I was thinking of something simpler, Have systemd become an
object manager but only have it check the services file.  That way we
just put a label on the services file and have systemd check if the user
context is allowed to "PROCESS" "EXECUTE" or some other access method on
the services file.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4d2acACgkQrlYvE4MpobP1vwCeOKZ7Z15EU43/I7UN9i86Udcz
Qi0AoM71WDDl6Y1N3ZDNbdf/mRcKIWfT
=fDed
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
