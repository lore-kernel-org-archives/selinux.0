Date: Wed, 27 Jun 2001 09:37:20 -0400
From: "Ward, Robert D" <robert.d.ward@lmco.com>
Subject: RE: Slackware
To: "'john.rh@hushmail.com'" <john.rh@hushmail.com>, SELinux@tycho.nsa.gov
Message-id: <B1B0DD19298CD41195A600508BF9067A02C14F24@emss04m08.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good Morning,

I am running Slackware 7.0 with SE Linux on a home PC.  It seems to be
working fairly well, but I did have some difficulties on the installation as
described below.  If you have any specific questions I would be happy to
help.  Please bear in mind that my experience level is "enthusiastic
amateur", so I haven't really tried anything too challenging on the system.


I was working with Slackware 7.0 and the March 15th release of the SE Linux
source code.  These were the steps that I had to use to get the kernel to
compile on my system.

1.	 Link /usr/include/linux to /usr/src/slinux/kernel/include/linux

2.	 /usr/include/linux/errno.h should have a reference the following
include file in the headers :
#include </usr/src/linux/kernel/include/asm>

	3.  Create a link /usr/src/slinux/kernel/include/asm and point it to
./asm-i386
	
3.	run ./buld-kernel , and then ./install-kernel.  

After running the installation script for the kernel, I had to edit
lilo.conf manually.  For this I had to rely on earlier posts by Mr. Smalley
(Re: Can I compile NSA Linux 2.4.2 kernel the same way I do a the normal
2.4.2 kernel?, dated 3/30/01) and Mr. McCall (RE: Can I compile NSA Linux
2.4.2 kernel the same way I do a the norm	al 2.4.2 kernel?, dated
3/29/01).  

I still have problems getting the tools to install, but that should work for
the kernel.  When you do a uname -a after finishing, it should show the
FLASK kernel.  Hope this helps.



Respectfully,
Beau Ward

This email may contain Lockheed-Martin Management and Data Systems
confidential and privileged material for the sole use of the intended
recipient.  
Any review or distribution by others is strictly prohibited.  
If you are not the intended recipient please contact the sender and delete
all copies.



Management and Data Systems
(703) 293-4533
Robert.D.Ward@lmco.com <mailto:Robert.D.Ward@lmco.com> 


	-----Original Message-----
	From:	john.rh@hushmail.com [SMTP:john.rh@hushmail.com]
	Sent:	Tuesday, June 26, 2001 8:43 PM
	To:	SELinux@tycho.nsa.gov
	Subject:	Slackware

	I'm pretty new to the list (as of last week), so forgive me if i'm
being 
	ignorant of topics already covered.

	Has there been much success in using SELinux with the Slackware
distribution?
	Comments on using SELinux with Slackware are GREATLY appreciated!

	-john
	Free, encrypted, secure Web-based email at www.hushmail.com
	

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
