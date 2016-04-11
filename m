Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BNa10d003723
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 19:36:01 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Date: Mon, 11 Apr 2016 23:35:57 +0000
Message-ID: <DB5PR05MB1111F04641E58609E51A9630C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <20160411201155.GC371@obsidianresearch.com>
 <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
 <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411231250.GB5861@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/11/2016 6:12 PM, Jason Gunthorpe wrote:
> On Mon, Apr 11, 2016 at 10:30:54PM +0000, Daniel Jurgens wrote:
> 
> Like I said, the user facing name should be QP0 in that case.
> 
> Jason
> 

OK, I'll change idbev to ibendport and smi to qp0, or qpzero if the
SELinux user space code doesn't allow numbers in access vector identifiers.
