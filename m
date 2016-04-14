Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3EGQf6f003988
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 12:26:41 -0400
Date: Thu, 14 Apr 2016 12:26:06 -0400
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
Message-ID: <20160414162604.GA9697@rhel.sc.intel.com>
References: <20160411231250.GB5861@obsidianresearch.com>
 <DB5PR05MB1111F04641E58609E51A9630C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160412000621.GD5861@obsidianresearch.com>
 <570C85F7.5010101@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB040ABA@ORSMSX109.amr.corp.intel.com>
 <570DD3F5.2060302@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB041285@ORSMSX109.amr.corp.intel.com>
 <20160414002718.GA6660@rhel>
 <1828884A29C6694DAF28B7E6B8A82373AB041706@ORSMSX109.amr.corp.intel.com>
 <AM2PR05MB1105E03BDEE8ED9552C8EDE7C4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM2PR05MB1105E03BDEE8ED9552C8EDE7C4970@AM2PR05MB1105.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 14, 2016 at 01:11:15PM +0000, Daniel Jurgens wrote:
> On 4/13/2016 11:23 PM, Hefty, Sean wrote:
> >>>> Former (multicast modifications of fabric) also requires restricting
> >>>> arbitrary UD QPs as well as QP1 as SA access is QPn (n > 0) <-> QP1.
> >>>
> >>> The SA could have an option to ignore all requests that do not originate
> >> QP1,
> >>> then protect access to QP1 on the client nodes.
> >>
> >> I'm not really sure what we are protecting against here.  Is it simply DoS
> >> against the SA?
> > 
> > This would protect against a non-privileged QP trying to change multicast or event subscription, for example.  Though it could help with DoS, by avoiding the processing associated with requests.  Jason's original question was why would you want to leave qp1 open, and I think the answer to that depends on what restrictions could be enforced for qpX: X > 1.  Restricting both seem desirable, IMO.
> > 
> 
> There are no qpX to qpX restrictions.  As long as the users that created
> both QPs have permission to use the PKey in the PKey index they
> specified then they are free to communicate in any way.

For GSI (from 'random' QPs) this seams reasonable.

In InfiniBand, the pkey is ignored in SMPs (those packets on QP0/VL15).  So it
does not really make sense to me to control SMPs via pkey.  (OPA does check
pkeys in SMPs.)

Therefore, I agree with Jason that need to control access to QP0.  Furthermore,
I think you can/should do that when the agent is registered.  This will be more
performant for SMs as well.

For SA/GSI access using umad I think the best control is to limit access to the
umad char device itself?  ibacm has been changed to be an SA cache (with
plugins available for both IB and OPA) and therefore it can run with sufficient
privileges to access the umad char device.  Then regular user applications
don't need umad access at all.

For SA/GSI interactions from 'random' UD QPs, those can be controlled via the
Pkey mechanism you mention above.

If you do add a check on every packet in the mad stack I would like time to
evaluate how that will affect the mad interface for performance.

Ira
