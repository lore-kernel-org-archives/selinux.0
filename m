From: Daniel Jurgens <danielj@mellanox.com>
To: Leon Romanovsky <leonro@mellanox.com>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>,
 "Liran Liss" <liranl@mellanox.com>
Subject: Re: [PATCH v4 9/9] selinux: Add a cache for quicker retreival of PKey
 SIDs
Date: Wed, 9 Nov 2016 14:03:33 +0000
Message-ID: <VI1PR0501MB24299AA647D26CF04F127059C4B90@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1478639185-47521-1-git-send-email-danielj@mellanox.com>
 <1478639185-47521-10-git-send-email-danielj@mellanox.com>
 <20161109070455.GF27883@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/9/2016 1:05 AM, Leon Romanovsky wrote:
> On Tue, Nov 08, 2016 at 11:06:25PM +0200, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> It is likely that the SID for the same PKey will be requested many
>> times. To reduce the time to modify QPs and process MADs use a cache to
>> store PKey SIDs.
>>
>> This code is heavily based on the "netif" and "netport" concept
>> originally developed by James Morris <jmorris@redhat.com> and Paul Moore
>> <paul@paul-moore.com> (see security/selinux/netif.c and
>> security/selinux/netport.c for more information)
>>
>> issue: 736423
>> Change-Id: I176c3079d5d84d06839b4f750100ac47a6081e94
> It doesn't belong to commit message.
>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

Yes, sorry silly oversight on my part.  I will address for all patches in v5.
