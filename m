Message-Id: <200209171901.TAA20518@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: privfd attribute
Date: Tue, 17 Sep 2002 21:02:35 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

the privfd attribute is ofter use in the policy. But I don't understand why 
we create and use this attribute. 
And why don't we use it like e.g. the privlog attribute? Privlog is 
declared in attrib.te, get his rights in syslogd.te and often use in domain 
declarations. Is the same way for privfd not possible? This could simplify 
the rules. Or?

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
