Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JF7KrT012495
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 11:07:20 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JF7JNX006404
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 15:07:19 GMT
Received: from [10.1.12.42] (twoface.columbia.tresys.com [10.1.12.42])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id i8JF7KSf032493
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 11:07:20 -0400
Message-ID: <414DA0A7.1000708@gentoo.org>
Date: Sun, 19 Sep 2004 11:07:19 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: [RFC] Upstream policy handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It has been noted in the past that Gentoo policy changes don't often 
come upstream. This has been an issue because the policy has diverged a 
bit from the upstream policy and the changes are generally incompatible 
with those being made elsewhere (and being pushed upstream). For this 
reason I believe the current method of sharing the policy is inadequate. 
The current upstream policy is a compositite of most changes made by 
distros and policy writers who may have different philosophies about how 
the policy should work.

One example is our sysadmfile trim which happened a few weeks ago. Chris 
  PeBenito suggested this on the list only to be scrutinized, we have 
since gone ahead with the changes but based on the feedback here Chris 
felt it a moot point to post the changes. Recently it was suggested by 
another distro (though vetoed by Steve) to make sysadmfile even more 
accessible to non-admins. This illustrates the radical difference in 
policy philosophies.

I feel that distro tunables are undesirable. They bloat the policy in 
unnecessary ways and just don't make sense to me. Downstream vendors 
often apply their own patches to applications, so Gentoo, Debian and 
Redhat would have patchsets for apps rather than the upstream app having 
#ifdef REDHAT ... #elif DEBIAN and so on. (Russel pointed out that some 
apps have this sort of thing in upstream but that doesn't make it 
correct ;) )

Having said that, my suggestion to reconcile these issues and make the 
policy more flexible to downstream movement is to utilize more resources 
which make multiple branch repositories far easier to deal with. 
Specifically I think it would be optimal to set up a policy repository 
at bkbits.net (yes, this is bitkeeper, yes I know about the license, 
will cover that later). In this repository there should be branches for 
each vendor, and the NSA. Obviously each vendor pushes their own policy 
changes into their branch. If the NSA and/or any other vendors like the 
  change they can import that patchset into their own branch. This 
should work well for base-policy changes and also for application policies.

Second, I think the current policy layout might not be optimal for 
sharing of this nature. Since the policy module compiler will be 
available soon now might be the time to reconstruct the policy layout, 
my suggestion is as follows

NSA policy -+
	base-policy -+
		Makefile
		users
		rbac
		genfs_contexts
		...
		domains -+
			admin.te
			...
			programs -+
				(only .te's in base-policy)
		file_contexts -+
			(only .fc's in base-policy)

	applications -+
		apache -+
			apache.te
			apache.fc
			apache_macros.te
		...

Redhat policy -+
	....

Gentoo policy -+
	....

and so on

this would make it much easier to share applications as well.

This would provide a centralized repository for full copies of policy 
from multiple places, and a very easy way to compare them for 
differences. It would also allow us to share policy much more 
effectively while keeping the full policy source available in a central 
place.

So, the bitkeeper caveats would prevent someone from adding a cvs, arch 
or svn policy to the repository, and the other draconian license 
restrictions make it difficult to use, but the features it offers over 
cvs might make it worthwhile anyway. Also it provides a neutral place to 
  host the repository (bkbits), like sourceforge is doing for us currently.

If there are any other suggestions or comments on this I'd like to hear 
them. Obviously the implementation details are up in the air here, and I 
know that some of you can't/won't use bk. If there are suggestions for a 
  better system and a way to host it (preferably neutrally) that would 
be great.


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
