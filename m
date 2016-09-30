Date: Fri, 30 Sep 2016 14:46:05 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Jurgens <danielj@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20160930204605.GC5722@obsidianresearch.com>
References: <20160830185548.GA9768@obsidianresearch.com>
 <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
 <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
 <20160906200221.GE28416@obsidianresearch.com>
 <CAHC9VhRXDMiK5V0rOQTvtZB0Q8jTX7XecGmAfRhm8oqF9aBaiw@mail.gmail.com>
 <VI1PR0501MB24299E036F1FCD335A2C2049C4C80@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <CAHC9VhShCgxonV1rN-J7LyezamzZtKNZ1SR7ywnTB9Kgia_u1w@mail.gmail.com>
 <20160929224146.GE27229@obsidianresearch.com>
 <CAHC9VhTBW9VsMHag41x1GWUbwPQeLngi8_iq9CPuQ=UMxDebkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhTBW9VsMHag41x1GWUbwPQeLngi8_iq9CPuQ=UMxDebkg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 30, 2016 at 03:59:55PM -0400, Paul Moore wrote:
> > We also have iwarp vs rocee where AFAIK iwarp should get the vlan tag
> > from the IP socket that is allocated against the eth interface.
> 
> Sigh.
> 
> So we've got RDMA over IB (does this have an acronym?  my googling

We just call that IB

> isn't showing anything ...), RoCEv1 which appears to be RDMA over

Technically (IIRC) RoCEv1 is exactly the IB protocol with an ethernet
MAC header tacked in front. It even has a slot for a pkey value, but
no switches will inspect it.

> Ethernet (although it looks like it might still use an IP header?),

The 'IP' header is a IB GRH which is identical to a IPv6 header. We
call the IPv6 address in this header a GID.

> RoCEv2 which appears to be RDMA over UDP, and iWARP which seems to be
> RDMA over TCP/SCTP.  Are there any others?

RoCEv2 is the IB protocol with a UDP header added in.

iWARP is a unique protocol that runs RDMA inside TCP.

> We've already talked about the RDMA/IB's pkeys and RoCEv1's GID/VLANs,
> but RoCEv2 and iWARP are a little more interesting as they ride on top
> of a routable network transport.  Do RoCEv2 and iWARP use the kernel's
> stack, or is that off-loaded?

Gernally all off-loaded. There is one software implementation but it
is not used for anything serious. Well, maybe two IB drivers don't
offload this, I'm not sure.

> Actually, now that I think of it, RoCEv2 and iWARP are probably
> implemented as userspace libraries aren't they?

Nope, there is a userspace library component, but the kernel is
largely in charge. They are sort of distinct from the netstack, but
part of the RDMA stack. It is very confusing because netdev is
ideologically opposed (for good reason) to any form of offload, so
even though these devices use the same physical network port, and use
IP headers, they are not very well integrated.

Eg iwarp calls out to a userspace process which opens a socket to
reserve a port number and then feeds that back into the kernel to
setup IP headers which are safe to use. :\ The nic steals those
packets before the kernel ever sees them and processes them with an
internal 'CPU' and then feeds the QP infrastructure. (this is what is
ment by the term offload)

This also means that likely all the SE linux protections that apply to
ethernet are merrily voided by all this offload hardware and AFAIK
nobody has done any work to try and do something about that.

So Liran is right, when we talk about iWarp/RoCEv2 the SELinux stuff
should follow the ethernet stack.

However, every IB port typically has some number of child ipoib
netdevices as well, and those devices also specify a Pkey. This is
where the namespace patches source their pkey information from. I
don't know why a different approach is proposed for selinux. (Well,
aside from the fact the namespace patches were never completed and
basically don't work for strong isolation..)

.. and that is my basic concern, that selinux will get one patch
series and be left essentially incomplete like namespaces were.

Jason
