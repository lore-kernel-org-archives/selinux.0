From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Paul Moore
 <paul@paul-moore.com>
CC: Leon Romanovsky <leon@kernel.org>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
Date: Tue, 6 Sep 2016 20:35:56 +0000
Message-ID: <VI1PR0501MB24290102DD3246F0CA965746C4F90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
 <20160830074607.GN594@leon.nu>
 <CAHC9VhRUmbsuV40rRpG+LeNUgY7rVqOkt-fxTMAFDRRdLvEkug@mail.gmail.com>
 <VI1PR0501MB242949202A1DA23E5C8E1E8AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830184633.GE7586@obsidianresearch.com>
 <VI1PR0501MB2429992B1165DFADC6A6C35AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830185548.GA9768@obsidianresearch.com>
 <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
 <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
 <20160906200221.GE28416@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/6/2016 3:02 PM, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2016 at 02:06:46PM -0400, Paul Moore wrote:
>
>> Jason and/or Daniel, I think it would be helpful if you could explain
>> both the InifiniBand and IP based approaches for those of us who know
>> SELinux, but not necessarily the RDMA and InfiniBand portions of this
>> discussion.  Be verbose and explain it as if we were idiots (I get
>> called that enough, it must be true).
> Well, I'm not really familiar with SELinux, I know a little bit about
> how labels are applied in the netstack, but not that much...
>
> The RDMA subsystem supports 4 different networking standards, and they
> each have their own objects..
>
> Just focusing on the pkey/vlan ideas. Every packet placed on the
> network has either a pkey or vlan label, the networking switches and
> receivers use these labels to create strong access control.
>
> The labels are not-global, they are isolated to a site, or even a
> single network within a site.
>
> ipoib also uses pkey&vlan in the same way netdev does (with these
> patches it looks like a userspace can still access a pkey via ipoib
> even if selinux is restricting access to it).
>
> Daniel's patch also touched on the QP1 and QP0 concepts. Packets can
> be labeled as being for QP0/1 and the recievers process them under the
> assumption they were sent by something with privilege (eg like the low
> port numbers in IP)
>
> So, from my perspective, we shouldn't be talking about doing pkey
> without also addressing vlan. It sounds like Daniel's concern is how to
> identify the number space (eg he is using a GID prefix for IB, which
> won't work on anything else, maybe rdma device handle is a better choice)
>
> Jason
>
I think to control access to a VLAN for RoCE there would have to labels for GIDs, since that's how you select which VLAN to use.  It'd be very similar to how the pkey labels works, but it doesn't help with Infiniband, so I think the pkey labeling scheme is still required.  RDMA device handle labeling isn't granular enough for what I'm trying to accomplish.  We want users with different levels of permission to be able to use the same device, but restrict who they can communicate with by isolating them to separate partitions.
