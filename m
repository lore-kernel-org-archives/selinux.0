Message-ID: <72222DC86846D411ABD300A0C9EB08A101524364@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'f980215'" <f980215@mailandnews.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: SELinux@tycho.nsa.gov
Subject: RE: Install SELinux RPM
Date: Thu, 25 Apr 2002 08:25:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I building the freeswan module for this rpm
package I ran into a problem
I name the Development Mode Kernel
with an EXTRAVERSION -selinux-dev

the -dev broke the rpm build of freeswan

I have since rename the EXTRAVERSION to selinuxdev

I will be uploading the new rpm package today.

Mark

PS: I also hope the upload the freeswan module
today.

 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
