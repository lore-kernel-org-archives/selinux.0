Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOGZsRb008904
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 11:35:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAOGZFp5013338
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 16:35:15 GMT
Received: from smtp1.su.se (smtp1.su.se [130.237.162.112])
	by jazzswing.ncsc.mil  with ESMTP id hAOGZEt0013335
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 16:35:14 GMT
Message-Id: <3.0.32.20031124113541.00aedb98@mail.dsv.su.se>
Date: Mon, 24 Nov 2003 11:35:42 -0500
To: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
From: Sead Muftic <sead@dsv.su.se>
Subject: Re: smart cards
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell:

>Anyone working on smart-card support for SE Linux?

My answer to you is "Yes", but it needs some clarifications.

The first problem with smart cards on Linux machines are SC and reader
drivers. We tried to activate
M.U.S.C.L.E. drivers, we worked on this on-and-off several months and we
didn't reach the point of 
smooth installation, then activation.

Just to mention that we have developed SC middleware (compliant with OCF
and US Gov't GSC-IS, v 2.0), 
so "underneath" we can plug multiple drivers, only if they work. This means
that some alternative
drivers, if you know of some, can be relatively easily "plugged" under our
middleware.

Finally, we have in fact developed nice, easy-to-use, GUI system to
administer all aspects
and entities of SELinux which performs SELinux admin functions at the click
of the button.
The first version was "single machine" version, i.e. it had to be located
on the same machine
as SELinux being administered. Now, we are in the final phase of testing
the networked version.

This SELinux admin interface can use smart cards for login and remote
commands security (based 
on SSL). However, due to problems with SC drivers it runs only on Windows
(sorry !). 


>
>I think it's something we need for the future, but at the moment I don't
know 
>anyone who is using such hardware and have no access to it myself.  If 
>someone is using smart cards and can tell me what needs to be done then I
can 
>start planning what we need for SE Linux policy to support it.
>


As far as policy is concerned, we are following Certification Policy,
compliant with Federal
Bridge CA, but it regulates only issuance of cards, technical parameters
for those cards and rules
of handling certificates, not much related to SELinux, for the time being.

Regards,

Sead Muftic
SETECS
Rockville, MD



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
