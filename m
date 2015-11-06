Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6IB9E4027819
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 13:11:09 -0500
Received: by wmll128 with SMTP id l128so47671173wml.0
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 10:11:05 -0800 (PST)
Date: Fri, 6 Nov 2015 19:11:03 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: Paul Moore <pmoore@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: New SELinux userspace release supporting extended ioctl
 permissions?
Message-ID: <20151106181102.GB10239@x250>
References: <1852496.Nbh2u1K4Uk@sifl> <20151106162635.GA10239@x250>
 <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Nov 06, 2015 at 09:51:08AM -0800, Jeffrey Vander Stoep wrote:
> > Applying ioctl whitelisting on GNU/Linux systems looks to me pretty hard
> > to do though. Many drivers, and their ioctls to support.
> 
> Agreed.
> 
> On Android we use ioctl whitelisting only in a targeted manner. I
> think the same approach could (should) be applied to GNU/Linux.
> 
> The example that went out in the M release focused on restricting the
> leakage of privacy sensitive information from socket ioctls. Apps are
> blocked from using socket ioctls to access the wifi MAC address, wifi
> SSID and layer 2 encryption protocol. I could see a similar policy
> applied to the GNU/Linux browser. Ioctl policies on GPU access also
> seem practical albeit device specific.

Thanks. that prompted me to see what happened to the seandroid
repository on bitbucket because it has been stale for a while now.

found
https://android.googlesource.com/platform/external/sepolicy/+/master/ioctl_macros

That should be easy to implement on GNU/Linux indeed. Will try that soon

> 
> Constructing a comprehensive list of ioctls and the
> source/target/class sets that require access does not strike me as
> practical. In many cases these ioctls are already properly restricted
> via the ioctl permission.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWPO0yAAoJENAR6kfG5xmcmoEL/0ldXc6lSpW/ztGGDPmgEZkc
MqUi5l8bze1oyPiFVYlcXNe7ht9wHc8B6kZXH6k0XHOCpXO7hHO0PGp1hlb2JkHI
qdEGGjPEPob0N7meDA8MV9WRXO2eTkBhJ0CU8mEtx9FjGplDqvWKpDi28SG+9h3S
1WhEKbsSoqJ8jcd//X9IxVcFsQHLmu+HfNxyGYI33VdBxyqJWrVEq2OYyXdOYmM5
MjCHb/oDLuzKhuKrejCl+ecHcAA6iCf2PYfS6PQAbfi7Fooa9r3gocrVmMzvjXR8
TfNJeIceK+PclF7830ByPeInJ0FE1DxrZGGKMAnbYLAT4tFl5E9BzKEADJicLEqH
2pRxAsYf1qMs5Zfxul/LQWhu3E9HBRRpnijVCmcnJ5PjCPVWUd5olcS2rKMtkBsf
OC16SQO1Zsgv//xzumvGGTeyJEVR94Uoukh5uQnCjdJz9UZApIW/0wm/sbgnAEqz
tclJiiE1oZqT1khg8uhRh/AAl91nptYqCmlYBplp0w==
=+KkK
-----END PGP SIGNATURE-----
