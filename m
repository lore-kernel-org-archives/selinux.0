Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37HicmV027045
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 13:44:42 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: "leon@leon.nu" <leon@leon.nu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 09/13] ib/core: Enforce PKey security when
 modifying QPs
Date: Thu, 7 Apr 2016 17:44:33 +0000
Message-ID: <DB5PR05MB11110D54B1903809091D5FBEC4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-10-git-send-email-danielj@mellanox.com>
 <20160407163100.GA5808@leon.nu>
 <DB5PR05MB111169883324ADC42E52C4D6C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160407173953.GB5808@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/7/2016 12:40 PM, leon@leon.nu wrote:
> On Thu, Apr 07, 2016 at 05:03:50PM +0000, Daniel Jurgens wrote:
>> On 4/7/2016 11:31 AM, Leon Romanovsky wrote:
>>> On Thu, Apr 07, 2016 at 02:33:54AM +0300, Dan Jurgens wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>> +		kfree(qp->qp_sec);
>>>> +
>>>> +	return err;
>>>> +}
>>>> +EXPORT_SYMBOL(ib_security_create_qp_security);
>>>> +
>>>> +void ib_security_destroy_qp(struct ib_qp_security *sec)
>>>> +{
>>>> +	security_ib_qp_free_security(sec);
>>>> +	kfree(sec);
>>>> +}
>>>
>>> Did you want to EXPORT_SYMBOL here too?
>>>
>>
>> It's not called from outside ib_core, I only exported the functions that
>> are. ib_security_modify_qp and ib_security_create_qp security are called
>> from ib_core and ib_uverbs.  ib_security_enforce_mad_agent_pkey_access
>> is called from ib_mad.
> 
> So, how are you releasing the memory which is taken by
> ib_security_create_qp_security ?

It is freed in ib_security_destroy_qp, which is called by ib_destroy_qp
after the QP is destroyed successfully.
