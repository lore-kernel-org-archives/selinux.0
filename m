Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3MDhYgY023945
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2008 09:43:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3MDhXgG006003
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2008 13:43:33 GMT
Message-ID: <480DEB70.1060707@redhat.com>
Date: Tue, 22 Apr 2008 09:43:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Herv=E9_WERNER?= <herve.werner@ensi-bourges.fr>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SELinux with NFSv4
References: <45448.82.246.196.177.1208811177.squirrel@webmail.ensi-bourges.fr>
In-Reply-To: <45448.82.246.196.177.1208811177.squirrel@webmail.ensi-bourges.fr>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hervé WERNER wrote:
>> NFS extended attribute discussion is happing on the SELinux NSA Mail
>> list <selinux@tycho.nsa.gov>
>>
>> You can add a label to the NFS mount and make this not accessable by
>> normal users which would get you what you want.
> I meant putting different labels on files resulting from the same mount.
> Currently I can only put an only label on all files coming from the same
> mount. I would like to be able to label differently files from a same
> mount. It is a kind of public share with permissions that I would like to
> do...
> 
Sorry you can not do that currently.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgN63AACgkQrlYvE4MpobNS0gCeKaCM90qYaqlfDedFCm62nt0U
4TMAoJUFle8W2/j+KnBHB/dPrSDrVx1z
=aVrU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
