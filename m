Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18546
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2001 08:59:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id NAA11558
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2001 13:57:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id NAA11554
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2001 13:57:57 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id IAA17221
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2001 08:58:47 -0500 (EST)
Date: Thu, 18 Jan 2001 08:58:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: porting to 2.4?
In-Reply-To: <Pine.LNX.4.21.0101011054260.7964-100000@mail.thesportsregister.com>
Message-ID: <Pine.SOL.3.95.1010118083037.16394C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


We have started work on porting to the 2.4 kernel.  The new 
operating system components added by the Flask architecture
(the security server and the access vector cache) have been ported.
The support for labeling processes and file-related objects
has also been ported.  The port of process and file-related 
mandatory access controls is underway, as is the port of the
network-related labeling.  So far, the port has been relatively
straightforward.

If you have reviewed the design and implementation of the Flask 
security changes for the 2.2 kernel and have any constructive
suggestions (or even improved implementations) for future versions, let us
know. Likewise, if you have experimented with using the system and have
any constructive suggestions, let us know.

If you want to tackle some aspect of the port, whether porting
existing code, improving the implementation of some existing code,
designing and implementing similar controls for some aspect of the kernel
that we haven't covered (especially new features in the 2.4 kernel
like devfs), then let us know.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
