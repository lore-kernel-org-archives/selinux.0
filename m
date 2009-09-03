Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n83725Us021094
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 03:02:05 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8373K7S002193
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 07:03:21 GMT
Message-ID: <4A9F69E8.3050303@ak.jp.nec.com>
Date: Thu, 03 Sep 2009 16:02:00 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Remmolt G. Zwartsenberg" <remmolt@zwartsenberg.eu>
CC: selinux@tycho.nsa.gov, henk.busscher@yahoo.com
Subject: Re: [PATCH] libselinux: disable refcounting in the userspace AVC
References: <4A9DE7FE.9000008@tycho.nsa.gov>	 <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil>	 <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com> <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil> <4A9F24D2.9020805@ak.jp.nec.com> <3660A45FD9BC4D52AA7737D1CF2F1F5E@CIMSLAB.NL>
In-Reply-To: <3660A45FD9BC4D52AA7737D1CF2F1F5E@CIMSLAB.NL>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remmolt G. Zwartsenberg wrote:
> Hi KaiGai,
> 
>>From a mediation and billing perspective, i agree with you.
> The Network Management part of the OSS system uses URL's that resolve to
> high-latency authentication, that need no encryption in the columns.
> 
> In VOIP tunnels this can lead to congestion, ie in 2-way Irridium
> conversations. Erroneous frame dragging?

Sorry, I'm not sure what do you want to discuss.

At the previous message, I introduced a workload inside of the PostgreSQL
which tend to lookup userspace avc with same subject context many times.
It is not a workload between the client application and RDBMS.

Thanks,

> Kind regards,
> 
> ~remmolt 
> 
> Philips NEC Business Commumication Systems NL
> 
> remmolt@zwartsenberg.eu 
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of KaiGai Kohei
> Sent: donderdag 3 september 2009 4:07
> To: Stephen Smalley
> Cc: Joshua Brindle; Eamon Walsh; SELinux List; KaiGai Kohei
> Subject: Re: [PATCH] libselinux: disable refcounting in the userspace AVC
> 
> Stephen Smalley wrote:
>>> IIRC sepostgres reimplemented its sidtab and avc because our current one
>>> wasn't very friendly to multithread/multiprocess object managers.
>> Looking back, I think KaiGai's reasons were:
>> - he didn't see benefit to the indirection of the AVC SID table since
>> PostgreSQL has to directly manage security contexts for persistent
>> labeling,
> 
> Yes, it uses object identifier which is associated with a certain
> text representation of security context as a key to lookup its
> userspace avc.
> 
>> - he wanted to enable sharing of the AVC (via shared memory) and the
>> netlink thread among all PostgreSQL instances (processes, not just
>> threads).
> 
> The pgsql-hackers didn't like an idea to deploy userspace avc on the
> shared memory segment, so I had to change its implementation.
> Now, it put only a flag to notice avc invalidation for all the server
> processes. A background netlink process updates the flag on the shared
> memory segment, then other server processed voluntarily invalidates its
> userspace avc deployed on the process local memory prior to looking up.
> 
> In addition, characteristic of database workload enables to apply more
> optimization in the performance perspective.
> The subject security context of the userspace avc deployed on the process
> local memory is unchanged (except for trusted procedure execution),
> so SE-PostgreSQL categorizes all the avc entries by subject context to
> omit comparison of subject context.
> (Note that subject context is not database object, so it does not have
> object identifer. It requires strcmp() to compare subject context.)
> 
> Because the database workload (with row level security) needs to lookup
> the avc entry massive times in a short time, this kind of optimization
> is very important. At the past, I tried to compare subject context to
> lookup avc entry, then it recorded 50% of transaction-per-second toward
> the vanilla PostgreSQL. :(
> 
> Thus, now, it is not necessary to consider use cases in SE-PostgreSQL
> to update userspace avc stuff in libselinux.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
