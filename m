Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA18433
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 09:28:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA02289
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 13:27:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA02284 for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 13:27:20 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: new SE Linux release
Date: Fri, 26 Apr 2002 15:28:25 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020426132826.12CAE2CC9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do you know what the plans are for a new SE Linux release?

Currently there are 4 kernel patches and about a dozen separate patches to 
selinux-small which are needed in addition to the base code.

This is difficult to manage for me and other people preparing distributions 
of SE Linux and is probably more difficult for people who want to compile 
their own.  Also there are some new patches I want to write for SE Linux but 
I have not done because I don't want to get too far from the official code.

I believe that if my tree diverges too much from the official tree then 
potential users will be afraid to use it.

Another issue is the developments of the sample policy.  Organizations such 
as Tresys Technology are writing documents about SE Linux policy based on the 
structure of the sample policy and the location of the policydb.  However 
that policy has been changed in some structural ways and the location of the 
policydb has been changed.  As these changes are not in an official release 
Tresys are not documenting them, which means that my packages do not match up 
with Tresys documents which thus causes confusion for the users.

Also instead of a new release an official patch comprising two patch files 
(one for the kernel and one for the selinux-small) to apply against the last 
release would be just as good.  Also I believe that it would be best if such 
a patch was released every time there was to be a structural change to the 
sample policy or a change to the macros used.


One thing I want to code is some changes to setfiles.  I believe that I can 
make setfiles more flexible regarding input files (by removing the order 
dependency on the file_contexts) as well as making it use less CPU time for 
the average case.  But I am not prepared to start work on this until I get a 
copy of the newest setfiles source (some reasonably serious changes have been 
applied recently and I'm concerned that the next release might not quite 
match the patches I've received).

Another thing I want to do is improve the macros.  I have some ideas for 
macros that will make it easier to write policy without being too permissive 
(I believe that some of the current macros are being misused and some domains 
are getting more access than they deserve).  Also I aim to make the 
domains/program/* files significantly smaller on average through better 
macros, this is primarily because a small file is easier to audit.  But 
another benefit is that as it's easier to write a small file the users will 
be more likely to create new domains instead of improperly forcing additional 
programs into the same domain or blindly copying an existing domain without 
removing unnecessary permissions.

But my policy tree is already immensely different from the latest release, 
and I don't want to introduce any more significant changes until the last 
policy changes we all agreed on are in use by everyone.

When I start using Sourceforge for policy files (as Stephen has requested) 
this situation will improve, but I still don't want to go too far from the 
distribution (you should be able to copy files back and forth between a 
Debian system and a Slackware install without excessive pain).


Russell Coker


PS  I was going to send this as a private message, but I decided that there's 
quite a bit of background stuff here that many people will find interesting.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
