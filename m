Subject: Re: [PATCH] Improve ebitmap scanning (Re: [patch] Tuning avtab to
	reduce memory usage)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <46E8945A.9090603@ak.jp.nec.com>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
	 <46CC00F4.2090501@ak.jp.nec.com> <46E7583C.9030103@ak.jp.nec.com>
	 <200709121554.41662.paul.moore@hp.com>  <46E8945A.9090603@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 07:34:30 -0400
Message-Id: <1189683270.13723.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 10:37 +0900, KaiGai Kohei wrote:
> Paul Moore wrote:
> > On Tuesday, September 11 2007 11:08:44 pm KaiGai Kohei wrote:
> >> The attached patch applies the standard bitmap operations
> >> for the iteration macro of ebitmap, and enables to improve
> >> the performance in AVC-misses case.
> > 
> > In addition to the code changes to ebitmap_netlbl_{import,export}() you should 
> > probably either remove, or preferably update, the comment block in the body 
> > of the functions.
> 
> I replaced the comment block as follows:
> 
>     /* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
>      * however, it is not always compatible with an array of unsigned long
>      * in ebitmap_node.
>      * In addition, you should pay attention the following implementation
>      * assumes unsigned long has a width equal with or less than 64-bit.
>      */
> 
> BTW, is there any wrapper to copy an array of u64 to/from architecture specific
> unsigned long? If so, it will help implement ebitmap_netlbl_{import|export}()
> and ebitmap_read() more simply.

Might want to ask on linux-kernel.  More generally, it might be a good
idea to cc linux-kernel on your next posting of the patch to get wider
review of how you are using the native linux bitmap support.

The patch looks very promising, although a detailed review and testing
might take a little bit.

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
