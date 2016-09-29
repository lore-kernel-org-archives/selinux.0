Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TMGWKC031180
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 18:16:33 -0400
Received: by mail-ua0-f195.google.com with SMTP id 37so173029uaz.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 15:16:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB24299E036F1FCD335A2C2049C4C80@VI1PR0501MB2429.eurprd05.prod.outlook.com>
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
 <CAHC9VhRXDMiK5V0rOQTvtZB0Q8jTX7XecGmAfRhm8oqF9aBaiw@mail.gmail.com>
 <VI1PR0501MB24299E036F1FCD335A2C2049C4C80@VI1PR0501MB2429.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Sep 2016 18:16:03 -0400
Message-ID: <CAHC9VhShCgxonV1rN-J7LyezamzZtKNZ1SR7ywnTB9Kgia_u1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Leon Romanovsky <leon@kernel.org>,
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

On Fri, Sep 23, 2016 at 9:26 AM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 9/20/2016 6:43 PM, Paul Moore wrote:
>> On Tue, Sep 6, 2016 at 4:02 PM, Jason Gunthorpe
>> <jgunthorpe@obsidianresearch.com> wrote:
>>> On Thu, Sep 01, 2016 at 02:06:46PM -0400, Paul Moore wrote:
>>>
>>>> Jason and/or Daniel, I think it would be helpful if you could explain
>>>> both the InifiniBand and IP based approaches for those of us who know
>>>> SELinux, but not necessarily the RDMA and InfiniBand portions of this
>>>> discussion.  Be verbose and explain it as if we were idiots (I get
>>>> called that enough, it must be true).
>>> Well, I'm not really familiar with SELinux, I know a little bit about
>>> how labels are applied in the netstack, but not that much...
>>>
>>> The RDMA subsystem supports 4 different networking standards, and they
>>> each have their own objects..
>> All right, I'm done traveling for a bit and it seems like this
>> discussion has settled into a stalemate so let's try to pick things
>> back up and sort this out.
>>
>> Starting we a better RDMA education for me.
>>
>> So far the discussion has been around providing access controls at the
>> transport layer, are there any RDMA entities that are transport
>> agnostic that might be better suited for what we are trying to do?  Or
>> is it simply that the RDMA layer is tied so tightly to the underlying
>> transport that we can't separate the two and have to consider them as
>> one?
>
> Welcome back Paul.
>
> I don't think there is a transport agnostic way to provide the kind of control I use in this patch set, which is very Infiniband specific.  RoCE uses VLANs and they are conceptually similar to subnet partitions, but the means of using them is completely different.  To use a different VLAN the user must select a GID for that VLAN.  One could provide a means to control RoCE access to VLANs by labeling GIDs and controlling them in a similar way to how I do PKeys.  That approach doesn't help with Infiniband partitions though, because the same GID can be used on multiple partitions.  It's also not very desirable from a policy writers perspective because it makes it so a bespoke policy is required per node.
>
> Regardless of any other approaches one might like to use to provide access control for RDMA non-Infiniband transport I think controlling access to Infiniband PKeys is still a desirable feature and I don't see any other way to have that.

Let me try to summarize and work through some of this stuff, please
correct me if any of this is wrong.

The queue pair (QP) concept lives in the RDMA layer and isn't tied to
any particular transport.  They appear to be somewhat analogous to
network sockets, although I'm guessing they can't be shared/passed
between process like a network socket, yes?

The IB partition is similar to a ethernet VLAN in that it providedes
enforced separation across the network; IB uses partition keys, VLANs
use tags/IDs.  IB partition keys are a 16 bit number, GIDs appear to
be a 16 byte number created from some combination of IP address, MAC
address, and VLAN ID.

In the case of RDMA over IB, we want to control QP access to
partitions/pkeys; in the case of RDMA over ethernet we want to control
QP access to VLANs/GIDs.

Is the above correct?

-- 
paul moore
www.paul-moore.com
