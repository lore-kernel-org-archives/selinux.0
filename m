Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1K7h7kw022086
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 02:43:07 -0500
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n1K7h5Ud000902
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 07:43:05 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: ext3 security labels missing
Date: Fri, 20 Feb 2009 15:42:47 +0800
Cc: "SE-Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
In-Reply-To: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2136271.2WTH8uFbop";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200902201542.50638.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2136271.2WTH8uFbop
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Might it be possible that you didn't enable support for security labels whe=
n=20
compiling the kernel?
Check Filesystems -> Ext3 Security Labels

Also, when installing LFS with SELinux, did you compile GLibC twice?
I first compile it without SELinux, afterwards the SELinux-libraries, so th=
at=20
those can link against GLibC, and then again GLibC, with SELinux-support th=
at=20
time.
Don't know though if that would be any issue, having a GLibC that isn't awa=
re=20
of SELinux.
But I, for myself found that probably the safest way seems to add an extra=
=20
compile of GLibC to the install after installing the SELinux-libs.

On Friday 20 February 2009 15:04:54 Justin Mattock wrote:
> I've a strange issue.
> with my experimental learning machine(LFS)
> I'm able to load the policy etc.. but have no labels
> on my files.(just a question mark);
>
>
> ls -lZ shows
>
> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
> /boot/vmlinuz-2.6.29-rc4
>
> if I do a id -Z I get:
> id: --context (-Z) works only on an SELinux-enabled kernel
> (but it is enabled in the kernel)
>
> >From looking back, I enabled as much as possible in any app/lib I was
> > compiling
>
> that provided selinux support.(libc,xserver,hal,dbus, etc..);
> But could be missing an important app/lib that might make the security
> labels give the proper label. by chance if anybody had experienced this
> and/or knows what might be going on,(would be really appreciated).
>
> regards;



--nextPart2136271.2WTH8uFbop
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmeXvoACgkQ1sXw8/2VziSG9gCeL2IWuJ174qaCf5uXoT1e78/9
g1gAnRZZQNaQDPnMJvhRm37564WLwFYN
=bP2B
-----END PGP SIGNATURE-----

--nextPart2136271.2WTH8uFbop--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
