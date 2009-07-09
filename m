Date: Thu, 09 Jul 2009 16:54:43 -0400
Subject: Re: [RFC] Install SELinux policies from rpm package header
From: Chad Sellers <csellers@tresys.com>
To: Paul Howarth <paul@city-fan.org>
CC: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-ID: <C67BD153.A89B9%csellers@tresys.com>
In-Reply-To: <20090709211019.518eeb3b@metropolis.intra.city-fan.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/9/09 4:10 PM, "Paul Howarth" <paul@city-fan.org> wrote:

> On Thu, 09 Jul 2009 11:03:05 -0400
> Chad Sellers <csellers@tresys.com> wrote:
> 
>> RPM currently has support for security policies to be stored in an rpm
>> header but it doesn't currently do anything with the policies.
>> Instead, SELinux policy is usually installed through %post scripts.
>> We're planning to work with the RPM community to get integrated
>> support for SELinux policy, and we'd like to get some feedback on our
>> plans from the SELinux community.
>> 
>> First, a bit of background. SELinux policy is currently installed
>> through %post scripts. This presents several problems. First, this
>> means that policy for a given application may not be loaded at the
>> time the files are written to disk, preventing those files from being
>> labeled properly, because the symbols used to label files need to be
>> in the policy loaded into the kernel. Secondly, this means that if
>> multiple packages install policy, each of their %post scripts will
>> reload the policy, which is a very expensive operation. Consequently,
>> policy is generally kept in a single package to avoid this, despite
>> containing many application specific policy modules that might be
>> more suited to be included in their application package. There are
>> many other problems with the current RPM support which I'd be happy
>> to get into as well, but I'll leave them out for now to prevent this
>> email from getting too long.
>> 
>> So, what we would like to do is to start including SELinux policy as
>> part of the rpm and have rpm install all policies together before
>> files start to hit the disk. To do this, we would like to use the
>> already supported %policy directive, which stores the policy in the
>> RPM archive header.
>> 
>> We would then install the policy very early (before pretrans). This
>> policy load would involve gathering all the policies to be installed
>> from all packages, writing them to a temporary location, and calling
>> out to semodule to install the SELinux policy modules.
>> 
>> This new support will enable application packages to include their
>> policy within their package (e.g. bind includes the bind policy
>> module in the bind rpm), which would make it much easier to ensure
>> that the appropriate policy version is installed for a given
>> application version. Note that while it is possible to include policy
>> within application packages, it is not necessary. This new support
>> would still allow a single policy RPM to contain many policy modules
>> as we have today. Those policy modules could then be slowly split out
>> to be included with the applications they confine as it makes sense.
>> 
>> Obviously I'm glossing over many implementation details that would
>> need to be worked out. The point of this email is strictly to get
>> feedback on our approach. You can see a proof of concept patch that
>> begins this implementation, as well as some of our conversation with
>> the RPM community here:
>> 
>> http://lists.rpm.org/pipermail/rpm-maint/2009-July/002452.html
> 
> In addition to the discussion on the RPM list, some accumulated wisdom
> on integrating policy modules with existing RPM infrastructure can be
> found on the Fedora wiki:
> 
> https://fedoraproject.org/wiki/SELinux_Policy_Modules_Packaging_Draft
> 
> A few things spring to mind straight away:
> 
> 1. Package Removal
> 
> At package removal time, it's important that policy stays around until
> files have been removed *and* in the case of packages for daemons,
> processes killed. Removing policy underneath a running process can
> result in unlabeled processes that are unkillable.
> 
That's a good point. We were planning to remove policy at the end, but I'm
not sure how that would interact with running daemons. It appears that this
scenario should be handled with care and requires specific knowledge of the
particular policy (to flip a boolean). So, I don't think we could handle
this automatically. Perhaps we should include a fallback mechanism to allow
package authors to turn off automatic removal and revert to a %postun
script. Thoughts?

> 2. Dependencies
> 
> Policy modules include interfaces, and call the interfaces of other
> modules. In order to ensure that all required interfaces are present,
> packages will have to grow another set of dependencies on the packages
> that provide these interfaces. Since policy is generally written to
> encompass everything that an application *might* need to be able to do,
> it follows that more packages will be pulled in as dependencies as a
> result of policy than would have been pulled in in the absence of the
> bundled policy. A way around this might be to package the policy in
> subpackages rather than the main packages, and the likely result of
> this is having vast swathes of policy subpackages installed but not the
> main packages that go with them because they're not actually needed,
> which is not too far away from where we are today except that all of
> those policy modules are in a single package today - and I rather
> suspect that would be more efficient in terms of metadata/disk space
> etc.
> 
Our goal here is to provide a better mechanism for installing policy that
can be used with policy in the application package or in a subpackage. As
the Fedora wiki points out, there are reasons to choose either of these, and
we want to support both choices.

Also, note that policy is written to encompass everything an application
might need to be able to do, but much of this policy utilizes optional
blocks. This means these bits of policy don't depend on other policy
modules, but instead will utilize them if they're around. This limits the
explosion of dependencies in the non-subpackage case.

> It's also important to realise that policy module dependencies would
> have to be versioned, with a version bump when there's an interface
> change as per shared libraries.
> 
Agreed.

> 3. I've encountered problems in the past when installing RPMs
> containing SELinux policy when either:
> (a) the policy module package was built against a newer version of base
> policy - hence the versioning requirement in packaging draft above, or

This is a deficiency of the current policy language that we're working on
fixing (in a separate project concurrently). We really want to get to the
point where more is resolved at install time and less is resolved at build
time. In the mean time, your correct that version requirements will be more
extensive.

> (b) a policy module I've developed locally is merged to or otherwise
> conflicts with the main selinux-policy package
> This can result in policy not loading. I know how to resolve issues
> like these manually but if policy is going to be spread more widely
> between packages, issues like these need to be resolved in a better
> (automagic?) way.
> 
Should a conflict occur, we'll of course provide a (hopefully) useful error
message and bail on the transaction. I'm not sure what automagic resolution
we would be able to offer. We'll provide a way to install an rpm without its
policy should a conflict arise that the user cannot resolve, but I can't
begin to imagine how to do automagic resolution of conflicts with the
current policy language.

Thanks very much for the feedback. It is much appreciated.

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
