From: Daniel Jurgens <danielj@mellanox.com>
To: Leon Romanovsky <leon@kernel.org>, Yuval Shaia <yuval.shaia@oracle.com>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH 02/12] selinux: Create policydb version for Infiniband
 support
Date: Fri, 1 Jul 2016 13:49:49 +0000
Message-ID: <DB6PR0501MB2261C7D467873122250A1F3EC4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-3-git-send-email-danielj@mellanox.com>
 <20160630150140.GB22107@yuval-lap.uk.oracle.com>
 <20160701125043.GD4750@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/1/2016 7:50 AM, Leon Romanovsky wrote:
> On Thu, Jun 30, 2016 at 06:01:42PM +0300, Yuval Shaia wrote:
>> On Thu, Jun 23, 2016 at 10:52:48PM +0300, Dan Jurgens wrote:
>>
>>>  				if (rc)
>>>  					return rc;
>>>  				break;
>>> +			case OCON_PKEY: {
>> Is "{" needed?
> No, I agree, need to remove.
The { is needed here, unless the variable sbn_pfx is defined at function scope.
>
>>> +				__be64 *sbn_pfx = (__be64 *)nodebuf;
>>> +				*sbn_pfx = cpu_to_be64(c->u.pkey.subnet_prefix);
