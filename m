Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00750
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 11:27:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA16042
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:26:22 GMT
Received: from dit2.state.va.us (dit2.state.va.us [165.176.32.4])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA16034
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:26:21 GMT
Received: from ditmis8.state.va.us (ditmis8 [165.176.61.18])
	by dit2.state.va.us (8.9.3+Sun/8.9.3) with ESMTP id LAA18356
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 11:25:46 -0500 (EST)
Message-ID: <A0669F3E0A6B3448A962DC6141E6C7A6144156@mis1>
From: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
To: selinux@tycho.nsa.gov
Subject: RE: Security enhancements, et al
Date: Wed, 10 Jan 2001 11:27:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Is anyone currently using the Rule Set Based Access Control linux security
extension? I am curious on how it compares to SELinux. You can get the
extension at:

www.rsbac.de

I am currently using Debian/GNU linux w/ kernel 2.2.17 + RSBAC security
extension on an SMP machine.

I have not had the opportunity to try out SELinux, but I have been using the
RSBAC security extension for sometime now. Having used and involved in the
testing of DG/UX with the B2 and C2 security options, I think this security
extension is by far the best one available for linux. (When you compare what
this security extension does for linux as opposed to a commercial OS with an
evaluated security package) 

Does anyone have any idea why it has taken so long the release of SELinux?
I'm assuming that maybe it was due to a source code audit... the man pages
for many of the commands added by SELinux show updates from 1997-1999 (sorry
if this has been changed in the current version).

I am willing to give SELinux a try, but with security extensions such as
RSBAC for linux being effective for information security on a linux
platform, I am in interested to see in how this product will continue to
develop, given the pace it is at right now and the list of improvements that
still need to be made. 

- Chris Belmonte

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
