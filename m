Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B1DqrT003383
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 21:13:52 -0400 (EDT)
Received: from TYO202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B1DlaH001193
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 21:13:48 -0400 (EDT)
Message-ID: <004d01c44f51$543a2ae0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: <linux-ia64@vger.kernel.org>, <selinux@tycho.nsa.gov>
Cc: "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0406101657420.8385-100000@thoron.boston.redhat.com>
Subject: Re: [PATCH] Kernel panic on IA-64 Linux with SELinux
Date: Fri, 11 Jun 2004 10:13:38 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> Were you using a standard kernel, or was this a vendor or otherwise 
> patched kernel?  I know people have booted IA64 with SELinux enabled in 
> recent times with no problems.

Yes, I booted up both of the standard kernel (2.6.6) with both of the previous patches.
SELinux was configured to the Permissive-mode.
(I have not tried to boot up with the Enforcing-mode.)

I'm interested in the case you mentioned.
In my experience, kernel panic always occurs while booting up.
What is written in /etc/sysconfig/selinux?
--------
Kaigai Kohei, Linux Promotion Center, NEC
E-mail: kaigai@ak.jp.nec.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
