Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA23611
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 16:44:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA06977
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 21:44:03 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA06973
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 21:44:03 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA14669
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 16:44:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA23506
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 16:33:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA21265
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 21:32:00 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA21261
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 21:31:59 GMT
From: "LA Walsh" <law@sgi.com>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        "Stephen Smalley" <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Date: Fri, 12 Jan 2001 13:31:39 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCEBDCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200101112310.RAA87961@tomcat.admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> That is true for some security policies, not for others. POSIX is/was
> based on the TSEC description, which is a very black/white model. It
> does not support a more complex model such as a chinese wall structure.
---
	No?  User1 wants to access the Firm-A defense file.  Runs a transition
program that adds Firm-A to the user's mac-label division list.  Now any
files or users that are working on Firm-B defense files (which have gone
through the same transition to mac-label w/division "firm-b" added) are 
inaccessible to the User1.  User1 is now permanently banned from firm-b
files by having transitioned into a user with 'firm-a' access.

	Seems like that implements perfectly a chinese wall /conflict of
interest model.  

	To my mind MAC+capabilities + a transitions config file = "domain
or type enforcement".  I see the transitions file as being fairly easy to
maintain.  	

	MAC and capabilities are basic building blocks from which you can
build other security models.

	I'm told you can build MAC and capabilities from DTE with 
sufficient rules, and perhaps that is so, but it seems that set of rules
would be considerably more complex than a "transitions" file with which
to implement DTE or Chinese Wall.

-l




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
