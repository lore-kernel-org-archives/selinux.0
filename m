Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00871
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:27:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA25387
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:27:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA25383
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:27:11 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11200
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:27:12 -0500 (EST)
Date: Tue, 13 Mar 2001 11:27:11 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200103131627.LAA05837@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: 2.4.x porting
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Justin Ramos wrote:

> I'd like to be involved with porting SE Linux to the Linux 2.4.x kernel.
> I have extensive knowledge of the C programming language, the Linux
> kernel, and coding for Linux systems, and would like to contribute in
> any way possible to this project. Any information as to how to go about 
> doing this would be greatly appreciated. Thank you.

Thank you for your offer. The port is essentially done, and will be available soon. A few things that haven't been done but would certainly make SELinux better are:

 - Support for other file systems besides Ext2
 - Adding controls to IPv6 like the ones in IPv4

--
Pete Loscocco, NSA
pal@tycho.ncsc.mil

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
