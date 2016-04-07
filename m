Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37L2mGl012618
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 17:02:48 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: "leon@leon.nu" <leon@leon.nu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 09/13] ib/core: Enforce PKey security when
 modifying QPs
Date: Thu, 7 Apr 2016 21:02:43 +0000
Message-ID: <DB5PR05MB11113874870EBBE896E0D601C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-10-git-send-email-danielj@mellanox.com>
 <20160407163100.GA5808@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/7/2016 11:31 AM, Leon Romanovsky wrote:
> On Thu, Apr 07, 2016 at 02:33:54AM +0300, Dan Jurgens wrote:
> 
>> +	if (sec->qp == sec->qp->real_qp) {
>> +		/* The caller of this function holds the QP security
>> +		 * mutex so this list traversal is safe
>> +		*/
> 
> Did the comment below pass checkpatch.pl?

It did.

>> +		list_for_each_entry(shared_qp_sec,
>> +				    &sec->shared_qp_list,
>> +				    shared_qp_list) {
> 
> Is this list always needed to be protected by lock?
> In general, I prefer to see lock/unlock operations near protected code.
> Otherwise, it is hard to follow all lock/unlock paths.

The mutex is required, and I'm not sure how to push it lower safely.
Consider the situation where a QP is being modified concurrently with an
open_shared_qp. Unless the lock is held the entire time for each
operation open_shared_qp could check permission using a ib_qp_security
struct in a partially modified state, i.e. there could be a mix of new
and old settings for the port/pkey index/alternate path.  Shared QPs use
the port and pkey setting for the underlying real QP with the shared qp
q_security.
