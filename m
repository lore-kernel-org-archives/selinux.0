Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA06127
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 12:46:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA05532
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 16:46:01 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id QAA05524
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 16:46:00 GMT
Date: Thu, 8 Aug 2002 11:46:49 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208081646.LAA04533@tomcat.admin.navo.hpc.mil>
To: jwalters@eng.uiowa.edu, <selinux@tycho.nsa.gov>
Subject: Re: Console typing frequency authentication
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Jesse D. Walters" <jwalters@eng.uiowa.edu>:
> 	Hi, I am not sure if this is the correct mailing list for this
> topic, so pardon me in advance.
> 	I was wondering if anyone is working on, or has investigated
> creating a authentication method that not only verifies a users password
> when logging in from the console, but also analyses the speed which a user
> types his or her password.
> 	I already see a problem with a standard keyboard buffering the
> characters between interupts, but I thought it was an interesting idea,
> maybe for my Electrical Engineering senior design project.
> 	Thank you.

This is not really usefull - Most logins are done over a net and the
keystroke arrival rate varies due to network latency. On local login (console)
the latency depends on the interface - a number of interfaces support a
queue of 1-4 scan codes, which are then tranlated to characters which are
put in a queue. The application may recieve from 1-4 characters in one
transaction (even using a read(buf,1,..) causes other latencys in addition:
context switching rate, general system load, ....

Not to mention that the timestamps you need to use will be smaller than
the clock counts (when the batch of characters suddenly show up), and are
not associated with when the scan codes were recieved.

Another issue related to network based logins - it is entirely possible
to copy/paste the password into the login window... there is zero latency
in this case, since the entire string is passed in a single message.

Now, a custom keyboard that can take a timestamp of when the key is pressed,
pass the scan codes + timestamp to the driver, and have the driver and
application know how to pass the characters + timestamp to the application
just might work. But then - since the keyboard is external to system, the
entire thing could be spoofed via an external wiretap on the keyboard cable.

This is the same problem with the "smart card" readers and fingerprint
scanners. And the fingerprint scanners have yet more problems....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
