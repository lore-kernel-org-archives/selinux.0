Date: Fri, 10 Aug 2007 16:25:20 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: James Morris <jmorris@namei.org>
Subject: Re: Appropriate number of hash slots for te_avtab(Was:Re: [RFC] Dynamically deciding number of hash slots for avtab
Cc: ynakam@hitachisoft.jp, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com,
        method@manicmethod.com
In-Reply-To: <Pine.LNX.4.64.0708080833570.3111@us.intercode.com.au>
References: <1186584312.6916.111.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0708080833570.3111@us.intercode.com.au>
Message-Id: <20070810162046.255A.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 8 Aug 2007 08:35:09 -0700 (PDT)
James Morris wrote:
> On Wed, 8 Aug 2007, Stephen Smalley wrote:
> 
> > > Can We use jhash ?
> > 
> > I think so, as long as it doesn't impose a significant overhead.
> 
> It's now used extensively in the networking code, so I suspect it will be 
> ok (and unlikely to be a bottleneck for SELinux), but yep, we do need to 
> measure it.

I've measured performance of hash functions in avtab.c.
I compared default hash and jhash.

To measure performance, I measured time to call security_compute_av.
I measured time 10000 security_compute_av call from system boot, 
like below code.

int avc_has_perm_noaudit(u32 ssid, u32 tsid,
                         u16 tclass, u32 requested,
                         struct av_decision *avd)
{
	struct avc_node *node;
	struct avc_entry entry, *p_ae;
	int rc = 0;
	u32 denied;
+	unsigned long long t0,t1;
+	unsigned long long t2=0;
+	static unsigned long long t3=0;
+	static int count = 0;
+	static int flag = 1;
+	static int max = 10000;
+	int i = 0;


	rcu_read_lock();
+	if (flag && ss_initialized) {
+		t0 = sched_clock();
+		security_compute_av(ssid,tsid,tclass, requested, &entry.avd);
+		t1 = sched_clock();
+		t2 = t1 - t0;
+		t3 += t2;
+		count ++;
+	} 
+	if (flag && (count == max)) {
+		flag = 0;
+		printk("SELinux:security_compute_av execution time:%Lu\n", t3);
+
+	}

security_compute_av is located at the entry of avc_has_perm_no_audit.
And nano second to call 10000 security_compute_av function is printed out.

I did this benchmark varying hash table size, policy and hash functions.
I summarized result with hash table chain length(those I measured in previous message).
Below is a result.

1. Result for 1) (Full strict refpolicy)
* max table size = 32768
        usage of slot  chain-length  time to call 10000 security_compute_av(sec)
default: 30128/32768   34            6.95
jhash  : 32391/32768   21            7.28

* 16384
default:  16221/16384 59  6.91
jhash:    16382/16384 27  7.28

* 8192
default: 8190/8192 97 7.15
jhash:   8192/8192 41 7.78

*  4096
default: 4096/4096  182 7.73
jhash:   4096/4096  67  8.87

2. Result for 2) (smaller refpolicy)
* Number of slot = num of rules
        usage of slot  chain-length time(sec)
default : 3925/8192      13           9.65
jhash   : 5053/8192      7           10.1

* Number of slot = num of rules/2
default : 2809/4096  21   9.63
jhash   : 3466/4096   9   10.35

* Number of slot = num of rules/4
default: 1742/2048  35    9.69
jhash:   1991/2048  12   10.35

*  Number of slot = num of rules/8
default: 978/1024    64  10.02
jhash  : 1024/1024   22  11.23

* Number of slot = default(32768)
default: 5993/32768 7   9.99
jhash:  6975/32768  4  10.50

In both case,
about chain length, jhash is better,
however, performance is worse !
so is it better not to use jhash??

About max number of hash slots, 
we can use 16384 or 8192, because performance is almost the same.
About number of dynamically allocated hash slots, 
we can use slot = num of rules /4?

And there is one strange thing.
Performance is worse in smaller policy.
For 32768 hash slots, default hash function, 
6.95(s) for strict policy, 9.99(s) for smaller refpolicy.

Any comments, please.

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
