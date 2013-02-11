Message-ID: <511946AB.10802@tycho.nsa.gov>
Date: Mon, 11 Feb 2013 14:29:47 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: systemd selinux
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com> <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
In-Reply-To: <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/11/2013 02:17 PM, Brian Iván Martínez wrote:
> Yes, thank you, first of all, and second, one user (the maintainer of
> the package) found a patch from Fedora that, for now, seems to be
> working fine, but that is not the problem now, the problem is with
> systemd wich doesn't compile. The PKGBUILD file says it is version 197
> and it applies 2 patches, use-split-usr-path.patch and
> 0001-dbus-fix-serialization-of-calendar-timers.patch, then it configures
> with the next flags:
>
> --enable-introspection
> --enable-gtk-doc
> --enable-selinux
> --disable-audit
> --disable-ima
>
> When I try to build using those files (from
> https://aur.archlinux.org/packages/selinux-systemd/) it gets stuck in
> the configure part stating:
>
> checking for SELINUX... no
> configure: error: *** SELinux support requested but libraries not found
>
> I think it just doesn't find SELinux but then how can I fix it? the only
> dirs passed to configure are:
>
> --libexecdir=/usr/lib
> --localstatedir=/var
> --sysconfdir=/etc
>
> The PKGFILE may be more explicit than me.

Do you have a /usr/lib/pkgconfig/libselinux.pc or 
/usr/lib64/pkgconfig/libselinux.pc file?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
