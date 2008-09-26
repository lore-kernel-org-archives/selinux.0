Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8Q3pLqO027773
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 23:51:21 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8Q3pJWa019049
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 03:51:20 GMT
Message-ID: <48DC5C16.9040607@ak.jp.nec.com>
Date: Fri, 26 Sep 2008 12:50:46 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>            <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>
In-Reply-To: <9546.1222400049@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 24 Sep 2008 09:18:16 +0900, KaiGai Kohei said:
>> James Morris wrote:
>>> Is there a programmatic way to determine the type of SELinux policy 
>>> configured on a system? (e.g. "targeted")
>>>
>>> I've looked in the SELinux userspace and SETools repositories but not 
>>> found a library call to do this.
>> I also want to know the way to obtain the list of policy types,
>> because it is necessary to make a specfile which provides policy
>> modules.
> 
> There be dragons here. :)
> 
> Keep in mind that the list of available policies on the machine that you
> create an RPM spec file and do the 'rpmbuild' may differ from the actual
> install environment.  So keep straight your Requires: and Build-Requires: ;)

Don't worry. I actually maintain the specfile of sepostgresql package
that provides its security policy modules. :)
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
