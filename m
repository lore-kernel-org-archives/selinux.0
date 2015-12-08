Subject: Re: Performance issues - huge amount of AVC misses
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
 <5666F8A8.3040703@tycho.nsa.gov>
 <CAL8PO=2TMsT=DUJ-1oKKC+OutuHWVH1VqTsNDqKxKRVwon7Urw@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56670E15.60305@tycho.nsa.gov>
Date: Tue, 8 Dec 2015 12:06:29 -0500
MIME-Version: 1.0
In-Reply-To: <CAL8PO=2TMsT=DUJ-1oKKC+OutuHWVH1VqTsNDqKxKRVwon7Urw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/08/2015 11:21 AM, Michal Marciniszyn wrote:
> Hi,
>
> there are neither categories nor MLS used on the system. I'll get the
> amount of different types used by the system (I need to do some digging,
> will get the data tomorrow). Most of classes will be regular file,
> directories and some symbolic links. There will be a lots of files as
> AFAIK vertica uses lots of smaller files.
>
> I'll try to reduce amount of dontaudit rules and I'll see how much this
> reduces cache misses. The hard truth is, that vertica is looking at many
> places during the run, most of which it does not need. Maybe the way we
> have rules defined is creating a lot of stress on the amount of rules in
> the policy, I'll try to get the data on that.

Cache misses aren't related to your number of dontaudit rules (or your 
number of rules at all, for that matter).  The optimal AVC size is 
driven by the number of unique (source security context, target security 
context, target security class) triples being accessed during the 
workload.  Each entry holds a complete access vector decision structure, 
including permissions that are allowed, permissions that are audited 
when denied, and permissions that are audited when allowed.

I would recommend trying different values for the cache threshold and 
see how it performs. Collecting information on the number of domains, 
types, and classes involved in your workload may be helpful in 
determining the optimal value, but some experimentation will likely be 
required regardless.

Reducing the number of rules may help with the performance overhead when 
there is an AVC miss, but the first step is to reduce the AVC misses.
