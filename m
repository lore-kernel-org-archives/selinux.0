Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07459
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 08:46:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23670
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:45:23 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id NAA23666 for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:45:18 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242C9@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: gdm
Date: Mon, 11 Feb 2002 07:46:15 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I orginaly ported the gdm to selinux. The apm_bios 
is access by XFree86. I am not really sure what the 
XFree86 is doing with the bios, I can only guess it 
is trying to gather information about the graphics card
or looking at the screen saving information (i.e blank
the screen when not in use).

Have you include the code in the xdm to login a 
user ? 

Mark

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Sunday, February 10, 2002 11:51 PM
To: SE Linux
Subject: gdm


The gdm.te file gives gdm access to apm_bios, why is this?

I am thinking of creating some SE policy files which include a macro for xdm

type programs (there are about a dozen xdm type programs which are mostly
the 
same in terms of SE issues so they can use almost the same config apart from

minor issues such as apm_bios).

Or should we just make it xdm.te and have lots of comments of the form 
"uncomment this for gdm" for the rules that are specific to a particular dm?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

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
