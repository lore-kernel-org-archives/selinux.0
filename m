Subject: Re: [RFC][selinux] Tuning SELinux permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
In-Reply-To: <1188476863.26572.257.camel@moss-spartans.epoch.ncsc.mil>
References: <20070830142757.58A4.YNAKAM@hitachisoft.jp>
	 <1188476863.26572.257.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 08:50:11 -0400
Message-Id: <1188478211.26572.278.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 08:27 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-30 at 14:45 +0900, Yuichi Nakamura wrote:
> > Hello.
> > 
> > I am porting SELinux to embedded devices.
> > And I found big overhead in read/write on CPUs for embedded devices.
> > I tried tuning and found it can be reduced.
> > I want comments from community.
> > 
> > 1. Background
> > Look at benchmark result below.
> > lmbench simple read/write.
> > Big overhead exists especially on SH(SuperH) arch.
> > 
> > 1) Result for x86(Pentium 4 2.6Ghz), kernel 2.6.22
> >                 Base    SELinux  Overhead(%)
> > Simple read     1.1034  1.2387   12.3
> > Simple write    0.9989  1.139    14.0
> > * Base: kernel compiled without SELinux support
> > 
> > 2) Result for ARM(Intel XScale (PXA270 416MHz)), kernel 2.6.17
> >                 Base    SELinux   Overhead(%)
> > Simple read     1.7945  3.1279    74.3
> > Simple write    1.4706  2.9228    98.7
> > 
> > 3) Result for SH(SH4, SH7751R), kernel 2.6.22
> >                 Base    SELinux   Overhead(%)
> > Simple read     2.6781  6.4671    141.5
> > Simple write    2.0781  5.3181    155.9
> > 
> > Overhead more than 100%!
> > 
> > 2. Solution
> > I found function calls in SELinux permission checks
> > are causing performance overhead.
> > I tried to reduce function calls like below.
> > 
> > 1) avc_has_perm
> > In avc_has_perm, avc_audit is called everytime.
> > I think most access does not need to be audited, 
> > so I changed it to be called only when necessary.
> > 
> > 2) avc_has_perm_noaudit
> > I changed it to "inline".
> > 
> > 3) selinux_file_permission
> > >From selinux_file_permission,
> > file_has_perm -> inode_has_perm -> avc_has_perm
> > functions are called.
> > I made simple selinux_file_permission and reduced code.
> 
> Hmm...I thought that we used to mark some of these functions inline, but
> upstream kernel removed many explicit inline markers under the argument
> that the compiler is best able to decide when to inline and forcing
> inlining often causes code bloat that is worse than the function call
> overhead.
> 
> > 3. Benchmark result after tuning
> > Performance is improved especially in SH.
> > also a little effective for x86.
> > 
> > 1) Result for x86
> >              Base     SELinux   Overhead(%)
> > Simple read  1.1034   1.1939    8.2(before 12.3)
> > Simple write 0.9989   1.1039    10.5(before 14.0)
> > 
> > 2) Result for ARM
> >              Base     SELinux   Overhead(%)
> > Simple read  1.7945   2.7555    53.6(before 74.3)
> > Simple write 1.4706   2.5347    72.4(before 98.7)
> > 
> > 3) Result for SH
> >                 Base   SELinux  Overhead(%)
> > Simple read     2.6781 3.6538  36.43(before 141.5)
> > Simple write    2.0781 3.321   59.80(before 155.9)
> > 
> > Are such changes acceptable ??
> > Below is a patch to linux-2.6.22.
> 
> Given such an improvement, I'm certainly open to the idea, but I find it
> a bit troubling that we have to engage in such manual optimization when
> it seems that the compiler should be able to do this automatically, and
> that function call overhead shouldn't be that high.
> 
> I'd also like to separately explore a different approach for improving
> the overhead on read/write that has come up previously, namely don't
> recheck at all unless one of the following conditions is met:
> 1) process SID has changed since open-time check (i.e. exec with SID
> transition or setcon),
> 2) file SID has changed since open-time check (i.e. setxattr) ,
> 3) policy seqno has changed since open-time check (i.e. policy reload or
> boolean change).

Other options:
1) Make selinux_file_permission optional, e.g. depend on separate config
option, so people can build kernels without it.  Revalidation on
read/write is nice for revocation on file relabels and policy changes,
but it is known to be incomplete (e.g. mmap'd files), it isn't required
for evaluation/certification, and it carries a high cost.
2) Switch from a recheck-on-use model to a revoke-on-change model, i.e.
revoke file access upon file relabel or policy change.  That requires
the revoke infrastructure and could be fairly hard to get right, but
would (if done properly) be more complete in coverage and move the cost
to the relabel or policy change operation instead of each read/write.

> The original SELinux optimized the read/write case by caching a
> reference to the AVC entry used for the open-time check in the struct
> file's security blob, then re-using that if it was still valid and the
> SID hadn't changed.  But those AVC entry references were eliminated by
> the conversion to RCU.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
