Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3ELwwhk019648
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 17:58:58 -0400
Date: Thu, 14 Apr 2016 17:58:50 -0400
From: Ira Weiny <ira.weiny@intel.com>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>,
 Hal Rosenstock <hal@dev.mellanox.co.il>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160414215849.GA15322@rhel.sc.intel.com>
References: <20160412000621.GD5861@obsidianresearch.com>
 <570C85F7.5010101@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
 <570DD3F5.2060302@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB041285@ORSMSX109.amr.corp.intel.com>
 <20160414002718.GA6660@rhel>
 <1828884A29C6694DAF28B7E6B8A82373AB041706@ORSMSX109.amr.corp.intel.com>
 <AM2PR05MB1105E03BDEE8ED9552C8EDE7C4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
 <20160414162604.GA9697@rhel.sc.intel.com>
 <AM2PR05MB11059E1985CE6544FAE4BA00C4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM2PR05MB11059E1985CE6544FAE4BA00C4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> > 
> > If you do add a check on every packet in the mad stack I would like time to
> > evaluate how that will affect the mad interface for performance.
> 
> I don't anticipate a large performance impact, due to caching of
> security ID's.  I can try to quantify it though.  I don't know of any
> MAD performance tests off hand, do have a recommendation?

Unfortunately I don't have any that are public.

Ira
