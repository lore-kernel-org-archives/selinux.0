Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3O35FI4006229
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 23:05:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3O359Vf010065
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:05:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3O3574D010062
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:05:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Peter Gervai <grin@tolna.net>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: please offer your good advices / new policies: exim, dovecot, maradns, (aptitude)
Date: Thu, 24 Apr 2003 13:05:05 +1000
References: <20030423111231.GV3993@narya.grin.hu>
In-Reply-To: <20030423111231.GV3993@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304241305.05188.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In future, could you please split long messages into several shorter messages 
with topics to match?  This makes it easier for people to track threads, and 
sometimes I just don't have the time to respond to a long message...

On Thu, 24 Apr 2003 02:06, Peter Gervai wrote:
> Other question: what is the advised way to have the server an admin
> (staff_t?) who is able to create/delete users? Probably emitting user_u
> users are okay in the beginning, because I believe everything more would
> require policy reloading. (I'm checking this after this email anyway, but
> maybe you're faster.)

Anything other than user_u users does require a new policy to be loaded.

An interim solution assuming that you have a basic trust in those 
administrators is to do:
domain_auto_trans(staff_t, useradd_exec_t, useradd_t)
role staff_r types useradd_t;

Now a hostile user with this access could use userdel to remove the 
administrative account, recreate it with a different password, and then login 
for full access.  If you are just protecting against mistakes, tricks, etc 
then it may be OK.

What we probably need is two types of useradd wrapper (similar to the spasswd 
and sadminpasswd distinction).  Then for less priviledged users they won't be 
able to create or remove accounts outside certain UID/GID ranges.

NB  useradd_t does not have setuid capability.  So if the staff_r user does 
not have access to UID=0 and you want a SUID root useradd then you will need 
to add the setuid capability to useradd_t.

Also consider creating a new type for /usr/bin/suseradd so that a staff_r user 
can run useradd but not userdel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
