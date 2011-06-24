Message-ID: <4E0488DE.3000300@redhat.com>
Date: Fri, 24 Jun 2011 08:53:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Wrong context for user
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
In-Reply-To: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/24/2011 08:04 AM, c.r.madhusudhanan@gmail.com wrote:
> Hi All,
> 
> 
> I have meego configured with SELinux refpolicy. I have enabled SELinux
> user to linux user mapping, and though it shows correct selinux user and
> selinux role, 
> the domain/type appears to be wrong.
> 
> For example, when I login linux user "meego", and say ps -Z, it shows me,
> 
> user_u:user_r:insmod_t          773   tty1   00:00:00 bash
> user_u:user_r:insmod_t          795   tty1   00:00:00 ps
> 
> where I expect this has to be user_u:user_r:user_t, any pointers?
> 
> 
> Regards,
> Madhu
Most likely your login program is not running with the correct context.

ps -eZ | grep login
- --> Should be local_login_t
ps -eZ | grep sshd
- --> Should be sshd_t
ps -eZ | grep gdm
- --> Should be xdm_t

Usually login programs running as the wrong context need to be
relabeled.  touch /.autorelabel; reboot
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4EiN4ACgkQrlYvE4MpobMTewCg6FBaXsxZaJ/veVWbiqfeS38m
B2gAoM1iOR3Dd9fjoyDHM6NFDve09VB8
=Xrpt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
