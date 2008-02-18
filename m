Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1IEIXNg032606
	for <selinux@tycho.nsa.gov>; Mon, 18 Feb 2008 09:18:33 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1IEIU5B009852
	for <selinux@tycho.nsa.gov>; Mon, 18 Feb 2008 14:18:30 GMT
Message-ID: <47B993B0.6010207@redhat.com>
Date: Mon, 18 Feb 2008 09:18:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Hal <hal_bg@yahoo.com>
CC: selinux@tycho.nsa.gov
Subject: Re: xguest LDAP authentication
References: <504340.31062.qm@web32205.mail.mud.yahoo.com>
In-Reply-To: <504340.31062.qm@web32205.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hal wrote:
> Hi all,
> I have a selinux question concerning xguest and ldap user authentication. 
> I want to achieve two goals:
> 
> 1. All the users are authenticated by LDAP (I have several machines that share
> the same users and same user home dirs on the common storage.) and I want to
> convert most of the users to Selinux xguest users.
> 
> 2. I want all the new users created in the LDAP to be assumed as xguest users
> on all machines by default. 
> 
> How can this be done?
> I am running Fedora 8. 
> 
> Regrards
> Hal
> 
> 
>       ____________________________________________________________________________________
> Looking for last minute shopping deals?  
> Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Right now we do not have a distributed way of handling this.


semanage login -m -s xguest_u __default__

Will change the default users on a machine to xguest.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke5k7AACgkQrlYvE4MpobNdTgCgtmUiFumgSzDTJ69XE0li+Co8
QncAnjK3eIfVKJaS02NYNmPSy7A13Imv
=HTou
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
