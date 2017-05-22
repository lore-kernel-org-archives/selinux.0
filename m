From: Daniel Jurgens <danielj@mellanox.com>
To: James Morris <jmorris@namei.org>
CC: Chris Wright <chrisw@sous-sol.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>, "sean.hefty@intel.com"
 <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v7 2/9] IB/core: Enforce PKey security on QPs
Date: Mon, 22 May 2017 10:42:22 +0000
Message-ID: <VI1PR05MB167814F66EEF8A1BD77C793AC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <1495198139-69993-3-git-send-email-danielj@mellanox.com>
 <alpine.LRH.2.20.1705220959450.3502@namei.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/21/2017 7:13 PM, James Morris wrote:
> On Fri, 19 May 2017, Dan Jurgens wrote:
>
>> security/security.c                  | 385 ++++++++++++++++++++++
> This looks wrong -- merge problem?

Yes, it was a merge problem.  I added back the per field initialization of the security head hooks.  Paul stripped this (and the same problem in patch 0004) himself before merging.

>
>
>> +	if (pps->alt.state != IB_PORT_PKEY_NOT_VALID) {
>> +		get_pkey_and_subnet_prefix(&pps->alt,
>> +					   &pkey,
>> +					   &subnet_prefix);
>> +
>> +		ret = enforce_qp_pkey_security(pkey,
>> +					       subnet_prefix,
>> +					       sec);
>> +	}
>> +
>> +	if (ret)
>> +		goto out;
> The above if/goto is unnecessary.

Right.

Paul, do you want me to fix this with a new patch?

>
>> +
>> +out:
>> +	return ret;
>> +}
>
>
