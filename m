Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3CHwjbA004641
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 13:58:45 -0400
Date: Tue, 12 Apr 2016 11:58:37 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: "Hefty, Sean" <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal@dev.mellanox.co.il>,
 Daniel Jurgens <danielj@mellanox.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160412175837.GA15027@obsidianresearch.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <20160411201155.GC371@obsidianresearch.com>
 <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
 <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411231250.GB5861@obsidianresearch.com>
 <DB5PR05MB1111F04641E58609E51A9630C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160412000621.GD5861@obsidianresearch.com>
 <570C85F7.5010101@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 12, 2016 at 05:06:45PM +0000, Hefty, Sean wrote:
> > Wouldn't QP1 require different access control than QP0 due to SA clients
> > on every end node ?
> 
> QP1 still allows modification of the fabric (e.g. multicast join) or
> an DoS attack against the SA.  Though the latter probably requires
> restricting how a UD QP may be used.

Right, I don't disagree we should have smp and gmp 'just in case'
(fine names as well) labels, I just don't really understand why you'd
trust something enough to grant gmp but not enough for smp...

Particularly encouraging people to grant gmp as though that was 'safe'
is really bad advice.

Which in turn makes me wonder why the umad dev node label is not
sufficient.

Jason
