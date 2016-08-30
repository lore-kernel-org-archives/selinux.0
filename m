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
Date: Tue, 30 Aug 2016 19:10:12 +0000
Message-ID: <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhS1Tg3qr2Nncd_eq_eUXrf-wMickoeoF978Q7L+gN7J1g@mail.gmail.com>
 <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
 <20160830074607.GN594@leon.nu>
 <CAHC9VhRUmbsuV40rRpG+LeNUgY7rVqOkt-fxTMAFDRRdLvEkug@mail.gmail.com>
 <VI1PR0501MB242949202A1DA23E5C8E1E8AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830184633.GE7586@obsidianresearch.com>
 <VI1PR0501MB2429992B1165DFADC6A6C35AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830185548.GA9768@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/30/2016 1:56 PM, Jason Gunthorpe wrote:
>
> Are subsystems usually SELinux enabled in such a piecemeal way?
>
> Are you sure the 'partition' SELinux label should not be more general
> to cover more of the similar RDMA cases?
>
> Jason
>
In order to label something you have to be able to describe something unique about an instance of it, like a Subnet Prefix/PKey value pair.  What other thing could we label more generally to control access to a partition/VLAN?
