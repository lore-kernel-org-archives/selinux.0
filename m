Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20383
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 12:27:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA10941
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 16:27:04 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id QAA10937
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 16:27:03 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: Proposal: install policy.conf
Date: Fri, 24 May 2002 12:30:42 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMICENPKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524389@csoc-mail-box.csoconline.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I, Russell Coker and Howard Holm have gone through a lengthily
> discussion on where things go.
>
> We have settled on the following directory for the policy files.
> /etc/selinux/policy
>
> In this directory you will find policy.conf file
> /etc/security/policy/policy.conf
>
> /ss_policy is the binary compiled version of policy.conf
> and that has been moved to /etc/security/selinux/policy.9
>
> where .9 is the current version of the compiled policy.

That's fine...just to be clear, I'm interested in policy.conf being treated
as the officially installed policy, ot where it is put.  I don't have an
opinion on where it is installed (the version I'm using does not have
policy.conf installed), and at that point the use of ss_policy can be
considered an internal implementation detail by policy writers and tool
developers.

What I would hope we can avoid is installing the policy make directory, or
at least not requiring the make directory.  I suggest we think of the
current make structure as just one (of hopefully many to come) way to write,
edit and manage policies.

Frank



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
