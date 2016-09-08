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
Date: Thu, 8 Sep 2016 16:44:36 +0000
Message-ID: <DB6PR0501MB24227FF5BE230C826615111FC4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
References: <VI1PR0501MB2429992B1165DFADC6A6C35AC4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160830185548.GA9768@obsidianresearch.com>
 <VI1PR0501MB242974DEE5E0BF2FFE3A5DA0C4E00@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160901163418.GA6479@obsidianresearch.com>
 <CAHC9VhR-u-ZXMeLkZL7y3=DJP5XaH7CxcZ=b5z67wVwhaPcUhQ@mail.gmail.com>
 <20160906200221.GE28416@obsidianresearch.com>
 <VI1PR0501MB24290102DD3246F0CA965746C4F90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <20160906215548.GA27225@obsidianresearch.com>
 <20160908000134.GC4515@phlsvsds.ph.intel.com>
 <DB6PR0501MB2422EA34EED4EE35EE7B1D28C4FB0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <20160908161948.GA21614@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/8/2016 11:20 AM, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2016 at 02:12:48PM +0000, Daniel Jurgens wrote:
>
>> It would have to include the port, but idea of using a device name
>> for this is pretty ugly.  <subnet_prefix,pkey> makes it very easy to
>> write a policy that can be deployed widely.  <device,port,pkey/vlan>
>> could require many different policies depending on the configuration
>> of each machine.
> What does net do? Should we have a way to unformly label the rdma ports?
>
> How do you imagine these policies working anyhow? They cannot be
> shipped from a distro. Are these going to be labeled on filesystem
> objects? (how doe that work??) Or somehow injected when starting a
> container?
>
> If they are not written to disk I don't see the problem, the dynamic
> injector will have to figure out what interface is what.
>
> Jason
>
Net has variety of means of enforcement, one of which is controlling access to ports <tcp/udp,port number>, which is the most like what I'm doing here.  They also have other enforcement options that can't work for RDMA because it bypasses the kernel.

It will work like any other SELinux policy.  You label the things you want to control with a type and setup rules about which roles/types can interact with them and how.  I'm sure the default policy from distros will be to not restrict access.  Policy is loaded into the kernel, the disk and filesystem has nothing to do with this aside from it being where the policy is stored before being loaded.  What is this dynamic injector you are talking about?

Assume you have machines on one subnet (0xfe80::) one has a device called mlx5_0, the another mlx4_0 and you want to grant access to system administrators.

This hypothetical policy could be deployed on both:

    pkeycon 0xfe80:: 0xFFFF  gen_context(system_u:object_r:default_pkey_t);

    allow sysadm_t default_pkey_t access;

If we use device name you'd need to write separate policy for each node.

    pkeyvlancon mlx4_0 1 0xFFFF gen_context(system_u:object_r:default_pkey_t);

or

    pkeyvlancon mlx5_0 1 0xFFFF gen_context(system_u:object_r:default_pkey_t);
