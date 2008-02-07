Message-ID: <47AB3DE4.6040308@redhat.com>
Date: Thu, 07 Feb 2008 12:20:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Resend: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880181F138@exchange.columbia.tresys.com> <47A9D23A.80405@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880181F2A3@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181F2A3@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Daniel J Walsh wrote:
>> I don't recall, I wrote it several years ago.  I guess the simplest
>> thing is to try it out, without the fork.
> 
> Seems to work fine without the fork.  I've made quite a few changes and
> you can now specify sudoers lines like:
> 
> tmiller ALL=(ALL) ROLE=sysadm_r TYPE=sysadmin_t /bin/sh
> 
> and have it do what (I think) you want.  Note that "make install" does
> not currently set the label on sesh, perhaps it should.  I'm also not
> sure that /usr/sbin is the best place for sesh.  My inclination would be
> to put it in /usr/libexec, though this is not a big deal.
> 
>  - todd
You are the boss.  Move it to /usr/libexec.  And I will fix policy to
label it correctly.  I would not put SELinux awareness into the install,
that is either "install", rpm. dpkg problem.

I look forward to testing it out.  And once it is in Rawhide, will blog
about how to use it with SELinux.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkerPeQACgkQrlYvE4MpobM0dgCgsVNlzSmComL5m39JExgG0cjj
Z3gAoJ1GydVEoFvHUf4CNvgjNhZNoygg
=grpX
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
