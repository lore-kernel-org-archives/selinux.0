Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9FFP7ci015839
	for <selinux@tycho.nsa.gov>; Tue, 15 Oct 2013 11:25:07 -0400
Message-ID: <525D5E29.1050307@redhat.com>
Date: Tue, 15 Oct 2013 11:24:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: zhangdaolong <zhangdl.fnst@cn.fujitsu.com>, kmacmillan@mentalrootkit.com,
        SELinux <selinux@tycho.nsa.gov>, kmacmillan@tresys.com
Subject: Re: There is  question about command semodule_deps
References: <525BA0AB.8040408@cn.fujitsu.com>
In-Reply-To: <525BA0AB.8040408@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/14/2013 03:43 AM, zhangdaolong wrote:
> Hi kmacmillan cc dwalsh
> 
> The command "semodule_deps" is new to me ,so i learn to use it. But there
> is a problem that i can not understand ,The problem is as follows
> 
> There are four policy modules:a base policy module and three none base 
> modules. and the relationship between them is as follows. 1) AB deps base; 
> 2) C deps AB and base; 3) D deps AB,C and base;
> 
> I excute the command" semodule_deps -b base.pp AB.pp C.pp D.pp ",and expect
> the following log is outputed. ----------------------------- module: C AB 
> BASE module: D C AB BASE module: AB BASE } ------------------------------ 
> But in fact the following log is outputed ----------------------------- 
> module: C C BASE module: D C D BASE module: AB BASE } 
> -----------------------------
> 
> I want to know the aboveoutput is correct or not?
> 
Pleas ask on the SELinux <selinux@tycho.nsa.gov> list.  I am not sure of the
correct answer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJdXikACgkQrlYvE4MpobOzQgCeLoP/DBZJPIdszN6h6Qj1nMwx
ewAAn34tiNn6PaMR9Q6E1IPnra1ryKBK
=5Xmi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
