Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA08298
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 16:43:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA13496
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 20:43:15 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzband.ncsc.mil  with ESMTP id UAA13481
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 20:42:40 GMT
Subject: A notion
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 02 Oct 2001 04:42:53 -0400
Message-Id: <1002012173.1248.12.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It occurred to me that custom versions of software can be more secure
than standard versions because various exploits (like stack smashing,
etc.) require precise knowledge of certain sizes and distances in RAM
(for instance, the distance from the end of a buffer to the return
point...).

Isn't it possible to develop a "randomizing C compiler" that randomly
varies these distances every time it compiles a program? No two compiles
of the same source code would be exactly the same (but they would
execute the same way).

This might involve inserting small random-sized blocks of dead code, or
doing returns from subroutines through a level of indirection (i.e.,
putting the actual return at some random location in the object code
with a branch to it).

Done right, this might not degrade performance significantly.


-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
