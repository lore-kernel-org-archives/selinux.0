Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA12427
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 14:04:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA29120
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 19:04:21 GMT
Received: from mail.thesportsregister.com ([208.53.250.139])
	by jazzswing.ncsc.mil  with ESMTP id TAA29116
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 19:04:20 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.thesportsregister.com (Postfix) with ESMTP id 78011BB
	for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2001 14:09:10 -0500 (EST)
Date: Fri, 9 Mar 2001 14:09:10 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: <selinux@tycho.nsa.gov>
Subject: How is 2.4.x progressing?
In-Reply-To: <p04320405b6c04aed15b0@[208.24.120.15]>
Message-ID: <Pine.LNX.4.30.0103091352460.6433-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi,

   Long time, no post. Thought I'd drop a note and ask how the port to
Linux 2.4.x was progressing. Also, wondering if SE Linux made any use of
the International Patch, if installed. (SE Linux might not use crypto,
but I'd be amazed if it never used secure hash functions.)

   Also, to go back to the IPSec question, NIST's Cerberus IPSec was/is
either funded by, or partially developed by the NSA, if I'm reading the
documents rightly. However, it was said (more than once) on this list
that SE Linux will -probably- use FreeSWAN. My question here is not
whether that is technically the right decision (FreeSWAN is evolving,
Cerberus is stagnating), but whether the SE Linux core team is going to
be free to make it. I could just be over-anxious, here, but I don't know
of many PHB's who will pay to develop one product, and then use a
"competitors". Any reassurance on this would be greatfully received.

Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
