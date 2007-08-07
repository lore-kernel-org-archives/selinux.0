Date: Tue, 07 Aug 2007 18:05:27 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Appropriate number of hash slots for te_avtab(Was:Re: [RFC] Dynamically deciding number of hash slots for avtab
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, method@manicmethod.com
In-Reply-To: <1185368380.2900.40.camel@moss-spartans.epoch.ncsc.mil>
References: <20070725113339.610F.YNAKAM@hitachisoft.jp> <1185368380.2900.40.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20070807175824.4CBF.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

In previous discussion,
I posted patch to reduce memory usage of te_avtab, 
and it could save up to 300k memory.

I had to determin two things about te_avtab hash table.
1)  Determin appropriate max number of hash slots.
  It is 32768(MAX_AVTAB_HASH_SIZE) in previous patch.
  If it can be smaller, kmalloc can be used instead of zmalloc.

2) Determin number of hash slots from number of rules.
 In previous patch, number of allocated hash slots is the same as number of rules.

To determin 1), 
We have to see hash stats when big policy is loaded.
I loaded full-size refpolicy(It is strict policy), and looked at hash stats.
# I defined  DEBUG_HASHES to see hash stats.
And varied max number of hash slots.
* Version of refpolicy: selinux-policy-strict-2.4.6-80.fc6
* Num of uncond rules: 166741.

To determin 2), 
We have to see hash stats when small policy is loaded.
I loaded small size refpolicy, and looked at hash stats.
Varied number of hash slots.
* Version of refpoilcy: serefpolicy-2.4.6
* Num of uncond rules: 8188
 # Removed unneeded sources, and made it smaller.

Below is a result of measurement of hash stats.
Please give me advice about appropriate number of hash slots. 

1. Result for 1)
* max table size = 32768
SELinux:32768 avtab hash slots allocated. Num of rules:166741
rules:  166741 entries and 30128/32768 buckets used, longest chain length 34   
-> chain length = 34

* 16384
SELinux:16384 avtab hash slots allocated. Num of rules:166741   
rules:  166741 entries and 16221/16384 buckets used, longest chain length 59   

* 8192
SELinux:8192 avtab hash slots allocated. Num of rules:166741
rules:  166741 entries and 8190/8192 buckets used, longest chain length 97   

*  4096
SELinux:4096 avtab hash slots allocated. Num of rules:166741enfs_contexts
rules:  166741 entries and 4096/4096 buckets used, longest chain length 182

It seems that 4096, 8192 is small, because chain length is 182, 97.
It might be better not to alter max table size, but I am not sure..

2. Result for 2)
* Number of slot = num of rules
SELinux:8192 avtab hash slots allocated. Num of rules:8188
rules:  8188 entries and 3925/8192 buckets used, longest chain length 13     
-> chain length = 13

* Number of slot = num of rules/2
SELinux:4096 avtab hash slots allocated. Num of rules:8188
rules:  8188 entries and 2809/4096 buckets used, longest chain length 21

* Number of slot = num of rules/4
SELinux:2048 avtab hash slots allocated. Num of rules:8188
rules:  8188 entries and 1742/2048 buckets used, longest chain length 35

*  Number of slot = num of rules/8
SELinux:1024 avtab hash slots allocated. Num of rules:8188
rules:  8188 entries and 978/1024 buckets used, longest chain length 64

"Number of slot = num of rules/8" may be too small.
/4 or /2 is good?



Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
