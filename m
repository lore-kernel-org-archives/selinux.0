From: Daniel Jurgens <danielj@mellanox.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH 03/12] selinux: Implement Infiniband flush callback
Date: Thu, 30 Jun 2016 15:44:45 +0000
Message-ID: <AM4PR0501MB22578AA5FF8B4062F650C581C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-4-git-send-email-danielj@mellanox.com>
 <20160630151005.GC22107@yuval-lap.uk.oracle.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 6/30/2016 10:10 AM, Yuval Shaia wrote:
> On Thu, Jun 23, 2016 at 10:52:49PM +0300, Dan Jurgens wrote:
>
>> +static void (*ib_flush_callback)(void);
> Do we really want to have such ib_ prefix in security/ directory?
>
>> +		if (ib_flush_callback)
>> +			ib_flush_callback();
> How about some generic mechanism (such as a list) in case more
> modules/drivers would like to register callbacks?
> ( assuming this is no longer RFC :) )
>
Paul Moore and I were having a higher level discussion about this in the 00/12 thread.  I think your suggestion makes sense, perhaps Paul will weigh in when he reaches this patch.
