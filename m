Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8A58arT016850
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 01:08:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8A58Yl6023126
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 05:08:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: tmpfs /dev
Date: Fri, 10 Sep 2004 15:08:27 +1000
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   fedora-devel-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
References: <200409100536.59711.russell@coker.com.au> <4140BAB8.8070808@redhat.com>
In-Reply-To: <4140BAB8.8070808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409101508.27612.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Sep 2004 06:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
> You will need to talk to Bill Nottingham about modifying /sbin/init to
> do this.  They are not crazy about
> putting additional code into /sbin/init since it is very hard to debug.

We've done it once, we can do it again.

> They prefer rc.sysinit.  They also do not

rc.sysinit means changing the policy for init_t, initrc_t, and maybe others.

> want to relabel the /dev file system if it is not a tmpfs,  since with
> 8000 or more files it could take a while and
> slow down the boot up.

On the slowest machine I have access to (a machine that can never run Fedora 
because it doesn't meet the hardware requirements) it takes 12 seconds to run 
setfiles on a fully loaded /dev.  On machines that are a mere four years old 
it takes about 2 seconds, I doubt that you will be able to measure the 
difference that this makes on any hardware that can be purchased now.  But 
writing some code to check for the file system type is not too difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
