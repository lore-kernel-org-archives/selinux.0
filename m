Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBUD6QWD025471
 for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2016 08:06:26 -0500
From: Russell Coker <russell@coker.com.au>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Reply-To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
Date: Sat, 31 Dec 2016 00:05:56 +1100
Message-ID: <70625685.47kgmqZV44@russell.coker.com.au>
In-Reply-To: <CAJfZ7=nLMJdwfYRCuPR5LssYHXp2SZ00cPk9RxKa=e_3EsHLNQ@mail.gmail.com>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <7415401.n4TOyH4plo@russell.coker.com.au>
 <CAJfZ7=nLMJdwfYRCuPR5LssYHXp2SZ00cPk9RxKa=e_3EsHLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, 26 December 2016 7:10:19 PM AEDT Nicolas Iooss wrote:
> With the output you gave I searched in D-Bus source how the
> LinuxSecurityLabel was computed here. I discovered a lot of files in dbus/
> directory which seem to duplicate things from bus/ I have described in my
> previous email. In dbus/dbus-sysdeps-unix.c there is a function which calls
> "getsockopt (client_fd, SOL_SOCKET, SO_PEERSEC, ...)" in order to get this
> "system_u:system_r:systemd_machined_t:s0"
> (add_linux_security_label_to_credentials,
> https://cgit.freedesktop.org/dbus/dbus/tree/dbus/dbus-sysdeps-unix.c?h=dbus-> 1.10#n1760). This function queries the same kernel API as libselinux's
> getpeercon_raw(), but without using libselinux (which is normal as it can
> also returns Smack or AppArmor labels). This is why the context is not
> translated.
> 
> The documentation of GetConnectionCredentials->LinuxSecurityLabel is way
> better than the one of GetConnectionSELinuxSecurityContext in D-Bus
> specification (
> https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specification.xml?h=dbu
> s-1.10#n6030) so if I were to decide, I would rather migrate systemd's
> bus_get_name_creds_dbus1() to GetConnectionCredentials (in
> https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-contr
> ol.c#L865). However this implies some non-trivial systemd code modifications
> and I do not know how systemd developers are willing to modify this part of
> their code.
> An other option consists in making D-Bus use getpeercon_raw() in
> GetConnectionSELinuxSecurityContext (and documenting this in the D-Bus
> spec). I do not know what subtle side-effects such a change would have on a
> system (a quick search of users of this interface on searchcode.com gave
> some Android-related projects).

Thanks for your suggestions.  I ran a VM of Fedora 24 with my policy to test 
this.  Fedora 24 ran well with that and gave no such errors.  Fedora has dbus 
1.11.8 (development) and systemd 229 while Debian/Unstable has dbus 1.10.14 
(stable) and systemd 332.

A did a diff on the Fedora 24 dbus source and the Debian dbus source and 
didn't find anything that seemed to be related.  So I presume that it's more 
related to systemd - which doesn't necessarily imply that changing systemd is 
the correct way to fix it.

I'll try rawhide now.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
