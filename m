Message-ID: <5335758D.6020900@tycho.nsa.gov>
Date: Fri, 28 Mar 2014 09:13:49 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tim_lee@htc.com, selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 ivy_lu@htc.com, jon_tsai@htc.com
Subject: Re: [SELinux] We found that there was bug on at
 /kernel/security/selinux/avc.c:158!
References: <5ADE3345D51E1E4A932ADBBE125E7CDB0B390A15@TPE-MBX01.HTC.COM.TW>
In-Reply-To: <5ADE3345D51E1E4A932ADBBE125E7CDB0B390A15@TPE-MBX01.HTC.COM.TW>
Content-Type: text/plain; charset=Big5
Cc: nnk@google.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/28/2014 05:27 AM, Tim_lee@htc.com wrote:
> Hello guys,
> 
>  
> 
> I¡¦m Tim Lee from HTC who have mailed to you guys before about SELinux
> problem.
> 
> Now, we found that there was bug on at /kernel/security/selinux/avc.c:158!
> 
> Could you please help us to check why SELinux will got this kind of
> error then trigger bug on? Thanks.

Note the "SELinux:  Invalid class 119" message just prior to the BUG.
The BUG is when there is an out-of-range class value passed to the AVC.
Given the call chain, this suggests you have an inode whose i_security
pointer is referencing memory containing garbage values.

Previously for a different issue, I suggested that you apply this patch:
https://android-review.googlesource.com/#/c/79591/

I don't see that in the kernel to which you linked.  Have you applied it?

I also note that you have out-of-tree modules and proprietary modules
listed in your kernel log, so there is certainly potential for memory
corruption or lack of proper initialization/handling of
inode->i_security there.

You don't need to post to both lists; just pick the most relevant one.
