Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u61Kgoqo026163
 for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2016 16:42:50 -0400
Received: by mail-oi0-f53.google.com with SMTP id u201so125978139oie.0
 for <selinux@tycho.nsa.gov>; Fri, 01 Jul 2016 13:42:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DB6PR0501MB2261C903AB4CE9644604B9E8C4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-6-git-send-email-danielj@mellanox.com>
 <CAGH-KgtNiMrLVz_fMG22WcpAL3EQq9ike=EYHfxbBa4Sg2-R8A@mail.gmail.com>
 <DB6PR0501MB2261BC286E974CFE76B1E901C4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
 <CAGH-KgvS7jvd4yiO-BGyqCbuZEwbXbjE61s2B7G6r=rOZse7iw@mail.gmail.com>
 <DB6PR0501MB22614C80007D7408544B4B30C4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
 <CAGH-KguvznwFOhYVhPKdu0t8_z=Q_eZ5Njss=ECWquagPhkc2Q@mail.gmail.com>
 <DB6PR0501MB2261C903AB4CE9644604B9E8C4250@DB6PR0501MB2261.eurprd05.prod.outlook.com>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 1 Jul 2016 16:42:47 -0400
Message-ID: <CAGH-KgsE2tPOpqb6tzWd02avj8hSsDnxw2p2rD4xy4RdTdvuYw@mail.gmail.com>
Subject: Re: [PATCH 05/12] selinux: Implement Infiniband PKey "Access" access
 vector
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
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

On Fri, Jul 1, 2016 at 3:57 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 7/1/2016 2:26 PM, Paul Moore wrote:
>> On Fri, Jul 1, 2016 at 3:16 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>>> On 7/1/2016 1:59 PM, Paul Moore wrote:
>>>> On Fri, Jul 1, 2016 at 2:21 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>>>>> On 7/1/2016 11:29 AM, Paul Moore wrote:
>>>>>> I wondered about this earlier in the patchset when we were discussing
>>>>>> the policy format, and I'm still wondering; perhaps you can help me
>>>>>> understand IB a bit better ...
>>>>>>
>>>>>> From what I gather, the partition key is the IB security boundary, not
>>>>>> the subnet, is that true?  If so, why are we including the subnet with
>>>>>> the partition key value/label?  I understand the low/high pkey range
>>>>>> as a way of simplifying the policy, but I don't quite understand the
>>>>>> point of tying the subnet to the partition key label.  Would you ever
>>>>>> want to have multiple labels for a single partition key, or should it
>>>>>> be a single label for the partition key regardless of the subnet?
>>>>>>
>>>>> Each subnet can have a different partition configuration and a node can be on multiple subnets.  By specifying the subnet prefix along with the pkey value the user has flexibility to have different policy for different subnets, instead of a global PKey space that would require coordinating the partition configuration across all subnets.
>>>> Perhaps a better explanation of partitions and subnets are in order,
>>>> especially for those of like me who are new to IB.
>>>>
>>> A subnet is a set of ports managed by a common subnet manager, which sets up the partition configuration.
>> So there can be multiple partitions inside a subnet and not multiple
>> subnets inside a partition?
>
> Yes, a each subnet can have many partitions.  The partitions are contained within that subnet, a different subnet can have a partition that uses same PKey value, but that's a different partition.  So if we have 2 subnets, fe80:: and fe81:: they can each have a partition that uses PKey X but it doesn't mean nodes with access to that partition on 0xfe80 can reach nodes on 0xfe81 on that partition.

Thanks, that clears things up.  Originally I thought it was the other
way around which we causing a lot of confusion on my part.

-- 
paul moore
security @ redhat
