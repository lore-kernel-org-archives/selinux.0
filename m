MIME-Version: 1.0
In-Reply-To: <52716DE6.8040401@redhat.com>
References: <52715E75.5000005@redhat.com>
	<527168B1.4040905@tycho.nsa.gov>
	<52716DE6.8040401@redhat.com>
Date: Sat, 2 Nov 2013 17:42:38 +0100
Message-ID: <CAPzO=NyM2K5zb3DemGOxCFVU3dwuFDjo23AgtxS=oSwxrFdDxA@mail.gmail.com>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on Linux.
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 30, 2013 at 9:36 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
[...]
>> On 10/30/2013 03:31 PM, Daniel J Walsh wrote:
>>> We are trying to shrink out cloud image as small as possible.  One idea
>>> was to shrink SELinux Policy footprint by adding compression to it.
[...]
>> Personally, I'd much rather see work done on shrinking the actual policy
>> size in Fedora rather than just compressing it.  Both by reducing the
>> overall size of refpolicy through coalescing similar domains/types and by
>> making better use of the work that has already been done to support putting
>> policy modules into rpms and only installing what actually get used.
[...]
> Well we have done some work on combining like domains, see antivirus and
> spamassassin, but this is a lot of work which no one has time for.
>
> I would love to see the mailserver and mailclients domains combined.
>
> If people want to suggest or more importantly submit patches to combine other
> domains, I am all for it.
>
> Problems with shipping policy within rpm still exists. although we (Red Hat)
> are at least moving toward layered products shipping their own policy.
> openstack-selinux, openshift-selinux, gluster-selinux.  This is more for them
> updating quicker then RHEL.

In Gentoo, we try to only install the SELinux policies related to the
package that is installed. So if a system does not have a web server,
no httpd policies are loaded. This works pretty well. My workstation
(which is where I do all my SELinux policy development on) has 100
policy modules loaded; my servers usually have around 50 to 60 modules
loaded. That makes running things like "semodule -B" rather smooth.
Not really fast, but one doesn't need to switch to another thing to do
while waiting (4 seconds on a VM I'm currently playing with).

When updates occur only on a module's .te file, it could even be
distributed towards the users easily (no need to do a full policy
refresh), although I usually wait and make a full policy release.

It probably doesn't take long for Fedora/RedHat to find out which
packages need which SELinux policy modules. A quick way to find them
is to parse the RPM file list and check the file contexts of the
SELinux policy tree for matches.

> For every apache bug in policy, do we want to wait for an update apache
> package, or do we ship lots more packages.

I'd go for the latter. Put the policies in their own RPMs.

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
