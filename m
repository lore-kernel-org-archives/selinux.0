Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8MIvcwh004258
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 14:57:39 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8MIuh5U013553
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 18:56:43 GMT
Message-ID: <48D7EAA6.1000107@redhat.com>
Date: Mon, 22 Sep 2008 14:57:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest flask definitions for libselinux.
References: <48D7EA05.8060608@manicmethod.com>
In-Reply-To: <48D7EA05.8060608@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> 
> 
> diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/flask.h libselinux-2.0.71/include/selinux/flask.h
> --- nsalibselinux/include/selinux/flask.h	2008-08-28 09:34:24.000000000 -0400
> +++ libselinux-2.0.71/include/selinux/flask.h	2008-09-22 13:28:05.000000000 -0400
> @@ -35,18 +35,18 @@
>  #define SECCLASS_SHM                                     28
>  #define SECCLASS_IPC                                     29
>  #define SECCLASS_PASSWD                                  30
> -#define SECCLASS_DRAWABLE                                31
> -#define SECCLASS_WINDOW                                  32
> -#define SECCLASS_GC                                      33
> -#define SECCLASS_FONT                                    34
> -#define SECCLASS_COLORMAP                                35
> -#define SECCLASS_PROPERTY                                36
> -#define SECCLASS_CURSOR                                  37
> -#define SECCLASS_XCLIENT                                 38
> -#define SECCLASS_XINPUT                                  39
> -#define SECCLASS_XSERVER                                 40
> -#define SECCLASS_XEXTENSION                              41
> -#define SECCLASS_PAX                                     42
> +#define SECCLASS_X_DRAWABLE                              31
> +#define SECCLASS_X_SCREEN                                32
> +#define SECCLASS_X_GC                                    33
> +#define SECCLASS_X_FONT                                  34
> +#define SECCLASS_X_COLORMAP                              35
> +#define SECCLASS_X_PROPERTY                              36
> +#define SECCLASS_X_SELECTION                             37
> +#define SECCLASS_X_CURSOR                                38
> +#define SECCLASS_X_CLIENT                                39
> +#define SECCLASS_X_DEVICE                                40
> +#define SECCLASS_X_SERVER                                41
> +#define SECCLASS_X_EXTENSION                             42
>  #define SECCLASS_NETLINK_ROUTE_SOCKET                    43
>  #define SECCLASS_NETLINK_FIREWALL_SOCKET                 44
>  #define SECCLASS_NETLINK_TCPDIAG_SOCKET                  45
> 
> 
> These are renumbered, why are you doing that?
I did nothing other then take the policy in REFpolicy and run the make
file on it.

My only change was to add netlink
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjX6qYACgkQrlYvE4MpobNLAACcCt7No3PTMRAFxzE8PGiiaZgJ
Mn4AoNZ/mX1uTrC2aEXOLwdXPBC7o2Sp
=TVE7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
