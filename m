Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3E0RPAp008094
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 20:27:25 -0400
Date: Wed, 13 Apr 2016 20:27:19 -0400
From: Ira Weiny <ira.weiny@intel.com>
To: "Hefty, Sean" <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal@dev.mellanox.co.il>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Daniel Jurgens <danielj@mellanox.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160414002718.GA6660@rhel>
References: <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
 <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411231250.GB5861@obsidianresearch.com>
 <DB5PR05MB1111F04641E58609E51A9630C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160412000621.GD5861@obsidianresearch.com>
 <570C85F7.5010101@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
 <570DD3F5.2060302@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB041285@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1828884A29C6694DAF28B7E6B8A82373AB041285@ORSMSX109.amr.corp.intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 13, 2016 at 04:47:48PM +0000, Sean Hefty wrote:
> > Former (multicast modifications of fabric) also requires restricting
> > arbitrary UD QPs as well as QP1 as SA access is QPn (n > 0) <-> QP1.
> 
> The SA could have an option to ignore all requests that do not originate QP1,
> then protect access to QP1 on the client nodes.

I'm not really sure what we are protecting against here.  Is it simply DoS
against the SA?

Ira

> --
>
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
