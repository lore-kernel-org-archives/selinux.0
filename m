Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA01055
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:14:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA17658
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 21:13:09 GMT
Received: from mail.thesportsregister.com (mail.thesportsregister.com [208.53.250.138])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA17654
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 21:13:08 GMT
Date: Mon, 15 Jan 2001 16:18:16 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: Bennett Todd <bet@rahul.net>
Cc: Jan Petranek <jan@petranek.de>, selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root
In-Reply-To: <20010115141903.S8565@rahul.net>
Message-ID: <Pine.LNX.4.21.0101151453430.18627-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi again,

	The problem is this. Let your innermost layer of defence be
defined as "L".

	If there exists any "legit" method of bypassing "L", there exists
a malicious method of bypassing "L".

	So, yes, if someone can bypass the OS by running their own, or
tampering with the HW, anything that is actively prohibited by the OS can
be done.

	The trick is to NOT rely on active defences, but to also use some
form of passive defence, where the OS doesn't prevent the unauthorised as
actively permit the authorised. That way, bypassing the OS achieves
nothing.

	The "usual" way to do this is to use encrypted storage space. The
problem there is that you've got to have an unprotected way for the system
to bootstrap. Catch-22.

	This is usually dealt with by placing the unprotected component on
a removable device. Then, it's only vulnerable at the time when an
authorised person is present. In theory. In reality, all you're doing is
shifting the problem, not solving it.

	How to solve the problem? This isn't as hard as it sounds. Trying
to stop the unstoppable is an obvious impossibility. So, instead of being
a follower of King Canute, it makes more sense to =assume= that someone
can/has tampered with the HW, and figure out how to limit the damage.

	That -is- a solvable problem. If the OS is segmented, with each
segment itself constrained by mandatory access controls, then tampering
with the OS won't achieve much, without disabling the MAC first. And if
the MAC is part of the mechanism which permits the OS to do anything, then
disabling it disables the OS. Hmmm.

	It's true that NO protection, however good, will be 100%
effective. That's why it's better to concentrate on damage limitation
systems and compartmentalization, so that damage is always confined.

	In summary, the DEFAULT privilage, regardless of the method of
access, or what OS is used, should be that the user cannot read the data
on the disk. ONLY through active, specific, deliberate permission should
any other privilage be possible. THEN, you have as much security as you
can realistically achieve.

Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
