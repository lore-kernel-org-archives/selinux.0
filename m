Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1KFKPJj015711
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 10:20:25 -0500
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n1KFH0vr007356
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 15:17:00 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: ext3 security labels missing
Date: Fri, 20 Feb 2009 23:20:12 +0800
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com> <1235139267.6285.14.camel@localhost.localdomain> <dd18b0c30902200703j9173fddne33cf6c09b8d08e6@mail.gmail.com>
In-Reply-To: <dd18b0c30902200703j9173fddne33cf6c09b8d08e6@mail.gmail.com>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15251765.BaW3b4ldXh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200902202320.16356.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart15251765.BaW3b4ldXh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Are the coreutils compiled with SELinux-support?
I just gave it a quick check and found that the -Z option is available in b=
oth=20
id and ls without coreutils having actually been built without SELinux-
libraries actually available.

Could you check this:
ldd $(which ls)

This should show up a reference to libselinux.so.1
If this reference is missing then I'd suggest recompiling the coreutils.

On Friday 20 February 2009 23:03:37 you wrote:
> On Fri, Feb 20, 2009 at 6:14 AM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
> > On Thu, 2009-02-19 at 23:04 -0800, Justin Mattock wrote:
> >> I've a strange issue.
> >> with my experimental learning machine(LFS)
> >> I'm able to load the policy etc.. but have no labels
> >> on my files.(just a question mark);
> >>
> >>
> >> ls -lZ shows
> >>
> >> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
> >> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
> >> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
> >> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
> >> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
> >> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
> >> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
> >> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
> >> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
> >> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
> >> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
> >> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
> >> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
> >> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
> >> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
> >> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
> >> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
> >> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
> >> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
> >> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
> >> /boot/vmlinuz-2.6.29-rc4
> >>
> >> if I do a id -Z I get:
> >> id: --context (-Z) works only on an SELinux-enabled kernel
> >> (but it is enabled in the kernel)
> >
> > sestatus shows what?
> >
> > To be fully "enabled" as far as userspace is concerned, SELinux has to
> > be:
> > - enabled in your kernel build,
> > - enabled at boot,
> > - policy has to be loaded
> >
> > grep SELINUX .config
> > cat /etc/selinux/config
> > dmesg | grep SELinux
> >
> >> >From looking back, I enabled as much as possible in any app/lib I was
> >> > compiling
> >>
> >> that provided selinux support.(libc,xserver,hal,dbus, etc..);
> >> But could be missing an important app/lib that might make the security
> >> labels give the proper label. by chance if anybody had experienced this
> >> and/or knows what might be going on,(would be really appreciated).
> >>
> >> regards;
> >
> > --
> > Stephen Smalley
> > National Security Agency
>
> Thanks for the reply.
> here's what /usr/sbin/sestatus -vv (says);
>
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 22
> Policy from config file:        refpolicy
>
> Process contexts:
> Current context:                system_u:system_r:local_login_t
> Init context:                   system_u:system_r:init_t
>
> File contexts:
> Controlling term:               system_u:object_r:devpts_t
> /etc/passwd                     system_u:object_r:etc_t
> /bin/bash                       system_u:object_r:shell_exec_t
> /bin/login                      system_u:object_r:login_exec_t
> /bin/sh                         system_u:object_r:bin_t ->
> system_u:object_r:shell_exec_t
> /sbin/agetty                    system_u:object_r:getty_exec_t
> /sbin/init                      system_u:object_r:init_exec_t
> /lib/libc.so.6                  system_u:object_r:lib_t ->
> system_u:object_r:lib_t
> /lib/ld-linux.so.2              system_u:object_r:lib_t ->
> system_u:object_r:ld_so_t
>
> I think this is some aterm,xproto,etc.. library/app(that I forgot to
> install) that's responsible for displaying the security label info in the
> shell.(example) when I use
> audit2allow -d, I generate the correct security allow rules.
> when running make relabel in the policy source directory, reacts as it
> should.
>
> As for setting any options in the kernel. no
> left everything as I've had in the past.
> as for enabling everything. yes
> - enabled in your kernel build,
> - enabled at boot,
> - policy has to be loaded
>
> I'll try adding these rules into the policy irregardless of a
> broken proto/low level communications thing.
> didn't mean to causing any heat.
>
> regards;



--nextPart15251765.BaW3b4ldXh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmeyjAACgkQ1sXw8/2VziQIZQCgixxmKXYdfAaiDOcTTU/ttdsP
D/QAoLTox+nNU3JisbEh90sv060hvj7j
=7Iyp
-----END PGP SIGNATURE-----

--nextPart15251765.BaW3b4ldXh--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
