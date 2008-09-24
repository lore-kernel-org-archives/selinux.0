Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8O0gE2i018175
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 20:42:14 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8O0fGAY016621
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 00:41:17 GMT
Message-ID: <48D98CCE.4050301@ak.jp.nec.com>
Date: Wed, 24 Sep 2008 09:41:50 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Paul Howarth <paul@city-fan.org>
CC: Mike Sweetser - Adhost <mikesw@adhost.com>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	<17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan> <20080924012131.76c5e84f@metropolis.intra.city-fan.org>
In-Reply-To: <20080924012131.76c5e84f@metropolis.intra.city-fan.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Howarth wrote:
> On Tue, 23 Sep 2008 16:32:16 -0700
> "Mike Sweetser - Adhost" <mikesw@adhost.com> wrote:
> 
>> James,
>>
>> The following command set should give you what you want:
>>
>> grep '^SELINUXTYPE' /etc/selinux/config | awk '{split($0,a,"="); print
>> a[2];}'
>>
>> When run against my targeted setup on RHEL 5.2, it gave me back
>> "targeted".
> 
> There's also the "sestatus" command:
> 
> # sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy version:                 21
> Policy from config file:        targeted
> 
> Paul.

selinux_getpolicytype() is available to obtain the current policy type.
(It paerses /etc/selinux/config.)

But, there is no reasonable way to obtain the list of policy types.
Perhaps, I misunderstood the matter. :-)

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
