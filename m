Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RHis99005916
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 13:44:54 -0400
Message-ID: <4F71FC94.30704@redhat.com>
Date: Tue, 27 Mar 2012 13:44:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 55/73] policycoreutils: Disable user restorecond by default
References: <4F71DDF3.6010407@redhat.com> <1332862820.15547.17.camel@lenny>
In-Reply-To: <1332862820.15547.17.camel@lenny>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/27/2012 11:40 AM, Colin Walters wrote:
> Why even build/install it then?
> 
> Seems like this should be a configure option like: --disable-user-restorecond
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing list. If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes as the message.

Or I guess we could stop shipping the desktop file.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x/JQACgkQrlYvE4MpobPaVACgg3dVLZEU6AI5ve5jrYIFiRxh
UVIAmgJPAxLc2+/1RWMtZDlmOTwER0QM
=4SEO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
