Message-ID: <5204BD9A.5090108@redhat.com>
Date: Fri, 09 Aug 2013 05:59:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dan Pou <danielp@sgi.com>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Programmatic domain change to unprivileged role
References: <20130805190732.GT18909@localhost> <52015950.9010906@tycho.nsa.gov> <20130806203751.GA14875@localhost> <52023D7D.7040409@tycho.nsa.gov> <52024071.4000206@tycho.nsa.gov> <20130808195857.GB23152@localhost>
In-Reply-To: <20130808195857.GB23152@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/08/2013 03:58 PM, Dan Pou wrote:
> Thanks for the suggestion about strace, that is pointing to the problem. I
> need to check the policy rules I have been adding to see how I got here:
> 
> write(3, "user_u:sysadm_r:sysadm_t:s0\0", 28) = -1 EINVAL (Invalid 
> argument)
> 

Most likely user_u does not allowed sysadm_r

semanage user -l | grep user_u


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIEvZoACgkQrlYvE4MpobOx3wCg0XS4z3Gw5U0lcYRiN/bE6X9y
KWYAn2QbXMP580qcCmftJBBOdQzJhivh
=6NHy
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
