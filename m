From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Date: Tue, 21 Aug 2007 12:55:44 -0400
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <200708211111.27019.paul.moore@hp.com> <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708211255.45132.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 21 2007 12:37:49 pm Stephen Smalley wrote:
> On Tue, 2007-08-21 at 11:11 -0400, Paul Moore wrote:
> > On Tuesday, August 21 2007 9:47:38 am Stephen Smalley wrote:
> > > We likely should look at optimizing the ebitmap code, or replacing it
> > > with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
> > > For example, ebitmap_next could possibly use find_next_bit().
> >
> > [Removed the busybox list because I'm sure they don't care]
> >
> > Would the fact that the MLS category bitmaps grow to 1024 bits be a
> > concern with using a single contiguous bitmap instead of the sparse
> > bitmap the ebitmap currently uses?  Granted, in the worst case of
> > c0.c1023 the kernel bitmap would most certainly be better but I wonder
> > what the common case is (and if the MLS compartments even factor into the
> > discussion) and which type is better suited to handle this case.
>
> Even if we retain the ebitmap type as a sparse bitmap, I think we can do
> some optimization of its internals, possibly leveraging things like
> find_next_bit(), to speed up the loops that were introduced when we
> optimized the avtab memory layout by pushing attributes down into the
> kernel policy (policy.20).
>
> Trying Yuichi's simple instrumentation of security_compute_av, I see a
> huge difference in security_compute_av times between policy.19 and
> policy.20.  We knew it would slow security_compute_av down (standard
> tradeoff between runtime performance and memory use), but the thinking
> at the time was that it wouldn't matter because of the AVC.  But we do
> have to bound our worst case latency.

I understand, I was just slightly concerned about losing the sparse bitmap 
feature which I have a hunch is beneficial in the MLS compartment case.  
Although I will readily admit I have no data to support this claim, I just 
wanted to throw it out as something to consider.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
