Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8CEib0Q016539
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 10:44:37 -0400
Received: from asmtpout025.mac.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8CEhuYV025051
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 14:43:56 GMT
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Received: from falmouth.jbj.org
 (cpe-069-134-024-120.nc.res.rr.com [69.134.24.120])
 by asmtp025.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KPV0088R4YAF540@asmtp025.mac.com> for
 selinux@tycho.nsa.gov; Sat, 12 Sep 2009 07:44:36 -0700 (PDT)
From: Jeff Johnson <n3npq@mac.com>
Subject: Installing modular policy using RPM
Date: Sat, 12 Sep 2009 10:44:33 -0400
Message-id: <F64B192E-ADFA-42B7-B9AB-3C3855C8F9F5@mac.com>
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because of Tresys patches, I am forced to look at the
issues of installing modular policy using RPM @rpm5.org.

The core agenda appears to be make rpm "untrusted" by
exec'ing semodule.

That opens up the issue of how to install in empty chroot's
where a semodule executable may not be present.

The approach that will be taken @rpm5.org will be to carry
a semodule executable within rpm sources located in a
private bin directory.

When installing in empty chroot's, rpm will undertake whatever
is necessary to bring the executable (with xattr's attached) into
the empty chroot, either by using mount(2) (my current preference)
or by copying.

That solves the core agenda issue of "untrusted" installs afaict.
And there's the added benefit of __ALWAYS__ being able to rely
on semodule being present without all the usual RPM assertion/ordering
baggage to try to ensure that, indeed, an executable can be invoked.

But there are several other issues that are in need of thought.

First of all, afaict there are no intergrity checks on *.pp
modular policy that I've found so far. Blindly installing
base64 encoded, bzip'd, blobs from an "untrusted" source
has some fairly obvious flaws. I'd suggest getting some
integrity check in place, even CRC32, to ensure that the
blob is indeed as advertised. Some means for RPM to notify -lselinux
that the signature on the header has been verified
might help, but the policy blob is still a policy blob
even if the signature on the header has been verified.

Second, installing modular policy within a chroot re-opens
all the usual issues of chroot(2) path prefixing, as well
as disabling loading within the chroot (as is being done
with mock currently). While using mount --bind to mask
/selinux/load (I apologize if I've gotten the path wrong)
"works" for the narrow case of mock builds, there will
likely be a need for a better means of disabling semodule
policy loads that will have to be undertaken by RPM. Expecting
the correct CLI options to be present when semodule is invoked
cannot always be relied on, particularly when there's already
a great deal of divergence in how RPM is configured.

There's also the issue of modular policy dependencies (yes
I've looked at selinux/policycoreutils/semodule_deps in git).
Modular policy dependencies are rather simple compared to
what is in RPM's assertion checker. Within the selinux
namespace, there's a need to ensure that some label is
already defined so that it can be reused. So modular
policy dependencies are largely "mention before use",
no different than say, in C, a variable must be declared
before it is used.

One rather simple means to do modular policy dependency checking
would be to add a Bloom filter to *.pp modular policy packages.
A Bloom filter (if done correctly) should scale nicely across
numerous modular policy blob's without adding a great deal
of "bloat". One will have to worry about false positives/negatives w  
Bloom filters,
and have Yet Another Means to verify modular policy dependencies
but you already have explicit dependency checks in semodule afaict. A  
Bloom filter
would simply be a means to detect a class of failures sooner
rather than later, needing only the .pp blob, not all the semodule
and -lsemanage baggage.

I will have other comments as I look more deeply into *.pp
format. While *.pp may be perfectly useful for SELinux needs
at the moment, the lack of data normalization and the redundancy
within existing *.pp strings may not be the best means for
distributing policy. Disclaimer: I haven't started to look at *.pp  
yet ...

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
