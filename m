Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8U86Zu0009110
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 04:06:35 -0400
Received: from goalkeeper.city-fan.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8U85ViI024859
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:05:32 GMT
Message-ID: <48E1DDEB.8070506@city-fan.org>
Date: Tue, 30 Sep 2008 09:06:03 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Dominick Grift <domg472@gmail.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: sepostgresql.pp conflicts on F9 (Re: How to find SELinux	policy
 type?)
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	 <48DC5C16.9040607@ak.jp.nec.com>	 <1222421896.24783.7.camel@sulphur.notebook.internal>	 <48DCB88E.3080503@kaigai.gr.jp>	 <1222425714.24783.13.camel@sulphur.notebook.internal>	 <48DCE45B.3040900@kaigai.gr.jp> <48DE5718.2050404@kaigai.gr.jp>	 <48E1A8BF.6060107@ak.jp.nec.com> <1222759447.29878.3.camel@sulphur.notebook.internal> <48E1DAAC.6040403@ak.jp.nec.com>
In-Reply-To: <48E1DAAC.6040403@ak.jp.nec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Dominick Grift wrote:
>> On Tue, 2008-09-30 at 13:19 +0900, KaiGai Kohei wrote:
>>> Dominick,
>>>
>>> Show the package:
>>>   http://koji.fedoraproject.org/koji/buildinfo?buildID=64748
>>>
>>> It will be able to help your matter.
>> hello
>>
>> sh-3.2# rpm -Uvh sepostgresql-8.3.4-2.1067.fc9.x86_64.rpm
>> error: Failed dependencies:
>> postgresql-server = 8.3.4 is needed by
>> sepostgresql-8.3.4-2.1067.fc9.x86_64
> 
> It will be released soon, but not uploaded to Fedora 9 updates repository yet.
> You can obtain the latest updates package from:
>   http://koji.fedoraproject.org/koji/buildinfo?buildID=64273
> 
> In addition, it requires selinux-3.3.1-96.fc9 packages from:
>   http://koji.fedoraproject.org/koji/buildinfo?buildID=64649
> (But I don't know whether Dan want to push it to Fedora9 updates, or not.)
> 
> If you cannot wait for several days, plese obtain these packages by hand,
> and apply them as follows:
>   # rpm -Uvh sepostgresql-8.3.4-2.1067.fc9.x86_64.rpm   \
>              postgresql-*8.3.4-1.fc9.x86_64.rpm         \
>              selinux-policy-*3.3.1-96.fc9.noarch.rpm
> 
> BTW, there are no actual problem to mix postgresql-server-8.3.3 and
> sepostgresql-8.3.4, because they has same major version number (8.3.x).
> However, specfile of RPM does not allow to write a dependency to a part
> of version number like "Requires: postgresql-server-8.3.*".
> If someone knows the way to describe it cool, please tell me.

Perhaps this?:

Requires: postgresql-server >= 8.3
Conflicts: postgresql-server >= 8.4

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
