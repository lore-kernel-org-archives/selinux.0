Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20081
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:54:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA09272
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:54:30 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id PAA09268
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:54:25 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524389@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Frank Mayer'" <mayerf@tresys.com>,
        NSA Selinux Mailinglist
	 <selinux@tycho.nsa.gov>
Subject: RE: Proposal: install policy.conf
Date: Fri, 24 May 2002 10:54:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

on Friday, May 24, 2002 10:42 AM Frank Mayer wrote:

> I suggest that policy.conf be installed in /etc/security as the "official
> installed" policy (rather than /ss_policy), that load_policy or equivalent

I, Russell Coker and Howard Holm have gone through a lengthily
discussion on where things go. 

We have settled on the following directory for the policy files.
/etc/selinux/policy

In this directory you will find policy.conf file
/etc/security/policy/policy.conf

/ss_policy is the binary compiled version of policy.conf
and that has been moved to /etc/security/selinux/policy.9

where .9 is the current version of the compiled policy.


Mark Westerman 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
