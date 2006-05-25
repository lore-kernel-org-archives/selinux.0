Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4P7CKoU024230
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 03:12:20 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4P7CH9h011019
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 07:12:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
Subject: Re: daemons and MCS categories
Date: Thu, 25 May 2006 17:12:26 +1000
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>,
        SE-Linux <selinux@tycho.nsa.gov>
References: <200605220930.05483.russell@coker.com.au> <Pine.LNX.4.64.0605250105520.15655@d.namei> <1148538208.1797.23.camel@papa.intrajp-yokosuka.co.jp>
In-Reply-To: <1148538208.1797.23.camel@papa.intrajp-yokosuka.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Message-Id: <200605251712.31603.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 May 2006 16:23, Shintaro Fujiwara <shin216@xf7.so-net.ne.jp> 
wrote:
> What I really want to do, is let apache run say
> s0:c0.c2 and do Unix users do their jobs,
> webdesigner-s0:c0,scriptwriter-s0:c1,webmaster-s0:c2
> (whatever the word is).
> So, I can tell scriptwriter and webmaster (not designer
> this time) root password.
> I understand if they can be root, they cannot do anything
> harmful to the system.
> It's useful when I have several men under me (sysadmin)
> who are not so skillful.

One thing you didn't mention is whether you plan to use strict or targeted 
policy on the machine in question.  I know that you use strict at home, but 
targeted is the default (and the easy option) so I guess it's likely that you 
use it at work.

In targeted policy users run as unconfined_t, so therefore giving out the root 
password allows doing every harmful thing.  sudo may be a solution to this.  
If the daemon is to have more categories than the user who starts it then 
run_init can be used to run it.

In strict policy you can restrict the damage from the root account (although 
it takes a little configuration work).

But it seems that you are raising a new issue here, that of securely 
restarting daemons by users other than the sys-admin.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
