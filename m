From: Liran Liss <liranl@mellanox.com>
To: "ira.weiny" <ira.weiny@intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>
CC: Daniel Jurgens <danielj@mellanox.com>, Paul Moore <paul@paul-moore.com>,
 Leon Romanovsky <leon@kernel.org>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: RE: [PATCH v3 0/9] SELinux support for Infiniband RDMA
Date: Thu, 22 Sep 2016 15:04:37 +0000
Message-ID: <VI1PR0501MB218937796728388A3FE0E0C9B1C90@VI1PR0501MB2189.eurprd05.prod.outlook.com>
References: <20160906200221.GE28416@obsidianresearch.com>
 <VI1PR0501MB24290102DD3246F0CA965746C4F90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160906215548.GA27225@obsidianresearch.com>
 <20160908000134.GC4515@phlsvsds.ph.intel.com>
 <DB6PR0501MB2422EA34EED4EE35EE7B1D28C4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908161948.GA21614@obsidianresearch.com>
 <DB6PR0501MB24227FF5BE230C826615111FC4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908183611.GD21614@obsidianresearch.com>
 <VI1PR0501MB2429AAD28BD78334C1FE0E5AC4FB0@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160908193235.GA1868@obsidianresearch.com>
 <20160921161626.GA27837@phlsvsds.ph.intel.com>
In-Reply-To: <20160921161626.GA27837@phlsvsds.ph.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> From: ira.weiny [mailto:ira.weiny@intel.com]

> >
> > It really isn't. net ports and service_ids are global things that do
> > not need machine-specific customizations while subnet prefix or device
> > name/port are both machine-local information.
> 
> I agree that service_ids are more analogous to net ports.
> 
> However, subnet prefixes are _not_ machine-local.  They are controlled by the
> Admin of the fabric by a central entity (the SM).  This is more helpful than in
> ethernet where if you configure the wrong port with the wrong subnet things
> just don't work.  In IB I can physically plug my network into any IB port I want
> and the system is _told_ which "subnet" that port belongs to.  (OPA is the same
> way.)
> 
> So for IB/OPA a subnet prefix is a really good way to ID which network (subnet)
> you want to use.  Unfortunately, I'm not sure how to translate that to
> iwarp/roce seamlessly except to have some concept of "domain" as I mentioned
> in my other email.
> 

Exactly. The identity of both the "domain" (the subnet ID) and the "label" stem from a central entity - the SM.
It would be very natural to have IB/OPA subnet policies that are configured in all hosts and the SM. These policies are automatically enforced for any port connected to the subnet.

Not everything needs to be related to IP interfaces.
I can envision multiple jobs in the cluster, running on distinct partitions using distinct security tags, without configuring IP interfaces on these partitions.
Partition security is a useful and an effective measure that is applicable to IB/OPA networks. That's it.

Ethernet VLANs are a totally different thing --- SELinux *already* handles them for Ethernet interfaces.
There is nothing special from an admin's point of view regarding how SELinux applies to RDMA over Ethernet (RoCE/iWarp). RDMA is just another transport, and any Ethernet L2 policies should apply to it seamlessly.

--Liran
