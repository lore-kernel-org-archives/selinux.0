Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t93AcYc3007535
 for <selinux@tycho.nsa.gov>; Sat, 3 Oct 2015 06:38:35 -0400
Received: from wheezy.localnet (ns-local [10.10.10.1])
 by smtp.sws.net.au (Postfix) with ESMTP id EEC75ECEE
 for <selinux@tycho.nsa.gov>; Sat,  3 Oct 2015 20:38:28 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Computer Science and SE Linux
Date: Sat, 3 Oct 2015 20:38:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201510032038.27911.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm going to offer a lecture about the Computer Science aspects of SE Linux in 
the near future.  Here's a quick summary of what I'm thinking of speaking 
about.

MAC vs DAC.

Domain-Type as a concept (not details of implementation).

LSM as a concept.

PAM and cron modifications.  Generally how the Unix users fit in with SE Linux 
and how that can be extended to other MAC systems.

Why we modify init and what other options were tested.

MLS as a concept in general.

File labelling, why and how.

Algorithms for optimising setfiles.

I'd like to speak about some features of the kernel code.  I recall reading 
about the optimisations for 32 core systems some time ago, I'm sure there's 
something in that which is worth mentioning.  It's not an area that I've 
worked on, can anyone suggest something I should read about this?

Any suggestions for other things I should mention?  Note that I'm not planning 
to mention anything about how to actually use SE Linux.  There are lots of web 
sites about that and I could offer a lecture on that topic at a different venue.  
The previous lecture in the series was about the design of the Enigma machines 
for WW2 cryptography.  The audience want to generally learn about maths and 
science not necessarily learn things that they can actually do.

Also the format of the presentation is that it has to finish quickly when the 
pizza arrives.  So the items at the bottom of the list may get skipped.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
