Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KNrHx6019844
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 18:53:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2KNrG9P016313
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 23:53:16 GMT
Received: from babylon.swishmail.com (babylon.swishmail.com [209.10.110.2])
        by jazzband.ncsc.mil  with SMTP id h2KNrFP7016305 for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 23:53:15 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: "Douglas Phillipson" <phillipd@oem.doe.gov>, <selinux@tycho.nsa.gov>
Subject: RE: Opinions on installing selinux on different distros, second try
Date: Thu, 20 Mar 2003 18:53:34 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMEEHECDAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E7A1FA6.1030604@oem.doe.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>-----Original Message-----
>From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
>Behalf Of Douglas Phillipson
>Sent: Thursday, March 20, 2003 3:08 PM
>To: selinux@tycho.nsa.gov
>Subject: Opinions on installing selinux on different distros, second try
>
>5) Has anyone had SELinux approved for use in a classified network?  If
>so do you have a security plan I could look at?

I would be surprised (pleasantly, of course) to learn of a blanket approval
for SELinux-based systems to process information in a classified
environment.  In any case, the C&A would be for more than just the OS, but
would need to cover the services and applications to determine if they pose
an "acceptable" risk for the level of network being considered.

I have passed a Vulnerability Analysis with a hardened unit running SELinux
(and my own policy files) that formed the basis of an IATC (Interim Approval
to Connect) to such a network, but I have not (yet) passed, say, a DITSCAP
evaluation.  However, probably 90% of my Security Template concerns the
applications that run on top of the OS, not the properties of the OS itself
(T.ROGUE_ADMIN being one of the main exceptions).

I'd be willing to explore the options for SELinux-based DITSCAP (EAL-2 seems
to be a no-brainer, and -3 doesn't seem to onerous) if anyone else is
contemplating the same, but it would probably need to be off-list.

Leslie French




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
