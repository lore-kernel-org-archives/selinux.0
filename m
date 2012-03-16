Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GDcDZK017347
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 09:38:13 -0400
Message-ID: <4F634242.6060400@redhat.com>
Date: Fri, 16 Mar 2012 09:38:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mikhail Efremov <mikhefr@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] policycoreutils: newrole: Fix drop_capabilities().
References: <20120316165040.1509ef42@c203.office.altlinux.ru>
In-Reply-To: <20120316165040.1509ef42@c203.office.altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/16/2012 08:50 AM, Mikhail Efremov wrote:
> Hello!
> 
> The CAP_* constants should not be or'ed, it is the bit numbers. And
> grant the access to the audit system too.
> 
> P.S. May be someone can look at the commit messages, I'm not sure 
> about my English.
> 


I talked to the developer of libcap-ng  (Steve Grubb) and he stated
that you are correct but "you should use the 'v' version of update
which allows you to update in just 1 library call. The
capabilities should be separated with a comma and to mark the end you
put a -1:"

capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
CAP_SYS_ADMIN,
CAP_FOWNER, CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_SETPCAP, CAP_AUDIT_WRITE,
- -1);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9jQkIACgkQrlYvE4MpobPK7wCfbrheXgQ3P49ztISEAya3OzDM
cAEAoMNEw9qe2+csKVh4Vup5XauG8cXG
=DUox
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
