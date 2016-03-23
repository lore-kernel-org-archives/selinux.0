Subject: Re: does it make sense that dac_override get's checked before
 dac_read_search?
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <56F2B5F7.9050406@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F2C7A5.1090303@tycho.nsa.gov>
Date: Wed, 23 Mar 2016 12:43:17 -0400
MIME-Version: 1.0
In-Reply-To: <56F2B5F7.9050406@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2016 11:27 AM, Dominick Grift wrote:
> 
> A long time ago Eric Paris hinted that the policy WRT dac_override
> could probably be cleaned up.
> 
> I suspect that most of the the time dac_override is not needed (too
> coarse). Instead dac_read_search would be sufficient for the common
> scenario where root processes traverse locations where it doesn't have
> DAC permissions to traverse.
> 
> The problem is that dac_override seems to be checked first. but
> dac_override , if i understand it, is broader than dac_read_search
> 
> so why is dac_read_search not checked before dac_override?

I would be in favor of flipping the order of checks, but not sure how
receptive upstream would be.  Outside of LSMs, the order doesn't matter
since it isn't being audited, and checking CAP_DAC_OVERRIDE first does
allow them to optimize for the case where the process has it.  In their
world, the case where a process has CAP_DAC_READ_SEARCH but not
CAP_DAC_OVERRIDE is rare.

A somewhat similar case was the order of checks in can_do_mlock, which
did get reversed:
commit a5a6579db33af91f4f5134e14be758dc71c1b694
Author: Jeff Vander Stoep <jeffv@google.com>
Date:   Thu Mar 12 16:26:17 2015 -0700

    mm: reorder can_do_mlock to fix audit denial

    A userspace call to mmap(MAP_LOCKED) may result in the successful
locking
    of memory while also producing a confusing audit log denial.
can_do_mlock
    checks capable and rlimit.  If either of these return positive
    can_do_mlock returns true.  The capable check leads to an LSM hook
used by
    apparmour and selinux which produce the audit denial.  Reordering so
    rlimit is checked first eliminates the denial on success, only
recording a
    denial when the lock is unsuccessful as a result of the denial.

However, in that case reordering the checks was more performant in the
common case.
