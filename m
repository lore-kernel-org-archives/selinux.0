Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SFLfrT008237
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 11:21:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SFKauK018146
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 15:20:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: fuse - how to "mirror" user_t file access rights?
Date: Wed, 29 Sep 2004 01:21:23 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040927012108.GL28076@lkcl.net>
In-Reply-To: <20040927012108.GL28076@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409290121.23628.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 11:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i found the privhome domain thing but russell said "no way!"
> because privhome allows access to *alll* user domains.

file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)

To do this properly we need an attribute that matches all the other file types 
for the user, I'll work on that later.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
