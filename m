Message-ID: <20050118061124.94277.qmail@web51506.mail.yahoo.com>
Date: Mon, 17 Jan 2005 22:11:24 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: How SELinux label packet by default?
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  In initial_sid_contexts, there seems no default
packet SID. Then, 
  (here, let's don't take IPsec protection into
account)
  1) When a packet is sending or receiving, Does
SELinux label the packet and then control the
sending/receiving packet according to the label? or
just ignore it?
  2) When an unlabeled packet is received from a node,
What default packet SID will SELinux set to the packet
? 
  Is it still be as "When a message is sent on a
socket, it inherits the SID of the sending socket by
default. When the network component receives a message
from the network, the SID of the message is initially
set to a default message SID associated with the
receiving network interface." as is described in
subsection 8.1.1 of "Integrating Flexible Support for
Security Policies into the Linux Operating System"

  Thank you.

=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
