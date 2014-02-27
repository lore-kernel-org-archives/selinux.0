Message-ID: <530F673B.5080906@tycho.nsa.gov>
Date: Thu, 27 Feb 2014 11:26:35 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] selinux: put the mmap() DAC controls before the MAC
 controls
References: <20140227143045.14242.66994.stgit@localhost>
 <530F607A.8070200@tycho.nsa.gov> <2802481.ZiEtmME2xN@sifl>
In-Reply-To: <2802481.ZiEtmME2xN@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: casey.schaufler@intel.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/27/2014 11:22 AM, Paul Moore wrote:
> On Thursday, February 27, 2014 10:57:46 AM Stephen Smalley wrote:
>> On 02/27/2014 09:30 AM, Paul Moore wrote:
>>> It turns out that doing the SELinux MAC checks for mmap() before the
>>> DAC checks was causing users and the SELinux policy folks headaches
>>> as users were seeing a lot of SELinux AVC denials for the
>>> memprotect:mmap_zero permission that would have also been denied by
>>> the normal DAC capability checks (CAP_SYS_RAWIO).
>>
>> So you think that the explanation given in the comment for the current
>> ordering is no longer valid?
> 
> Yes and no.  Arguably there is still some value in it but there are enough 
> problems with it as-is that I think the value is starting to be outweighed by 
> the pain it is causing (Dan can be very annoying when he wants something <g>).  
> For those users who still want notification of processes trying to mmap() low 
> addresses, I think an audit watch is a much better approach.  I don't think 
> SELinux shouldn't be acting as an intrustion detection tool when we have other 
> things that do that job.
> 
> Let's also not forget that the MAC-before-DAC approach goes against the 
> general approach to applying SELinux controls, so there is some argument to be 
> had for consistency as well.
> 
> Do you have a strong objection to this patch?

No, although I do wonder if we ought to just dispense with mmap_zero
altogether at this point.  It made sense when there was no capability
check or if the capability was one of the extremely broad ones (e.g.
CAP_SYS_ADMIN), but I don't really see why we can't be just as
restrictive with CAP_SYS_RAWIO / sys_rawio as with mmap_zero.
