From: Daniel Jurgens <danielj@mellanox.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: "ira.weiny" <ira.weiny@intel.com>, Liran Liss <liranl@mellanox.com>, "Paul
 Moore" <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>,
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
Date: Thu, 8 Sep 2016 18:59:13 +0000
Message-ID: <VI1PR0501MB2429AAD28BD78334C1FE0E5AC4FB0@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
 <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
 <20160906200221.GE28416@obsidianresearch.com>
 <VI1PR0501MB24290102DD3246F0CA965746C4F90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160906215548.GA27225@obsidianresearch.com>
 <20160908000134.GC4515@phlsvsds.ph.intel.com>
 <DB6PR0501MB2422EA34EED4EE35EE7B1D28C4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908161948.GA21614@obsidianresearch.com>
 <DB6PR0501MB24227FF5BE230C826615111FC4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908183611.GD21614@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/8/2016 1:36 PM, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2016 at 04:44:36PM +0000, Daniel Jurgens wrote:
>
>> Net has variety of means of enforcement, one of which is controlling
>> access to ports <tcp/udp,port number>, which is the most like what
>> I'm doing here.
> No, the analog the tcp/udp,port number is <ib, service_id> 
I should have been clearer here.  From the SELinux perspective this scheme is very similar to net ports.
>> It will work like any other SELinux policy.  You label the things
>> you want to control with a type and setup rules about which
>> roles/types can interact with them and how.  I'm sure the default
>> policy from distros will be to not restrict access.  Policy is
>> loaded into the kernel, the disk and filesystem has nothing to do
> Eh? I thought the main utility of selinux was using the labels written
> to the filesystem to constrain access, eg I might label
> /usr/bin/apache in a way that gets the <tcp,80> policy applied to it.
Filesystems can be labeled, but so can other things without a filesystem representation.
>> with this aside from it being where the policy is stored before
>> being loaded.  What is this dynamic injector you are talking about?
> The container projects (eg docker) somehow setup selinux on the
> fly for each container. I'm not sure how.
SELinux policy is modular and can be changed or updated while running, I'm not very familiar with docker so I'm not sure what they do regarding SELinux.  I'm also not sure it's relevant to the issues at hand.
>
>> Assume you have machines on one subnet (0xfe80::) one has a device
>> called mlx5_0, the another mlx4_0 and you want to grant access to
>> system administrators.
> So do this in userspace? Why should the kernel do the translation?
I'm still not clear on what translation you are talking about.  To look up a label for something the kernel uses the same attributes the policy writer used to create the label.  In this patch set when modify_qp is called there is a search of all the labels for pkeys for one that matches subnet prefix for the relevant port and the pkey number.
