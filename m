Message-Id: <200207261430.OAA20538@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: rules debuging 
Date: Fri, 26 Jul 2002 16:31:28 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HI!

this time I write to a rule set for isdn4linux with different domains.
The main domain contains domain_auto_trans to difficult subdomains e.g. to 
route_t. 
This works fine, but I get messages with file access to files and 
directories which route should not use. So I think my rules are not correct 
and I don't find the mistake.
Is there an possibility to "debug" the rule set and watch the program in 
the same time?

Thanks

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
