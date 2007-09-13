From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: [PATCH] Improve ebitmap scanning (Re: [patch] Tuning avtab to reduce memory usage)
Date: Thu, 13 Sep 2007 16:47:17 -0400
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <200709121554.41662.paul.moore@hp.com> <46E8945A.9090603@ak.jp.nec.com>
In-Reply-To: <46E8945A.9090603@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709131647.17539.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 12 2007 9:37:30 pm KaiGai Kohei wrote:
> Paul Moore wrote:
> > On Tuesday, September 11 2007 11:08:44 pm KaiGai Kohei wrote:
> >> The attached patch applies the standard bitmap operations
> >> for the iteration macro of ebitmap, and enables to improve
> >> the performance in AVC-misses case.
> >
> > In addition to the code changes to ebitmap_netlbl_{import,export}() you
> > should probably either remove, or preferably update, the comment block in
> > the body of the functions.
>
> I replaced the comment block as follows:
>
>     /* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
>      * however, it is not always compatible with an array of unsigned long
>      * in ebitmap_node.
>      * In addition, you should pay attention the following implementation
>      * assumes unsigned long has a width equal with or less than 64-bit.
>      */

That sound good to me.  FWIW, if/when this patch is accepted I'll take a look 
at the NetLabel security attributes struct as it _may_ be possible to change 
the NETLBL_CATMAP_MAPTYPE to an unsigned long from the u64 it currently uses.  
That should make these import/export functions a little cleaner.

> BTW, is there any wrapper to copy an array of u64 to/from architecture
> specific unsigned long? If so, it will help implement
> ebitmap_netlbl_{import|export}() and ebitmap_read() more simply.

I'm not sure, but Stephen's suggestion to ask lkml sounds like a good one.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
