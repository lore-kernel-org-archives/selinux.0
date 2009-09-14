Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8EIR5Pm018194
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 14:27:05 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8EISSjN013119
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 18:28:29 GMT
Message-ID: <4AAEC3DA.7060004@manicmethod.com>
Date: Mon, 14 Sep 2009 18:29:46 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jeff Johnson <n3npq@mac.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Installing modular policy using RPM
References: <F64B192E-ADFA-42B7-B9AB-3C3855C8F9F5@mac.com>
In-Reply-To: <F64B192E-ADFA-42B7-B9AB-3C3855C8F9F5@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/12/2009 10:44 AM, Jeff Johnson wrote:
> Because of Tresys patches, I am forced to look at the
> issues of installing modular policy using RPM @rpm5.org.
>
> The core agenda appears to be make rpm "untrusted" by
> exec'ing semodule.
>

The core agenda is adding support for installing SELinux policies. One 
security requirement we have is to split out security domains to bracket 
security critical pieces where possible. This is how SELinux 
fundamentally works. In the future we'd like to look at how certain 
security critical functions can be split out of RPM itself. For example, 
a very small bracketed parser that does nothing more than unpack header 
components and policy would give us more faith that the policy being 
provided hasn't been corrupted. Additionally, signatures on the policy 
data would also be added.

> That opens up the issue of how to install in empty chroot's
> where a semodule executable may not be present.
>

We've provided fallbacks to library interfaces for these corner cases. 
It isn't ideal but it is necessary for e.g., cross-installs

> The approach that will be taken @rpm5.org will be to carry
> a semodule executable within rpm sources located in a
> private bin directory.
>

What about cross-installs? We may be able to do something similar in rpm4

> When installing in empty chroot's, rpm will undertake whatever
> is necessary to bring the executable (with xattr's attached) into
> the empty chroot, either by using mount(2) (my current preference)
> or by copying.
>

The rpm4 community didn't seem open to this idea, as it pollutes the 
clean chroot.

> That solves the core agenda issue of "untrusted" installs afaict.
> And there's the added benefit of __ALWAYS__ being able to rely
> on semodule being present without all the usual RPM assertion/ordering
> baggage to try to ensure that, indeed, an executable can be invoked.
>

There are still assertion/ordering issues. For example, if the policy 
module being installed requires a later libsepol than is on the system 
to read the format you won't be able to install it using any semodule 
binary on the system.

> But there are several other issues that are in need of thought.
>
> First of all, afaict there are no intergrity checks on *.pp
> modular policy that I've found so far. Blindly installing
> base64 encoded, bzip'd, blobs from an "untrusted" source
> has some fairly obvious flaws. I'd suggest getting some
> integrity check in place, even CRC32, to ensure that the
> blob is indeed as advertised. Some means for RPM to notify -lselinux
> that the signature on the header has been verified
> might help, but the policy blob is still a policy blob
> even if the signature on the header has been verified.
>

These are certainly topics we are going to approach in the future. 
Signed policies are pretty high on our list of necessities but we need 
to get the foundation laid to get to a point where we can implement and 
use them.

> Second, installing modular policy within a chroot re-opens
> all the usual issues of chroot(2) path prefixing, as well
> as disabling loading within the chroot (as is being done
> with mock currently). While using mount --bind to mask
> /selinux/load (I apologize if I've gotten the path wrong)
> "works" for the narrow case of mock builds, there will
> likely be a need for a better means of disabling semodule
> policy loads that will have to be undertaken by RPM. Expecting
> the correct CLI options to be present when semodule is invoked
> cannot always be relied on, particularly when there's already
> a great deal of divergence in how RPM is configured.
>

We intend to disable policy loading when running in a chroot, it will be 
in a future patchset not long from now.

> There's also the issue of modular policy dependencies (yes
> I've looked at selinux/policycoreutils/semodule_deps in git).
> Modular policy dependencies are rather simple compared to
> what is in RPM's assertion checker. Within the selinux
> namespace, there's a need to ensure that some label is
> already defined so that it can be reused. So modular
> policy dependencies are largely "mention before use",
> no different than say, in C, a variable must be declared
> before it is used.
>
> One rather simple means to do modular policy dependency checking
> would be to add a Bloom filter to *.pp modular policy packages.
> A Bloom filter (if done correctly) should scale nicely across
> numerous modular policy blob's without adding a great deal
> of "bloat". One will have to worry about false positives/negatives w 
> Bloom filters,
> and have Yet Another Means to verify modular policy dependencies
> but you already have explicit dependency checks in semodule afaict. A 
> Bloom filter
> would simply be a means to detect a class of failures sooner
> rather than later, needing only the .pp blob, not all the semodule
> and -lsemanage baggage.
>

I'm not sure what the point here is. We'd have to provide all sorts of 
data out of the *.pp file to be used in the dependency checking which 
would have all sorts of overhead.

> I will have other comments as I look more deeply into *.pp
> format. While *.pp may be perfectly useful for SELinux needs
> at the moment, the lack of data normalization and the redundancy
> within existing *.pp strings may not be the best means for
> distributing policy. Disclaimer: I haven't started to look at *.pp yet 
> ...

Not sure what the point is here either.

Note that in the future we are moving toward purely source (text based) 
policy modules to be shipped which should clear up alot of these issues.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
