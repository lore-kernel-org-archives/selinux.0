Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA02142
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 09:01:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA05989
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 13:00:56 GMT
Received: from csoc-fire05.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzband.ncsc.mil  with SMTP id NAA05971
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 13:00:53 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152420A@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Conan Callen'" <ccallen@windowpane.com>, selinux@tycho.nsa.gov
Subject: RE: debugging tools
Date: Fri, 5 Oct 2001 08:01:19 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you are trying to debug the kernel. You might want to
try uml (user mode linux) run linux as a process. I have 
not tried selinux on that yet, from my understanding it
is great for debugging kernel problems.


Mark Westerman
mark.westerman@csoconline.com

-----Original Message-----
From: Conan Callen [mailto:ccallen@windowpane.com]
Sent: Thursday, October 04, 2001 12:05 PM
To: selinux@tycho.nsa.gov
Subject: debugging tools


I want to start stepping through the selinux / lsm code so I can see what
is happening. Does anyone have any recomendations on kernel debugging
tools for doing this? I've been using vstudio on windows for years and the
windows sdk debugger for working with kernel code. So far the only
tool used on linux are emacs and vi ;)

Conan


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
