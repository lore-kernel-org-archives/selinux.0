Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8O0Iuon015427
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 20:18:56 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8O0HwAY012180
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 00:17:59 GMT
Message-ID: <48D98748.6090408@ak.jp.nec.com>
Date: Wed, 24 Sep 2008 09:18:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> Is there a programmatic way to determine the type of SELinux policy 
> configured on a system? (e.g. "targeted")
> 
> I've looked in the SELinux userspace and SETools repositories but not 
> found a library call to do this.

I also want to know the way to obtain the list of policy types,
because it is necessary to make a specfile which provides policy
modules.

Thanks
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
