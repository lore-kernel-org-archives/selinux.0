Message-ID: <4958EDA7.5000206@redhat.com>
Date: Mon, 29 Dec 2008 10:32:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: xing li <lixing.1006@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Where can i find the source code of Userspace Packages with modifications
 for SELinux?
References: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com>
In-Reply-To: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

xing li wrote:
> Hello every one,
> 
> I known that linux distributions have modify some userspace packages in
> order to support selinux,such as:
> 
>    - SysVinit - load initial policy
>    - pam - set security context for user sessions, preserve security context
>    on /etc/shadow, check SELinux permissions
>    - util-linux - preserve security contexts on /etc/shadow, check SELinux
>    permissions
>    - openssh - set security context for user sessions
>    - vixie-cron - set security context for cron jobs, check permission
>    - at - similar to vixie-cron
>    - sudo - set security context
>    - shadow-utils - preserve security context on /etc/shadow
>    - libuser - preserve security context on /etc/shadow, check permission
>    - passwd - preserve security context on /etc/shadow, check permission
>    - logrotate - preserve security context on logs
>    - coreutils - get and set process and file security contexts
>    - findutils - find files with specific security contexts or display them
>    - procps - display process contexts
>    - psmisc - display process contexts
> 
> http://userspace.selinuxproject.org/trac/wiki/Userland
> and i am interested how the userspace packages be motified?
> and where can i find the relevant the source code of these?
> 
They are either in the upstream packages or contained as patches in the
Fedora and other Distro Releases
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklY7aYACgkQrlYvE4MpobMY3wCg4wyZfRrie1gi6PDEj3BjBNF7
v2kAoIUDv6SmffthhWpZ9WuAGNB4WRyK
=iPOd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
