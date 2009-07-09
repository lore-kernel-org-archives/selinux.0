Date: Thu, 09 Jul 2009 11:03:05 -0400
Subject: [RFC] Install SELinux policies from rpm package header
From: Chad Sellers <csellers@tresys.com>
To: SE Linux <selinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-ID: <C67B7EE9.A8979%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RPM currently has support for security policies to be stored in an rpm
header but it doesn't currently do anything with the policies. Instead,
SELinux policy is usually installed through %post scripts. We're planning to
work with the RPM community to get integrated support for SELinux policy,
and we'd like to get some feedback on our plans from the SELinux community.

First, a bit of background. SELinux policy is currently installed through
%post scripts. This presents several problems. First, this means that policy
for a given application may not be loaded at the time the files are written
to disk, preventing those files from being labeled properly, because the
symbols used to label files need to be in the policy loaded into the kernel.
Secondly, this means that if multiple packages install policy, each of their
%post scripts will reload the policy, which is a very expensive operation.
Consequently, policy is generally kept in a single package to avoid this,
despite containing many application specific policy modules that might be
more suited to be included in their application package. There are many
other problems with the current RPM support which I'd be happy to get into
as well, but I'll leave them out for now to prevent this email from getting
too long.

So, what we would like to do is to start including SELinux policy as part of
the rpm and have rpm install all policies together before files start to hit
the disk. To do this, we would like to use the already supported %policy
directive, which stores the policy in the RPM archive header.

We would then install the policy very early (before pretrans). This policy
load would involve gathering all the policies to be installed from all
packages, writing them to a temporary location, and calling out to semodule
to install the SELinux policy modules.

This new support will enable application packages to include their policy
within their package (e.g. bind includes the bind policy module in the bind
rpm), which would make it much easier to ensure that the appropriate policy
version is installed for a given application version. Note that while it is
possible to include policy within application packages, it is not necessary.
This new support would still allow a single policy RPM to contain many
policy modules as we have today. Those policy modules could then be slowly
split out to be included with the applications they confine as it makes
sense.

Obviously I'm glossing over many implementation details that would need to
be worked out. The point of this email is strictly to get feedback on our
approach. You can see a proof of concept patch that begins this
implementation, as well as some of our conversation with the RPM community
here:

http://lists.rpm.org/pipermail/rpm-maint/2009-July/002452.html

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
