Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OCdhgA016674
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 08:39:43 -0400 (EDT)
Received: from web60424.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4OCZ1Mp005776
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 12:35:01 GMT
Message-ID: <20050524123502.74451.qmail@web60424.mail.yahoo.com>
Date: Tue, 24 May 2005 05:35:01 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Moving target -- kernel version.
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am starting to feel a rising wave of frustration with producing a
reproducible script for installing selinux.

To do the install the kernel must be patched and rebuild.
To patch and build the source must be present
But which source???
  ? apt-get kernel-source-2.6.11     (version = 2.6.11-3)
  ? Distro version is not documented
     ? Kernel.org patches applied not documented
     ? Distro patches applied -- not documented
  ? /nsa/linux-2.6/    is what? Virgin kernel.org sourec ??
         nope, it changed since last CVS download a week ago (changes = 2168)
  
Right now I am diffing the /nsa/linux-2.6 and the apt-get kernel source.

Not sure what to do next for the best result.....



  

Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
