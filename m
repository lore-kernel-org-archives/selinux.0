Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CDxQod023888
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 09:59:26 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8CDxQ77029143
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 13:59:26 GMT
Message-ID: <48CA75B1.1020605@manicmethod.com>
Date: Fri, 12 Sep 2008 09:59:13 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add glob support for restorecond
References: <48C57717.7080903@redhat.com>
In-Reply-To: <48C57717.7080903@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have added supported for GLOB expressions in restorecond.  In order to
> get nsplugin to work well, you need all of the contents of the homedir
> labeled correctly.  Unfortunately gnome creates directories at a fairly
> random pace.  FCFS.  So it is very difficult to get transitions to
> happen properly.  As a tradeoff, we can use restorecond to watch the
> homedir and relabel the directory when it is created.  I know this is a
> potential race condition. where some of the files created in the
> directory will still have the wrong context, but I don't know of a
> better solution.
> 
> Telling everyone they need to restorcon -R -v ~ is not a great solution.
>  If you are worried about information flow you should never rely on
> restorecond.
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkjFdxcACgkQrlYvE4MpobPtjACg3uyqaHD78FRxdaG5mfitnoB/
> lh0AnjvfDC2vmCWisxzWq2qFsZMMu3XK
> =JiG7
> -----END PGP SIGNATURE-----
> 

Merged in policycoreutils 2.0.56

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
