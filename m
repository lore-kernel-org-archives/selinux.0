Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1Fdhm0026587
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 10:39:43 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1FbckD005214
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:37:39 GMT
Message-ID: <4934044E.5010404@redhat.com>
Date: Mon, 01 Dec 2008 10:35:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dave Feustel <dfeustel@mindspring.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy for Konqueror
References: <200811290240.mAT2evDd007952@mummy.ncsc.mil>
In-Reply-To: <200811290240.mAT2evDd007952@mummy.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Feustel wrote:
> A question from a newbie:
> Has anyone developed a selinux policy for konqueror?
> 
> Thanks.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
NO although the policy for firefox/mozilla would probably work.  Writing
a general purpose policy for a web browser that can do everything a web
browser is designed to do, is probably a waste of time, and will not
work the way you want.  If you have good Security Goals about the only
things you want the Browser to do, you might have a better shot.  But
the web browser being able to launch helper apps (ooffice, evince,
realplayer, mplayer, and hundreds of others make writing a good policy
near impossible.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkk0BE4ACgkQrlYvE4MpobMvLgCgjU2EbLyG0M3ZdbgYJVKpFQzh
r4AAoM8/wTN45VNJwztmVe8LjeVEo7Su
=2n6+
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
