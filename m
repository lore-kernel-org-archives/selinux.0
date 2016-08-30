From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>, Stephen Smalley
 <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>, "sean.hefty@intel.com"
 <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
Date: Tue, 30 Aug 2016 18:52:28 +0000
Message-ID: <VI1PR0501MB2429992B1165DFADC6A6C35AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhS1Tg3qr2Nncd_eq_eUXrf-wMickoeoF978Q7L+gN7J1g@mail.gmail.com>
 <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
 <20160830074607.GN594@leon.nu>
 <CAHC9VhRUmbsuV40rRpG+LeNUgY7rVqOkt-fxTMAFDRRdLvEkug@mail.gmail.com>
 <VI1PR0501MB242949202A1DA23E5C8E1E8AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830184633.GE7586@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/30/2016 1:46 PM, Jason Gunthorpe wrote:
> On Tue, Aug 30, 2016 at 02:06:53PM +0000, Daniel Jurgens wrote:
>
>> I don't this will be useful, RoCE doesn't have partitions/PKeys
>> because it uses Ethernet as the transport instead of Infiniband.
> The vlan stuff in roce should be just as restricted as the pkey is in
> IB....
>
> Jason
>
This patch set introduces a mechanism for controlling access to Infiniband partitions.  If someone is interested in writing SELinux tests regarding RoCE and VLANs then RXE may very well be useful for them.  It just doesn't apply here.
