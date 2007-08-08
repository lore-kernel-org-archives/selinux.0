Date: Wed, 08 Aug 2007 15:00:51 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Appropriate number of hash slots for te_avtab(Was:Re: [RFC] Dynamically deciding number of hash slots for avtab
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, method@manicmethod.com
In-Reply-To: <1186490009.26457.10.camel@moss-spartans.epoch.ncsc.mil>
References: <20070807175824.4CBF.YNAKAM@hitachisoft.jp> <1186490009.26457.10.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20070808150021.C617.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 07 Aug 2007 08:33:29 -0400
Stephen Smalley  wrote:
>If you had adjusted the hash function too, you could have gotten better
results.
<snip>
> Try tuning the hash function.

Thanks for advice.
So, I tried another hash function.
I found jhash_3words in linux/jhash.h,
it calculates hash value based on 3 args. 

I replaced AVTAB_HASH using jhash like below, 
and measured hash stats again.

#define AVTAB_HASH(keyp,mask)	\
(jhash_3words((u32)(keyp->target_class), \
 (u32)(keyp->target_type), \
 (u32)(keyp->source_type), 0) & \
 mask)

Following is result.

1. Result for 1) (Full strict refpolicy)

* max table size = 32768
SELinux:32768 avtab hash slots allocated. Num of rules:166741
- default hash
rules:  166741 entries and 30128/32768 buckets used, longest chain length 34   
- jhash
rules:  166741 entries and 32391/32768 buckets used, longest chain length 21  

* 16384
SELinux:16384 avtab hash slots allocated. Num of rules:166741   
- default
rules:  166741 entries and 16221/16384 buckets used, longest chain length 59   
- jhash
rules:  166741 entries and 16382/16384 buckets used, longest chain length 27

* 8192
SELinux:8192 avtab hash slots allocated. Num of rules:166741
- default
rules:  166741 entries and 8190/8192 buckets used, longest chain length 97   
- jhash
rules:  166741 entries and 8192/8192 buckets used, longest chain length 41 

*  4096
SELinux:4096 avtab hash slots allocated. Num of rules:166741enfs_contexts
- default
rules:  166741 entries and 4096/4096 buckets used, longest chain length 182
- jhash
rules:  166741 entries and 4096/4096 buckets used, longest chain length 67 

jhash is better.
If we use jhash, max table size could be 16384 or 8192..

2. Result for 2) (smaller refpolicy)

* Number of slot = num of rules
SELinux:8192 avtab hash slots allocated. Num of rules:8188
- default
rules:  8188 entries and 3925/8192 buckets used, longest chain length 13
- jhash
rules:  8188 entries and 5053/8192 buckets used, longest chain length 7 

* Number of slot = num of rules/2
SELinux:4096 avtab hash slots allocated. Num of rules:8188
- default
rules:  8188 entries and 2809/4096 buckets used, longest chain length 21
- jhash
rules:  8188 entries and 3466/4096 buckets used, longest chain length 9 

* Number of slot = num of rules/4
SELinux:2048 avtab hash slots allocated. Num of rules:8188
- default
rules:  8188 entries and 1742/2048 buckets used, longest chain length 35
- jhash
rules:  8188 entries and 1991/2048 buckets used, longest chain length 12 

*  Number of slot = num of rules/8
SELinux:1024 avtab hash slots allocated. Num of rules:8188
- default
rules:  8188 entries and 978/1024 buckets used, longest chain length 64
- jhash
rules:  8188 entries and 1024/1024 buckets used, longest chain length 22

jhash is also better.

Can We use jhash ?

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
