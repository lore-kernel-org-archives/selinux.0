Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n05JqeG2006450
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 14:52:40 -0500
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n05JqZjj005992
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 19:52:39 GMT
Message-ID: <496264FE.3000802@manicmethod.com>
Date: Mon, 05 Jan 2009 14:52:30 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: semodule patch to use new semanage interfaces
References: <49145394.3050806@redhat.com>
In-Reply-To: <49145394.3050806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Allows semodule to read bzip compressed policy packages directly.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkkUU5QACgkQrlYvE4MpobMHGQCdGwEl3h1ZwV92u1mfgrr3z7XT
> NGYAoIwz76N7QFdEr8I0t3ncGhbo6heq
> =raBi
> -----END PGP SIGNATURE-----
>   

I'm finally looking at these (sorry it took so long)..

I thought one part of it was suppose to make hard links to files if you 
install but after merging this patch and the compression support I try 
semodule -i /usr/share/selinux/targeted/somepolicy.pp.bz2 (I'm on F10 
and they are already bzip'd) and instead of making a hard link to the 
bz2 it looks like it writes the uncompressed file to 
/etc/selinux/targeted/modules/active/modules. Am I misunderstanding the 
intention of these patches?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
