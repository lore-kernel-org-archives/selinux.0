Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PGlusJ025200
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:47:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PGkCZt008035
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 16:46:12 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8PGkAM3008026
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 16:46:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Diyab <diyab@diyab.net>
Subject: Re: ssh policy hassles
Date: Fri, 26 Sep 2003 02:47:39 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030925102955.GC10234@vnl.com> <3F72E5DC.20603@diyab.net>
In-Reply-To: <3F72E5DC.20603@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309260247.39337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Sep 2003 22:55, Diyab wrote:
> Dale Amon wrote:
> > On Thu, Sep 25, 2003 at 08:46:17AM +0200, Tom wrote:
> >>You might want to define a special type for the empty dir, so you can
> >>move it around and don't have to give sshd access to all of /var
>
> I did this when I installed it on slackware.  In ssh.fc I added
>
> 	/var/empty	system_u:object_r:sshd_privsep_dir_t
>
> and in sshd.te I added
>
> 	type sshd_privsep_dir_t, file_type, sysadmfile;
>
> and
>
> 	allow sshd_t sshd_privsep_dir_t:dir { getattr search };

Why not just label it as var_run_t?

In my latest policy I have the privsep directory (which is under /var/run in 
Debian) labeled as var_run_t.  In the case of sshd as a daemon it can create 
files under that, but in the case of sshd run from inetd (which is what you 
will be doing if you want to lock down sshd) then it gets { getattr search } 
access.

NB  The privsep process will be prevented from creating files by Unix 
permissions anyway.  Sshd does not have permissions to change the mode on the 
directory and the privsep process can not change it's UID.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
