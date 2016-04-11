Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BMV0la021516
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 18:31:00 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Date: Mon, 11 Apr 2016 22:30:54 +0000
Message-ID: <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <20160411201155.GC371@obsidianresearch.com>
 <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/11/2016 5:12 PM, Jason Gunthorpe wrote:
> On Mon, Apr 11, 2016 at 08:38:50PM +0000, Daniel Jurgens wrote:
>>>> An Infiniband device (ibdev) is labeled by name and port number.  There is a
>>>> single access vector for ibdevs as well, called "smi".
>>>
>>> This is called an End Port (SMI is something else in the IB
>>> spec). Please use the standard terminology.
>> I see your point on the end port, I'll address this is the next series
>> by updating the commit messages and replacing ibdev with ibendport.
>>
>> I don't understand where you think I've gone wrong on SMI.
> 
> Well, this makes no sense:
>  There is a single access vector for ibdevs as well, called "smi".

Access vector is an SELinux term.  Object have access vectors.  For
example a file object has has many access vectors like "read", "write",
"unlink", etc.  Policy rules allow access to a type of object on a
subset of its access vectors.

Controlling the "smi" is to prevent someone from starting a subnet manager.

> SMI is not umad. SMI should only refer to the SMA access channel on a
> specific node, and I have no idea why someone would want to restrict
> local SMA access independently of generic umad qp0 access. Just call
> it QP0 or QP1 or umad.
> 
> SMI is an obscure internal term that should not be user facing.
> 

The point of control here is MAD agent registration and MAD transmit and
receive.  When a MAD agent is created it inherits the security ID of
it's parent task.  For MAD agents that have a QP of type IB_QPT_SMI,
when an attempt is made to send a MAD the security ID of the MAD agent
is checked for access to the SMI vector of the IB device (to become End
Port).  This is only for MAD agents that have a qp with of type
IB_QPT_SMI.  So having umad as the access vector is too broad.
