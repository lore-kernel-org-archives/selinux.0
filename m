Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OLKfsJ020799
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 17:20:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8OLIuZt003409
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 21:18:57 GMT
Received: from zaphod.crypt.gen.nz (203-79-74-197.adsl.paradise.net.nz [203.79.74.197])
	by jazzswing.ncsc.mil  with ESMTP id h8OLItM3003404
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 21:18:56 GMT
Message-ID: <1697.202.27.185.71.1064438435.squirrel@www.crypt.gen.nz>
In-Reply-To: <20030924203129.GQ21997@vnl.com>
References: <20030923150926.GG21997@vnl.com>
    <200309242334.55203.russell@coker.com.au>
    <20030924203129.GQ21997@vnl.com>
Date: Thu, 25 Sep 2003 09:20:35 +1200 (NZST)
Subject: Re: ssh policy hassles
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "Dale Amon" <amon@vnl.com>
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon said:
> avc:  denied  { search } for  pid=654 exe=/usr/sbin/sshd dev=sda2
> ino=903169 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:var_lib_t tclass=dir
>
> Can anyone think of a reason why an sshd would try to search
> /var/lib upon an incoming ssh connection? /var/lib is
> not in the source code, it's not in the config files...
> The only thing I see that looks even vaguely like a possible
> target there is /var/lib/urandom.
>

It might be in /etc/passwd for privsep, and new connections try to look
for something there. From my RedHat 9 box:

$ grep ssh /etc/passwd
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
$ ls -l /var/empty
total 0
$


-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
