Message-ID: <46CC00F4.2090501@ak.jp.nec.com>
Date: Wed, 22 Aug 2007 18:25:08 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <200708211111.27019.paul.moore@hp.com> <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil> <200708211255.45132.paul.moore@hp.com>
In-Reply-To: <200708211255.45132.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday, August 21 2007 12:37:49 pm Stephen Smalley wrote:
>> On Tue, 2007-08-21 at 11:11 -0400, Paul Moore wrote:
>>> On Tuesday, August 21 2007 9:47:38 am Stephen Smalley wrote:
>>>> We likely should look at optimizing the ebitmap code, or replacing it
>>>> with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
>>>> For example, ebitmap_next could possibly use find_next_bit().
>>> [Removed the busybox list because I'm sure they don't care]
>>>
>>> Would the fact that the MLS category bitmaps grow to 1024 bits be a
>>> concern with using a single contiguous bitmap instead of the sparse
>>> bitmap the ebitmap currently uses?  Granted, in the worst case of
>>> c0.c1023 the kernel bitmap would most certainly be better but I wonder
>>> what the common case is (and if the MLS compartments even factor into the
>>> discussion) and which type is better suited to handle this case.
>> Even if we retain the ebitmap type as a sparse bitmap, I think we can do
>> some optimization of its internals, possibly leveraging things like
>> find_next_bit(), to speed up the loops that were introduced when we
>> optimized the avtab memory layout by pushing attributes down into the
>> kernel policy (policy.20).
>>
>> Trying Yuichi's simple instrumentation of security_compute_av, I see a
>> huge difference in security_compute_av times between policy.19 and
>> policy.20.  We knew it would slow security_compute_av down (standard
>> tradeoff between runtime performance and memory use), but the thinking
>> at the time was that it wouldn't matter because of the AVC.  But we do
>> have to bound our worst case latency.
> 
> I understand, I was just slightly concerned about losing the sparse bitmap 
> feature which I have a hunch is beneficial in the MLS compartment case.  
> Although I will readily admit I have no data to support this claim, I just 
> wanted to throw it out as something to consider.

I think the sparse bitmap feature is also useful to skip unnecessary scan
on the ebitmap, so these features should be used together.

The current version of ebitmap contains a 64-bit length bitmap.
I have a concern to apply the standard bitops, and memory usage.

The one is a difference in the type of variable.
find_next_bit() requires the bitmap defined as unsigned long array,
but ebitmap uses a u64 value as a bitmap, so we cannot apply it as is.

The other is memory usage. The ebitmap_node is allocated by kzalloc().
However, sizeof(ebitmap_node) is 16-byte in 32bit arch, although
the minimun unit of kmalloc() is 32 byte.

In 32-bit arch, map should be defined as 'unsigned long map[6]'
to apply the standard bitops and to maximun memory usage.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
