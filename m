Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA29490
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 09:37:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA10826
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:35:48 GMT
Received: from mail.thesportsregister.com (mail.thesportsregister.com [208.53.250.138])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA10822
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:35:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.thesportsregister.com (Postfix) with ESMTP id F2E60FC0C
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 09:41:00 -0500 (EST)
Date: Wed, 10 Jan 2001 09:41:00 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: selinux@tycho.nsa.gov
Subject: Security enhancements, et al
In-Reply-To: <3A5C118F.36583E35@occamnetworks.com>
Message-ID: <Pine.LNX.4.21.0101100924010.5905-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi,

   First off, a quick question. Is there any code in SGI's Open B1 release
that could be sensibly utilised in SELinux? (I've not gone right the way
through OB1, but it seems silly to have a comprehensive resource just
sitting there. On the other hand, if SELinux covers everything of interest
in OB1 and/or the effort of writing from specs would be easier than a port
then trying to force chunks of OB1 into SELinux would be stupid beyond
belief.)

   Secondly, I've not seen a mention of SELinux on Freshmeat. The Slashdot
article probably did wonders for interest, but Freshmeat is a great tool
for maintaining the momentum. It'd be "better" if one of the core team
could post it, but that's an implementation issue. Getting it posted is
the main thing.

   Lastly, the reply to my question on IPSEC wasn't terribly clear. (But
that might just have been me.) I couldn't figure out if SELinux will have
it's own IPSEC implementation or a 3rd-party one. And, if 3rd-party, who.
The "Open Source" IPSECs I know of are: NIST (Linux), FreeS/WAN (Linux),
CISCO (BSD), MIT (BSD) and DOD (BSD). There are bound to be others. This
is not exhaustive. It'd be possible for SELinux to fork off any of these,
with various levels of effort, or to merge in diffs to support the SELinux
API.

Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
