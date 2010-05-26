Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4QJRP6u005147
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 15:27:25 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4QJSio0022363
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 19:28:45 GMT
Message-ID: <4BFD7619.1070805@redhat.com>
Date: Wed, 26 May 2010 15:27:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: install giving the wrong label
References: <C821BB21.B8234%csellers@tresys.com>
In-Reply-To: <C821BB21.B8234%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/25/2010 05:36 PM, Chad Sellers wrote:
> I just found a problem with /usr/bin/install. It appears that it will label
> things improperly if they have an extra / in the target name. For instance:
> 
> # install foo /usr
> # ls -lZ /usr/foo
> -rwxr-xr-x. root root system_u:object_r:usr_t:s0       /usr/foo
> 
> but
> 
> # install foo //usr
> # ls -lZ /usr/foo
> -rwxr-xr-x. root root system_u:object_r:default_t:s0       /usr/foo
> 
> The same thing goes for targets like /var/www//foo, where the // is later in
> the filename.
> 
> This appears to result from install calling matchpathcon() with the target
> passed in directly. My question is, whose responsibility should this be?
> Should matchpatchcon() scrub filenames passed into it, or should callers be
> required to pass proper filenames to matchpathcon()?
> 
> Thanks,
> Chad Sellers
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
I would expect matchpathcon to do the right thing.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkv9dhkACgkQrlYvE4MpobPv1wCgopndh1097BAaL+dSEAGj/z9g
w/8Anjmg2kDSvk4YnfEnw154O25wt1ap
=klZG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
