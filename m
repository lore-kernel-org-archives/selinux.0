Message-Id: <200211201845.SAA06177@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: multiple dontaudit rules
Date: Wed, 20 Nov 2002 19:46:43 +0100
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

in "Configuring the SELinux Policy" at point 4.2.5 wrote:
"If multiple allow or auditallow access vector rules are specified for a 
given type pair and class, then the union of the permission sets is used. 
If multiple dontaudit rules are specified for a given type pair and class, 
then the intersection of the permission sets is used. "

I am not sure but could it be better to handle multiple dontaudit rules in 
the same way as the multiple allow rules. In my eyes, there isn't a good 
reason to make a union of the one and a intersection of the others.

Or?

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
