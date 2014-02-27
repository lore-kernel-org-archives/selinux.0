From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: put the mmap() DAC controls before the MAC
 controls
Date: Thu, 27 Feb 2014 11:22:15 -0500
Message-ID: <2802481.ZiEtmME2xN@sifl>
In-Reply-To: <530F607A.8070200@tycho.nsa.gov>
References: <20140227143045.14242.66994.stgit@localhost>
 <530F607A.8070200@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: casey.schaufler@intel.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, February 27, 2014 10:57:46 AM Stephen Smalley wrote:
> On 02/27/2014 09:30 AM, Paul Moore wrote:
> > It turns out that doing the SELinux MAC checks for mmap() before the
> > DAC checks was causing users and the SELinux policy folks headaches
> > as users were seeing a lot of SELinux AVC denials for the
> > memprotect:mmap_zero permission that would have also been denied by
> > the normal DAC capability checks (CAP_SYS_RAWIO).
> 
> So you think that the explanation given in the comment for the current
> ordering is no longer valid?

Yes and no.  Arguably there is still some value in it but there are enough 
problems with it as-is that I think the value is starting to be outweighed by 
the pain it is causing (Dan can be very annoying when he wants something <g>).  
For those users who still want notification of processes trying to mmap() low 
addresses, I think an audit watch is a much better approach.  I don't think 
SELinux shouldn't be acting as an intrustion detection tool when we have other 
things that do that job.

Let's also not forget that the MAC-before-DAC approach goes against the 
general approach to applying SELinux controls, so there is some argument to be 
had for consistency as well.

Do you have a strong objection to this patch?

-- 
paul moore
security and virtualization @ redhat
