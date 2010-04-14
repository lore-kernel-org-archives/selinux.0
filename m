Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EGnkjY027176
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 12:49:46 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EGocQk016219
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 16:50:38 GMT
Message-ID: <4BC5F226.5090006@redhat.com>
Date: Wed, 14 Apr 2010 12:49:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jimi@sngx.net
CC: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net> <4BC5D183.20403@redhat.com> <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
In-Reply-To: <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/13/2010 09:53 AM, James Cammarata wrote:
> 
> On Wed, 14 Apr 2010 10:30:27 -0400, Daniel J Walsh <dwalsh@redhat.com>
>> We are very careful of what we backport and sudo has not come up on the
>> priority list.  With Shipping versions of RHEL we are hesitant to make
>> major modifications that could cause a regression.
> 
> Understood, I'm just surprised that running SElinux in strict mode breaks
> sudo isn't more of a priority.  Are that few people using strict mode?
> 
Well it depends on your definition of broken.  The way SELinux was
originally designed was to use newrole to change your role and sudo to
change your UID.  Only in RHEL6 is sudo able to do both.  Strict policy
is not used that much.  Although MLS policy is based on Strict policy,
but those people are a lot more used to the concept.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvF8iYACgkQrlYvE4MpobP1QACfdcivA4idxYIBcOFyyo/4pwZt
AwoAn36fyQa6gZTKxymSvQM2Xhnv1fgN
=tFRi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
