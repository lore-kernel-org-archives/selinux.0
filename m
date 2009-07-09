Message-ID: <4A5657AE.8040602@redhat.com>
Date: Thu, 09 Jul 2009 16:48:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Howarth <paul@city-fan.org>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [RFC] Install SELinux policies from rpm package header
References: <C67B7EE9.A8979%csellers@tresys.com> <20090709211019.518eeb3b@metropolis.intra.city-fan.org>
In-Reply-To: <20090709211019.518eeb3b@metropolis.intra.city-fan.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/09/2009 04:10 PM, Paul Howarth wrote:
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
> It's also important to realise that policy module dependencies would
> have to be versioned, with a version bump when there's an interface
> change as per shared libraries.
> 
> 3. I've encountered problems in the past when installing RPMs
> containing SELinux policy when either:
> (a) the policy module package was built against a newer version of base
> policy - hence the versioning requirement in packaging draft above, or
> (b) a policy module I've developed locally is merged to or otherwise
> conflicts with the main selinux-policy package
> This can result in policy not loading. I know how to resolve issues
> like these manually but if policy is going to be spread more widely
> between packages, issues like these need to be resolved in a better
> (automagic?) way.
> 
> Paul.
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
A couple of other problems with including policy with each rpm.  How do you handle different packaging.  MLS, Targeted, minimal.

If every package includes policy then we need to rely on the package maintainer to write good secure policy.  You have to realize that the goal of a package maintainer is to make the tool run, not necessarily to make sure it is secure or that other componants of the OS integrate well.  

ftp sometimes need to read any file on the OS, so I will add files_read_all(ftp_t)

Now getting the few packages that ship their own policy to work better and the selinux-policy package to work better would be great.  

How about fixing things like semanage command

semanage fcontext ....
semanage ports ....
restorecon ...


Removal of policy packages is a huge problem in that once a type is removed you end up with mislabeled files that can not be indentified.

You do not know where these files are and you need to relabel the entire machine to make sure there are no longer any mislabeled files around.

When you update policy you need to run a diff between the old file context and the new and run a recusive restorecon on the diff.  fixfiles -C PREVIOUS_FILECONTEXT relabel does this for you, but every rpm transaction that does a policy modules update needs to run this at the completion of the transaction.  As well as squirrel away the previous file context before the transaction.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
