Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5T0J5K5013308
	for <selinux@tycho.nsa.gov>; Sun, 28 Jun 2009 20:19:06 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5T0JctA004982
	for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2009 00:19:39 GMT
Message-ID: <4A480871.5050403@ak.jp.nec.com>
Date: Mon, 29 Jun 2009 09:18:57 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Kramer <josh@globalherald.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Can RHEL 5 set Context of Threads?
References: <alpine.LFD.2.00.0906280155390.13671@home-av-server.home-av>
In-Reply-To: <alpine.LFD.2.00.0906280155390.13671@home-av-server.home-av>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Kramer wrote:
> 
> Hello,
> 
> In this document, KaiGai outlines his SELinux Apache module.
> 
> http://code.google.com/p/sepgsql/wiki/Apache_SELinux_plus
> 
> Under the 'Internals' section, he notes that kernel versions > 2.6.28 
> have the capability to set an individual security context for each thread.
> 
> Has RedHat backported this capability to the 2.6.18 included with RHEL5? 
> Or do we have to wait for RHEL6?
> 
> Thanks!
> -Josh

As Stephen noted here,
  http://marc.info/?l=selinux&m=124265539924989&w=2

It also requires libsepol >= 2.0.34 and checkpolicy >= 2.0.17 to build
and install security policy module with bounds domain.

I'm not a person in RedHat, however, it seems to me it is better to wait
for RHEL6 rather than porting them into RHEL5 from now.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
