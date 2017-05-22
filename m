Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MLGXRu012125
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 17:16:35 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: Paul Moore <paul@paul-moore.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, kbuild test robot <fengguang.wu@intel.com>
Subject: Re: [pcmoore-selinux:next 17/17] security/selinux/ibpkey.c:116:24:
 sparse: incompatible types in comparison expression (different address
 spaces)
Date: Mon, 22 May 2017 21:16:13 +0000
Message-ID: <VI1PR05MB167871B25F7C3AE49878F3ADC4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <201705211751.KBNIRg9i%fengguang.wu@intel.com>
 <CAHC9VhQ3_cKwdY-b_1vuT840aGbe6eJq6iFtt_NVuFXitB9wUQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/22/2017 4:06 PM, Paul Moore wrote:
> On Sun, May 21, 2017 at 5:47 AM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> tree:   git://git.infradead.org/users/pcmoore/selinux next
>> head:   b76dd295790d44ecb04932110309bb6c15f263a8
>> commit: b76dd295790d44ecb04932110309bb6c15f263a8 [17/17] selinux: Add a cache for quicker retreival of PKey SIDs
>> reproduce:
>>         # apt-get install sparse
>>         git checkout b76dd295790d44ecb04932110309bb6c15f263a8
>>         make ARCH=x86_64 allmodconfig
>>         make C=1 CF=-D__CHECK_ENDIAN__
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>>>> security/selinux/ibpkey.c:116:24: sparse: incompatible types in comparison expression (different address spaces)
> I haven't looked at this too closely, but this may not be significant
> ... Daniel, can you look into this please?

I looked at this before.  I don't believe it's significant.  The same warning pops up in security/selinux/netport.c:125.

>
>> vim +116 security/selinux/ibpkey.c
>>
>>    100   * Description:
>>    101   * Add a new pkey record to the hash table.
>>    102   *
>>    103   */
>>    104  static void sel_ib_pkey_insert(struct sel_ib_pkey *pkey)
>>    105  {
>>    106          unsigned int idx;
>>    107
>>    108          /* we need to impose a limit on the growth of the hash table so check
>>    109           * this bucket to make sure it is within the specified bounds
>>    110           */
>>    111          idx = sel_ib_pkey_hashfn(pkey->psec.pkey);
>>    112          list_add_rcu(&pkey->list, &sel_ib_pkey_hash[idx].list);
>>    113          if (sel_ib_pkey_hash[idx].size == SEL_PKEY_HASH_BKT_LIMIT) {
>>    114                  struct sel_ib_pkey *tail;
>>    115
>>  > 116                  tail = list_entry(
>>    117                          rcu_dereference_protected(
>>    118                                  sel_ib_pkey_hash[idx].list.prev,
>>    119                                  lockdep_is_held(&sel_ib_pkey_lock)),
>>    120                          struct sel_ib_pkey, list);
>>    121                  list_del_rcu(&tail->list);
>>    122                  kfree_rcu(tail, rcu);
>>    123          } else {
>>    124                  sel_ib_pkey_hash[idx].size++;
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
