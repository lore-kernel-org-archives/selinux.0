Date: Thu, 8 Sep 2016 15:14:57 -0400
From: "ira.weiny" <ira.weiny@intel.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Daniel Jurgens <danielj@mellanox.com>, Liran Liss <liranl@mellanox.com>,
 Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
Message-ID: <20160908191457.GB26402@phlsvsds.ph.intel.com>
References: <20160830185548.GA9768@obsidianresearch.com>
 <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
 <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
 <20160906200221.GE28416@obsidianresearch.com>
 <VI1PR0501MB24290102DD3246F0CA965746C4F90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160906215548.GA27225@obsidianresearch.com>
 <20160908000134.GC4515@phlsvsds.ph.intel.com>
 <DB6PR0501MB2422EA34EED4EE35EE7B1D28C4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908161948.GA21614@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160908161948.GA21614@obsidianresearch.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 08, 2016 at 10:19:48AM -0600, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2016 at 02:12:48PM +0000, Daniel Jurgens wrote:
> 
> > It would have to include the port, but idea of using a device name
> > for this is pretty ugly.  <subnet_prefix,pkey> makes it very easy to
> > write a policy that can be deployed widely.  <device,port,pkey/vlan>
> > could require many different policies depending on the configuration
> > of each machine.
> 
> What does net do? Should we have a way to unformly label the rdma ports?

Uniformly label them on the local node or across a cluster?

I think Daniel has a point here.  Given a node with multiple device/ports using
the local device names is IMO wrong.

> 
> How do you imagine these policies working anyhow? They cannot be
> shipped from a distro. Are these going to be labeled on filesystem
> objects? (how doe that work??) Or somehow injected when starting a
> container?
> 
> If they are not written to disk I don't see the problem, the dynamic
> injector will have to figure out what interface is what.

Who is the "dynamic injector"?

Ira

> 
> Jason
