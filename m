Message-ID: <527168B1.4040905@tycho.nsa.gov>
Date: Wed, 30 Oct 2013 16:14:41 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com>
In-Reply-To: <52715E75.5000005@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 03:31 PM, Daniel J Walsh wrote:
> We are trying to shrink out cloud image as small as possible.  One idea was to
> shrink SELinux Policy footprint by adding compression to it.
> 
> Here is a patch I have been fooling around with which would read a policy.29
> file if it was compressed with xz.
> 
> xz compression does around a 90% compression on the policy file,  and does not
> slow the load in any meaningfull way.
> 
> I also have done a patch to try out gzip.
> 
> gzip and xz are already used in systemd, which means we would not need to add
> a new requirement to the minimal system.
> 
> xz seems quicker and smaller then gzip.
> 
> Have not started playing with libsemanage yet.
> 
> What do you think?  Is xz availabel on Android?

Personally, I'd much rather see work done on shrinking the actual policy
size in Fedora rather than just compressing it.  Both by reducing the
overall size of refpolicy through coalescing similar domains/types and
by making better use of the work that has already been done to support
putting policy modules into rpms and only installing what actually get used.

On the former, I wrote a little tool for Android called sepolicy-analyze
that identifies all equivalent types in the policy.  It works nicely on
the Android policy but unfortunately I gave up waiting on it running on
Fedora policy because it is so large.  We're also looking at extending
that tool to identify isomorphic types, not just equivalent ones.  I
know apol has a similar feature under the Analysis tab (Types
relationship summary) but it only does it on a pairwise basis; there
doesn't seem to be any way to apply it systematically.

Anyway, with regard to impact on Android of your patch, it won't affect
it as libselinux is forked (and significantly modified) there as Joshua
noted and we don't bring over any of libsemanage or policycoreutils
either (we reimplemented the pieces of policycoreutils that we wanted in
the Android init and toolbox programs, just as people previously did in
busybox).  And we only build/use libsepol and checkpolicy on the build
host, not the device.  So I think the only real concern is whether this
is an acceptable dependency on conventional Linux distros.









--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
