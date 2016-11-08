From: Daniel Jurgens <danielj@mellanox.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>, "eparis@parisplace.org"
 <eparis@parisplace.org>, "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>,
 "Liran Liss" <liranl@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH v4 3/9] selinux lsm IB/core: Implement LSM notification
 system
Date: Tue, 8 Nov 2016 23:41:02 +0000
Message-ID: <VI1PR0501MB2429F6023D7A33A5F4FF2728C4A60@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <201611090600.BYNmwuAI%fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/8/2016 4:36 PM, kbuild test robot wrote:
> Hi Daniel,
>
> [auto build test ERROR on rdma/master]
> [also build test ERROR on v4.9-rc4]
> [cannot apply to next-20161108]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Dan-Jurgens/SELinux-support-for-Infiniband-RDMA/20161109-053432
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma.git master
> config: i386-randconfig-s1-201645 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: "unregister_lsm_notifier" [drivers/infiniband/core/ib_core.ko] undefined!
>>> ERROR: "register_lsm_notifier" [drivers/infiniband/core/ib_core.ko] undefined!
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

This link error happens when CONFIG_SECURITY is not set.  I will address it in v5 after giving some time for additional comments.
