Message-Id: <200211031746.RAA13749@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: default_context file
Date: Sun, 3 Nov 2002 19:47:15 +0100
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've don't understand the new default_context file. Could anybody explain 
it? I understand the entries for login and ssh, but the line for the crond 
I to stupid.
The crond can use both partial context (user_r:user_crond_t and 
system_r:system_crond_t) but I don't unterstand the selection mechanism. 

Thanks

  Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
