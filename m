From: Steven Harp <steven.harp@adventiumlabs.org>
To: SELinux@tycho.nsa.gov
Subject: Re: Port Binding Being Allowed
Date: Tue, 17 Aug 2004 15:23:04 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200408171523.21707.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Suggest making sure the CONFIG_SECURITY_NETWORK security option 
in the kernel build has been enabled.  Curiously, this is off
by default in this config....

CONFIG_SECURITY_NETWORK=y  


On Tuesday 17 August 2004 10:51 am, Eric Andreychek wrote:
> Howdy,
> 
> I'm setting up an SELinux box using Hardened Gentoo, the 2.6.7-r7 kernel, with
> SMP enabled.  The goal is to set up a multi-user box with some reasonable
> security measures in place.
> 
> I'm hoping to restrict who can bind to a local port (ie, disallow someone from
> running a daemon).  It's my impression that this is the default, but it
> unfortunatly doesn't seem to be working for me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBImktPcFX9H2zuSkRAlW3AKC2Hee12tL6ADNy3SjeH7U6oiGJtwCeNABu
YUFtP9EDjGcBj9myUC1KuE4=
=2ToS
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
