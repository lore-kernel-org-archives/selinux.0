Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8P3X8sJ021996
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 23:33:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8P3X7CG027527
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 03:33:07 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8P3X4qJ027524 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 03:33:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Date: Thu, 25 Sep 2003 13:32:53 +1000
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au> <20030924203129.GQ21997@vnl.com>
In-Reply-To: <20030924203129.GQ21997@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309251332.53496.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Sep 2003 06:31, Dale Amon wrote:
> avc:  denied  { search } for  pid=654 exe=/usr/sbin/sshd dev=sda2
> ino=903169 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:var_lib_t tclass=dir

What is in /etc/passwd for the sshd account?

> The only thing I see that looks even vaguely like a possible
> target there is /var/lib/urandom.

That's not something that sshd should be accessing.

Does sshd work well without the access?  If so then a dontaudit rule is in 
order.

> Okay, now I've still one more, and this one is really
> confusing because ino=48726022 seems not to exist:
>
> 	48726022        <inode not found>
>
> I half wonder if I've got a bad link somewhere. It would
> be easy enough to add an allow for this, but I'd like
> to figure out why rather than blindly add things.
>
> avc:  denied  { read } for  pid=743 exe=/usr/sbin/sshd dev= ino=48726022
> scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t
> tclass=lnk_file

When you see that a domain is listed as the target (sshd_t is the tcontext) 
for a file/dir/link_file access then it's an access to /proc/pid .  In this 
case it's probably access to /proc/self/cwd or something.  In my latest 
policy I have the following:
dontaudit sshd_t proc_t:dir search;

Nothing else is permitted under /proc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
