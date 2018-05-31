To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
 <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
 <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <71925d61-743e-76a1-b0dd-1948468e2773@sony.com>
Date: Thu, 31 May 2018 16:12:11 +0200
MIME-Version: 1.0
In-Reply-To: <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable holds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2018 02:42 PM, Stephen Smalley wrote:
> On 05/31/2018 05:04 AM, peter enderborg wrote:
>> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>>> The boolean change becomes a lot more heavy with this patch,
>>>> but it is a very rare usage in compare with read only operations.
>>>> The lock held during a policydb_copy is about 1ms on a XEON.
>>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
>> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
>> We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
>> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
>> a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
>> with lot of atomic allocation and large vmallocs.
> Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
> Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.
>
> I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.

On the version 2 of the patchset you pointed out that I did a shallow copy, so I did a "deap" copy. As I see it the KaiGai cond_policydb_dup also do a shallow copy.
You dont happend to know exactly why KaiGai's patch never was accepted?

>  But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
>> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
>> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
>> is policydb_destroy() of the old copy.
>
>
>
