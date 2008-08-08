Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78Gq5pa011285
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 12:52:05 -0400
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78Gq4qp001680
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 16:52:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: Mike Edenfield <kutulu@kutulu.org>
Subject: Re: Help: SELinux causing(?) boot failures...
Date: Fri, 8 Aug 2008 12:51:45 -0400
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <489C6A4F.3020704@kutulu.org>
In-Reply-To: <489C6A4F.3020704@kutulu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808081251.45453.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 August 2008 11:46:23 am Mike Edenfield wrote:
> The reason I strongly suspect SELinux is the problem (or at least a
> major factor), is that adding "selinux=0" to my boot command line
> corrects the problem, and the system boots fine.  Everything appears
> to be installed and configured correctly, except obviously SELinux is
> now disabled.  The filesystems are all labeled correctly, and even on
> the failing boot the AVC messages display the correct labels, like
> tty_device_t and urandom_device_t.

Hi Mike,

In general, you are better off using "enforcing=0", which keeps SELinux 
enabled but puts it into permissive mode, on the kernel command line 
instead of "selinux=0", which disables SELinux entirely.  Have you 
tried rebooting with "enforcing=0" and capturing the AVC messages from 
the console/audit/syslog output and seeing if anything looks awry?  If 
not go ahead and do so and send them to the list, this will tell us 
what actions are being denied and why.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
