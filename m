Message-ID: <48B2B765.6050702@kaigai.gr.jp>
Date: Mon, 25 Aug 2008 22:45:09 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, jmorris@namei.org, paul.moore@hp.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>	 <4897EB5A.1040404@ak.jp.nec.com>	 <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>	 <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com>	 <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>	 <48B2A669.7040800@ak.jp.nec.com> <1219669066.2721.68.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219669066.2721.68.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-08-25 at 21:32 +0900, KaiGai Kohei wrote:
>> The following patch is revised one for kernel.
>>
>> Updates:
>>  - This patch is rebased on James's security-testing-2.6 tree.
>>  - security_bounded_transition() is deployed just after read_unlock()
>>    within do_each_thread() { ... } while_each_thread() loop again.
>>  - The properties of type_datum are packed within the third word of
>>    type entries in the kernel policy.
>>  - Bounds checks on constraints are integrated within avc creation.
>>    Lazy bounds checks are invoked at the tail of context_struct_compute_av(),
>>    and it drops all of boundary violated permissions. It compares permissions
>>    of a bounded type based on both of TE and constraints by a bounds type in
>>    same time, so the bounded type always cannot have any wider permission than
>>    its parent.
>>    e.g)
>>      When a type of child_t is bounded by parent_t and has mcssetcats attribute,
>>      we cannot assign undominated categories because parent_t is not allowed to
>>      assign them and it bounds permissions of child_t.
>>  - Sanity checks for constraints are removed by the above reason.
> 
> This looks good to me in terms of the functionality.
> Have you run any benchmarks to assess the performance impact on AVC
> misses?

Not yet.
I'll measure it tomorrow, please wait for a while.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
