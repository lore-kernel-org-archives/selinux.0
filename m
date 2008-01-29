Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TF9iQq011294
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:09:44 -0500
Received: from g5t0009.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TF9h6Q002133
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 15:09:43 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] pull request for lblnet-2.6_testing
Date: Tue, 29 Jan 2008 10:09:31 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200801291009.32056.paul.moore@hp.com>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi James,

I've just rebased the lblnet-2.6_testing tree against Linus' latest 
which already includes DaveM's net-2.6.25 tree so there shouldn't be 
any collisions with the core networking bits.  Other than minor changes 
needed to merge cleanly with the current linux-2.6 tree there have been 
no changes to the labeled networking patches since they were last 
posted.  The git tree can be found here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

In the interest of full disclosure, I was not able to test this tree as 
there are a few compile errors in the drivers area which are preventing 
me from getting a kernel built.  However, all of the relevant areas 
(security/selinux, net/netlabel, net/netfilter, net/xfrm, net/ipv4, 
net/ipv6) compiled without issue.  I will continue to try and get a 
kernel compiled but I thought getting this out in a reasonable 
timeframe to minimize merge issues was a better decision.  Thse patches 
applied to 2.6.24 do compile, boot, and run without any known 
regressions.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
