Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA28324
	for <selinux@tycho.nsa.gov>; Wed, 12 Jun 2002 07:21:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA00116
	for <selinux@tycho.nsa.gov>; Wed, 12 Jun 2002 11:21:34 GMT
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by jazzswing.ncsc.mil  with ESMTP id LAA00112
	for <selinux@tycho.nsa.gov>; Wed, 12 Jun 2002 11:21:33 GMT
Message-ID: <3D073122.1100B64B@dr-baldeweg.de>
Date: Wed, 12 Jun 2002 13:31:46 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: mingetty on SuSE
References: <Pine.GSO.4.33.0206101259260.13767-100000@raven>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I mean this is a SuSE specific problem. Today I rebuild the source rpm
"mingetty-1.00-1.src.rpm" from rpmfind.net and replay the suse file with
this package. It works fine. I do not get follow log entries:
"May 10 07:51:07 myserver mingetty[231]: cannot open(/proc/2/maps):
Permission denied"
I recommend all SuSE users to replace the mingetty programm.

Carsten

Stephen Smalley schrieb:
> 
> On Mon, 10 Jun 2002, Carsten Grohmann wrote:
> 
> > I use mingetty on my SuSE 7.1. Mingetty needs read access to many
> > different types in the proc directory to run correct.
> > Now me question: Is it possible to limit the access to the different
> > types only to the proc directory? I think no, but I hope anyone has an
> > solution. In the other case I can not get mingetty the permissions,
> > because it can read to much files. What getty programs do you use?
> 
> mingetty also runs on our machines, but I don't see this behavior.
> I assume that you mean that mingetty is probing the /proc/PID entries, and
> thus you are seeing audit messages for the various domains.  Unless
> mingetty truly needs access to other domains' /proc/PID files, I'd suggest
> using dontaudit (or auditdeny, if you haven't applied the dontaudit
> patch) rules to suppress the audit messages but continue denying access.
> See the xdm.te file or the user_macros.te file for examples.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
