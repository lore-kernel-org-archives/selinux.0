Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01006
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 11:43:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA03859
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:43:20 GMT
Received: from dit2.state.va.us (dit2.state.va.us [165.176.32.4])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA03855
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:43:19 GMT
Message-ID: <A0669F3E0A6B3448A962DC6141E6C7A614415B@mis1>
From: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
To: "'Johnathon Day'" <jcday@mail.thesportsregister.com>,
        selinux@tycho.nsa.gov
Subject: RE: Security enhancements, et al
Date: Wed, 10 Jan 2001 11:43:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

The Open B1 Release is not really about the code, but the concepts.

If you want SELinux to have capabilites similar to that of a B1 system, you
need to focus on what is going on from the implementation of the source
code, not the code itself.

Copying code from one implementation into another isn't effective in that
you are not looking at the system as a whole with modular components, but
rather trying to patch into a framework that is not currently designed for
such behavior.

If SELinux were to develop further into a serious solution that could
possibly be evaluated in the future, the overall integrity must not be
compromised by using other solutions that are optimised specifially for that
model.


-----Original Message-----
From: Johnathon Day [mailto:jcday@mail.thesportsregister.com]
Sent: Wednesday, January 10, 2001 9:41 AM
To: selinux@tycho.nsa.gov
Subject: Security enhancements, et al


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
