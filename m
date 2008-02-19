Message-ID: <47BB3240.3010300@redhat.com>
Date: Tue, 19 Feb 2008 14:47:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Resend: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880181F138@exchange.columbia.tresys.com> <47A9D23A.80405@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880181F2A3@exchange.columbia.tresys.com> <47AB3DE4.6040308@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880181F2BF@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181F2BF@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Daniel J Walsh wrote:
>> You are the boss.  Move it to /usr/libexec.  And I will fix policy to
>> label it correctly.  I would not put SELinux awareness into the
>> install, that is either "install", rpm. dpkg problem.
> 
> OK, I changed the path and updated the tarball.  Glad I don't have to
> worry about the label.
> 
>  - todd
There seems to be a bug. When I exit the shell it is not setting my tty
back.

In permissive mode.

$ ls -lZ `tty`
crw--w----  dwalsh tty staff_u:object_r:staff_devpts_t:s0 /dev/pts/2
 sudo sh
# ls -lZ `tty`
crw--w----  dwalsh tty staff_u:object_r:unconfined_devpts_t:s0 /dev/pts/2
# exit
$ ls -lZ `tty`
crw--w----  dwalsh tty staff_u:object_r:unconfined_devpts_t:s0 /dev/pts/2

In enforcing mode it kills the shell  :^(

I have it setup as staff_t and unconfined_t for root.


Other than this it looks greate.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke7MkAACgkQrlYvE4MpobMX3ACfa/DoyI4J9NaJDsm93fX7ptZk
Ya4AnifwZsH8iLGjAhYF2n7Aaf+As0Xo
=NQhj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
