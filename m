Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6MDkFsY009042
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2011 09:46:15 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6MDkEv3019477
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2011 13:46:14 GMT
Message-ID: <4E297F24.6090409@redhat.com>
Date: Fri, 22 Jul 2011 09:46:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: rarob@travelinglightfarm.net
CC: selinux@tycho.nsa.gov
Subject: Re: PythonSELinux binding problem
References: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
In-Reply-To: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/21/2011 05:33 PM, rarob@travelinglightfarm.net wrote:
> Hi, I'm using the python selinux bindings to determine if SELinux is 
> disable/permissive/enforcing.  The following snippet of code works
> just fine on RH5 and F10 regardless of the SELinux mode, but fails
> with an error on F11/12/13 and RH6 if SELinux is disabled.
> 
> $ python -c 'import selinux ; print selinux.security_getenforce()'
> 
> Under RH5 and F10 I correctly get the -1/0/1 returns for 
> disabled/permissive/enforcing, as specified in the man pages for 
> 'security_getenforce'.  Under F11/12/13 and RH6 for permissive and 
> enforcing I get the correct return values, but if the system is in 
> disabled mode instead an OSError is thrown for 'No such file or 
> directory'.  I haven't look at the source for the underlying 
> security_getenforce() system call, but I suspect is is assuming that
> the /selinux pseudo filesystem is populated (as in
> permissive/enforcing mode), and is not handling the case where that
> pseudo filesystem is empty.
> 
> For now I've got my python calls wrapped in try/except blocks
> treating any exception as SELinux in disabled mode.
> 
> I wasn't sure where the best place to log this as a bug is, either
> for the libselinux-python package or libselinux itself.
> 
> -Rob
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.

We have modified python to act correctly when it receives and error from
the underlying C Library and throw an exception with the STDERR reported.

I do not believe this is a bug.  And writing exception handling in
python is the correct behaviour, checking for -1 was the incorrect
behaviour from a python point of view.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAk4pfyMACgkQrlYvE4MpobP4+ACbBvgfbP/yQt7lBk8HEQvNAO+O
LcoAl0RWJYGD3IJKEYsMK2NZe72fPEY=
=HGQR
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
