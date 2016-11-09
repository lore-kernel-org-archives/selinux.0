Date: Wed, 9 Nov 2016 13:09:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: kbuild-all@01.org, chrisw@sous-sol.org, paul@paul-moore.com,
 sds@tycho.nsa.gov, eparis@parisplace.org, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com, liranl@mellanox.com, leonro@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH v4 9/9] selinux: Add a cache for quicker retreival of
 PKey SIDs
Message-ID: <201611091326.qY5eqLuS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478639185-47521-10-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Daniel,

[auto build test WARNING on rdma/master]
[also build test WARNING on v4.9-rc4]
[cannot apply to next-20161108]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Jurgens/SELinux-support-for-Infiniband-RDMA/20161109-053432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> security/selinux/ibpkey.c:116:24: sparse: incompatible types in comparison expression (different address spaces)

vim +116 security/selinux/ibpkey.c

   100	 * Description:
   101	 * Add a new pkey record to the hash table.
   102	 *
   103	 */
   104	static void sel_pkey_insert(struct sel_pkey *pkey)
   105	{
   106		unsigned int idx;
   107	
   108		/* we need to impose a limit on the growth of the hash table so check
   109		 * this bucket to make sure it is within the specified bounds
   110		 */
   111		idx = sel_pkey_hashfn(pkey->psec.pkey);
   112		list_add_rcu(&pkey->list, &sel_pkey_hash[idx].list);
   113		if (sel_pkey_hash[idx].size == SEL_PKEY_HASH_BKT_LIMIT) {
   114			struct sel_pkey *tail;
   115	
 > 116			tail = list_entry(
   117				rcu_dereference_protected(
   118					sel_pkey_hash[idx].list.prev,
   119					lockdep_is_held(&sel_pkey_lock)),
   120				struct sel_pkey, list);
   121			list_del_rcu(&tail->list);
   122			kfree_rcu(tail, rcu);
   123		} else {
   124			sel_pkey_hash[idx].size++;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
