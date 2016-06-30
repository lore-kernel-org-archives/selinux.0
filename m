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
Subject: Re: [PATCH 05/12] selinux: Implement Infiniband PKey "Access" access
 vector
Date: Thu, 30 Jun 2016 15:35:40 +0000
Message-ID: <AM4PR0501MB2257829BD6F13305957CB9B7C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-6-git-send-email-danielj@mellanox.com>
 <20160630152343.GE22107@yuval-lap.uk.oracle.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 6/30/2016 10:24 AM, Yuval Shaia wrote:
> On Thu, Jun 23, 2016 at 10:52:51PM +0300, Dan Jurgens wrote:
>> +	if (c) {
>> +		if (!c->sid[0]) {
>> +			rc = sidtab_context_to_sid(&sidtab,
>> +						   &c->context[0],
>> +						   &c->sid[0]);
>> +			if (rc)
>> +				goto out;
>> +		}
>> +		*out_sid = c->sid[0];
>> +	} else {
>> +		*out_sid = SECINITSID_PKEY;
>> +	}
> Curly brackets are not needed
>
According to the coding style guide if either branch requires brackets both should use them:

This does not apply if only one branch of a conditional statement is a single
statement; in the latter case use braces in both branches:

	if (condition) {
		do_this();
		do_that();
	} else {
		otherwise();
	}
