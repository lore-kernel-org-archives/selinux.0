Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4EK5b3h026662
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 16:05:37 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4EK5eW3016369
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 20:05:40 GMT
Date: Thu, 14 May 2009 16:05:35 -0400
Subject: Re: Patch to getdefaultcon to print just the correct match and add
 verbose option
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C631F1CF.A721D%csellers@tresys.com>
In-Reply-To: <49AEE781.5030301@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/4/09 3:41 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I really want to rename this to selinuxdefaultcon, which is what we ship
> in Fedora.
> 
> Also exit with proper error on failure.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkmu54AACgkQrlYvE4MpobNoZACdHgQDP2Hp/KDBpGCD7G08HjOX
> p68An25Uu83SlOqjKyy9EG8ZgdIcuTCB
> =L6UU
> -----END PGP SIGNATURE-----
> --- nsalibselinux/utils/getdefaultcon.c 2008-08-28 09:34:24.000000000 -0400
> +++ libselinux-2.0.78/utils/getdefaultcon.c 2009-03-04 15:23:52.000000000
> -0500
> @@ -22,8 +22,9 @@
> security_context_t usercon = NULL, cur_context = NULL;
> char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
> int ret, opt;
> + int verbose = 0;
>  
> - while ((opt = getopt(argc, argv, "l:r:")) > 0) {
> + while ((opt = getopt(argc, argv, "l:r:v")) > 0) {
> switch (opt) {
> case 'l':
> level = strdup(optarg);
> @@ -31,6 +32,9 @@
> case 'r':
> role = strdup(optarg);
> break;
> +  case 'v':
> +   verbose = 1;
> +   break;
> default:
> usage(argv[0], "invalid option", 1);
> }
> @@ -66,9 +70,13 @@
> }
> if (ret < 0)
> perror(argv[0]);
> - else
> -  printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context,
> seuser, role, level, usercon);
> -
> + else {
> +  if (verbose) {
> +   printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context,
> seuser, role, level, usercon);
> +  } else {
> +   printf("%s", usercon);
> +  }
> + }
>  
> free(role);
> free(seuser);
> @@ -76,5 +84,5 @@
> free(dlevel);
> free(usercon);
>  
> - return 0;
> + return ret >= 0;
>  }

Looks good to me.

Acked-by: Chad Sellers <csellers@tresys.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
