Message-ID: <4A9F24D2.9020805@ak.jp.nec.com>
Date: Thu, 03 Sep 2009 11:07:14 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [PATCH] libselinux: disable refcounting in the userspace AVC
References: <4A9DE7FE.9000008@tycho.nsa.gov>	 <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil>	 <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com> <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>> IIRC sepostgres reimplemented its sidtab and avc because our current one
>> wasn't very friendly to multithread/multiprocess object managers.
> 
> Looking back, I think KaiGai's reasons were:
> - he didn't see benefit to the indirection of the AVC SID table since
> PostgreSQL has to directly manage security contexts for persistent
> labeling,

Yes, it uses object identifier which is associated with a certain
text representation of security context as a key to lookup its
userspace avc.

> - he wanted to enable sharing of the AVC (via shared memory) and the
> netlink thread among all PostgreSQL instances (processes, not just
> threads).

The pgsql-hackers didn't like an idea to deploy userspace avc on the
shared memory segment, so I had to change its implementation.
Now, it put only a flag to notice avc invalidation for all the server
processes. A background netlink process updates the flag on the shared
memory segment, then other server processed voluntarily invalidates its
userspace avc deployed on the process local memory prior to looking up.

In addition, characteristic of database workload enables to apply more
optimization in the performance perspective.
The subject security context of the userspace avc deployed on the process
local memory is unchanged (except for trusted procedure execution),
so SE-PostgreSQL categorizes all the avc entries by subject context to
omit comparison of subject context.
(Note that subject context is not database object, so it does not have
object identifer. It requires strcmp() to compare subject context.)

Because the database workload (with row level security) needs to lookup
the avc entry massive times in a short time, this kind of optimization
is very important. At the past, I tried to compare subject context to
lookup avc entry, then it recorded 50% of transaction-per-second toward
the vanilla PostgreSQL. :(

Thus, now, it is not necessary to consider use cases in SE-PostgreSQL
to update userspace avc stuff in libselinux.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
