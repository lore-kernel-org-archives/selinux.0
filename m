Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4FFaXZr010620
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 11:36:33 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4FFaWF0002239
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 15:36:33 GMT
Received: by ewy8 with SMTP id 8so1209453ewy.12
        for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 08:36:31 -0700 (PDT)
Message-ID: <4DCFF2FD.6060704@gmail.com>
Date: Sun, 15 May 2011 17:36:29 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: FUSE and SELinux labeling
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
In-Reply-To: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/15/2011 04:40 PM, Sam Gandhi wrote:
> Hi
> 
> 
> Is there a FAQ or some description on what one needs to do to enable
> labeling on files created under a fuse filesystem?

fusefs does not support extended attributes, and so you cannot label
files on it.

You can however, probably, mount fusefs filesystems with a security context.

See man mount for information as to how to mount partitions with a
security context (context="security context here")
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3P8v0ACgkQMlxVo39jgT9zKwCfRnRgYRbrzZI4q7oNArJ+r4or
PGcAnAp6dioOPfETqpKIEN25i9I/o/nP
=7LRv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
