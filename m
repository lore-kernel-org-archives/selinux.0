Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15781
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:24:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA00059
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 21:23:05 GMT
Received: from cs.unt.edu (cs.unt.edu [129.120.36.230])
	by jazzswing.ncsc.mil  with ESMTP id VAA00055
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 21:23:04 GMT
Received: from zaphod.csci.unt.edu (zaphod.csci.unt.edu [129.120.36.22])
	by cs.unt.edu (Postfix) with ESMTP id 7876E7A328
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:24:50 -0500 (CDT)
Received: from localhost (srt@localhost)
	by zaphod.csci.unt.edu (8.11.6/8.9.3) with ESMTP id g3PLOog07976
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:24:50 -0500
Date: Thu, 25 Apr 2002 16:24:50 -0500 (CDT)
From: Steve Tate <srt@cs.unt.edu>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: A different policy analyzer/browser...
Message-ID: <Pine.LNX.4.33.0204251624140.7907-100000@zaphod.csci.unt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I'm releasing a tool that other might find useful.  It's a GUI browser
for SELinux type-enforcement rules, which are loaded from the final
(binary) compiled form of the policy.  I wanted some way to look at
the "real rules" that were in effect in a policy, and I couldn't find
a good way to do that, and the result is writing this browser.  You
can sort by any of the fields of the rules, or filter them in several
different ways -- see the README file for more details and an example.

I tried the original "apolicy" tool from Frank Mayer (but haven't yet
tried the just-released version with the GUI front-end), and while it
did a lot of what I wanted, it was difficult to use and provided too
much information in some cases with very little way to filter.  It
also worked off of the policy source rather than the binary form.
While I'm normally not a GUI-type guy, I thought this would be a great
place to have a GUI tool, where you could dynamically adjust your view
and filtering options while viewing the rules.

So here are some caveats:

   1) This is only for the TE rules -- the rest of the policy
      definition is ignored.

   2) This is the first real GUI tool I've ever written (like I said,
      I don't normally like 'em!).

   3) This is written in C++ -- I know a lot of you out there prefer
      C, and I started that way on this tool...  but when I caught
      myself repeatedly trying to fake C++-like constructs in C, I
      figured that was stupid....

Now that I have sufficiently lowered your expectations :-) here's
where you can get the code:

       http://cops.csci.unt.edu/projects/selinux/

I hope someone finds it useful!

-- 

Steve Tate
srt@cs.unt.edu


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
