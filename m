Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14034
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:24:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JHOJI28445
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:24:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1JHOHf28437 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:24:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Ask Holme <ask@eternal-newbie.dk>, selinux@tycho.nsa.gov
Subject: Re: passwd, sysadm_t access shadow_t:file
Date: Wed, 19 Feb 2003 18:24:08 +0100
References: <20030219180615.23730649.ask@eternal-newbie.dk>
In-Reply-To: <20030219180615.23730649.ask@eternal-newbie.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302191824.08871.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Feb 2003 18:06, Ask Holme wrote:
> I just discovered that i can't use the passwd program an my debian --
> the i get errors stating that the sysadm_t domain can't read/write/lock
> the shadow file (shadow_t:file). However i fell that it's perfectly okay
> that the sysadm can't do that, since only the passwd program should
> could, a quick hack would be to edit the domain/programs/passwd.te file
> and allow the sysadm_t domain access to the file however i would like to
> just allow the passwd_t domain, but would i need a recode of passwd for
> that ?

If you want to change your own password as a user then use "spasswd".  If you 
as administrator (sysadm_t) want to change someone else's password then use 
"sadminpassword".

If you change the policy to allow the administrator to write to or replace the 
shadow file then it will probably be replaced by type etc_t and therefore SE 
Linux won't prevent unauthorised access to it (you will be relying on Unix 
permissions alone).  This is probably not what you want.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
