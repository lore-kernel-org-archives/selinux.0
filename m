Message-ID: <46E8945A.9090603@ak.jp.nec.com>
Date: Thu, 13 Sep 2007 10:37:30 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: [PATCH] Improve ebitmap scanning (Re: [patch] Tuning avtab to reduce
 memory usage)
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <46CC00F4.2090501@ak.jp.nec.com> <46E7583C.9030103@ak.jp.nec.com> <200709121554.41662.paul.moore@hp.com>
In-Reply-To: <200709121554.41662.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday, September 11 2007 11:08:44 pm KaiGai Kohei wrote:
>> The attached patch applies the standard bitmap operations
>> for the iteration macro of ebitmap, and enables to improve
>> the performance in AVC-misses case.
> 
> In addition to the code changes to ebitmap_netlbl_{import,export}() you should 
> probably either remove, or preferably update, the comment block in the body 
> of the functions.

I replaced the comment block as follows:

    /* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
     * however, it is not always compatible with an array of unsigned long
     * in ebitmap_node.
     * In addition, you should pay attention the following implementation
     * assumes unsigned long has a width equal with or less than 64-bit.
     */

BTW, is there any wrapper to copy an array of u64 to/from architecture specific
unsigned long? If so, it will help implement ebitmap_netlbl_{import|export}()
and ebitmap_read() more simply.
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
