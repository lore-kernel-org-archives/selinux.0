Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAN6WoIi010096
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 01:32:51 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAN6VA5q024656
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 06:31:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jiann-Ming Su <sujiannming@gmail.com>
Subject: Re: MySQL Policy Patch
Date: Tue, 23 Nov 2004 16:09:53 +1100
Cc: selinux@tycho.nsa.gov
References: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net> <1098205374.29525.99.camel@moss-spartans.epoch.ncsc.mil> <561dc32604110511531fbd1e33@mail.gmail.com>
In-Reply-To: <561dc32604110511531fbd1e33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411231609.57657.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 06 November 2004 06:53, Jiann-Ming Su <sujiannming@gmail.com> 
wrote:
> FC3T3 wouldn't install on my system, so I'm having to work through
> FC2.  When I try to run "/etc/init.d/mysql start" as root, I get the
> following in dmesg:
>
> audit(1099684144.872:0): avc:  denied  { read } for  pid=5099
> exe=/bin/su name=.default_contexts dev=sda5 ino=213003
> scontext=jms:user_r:user_su_t tcontext=root:object_r:staff_home_dir_t
> tclass=file

It was never possible to get correct operation when su is used for starting 
daemons.

FC3 has a new program "runuser" for starting daemons in this situation, 
hopefully the mysql packages for FC3 will use runuser instead of su (if not 
it's a bug).

> inode_doinit_with_dentry:
> What do I need to do so that mysql will start on my system, and users
> can access the mysql database?  I've tried adding mysqld_r to the
> users file, but mysqld_r is not a role.  Sorry for being so slow with
> this.  Thanks for any info.

If you install the policy from FC3 and compile runuser on FC3 then you can 
modify the init.d script to use runuser instead of su and things should work.

But it may be easier to fix the problem with installing FC3.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
