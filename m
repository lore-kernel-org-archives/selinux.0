Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA03926
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 10:04:36 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: policy version
Date: Tue, 1 Oct 2002 16:04:25 +0200
References: <20021001131535.A21503@lemuria.org>
In-Reply-To: <20021001131535.A21503@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210011604.25300.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 13:15, Tom wrote:
> I have a totally unusable SELinux system right now, because of policy
> version conflicts. For reasons I don't understand, checkpolicy creates
> a binary representation version 12, which load_policy refuses to load
> because it's version 11.

Firstly your machine should still work.  The way things are designed to 
operate is that a unique file name is used for each version of the policy.  
So if you had a previously operational system with policy V11 and you did not 
delete any files then it should still boot up loading that V11 policy.  You 
won't be able to load a new V12 policy but that should not be a serious 
problem, your machine should still be in a state that allows you to compile 
the kernel.

Steve sent a kernel patch to this list at the same time as the checkpolicy 
patch that is in the Debian packages that Brian and I produce.  You need this 
patch to get it working.

> I just find it unacceptable that a standard update (all my troubles
> started when I ran nothing more than "se_apt-get upgrade" this morning)
> can take the system out completely, with no path back.

The way this is designed to work is that the "se_apt-get upgrade" will get you 
a new policy (which will install but not load) and a new kernel patch to 
match.  Then if you build a new kernel-image package with that kernel patch 
then it'll support the V12 policy and everything will be fine after a reboot.

Another option is to use the kernel-image packages Brian is producing, he has 
re-built all his packages with V12 policy support.  He appears to be going to 
a lot of effort to build those packages so it would be good if someone uses 
them...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
