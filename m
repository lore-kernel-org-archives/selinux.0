Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3ABUUNZ027002
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 07:30:31 -0400
Received: from car-mbus-sw2.mbs.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3ABURIR012289
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 11:30:29 GMT
Received: from mail.mbs.edu (car-mbus-cn2 [10.2.2.9])
	by car-mbus-sw2.mbs.edu (Postfix) with ESMTP id 7210215EA04
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 21:30:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Tue, 10 Apr 2007 21:30:23 +1000
Message-ID: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local>
From: "John Wan" <J.Wan@mbs.edu>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am new to SELinux, I would like to configure the SELinux (on a Linux
box running RH EL AS4 ) to work as a Proactive IPS device (such as
TippingPoint Intrusion Prevention Systems--- Proactive Network Security,
it would cost about $20K, which is way beyond my budget). I wish the
SELinux would work as an IPS device to protect our staff network from
our wireless network (the Linux RH EL AS4 box with Chillispots & SELinux
connects the staff network and the wireless network).  For example, a
student wireless laptop with a Trojan virus would not be able to go
through the Linux box (with Chillispots &SELinux) from the wireless
network to the staff network. This is because of the SELinux would act
as a TippingPoint IPS to block the nasty Trojan traffic. 

 My question is: Is this possible? 

I also realise the SELinux approach is totally different from the most
security products in the anti-virus and intrusion prevention and
detection markets. 

Anti-virus and IDS/IPS systems based on signatures are reactive,
operating only on known threats, which is why zero-day exploits are so
prized by malware authors.

SELinux, on the other hand, can be compared to a firewall with a default
"deny any" rule, and a set of "allow" rules to only permit actions that
are necessary for proper system operation.

My ultimate goal is to use the SELinux policy to block the abnormal
network traffic (such as a Trojan virus) from one network to another
network. Or the Linux box would be able to stop the contagious network
traffic in the wireless network by using the SELinux policy. 

Is that possible? Or am I terribly wrong here?

Any information and help would be much appreciated.

Many thanks in advance,

John Wan



--
_______________________________________________________________________________

 

Notice from Melbourne Business School Ltd 


The information contained in this e-mail is confidential, and is intended for
the named person's use only.  It may contain proprietary or legally privileged
information. If you have received this email in error, please notify the
sender and delete it immediately.  You must not, directly or indirectly, use,
disclose, distribute, print, or copy any part of this message if you are not
the intended recipient

Internet communications are not secure. You should scan this message and any
attachments for viruses. Melbourne Business School does not accept any
liability for loss or damage which may result from receipt of this message or
any attachments.

______________________________________________________________________________ 



 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
