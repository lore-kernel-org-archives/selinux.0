Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8SAjJUN026259
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 06:45:20 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8SAiV9q015045
	for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2009 10:44:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Zbynek Houska <zbynek.houska@gmail.com>
Subject: Re: Final year project ideas
Date: Mon, 28 Sep 2009 11:23:20 +1000
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
References: <761f67170909271125t493e9e2dx96158194dbd2f279@mail.gmail.com>
In-Reply-To: <761f67170909271125t493e9e2dx96158194dbd2f279@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200909281123.22364.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Sep 2009, Zbynek Houska <zbynek.houska@gmail.com> wrote:
> write a few (new) policies for software of my choice.  I intend to use
> honeypots running Fedora 11 as my base system. However, I'm not sure if
> college class B network will produce conclusive results.
>
> Thus, I would appreciate support, guidance and comments from (seasoned)
> SELinux gurus, developers and practitioners on this list in order to point
> me in the right direction when it comes to sourcing literature, white
> papers, research work other people might already have conducted and
> overcoming pitfalls related to such testing environments.

Firstly firewall all traffic from the system in question - other than that 
which is required for it to be vulnerable to the attacks you desire.  If you 
allow ICMP echo access then someone will try and ping-flood other systems.  
If you allow outbound TCP connections then your system may be used to 
compromise others.

Probably the best way to run honeypots is to use Xen or KVM to run virtual 
machines.  This means that you have lots of good options for monitoring the 
machines while they are attacked.  But don't assume that Xvn or KVM is 
flawless - IE don't have any sensitive data on the same physical machine.

The purpose of a honeypot is to attract attack, running the latest versions of 
software is going to make it more difficult for attackers and partially 
defeats this goal.  Maybe running Fedora 10 (or earlier) with no updates 
would be a better option.  Of course you will probably want to back-port the 
latest SE Linux policy before you do this (which shouldn't be difficult).

It's been a while since anyone ran a SE Linux Play Machine on Fedora, I would 
be happy to offer detailed advice and some testing if you want to run one.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
