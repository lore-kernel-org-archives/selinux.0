Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA04642
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:34:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA01134
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 21:33:04 GMT
Received: from mail4.registeredsite.com (mail4.registeredsite.com [64.224.9.13])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA01130
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 21:33:03 GMT
From: "Phillip H. Zakas" <pzakas@toucancapital.com>
To: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>,
        <selinux@tycho.nsa.gov>
Subject: RE: SELinux and covert channels
Date: Wed, 10 Jan 2001 16:34:01 -0500
Message-ID: <PHEOLKHKKADCALFJMBNIIEFECAAA.pzakas@toucancapital.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <A0669F3E0A6B3448A962DC6141E6C7A6144162@mis1>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Thanks for clarification and sorry for my obtuse reply to original message.
I was confusing a thread here with a thread on cypherpunks which delved into
a slightly different area.
Phillip

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Belmonte, Christopher
Sent: Wednesday, January 10, 2001 1:16 PM
To: selinux@tycho.nsa.gov
Subject: RE: SELinux and covert channels


Phillip,
	In regards to covert channels, this is what I am referring to (the
following is from "A GUIDE TO
UNDERSTANDING COVERT CHANNEL ANALYSIS OF TRUSTED SYSTEMS"):

Definition 1 - A communication channel is covert if it is neither designed
nor intended to transfer information at all. [Lampson73] (Note: Lampson's
definition of covert channels is also presented in [Huskamp78].)

Definition 2 - A communication channel is covert (e.g., indirect) if it is
based on "transmission by storage into variables that describe resource
states." [Schaefer77]

Definition 3 - Covert channels "will be defined as those channels that are a
result of resource allocation policies and resource management
implementation." [Huskamp78] (Note: The computing environment usually
carries out resource allocation policies and implementation.)

Definition 4 - Covert channels are those that "use entities not normally
viewed as data objects to transfer information from one subject to another."
[Kemmerer83]

Definition 5 - Given a nondiscretionary (e.g., mandatory) security policy
model M and its interpretation I(M) in an operating system, any potential
communication between two subjects I(Sh) and I(Si) of I(M) is covert if and
only if any communication between the corresponding subjects Sh and Si of
the model M is illegal in M. [Tsai90]

- Chris Belmonte

-----Original Message-----
From: Phillip H. Zakas [mailto:pzakas@toucancapital.com]
Sent: Wednesday, January 10, 2001 1:11 PM
To: Belmonte, Christopher; 'Johnathon Day'; selinux@tycho.nsa.gov
Subject: RE: SELinux and covert channels


It's open source, not sure how covert that could be?  unless one programs in
very obfuscated code I guess, but the code looks pretty good to me :)
pz

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Belmonte, Christopher
Sent: Wednesday, January 10, 2001 11:45 AM
To: 'Johnathon Day'; selinux@tycho.nsa.gov
Subject: SELinux and covert channels


Has anyone considered analyzing SELinux for covert channels?


- Chris Belmonte

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

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
