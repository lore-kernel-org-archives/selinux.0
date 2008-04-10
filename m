Message-ID: <47FE3A52.2080702@redhat.com>
Date: Thu, 10 Apr 2008 12:03:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Enabling policy capabilities
References: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> Where do we stand on actually enabling policy capabilities in policy so
> that people can start using newer features that depend on them?
> 
> I've definitely seen patches adding permissions for the peer checks, so
> is there anything preventing us from trying to enable
> network_peer_controls in policy and seeing what breaks (after Fedora 9
> at this point, I suppose - unfortunate that we didn't enable it sooner)?
> 
> I haven't seen patches adding permissions for open other than just to
> define them, IIRC.  So enabling open_perms would be rather bad right now
> except for unconfined domains.  As a possible strategy for gradual
> roll-out of open perm, we could add open everywhere there is a read or
> write granted, enable the open_perms capability, verify no breakage, and
> then gradually remove open permission where we know it to be unneeded.
> 
Open checks will be added in Fedora 10, along with turning on Xace.  We
are frozen in Fedora 9.  No new functionality.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkf+OlIACgkQrlYvE4MpobM+4gCcCHxrHzMnej50qajUUFTqMU3j
BMcAn3JWNm2zr6nl6QiyqZbWwfLSjQx1
=bMXX
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
