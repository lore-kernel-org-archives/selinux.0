Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3GLda1w006175
	for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2009 17:39:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n3GLdVFT014884
	for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2009 21:39:35 GMT
Date: Thu, 16 Apr 2009 17:39:31 -0400
Subject: Re: Patch matchpathcon to eliminate file "/" 
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C60D1DD3.A6857%csellers@tresys.com>
In-Reply-To: <49AEE703.306@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/4/09 3:39 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> So
> 
> matchpathcon /etc/
> Will work the same as
> matchpathcon /etc
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkmu5wMACgkQrlYvE4MpobNK4gCgiVeXXEZcCMsJKXM7jqh6r1u3
> OScAoLcmXBIR63gpvA8RS3g07pcPC6IF
> =e+Re
> -----END PGP SIGNATURE-----
> --- nsalibselinux/utils/matchpathcon.c 2008-10-28 10:06:51.000000000 -0400
> +++ libselinux-2.0.78/utils/matchpathcon.c 2009-03-04 15:23:52.000000000 -0500
> @@ -101,6 +101,11 @@
> for (i = optind; i < argc; i++) {
> int mode = 0;
> struct stat buf;
> +  int len = strlen(argv[i]);
> +  if (len > 1  && argv[i][len - 1 ] == '/') {
> +   argv[i][len - 1 ] = '\0';
> +  }
> +
> if (lstat(argv[i], &buf) == 0)
> mode = buf.st_mode;
>  

Looks fine to me.

Acked-by: Chad Sellers <csellers@tresys.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
