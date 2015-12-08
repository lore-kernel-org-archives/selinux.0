Subject: Re: Performance issues - huge amount of AVC misses
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>,
 selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5666F8A8.3040703@tycho.nsa.gov>
Date: Tue, 8 Dec 2015 10:35:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/08/2015 09:56 AM, Michal Marciniszyn wrote:
> Hi Dominic,
>
> while there is quite a lot of dontaudit rules around, the amount for
> domains running on this node is not high. Is there any way how to
> monitor which rules are loaded and released from the cache? Anything
> better than plain aggregated stats? We would bot care about performance
> of such monitoring tool if it provides some useful answer. For instance,
> is there a way how to use system tap or similar kernel profiling to get
> the data?
>
> I'll do a profiling on how many rules actually apply for the domains on
> the node (i.e. use sesearch to find out). If doing so, does the rule in
> cache hold whole vector (i.e. A is allowed to do X, Y, Z on B or is one
> cache entry A can do X on B)?

One cache entry holds the entire access vector.  However, they are 
unique per (source context, target context, target class) triple.

Are you using categories on this system (i.e. running processes in 
specific category sets, assigning specific categories to files), or just 
types?

How many unique domains are running in your workload?  How many file 
types are typically accessed by your workload?  How many different kinds 
of files (regular, directory, symbolic link, block device, ...) are part 
of your workload?
