Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1A4p8Rb007642
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 23:51:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1A4p6Oi023036
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 04:51:07 GMT
Received: from smtp016.mail.yahoo.com (smtp016.mail.yahoo.com [216.136.174.113])
        by jazzband.ncsc.mil  with SMTP id i1A4p5WW023027 for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 04:51:06 GMT
Date: Mon, 9 Feb 2004 22:50:57 -0600
Subject: Re: Issues relabeling filesystems
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
In-Reply-To: <1076338326.3523.5.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <B70EC6D6-5B84-11D8-B6A3-000393013D1A@unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday, February 9, 2004, at 08:52 AM, Stephen Smalley wrote:
>
> You either need to uncomment the POLICYCOMPAT definition in the policy
> Makefile, or update to a kernel that includes the conditional policy
> extension patch from Tresys.

Thanks a lot, that did the trick.

A quick one:
- - I've been looking at the list archives about the issues loading the 
policy from initrd when using UML. Is there a good reason for loading 
it from initrd instead of, for example, inserting the code from the 
script you provided (se-init) into the rc.local script? I'm having 
trouble loading the initrd that I created with the patched script, but 
I'm not sure if it's worth the trouble:

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 151k freed
VFS: Mounted root (ext2 filesystem) readonly.
Kernel panic: No init found.  Try passing init= option to kernel.

Always appreciate your hints,

Ignacio
CoPS Lab
University of North Texas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAKGM3wGqh0xtlFYsRAmH3AKCODSURA3s3lTfGrnDwk9Zm27LOLQCfcYX/
ZUNpqxc7eYUuVv3Fnpsgma0=
=EqnX
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
