Subject: Re: Performance issues - huge amount of AVC misses
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>, selinux@tycho.nsa.gov
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5666F74C.3010302@tycho.nsa.gov>
Date: Tue, 8 Dec 2015 10:29:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/08/2015 05:25 AM, Michal Marciniszyn wrote:
> Hello,
>
> we are heavy SELinux shop and we recently run into AVC related
> performance issue. I was trying to find an answer on freenode IRC chat
> but I was sent here by multiple guys. We're running on Scientific Linux
> 6.6 (upgrade to 6.7 ongoing) and we see this on some of our nodes:
>
> # cat /selinux/avc/cache_stats
> lookups hits misses allocations reclaims frees
> 3976846641 3626568307 350278334 350303465 344833264 346344169
> 3474274460 3092218096 382056364 382081270 381170512 382671551
> 2037181411 1655679702 381501709 381527148 380680320 382162477
> 1943162363 1651603455 291558908 291584892 288099840 289631602
> 829213467 406079951 423133516 423158604 422311024 423847681
> 1963015875 1555848944 407166931 407192104 406718592 408227742
> 3490131033 3117047653 373083380 373108386 372270880 373862706
> 940880689 549698684 391182005 391207388 390339328 391888374
> 4098417807 3712068859 386348948 386373592 385604096 387172806
> 3931378773 3549502965 381875808 381901074 381059904 382628308

FWIW, avcstat would summarize that for you.
Those stats seem very unusual.  You said you see this on some nodes. 
Anything to distinguish these nodes from the others that don't exhibit 
this behavior?

>
> Also we see
>
> # cat /selinux/avc/hash_stats
> entries: 499
> buckets used: 257/512
> longest chain: 6
>
> Some times under load we see SELinux consuming about 30% of CPU time.
> There is about 16% of cache misses on these nodes (and sometimes it goes
> as high as 30%). The lates article about the issue is from RHEL 5 times
> -
> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
> . We do not feel this to be too relevant in this case.
>
> Are there any recommendations on cache sizing for SELinux? We can resize
> cache to 1024 or 2048 entries, but would this help to resolve the issue?

Yes, increasing the cache threshold should help as you are evidently 
thrashing the cache.

> I'm attaching seinfo from node with our policy and then for comparison
> from node without any policy.

What do you mean by "our policy" versus "without any policy"?  Do you 
mean that the former has some local policy modules that you have added 
and the latter is the stock SL6.6 policy?

> With policy:
> # seinfo
>
> Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> Policy Version & Type: v.24 (binary, mls)
>
>     Classes:            81    Permissions:       238
>     Sensitivities:       1    Categories:       1024
>     Types:            4273    Attributes:        295
>     Users:               9    Roles:              12
>     Booleans:          234    Cond. Expr.:       274
>     Allow:          352554    Neverallow:          0
>     Auditallow:        140    Dontaudit:      321786
>     Type_trans:      42813    Type_change:        38
>     Type_member:        48    Role allow:         19
>     Role_trans:        409    Range_trans:      6421
>     Constraints:        90    Validatetrans:       0
>     Initial SIDs:       27    Fs_use:             23
>     Genfscon:           84    Portcon:           505
>     Netifcon:            0    Nodecon:             0
>     Permissives:        91    Polcap:              2
>
>
>
> Without policy:
>
> seinfo
>
> Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> Policy Version & Type: v.24 (binary, mls)
>
>     Classes:            81    Permissions:       238
>     Sensitivities:       1    Categories:       1024
>     Types:            3926    Attributes:        295
>     Users:               9    Roles:              12
>     Booleans:          234    Cond. Expr.:       274
>     Allow:          320969    Neverallow:          0
>     Auditallow:        140    Dontaudit:      273256
>     Type_trans:      41915    Type_change:        38
>     Type_member:        48    Role allow:         19
>     Role_trans:        386    Range_trans:      6069
>     Constraints:        90    Validatetrans:       0
>     Initial SIDs:       27    Fs_use:             23
>     Genfscon:           84    Portcon:           479
>     Netifcon:            0    Nodecon:             0
>     Permissives:        91    Polcap:              2
>
>
> Any help or guidance would be very much appreciated, if there is more
> in-depth info needed I'll be more than happy to provide it.
