Message-Id: <200207291631.QAA11082@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: security context of kapmd and others
Date: Mon, 29 Jul 2002 18:32:58 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

After  a ps ax --context, I see that some kernel daemons don't run in the 
kernel_t domain. On my SuSE are this kreiserfsd, keventd and kapmd.

Where can I change the settings to move this daemons to the kernel_t 
domain. I don't found any settings for this.

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
