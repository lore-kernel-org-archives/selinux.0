Message-ID: <48B4A9AA.5000705@ak.jp.nec.com>
Date: Wed, 27 Aug 2008 10:11:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, paul.moore@hp.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>  <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>  <487D5A3D.6090801@ak.jp.nec.com>  <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>  <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>  <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>  <4897EB5A.1040404@ak.jp.nec.com>  <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>  <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com> <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil> <48B2A669.7040800@ak.jp.nec.com> <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Mon, 25 Aug 2008, KaiGai Kohei wrote:
> 
>> @@ -5228,11 +5232,14 @@ static int selinux_setprocattr(struct task_struct *p,
>>  			do_each_thread(g, t) {
>>  				if (t->mm == mm && t != p) {
>>  					read_unlock(&tasklist_lock);
>> +					if (!security_bounded_transition(tsec->sid, sid))
>> +						goto boundary_ok;
>>  					return -EPERM;
> 
> Propagate the return value of security_bounded_transition().

OK, I'll fix it on the next.

> Also, if the user/role bounds are not being used, should they be included 
> in this?  From the kernel point of view, unused code should never be 
> added.

Existing named based hierarchy on users/roles are implemented using bounds
feature. If a user "staff_u.foo" is defined, the toolchain implicitly defines
bounds relationship with "staff_u", for example.

I don't provide an explicit way to define bounds (like TYPEBOUNDS) between
users/roles, but we can define it with existing grammar.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
