Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u81I6ptt012047
 for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2016 14:06:51 -0400
Received: by mail-oi0-f48.google.com with SMTP id p186so93013061oia.2
 for <selinux@tycho.nsa.gov>; Thu, 01 Sep 2016 11:06:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160901163418.GA6479@obsidianresearch.com>
References: <CAHC9VhS1Tg3qr2Nncd_eq_eUXrf-wMickoeoF978Q7L+gN7J1g@mail.gmail.com>
 <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
 <20160830074607.GN594@leon.nu>
 <CAHC9VhRUmbsuV40rRpG+LeNUgY7rVqOkt-fxTMAFDRRdLvEkug@mail.gmail.com>
 <VI1PR0501MB242949202A1DA23E5C8E1E8AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830184633.GE7586@obsidianresearch.com>
 <VI1PR0501MB2429992B1165DFADC6A6C35AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830185548.GA9768@obsidianresearch.com>
 <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Sep 2016 14:06:46 -0400
Message-ID: <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 1, 2016 at 12:34 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Aug 30, 2016 at 07:10:12PM +0000, Daniel Jurgens wrote:
>> On 8/30/2016 1:56 PM, Jason Gunthorpe wrote:
>> >
>> > Are subsystems usually SELinux enabled in such a piecemeal way?
>> >
>> > Are you sure the 'partition' SELinux label should not be more general
>> > to cover more of the similar RDMA cases?
>
>> In order to label something you have to be able to describe
>> something unique about an instance of it, like a Subnet Prefix/PKey
>> value pair.  What other thing could we label more generally to
>> control access to a partition/VLAN?
>
> IP prefix / vlan #? How does it work in net?
>
> Shouldn't you at least have a plan for how this will expand to cover
> the whole subsystem??

Jason and/or Daniel, I think it would be helpful if you could explain
both the InifiniBand and IP based approaches for those of us who know
SELinux, but not necessarily the RDMA and InfiniBand portions of this
discussion.  Be verbose and explain it as if we were idiots (I get
called that enough, it must be true).

-- 
paul moore
www.paul-moore.com
