Subject: Re: [patch] Tuning avtab to reduce memory usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <200708211111.27019.paul.moore@hp.com>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
	 <1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
	 <200708211111.27019.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 12:37:49 -0400
Message-Id: <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 11:11 -0400, Paul Moore wrote:
> On Tuesday, August 21 2007 9:47:38 am Stephen Smalley wrote:
> > We likely should look at optimizing the ebitmap code, or replacing it
> > with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
> > For example, ebitmap_next could possibly use find_next_bit().
> 
> [Removed the busybox list because I'm sure they don't care]
> 
> Would the fact that the MLS category bitmaps grow to 1024 bits be a concern 
> with using a single contiguous bitmap instead of the sparse bitmap the 
> ebitmap currently uses?  Granted, in the worst case of c0.c1023 the kernel 
> bitmap would most certainly be better but I wonder what the common case is 
> (and if the MLS compartments even factor into the discussion) and which type 
> is better suited to handle this case.

Even if we retain the ebitmap type as a sparse bitmap, I think we can do
some optimization of its internals, possibly leveraging things like
find_next_bit(), to speed up the loops that were introduced when we
optimized the avtab memory layout by pushing attributes down into the
kernel policy (policy.20).

Trying Yuichi's simple instrumentation of security_compute_av, I see a
huge difference in security_compute_av times between policy.19 and
policy.20.  We knew it would slow security_compute_av down (standard
tradeoff between runtime performance and memory use), but the thinking
at the time was that it wouldn't matter because of the AVC.  But we do
have to bound our worst case latency.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
