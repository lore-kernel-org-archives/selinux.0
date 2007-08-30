Subject: Re: [RFC][selinux] Tuning SELinux permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
In-Reply-To: <20070830142757.58A4.YNAKAM@hitachisoft.jp>
References: <20070830142757.58A4.YNAKAM@hitachisoft.jp>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 08:27:43 -0400
Message-Id: <1188476863.26572.257.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 14:45 +0900, Yuichi Nakamura wrote:
> Hello.
> 
> I am porting SELinux to embedded devices.
> And I found big overhead in read/write on CPUs for embedded devices.
> I tried tuning and found it can be reduced.
> I want comments from community.
> 
> 1. Background
> Look at benchmark result below.
> lmbench simple read/write.
> Big overhead exists especially on SH(SuperH) arch.
> 
> 1) Result for x86(Pentium 4 2.6Ghz), kernel 2.6.22
>                 Base    SELinux  Overhead(%)
> Simple read     1.1034  1.2387   12.3
> Simple write    0.9989  1.139    14.0
> * Base: kernel compiled without SELinux support
> 
> 2) Result for ARM(Intel XScale (PXA270 416MHz)), kernel 2.6.17
>                 Base    SELinux   Overhead(%)
> Simple read     1.7945  3.1279    74.3
> Simple write    1.4706  2.9228    98.7
> 
> 3) Result for SH(SH4, SH7751R), kernel 2.6.22
>                 Base    SELinux   Overhead(%)
> Simple read     2.6781  6.4671    141.5
> Simple write    2.0781  5.3181    155.9
> 
> Overhead more than 100%!
> 
> 2. Solution
> I found function calls in SELinux permission checks
> are causing performance overhead.
> I tried to reduce function calls like below.
> 
> 1) avc_has_perm
> In avc_has_perm, avc_audit is called everytime.
> I think most access does not need to be audited, 
> so I changed it to be called only when necessary.
> 
> 2) avc_has_perm_noaudit
> I changed it to "inline".
> 
> 3) selinux_file_permission
> >From selinux_file_permission,
> file_has_perm -> inode_has_perm -> avc_has_perm
> functions are called.
> I made simple selinux_file_permission and reduced code.

Hmm...I thought that we used to mark some of these functions inline, but
upstream kernel removed many explicit inline markers under the argument
that the compiler is best able to decide when to inline and forcing
inlining often causes code bloat that is worse than the function call
overhead.

> 3. Benchmark result after tuning
> Performance is improved especially in SH.
> also a little effective for x86.
> 
> 1) Result for x86
>              Base     SELinux   Overhead(%)
> Simple read  1.1034   1.1939    8.2(before 12.3)
> Simple write 0.9989   1.1039    10.5(before 14.0)
> 
> 2) Result for ARM
>              Base     SELinux   Overhead(%)
> Simple read  1.7945   2.7555    53.6(before 74.3)
> Simple write 1.4706   2.5347    72.4(before 98.7)
> 
> 3) Result for SH
>                 Base   SELinux  Overhead(%)
> Simple read     2.6781 3.6538  36.43(before 141.5)
> Simple write    2.0781 3.321   59.80(before 155.9)
> 
> Are such changes acceptable ??
> Below is a patch to linux-2.6.22.

Given such an improvement, I'm certainly open to the idea, but I find it
a bit troubling that we have to engage in such manual optimization when
it seems that the compiler should be able to do this automatically, and
that function call overhead shouldn't be that high.

I'd also like to separately explore a different approach for improving
the overhead on read/write that has come up previously, namely don't
recheck at all unless one of the following conditions is met:
1) process SID has changed since open-time check (i.e. exec with SID
transition or setcon),
2) file SID has changed since open-time check (i.e. setxattr) ,
3) policy seqno has changed since open-time check (i.e. policy reload or
boolean change).

The original SELinux optimized the read/write case by caching a
reference to the AVC entry used for the open-time check in the struct
file's security blob, then re-using that if it was still valid and the
SID hadn't changed.  But those AVC entry references were eliminated by
the conversion to RCU.

> ---
>  security/selinux/avc.c   |    7 +++++--
>  security/selinux/hooks.c |   31 ++++++++++++++++++++++++++-----
>  2 files changed, 31 insertions(+), 7 deletions(-)
> diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/avc.c linux-2.6.22/security/selinux/avc.c
> --- linux-2.6.22.orig/security/selinux/avc.c	2007-07-09 08:32:17.000000000 +0900
> +++ linux-2.6.22/security/selinux/avc.c	2007-08-29 16:24:37.000000000 +0900
> @@ -845,7 +845,7 @@ int avc_ss_reset(u32 seqno)
>   * auditing, e.g. in cases where a lock must be held for the check but
>   * should be released for the auditing.
>   */
> -int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> +inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>                           u16 tclass, u32 requested,
>                           struct av_decision *avd)
>  {
> @@ -910,6 +910,9 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
>  	int rc;
>  
>  	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, &avd);
> -	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> +
> +	if ((requested & ~avd.allowed) | rc | (requested & avd.auditallow))

Why not make this test identical to the one within avc_audit, and remove
the test from avc_audit?  

I think we can actually turn the last remaining use of avc_audit()
outside of the avc into a normal avc_has_perm() check and make
avc_audit() private to avc.c.  At which point avc_audit() can be inline,
so you don't even need to move the test out of it.

> +		avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> +
>  	return rc;
>  }
> diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/hooks.c linux-2.6.22/security/selinux/hooks.c
> --- linux-2.6.22.orig/security/selinux/hooks.c	2007-07-09 08:32:17.000000000 +0900
> +++ linux-2.6.22/security/selinux/hooks.c	2007-08-29 16:21:51.000000000 +0900
> @@ -2462,6 +2462,11 @@ static int selinux_file_permission(struc
>  {
>  	int rc;
>  	struct inode *inode = file->f_path.dentry->d_inode;
> +	struct avc_audit_data ad;
> +	struct task_security_struct *tsec = current->security;
> +	struct file_security_struct *fsec = file->f_security;
> +	struct inode_security_struct *isec = inode->i_security;
> +	u32 av;
>  
>  	if (!mask) {
>  		/* No permission to check.  Existence test. */
> @@ -2472,11 +2477,27 @@ static int selinux_file_permission(struc
>  	if ((file->f_flags & O_APPEND) && (mask & MAY_WRITE))
>  		mask |= MAY_APPEND;
>  
> -	rc = file_has_perm(current, file,
> -			   file_mask_to_av(inode->i_mode, mask));
> -	if (rc)
> -		return rc;
> -
> +	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	ad.u.fs.mnt = file->f_path.mnt;
> +	ad.u.fs.dentry =  file->f_path.dentry;
> +	if (tsec->sid != fsec->sid) {
> +		rc = avc_has_perm(tsec->sid, fsec->sid,
> +					  SECCLASS_FD,
> +					  FD__USE,
> +					  &ad);
> +			if (rc)
> +				return rc;
> +	}
> +
> +	av = file_mask_to_av(inode->i_mode, mask);
> +	if (av) {
> +		if (unlikely (IS_PRIVATE (inode)))
> +			return 0;
> +		rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
> +				 av, &ad);
> +		if (rc)
> +			return rc;
> +	}
>  	return selinux_netlbl_inode_permission(inode, mask);
>  }

This kind of manual inlining of functions seems wrong conceptually,
although I can't argue with those numbers.

Are you sure about your data?  Ran it for many trials?  While in
single-user mode after a fresh boot?  

> Regards,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
