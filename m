From: Daniel Jurgens <danielj@mellanox.com>
To: James Morris <jmorris@namei.org>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v5 9/9] selinux: Add a cache for quicker retreival of PKey
 SIDs
Date: Tue, 22 Nov 2016 23:21:12 +0000
Message-ID: <VI1PR0501MB2429BE9BBEB80693B3136F98C4B40@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1479843638-67136-1-git-send-email-danielj@mellanox.com>
 <1479843638-67136-10-git-send-email-danielj@mellanox.com>
 <alpine.LRH.2.20.1611230948300.3895@namei.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2016 4:53 PM, James Morris wrote:
> On Tue, 22 Nov 2016, Dan Jurgens wrote:
>
>> +static int sel_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
>> +{
>> +	int ret = -ENOMEM;
>> +	struct sel_pkey *pkey;
>> +	struct sel_pkey *new = NULL;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&sel_pkey_lock, flags);
>> +	pkey = sel_pkey_find(subnet_prefix, pkey_num);
>> +	if (pkey) {
>> +		*sid = pkey->psec.sid;
>> +		spin_unlock_irqrestore(&sel_pkey_lock, flags);
>> +		return 0;
>> +	}
>> +
>> +	ret = security_pkey_sid(subnet_prefix, pkey_num, sid);
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>> +	if (!new)
>> +		goto out;
>> +
>> +	new->psec.subnet_prefix = subnet_prefix;
>> +	new->psec.pkey = pkey_num;
>> +	new->psec.sid = *sid;
>> +	sel_pkey_insert(new);
>> +
>> +out:
>> +	spin_unlock_irqrestore(&sel_pkey_lock, flags);
>> +	if (unlikely(ret))
>> +		kfree(new);
>> +
>> +	return ret;
> The error handling is messed up here.
>
> You'll return 0 on kzalloc failure.
>
> Also, if security_pkey_sid fails, you'll attempt to kfree 'new', and you 
> don't need an unlikely() in a slow path.
>
>
Right.  I'll remove the if/kfree in the out path completely.  There's no way ret becomes non-zero after the kzalloc.  If the kzalloc fails I'll still have it return 0, the SID retrieved is valid, it just won't be added the cache so returning with an error is overkill.

Thank you for your review.
