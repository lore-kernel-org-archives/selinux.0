Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBGJJPBF016976
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 14:19:25 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oBGJJOlc014678
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 19:19:24 GMT
Date: Thu, 16 Dec 2010 14:19:23 -0500
Subject: Re: I think it is time to turn off default user handling in
 libselinux
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <C92FD06B.BBB31%csellers@tresys.com>
In-Reply-To: <4D0665B1.2040005@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/10 1:28 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch will turn this handling off.  Meaning you will not end up
> with some bizarro context and fail to login if the login program can not
> figure how to log you in.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk0GZbEACgkQrlYvE4MpobOF7QCgsD1XYuNC6B5MyIezCZvN9mYL
> UX4AoOe9GsP3bhuvMBPea9LXeV/7tCPS
> =B9Pk
> -----END PGP SIGNATURE-----

I agree. In fact, I'd love to rework the entire process of computing a login
context at some point.

In the mean time, this patch looks good to me. Merged as of libselinux
2.0.98.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
