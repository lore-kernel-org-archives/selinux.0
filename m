Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CExMAt024234
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:59:22 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1CExLwI028769
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 14:59:22 GMT
Message-ID: <47B1B440.7030701@redhat.com>
Date: Tue, 12 Feb 2008 09:59:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
CC: selinux@tycho.nsa.gov
Subject: Re: Disabling SELinux by kernel vulnerability
References: <20080212234339.40551955.himainu-ynakam@miomio.jp>
In-Reply-To: <20080212234339.40551955.himainu-ynakam@miomio.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yuichi Nakamura wrote:
> Hi.
> 
> I saw an article on slashdot.
> http://it.slashdot.org/article.pl?sid=08/02/10/2011257
> 
> Local exploit code for Linux kernel exists, 
> exploit code is also disclosed in http://www.milw0rm.com/exploits/5092.
> 
> In the exploit code, only uid is changed to 0.
> So, SELinux is not affected.
> 
> However, SELinux can be disabled by overwriting selinux_enforcing to 0.
> The address of selinux_enforcing can be seen in /proc/kallsyms, 
> and I've set the value on the address to 0.
> 
> I tried that on Fedora 8, 
> and I could disable SELinux(set selinux as permissive) from xguest_t
> domain.
> 
> I want to make it more difficult 
> for attackers to disable SELinux by kernel exploit.
> 
> I think not exporting selinux_enforcing(and selinux_disable) to
> /proc/kallsyms is useful.
> And /proc/kallsyms is visible from many processes because it is proc_t,
> assigning /proc/kallsyms label such as proc_ksym_t may be also useful.
> Are they really useful?
> Or any idea??
> 
> --
> Yuichi Nakamura
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
So this exploit, don't you neet to write to /proc?  xguest_t should not
be allowed to do this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkextEAACgkQrlYvE4MpobNWWgCg6acsickGQTXcl0xj3YyBYoRn
NGUAnR45m3M0yM15igKtZzh6ORQ9CYTQ
=64qb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
