Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p81Dj9ju030610
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 09:45:09 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p81Dj8xY021152
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 13:45:08 GMT
Message-ID: <4E5F8C4D.7000200@redhat.com>
Date: Thu, 01 Sep 2011 09:44:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: no new-line in setfiles/restorecon patch
References: <201109011411.32863.russell@coker.com.au>
In-Reply-To: <201109011411.32863.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/01/2011 12:11 AM, Russell Coker wrote:
> New-lines just look ugly when the screen width isn't 80 columns.
> Knowing exactly how much progress we have made in increments of
> 80,000 isn't that useful IMHO.
> 
> As an aside, I've been considering patching it to display "12345"
> instead of "*****" as the progress.  If you think this is a good
> idea then let me know and I'll submit a patch to do it.
> 
This looks good to me.

Ack.

Not sure the 123 would be useful.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5fjE0ACgkQrlYvE4MpobOL4ACg3MA6J4ZJxj0jmAdPnRueed+5
+2gAoMK+qq31kl8ZKKGXyswAk6FqJERO
=AfE3
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
