Message-ID: <533AB88C.3000900@tycho.nsa.gov>
Date: Tue, 01 Apr 2014 09:01:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tim_lee@htc.com, selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 ivy_lu@htc.com, jon_tsai@htc.com
Subject: Re: [SELinux] We found that there was bug on at
 /kernel/security/selinux/avc.c:158!
References: <5ADE3345D51E1E4A932ADBBE125E7CDB0B390A15@TPE-MBX01.HTC.COM.TW>
 <5335758D.6020900@tycho.nsa.gov>
 <5ADE3345D51E1E4A932ADBBE125E7CDB0B394F01@TPE-MBX01.HTC.COM.TW>
In-Reply-To: <5ADE3345D51E1E4A932ADBBE125E7CDB0B394F01@TPE-MBX01.HTC.COM.TW>
Content-Type: text/plain; charset=Big5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/01/2014 04:43 AM, Tim_lee@htc.com wrote:
> Hi Stephen,
> Thanks your great support to reply our questions. Check my reply as below:
> 
> Previously for a different issue, I suggested that you apply this patch:
> https://android-review.googlesource.com/#/c/79591/
> 
> I don't see that in the kernel to which you linked.  Have you applied it?
> Tim: We have applied this patch, but the issue device's ROM didn't include this patch.
> 
> Now, we have requested new release ROM with this patch then try to repo this issue symptom.
> And from your reply
>  
> "I also note that you have out-of-tree modules and proprietary modules listed in your kernel log, so there is certainly potential for memory corruption or lack of proper initialization/handling of
> inode->i_security there."
> 
> You mentioned that  there is certainly potential for memory corruption or lack of proper initialization/handling of
> inode->i_security there. Did you have any clues from the log to find out the root cause? Thanks your help.

This is just speculation, but you have two out-of-tree filesystem
modules listed in your "Modules linked in:" message in the kernel log:
ecryptfs (O) and texfat(PO).  Wondering if those were built with
CONFIG_SECURITY enabled (so that their kernel data structures, e.g.
struct inode, properly include the security field) and if they do
anything that might lead to an inode with an uninitialized or corrupted
security pointer.
