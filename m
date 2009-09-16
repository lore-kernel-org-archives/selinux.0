MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Subject: Re: [PATCH] setfiles fails to relabel if selinux not enabled
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <1253111809.18198.104.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 16 Sep 2009 13:21:53 -0400
Cc: Joshua Brindle <jbrindle@tresys.com>, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Message-id: <8695AD02-EDBD-488D-95A1-56EE97D01BDF@mac.com>
References: <1253042418-28141-1-git-send-email-ccase@tresys.com>
 <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
 <06A6610D4F464D4EBEAFBF2C5F86911E014CEA9F@exchange2.columbia.tresys.com>
 <1253109741.18198.93.camel@moss-pluto.epoch.ncsc.mil>
 <D095955D-66A2-4A9E-854A-5A5AF0C92EF3@mac.com>
 <1253111809.18198.104.camel@moss-pluto.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 16, 2009, at 10:36 AM, Stephen Smalley wrote:

> On Wed, 2009-09-16 at 10:16 -0400, Jeff Johnson wrote:
>> On Sep 16, 2009, at 10:02 AM, Stephen Smalley wrote:
>>
>>>>
>>>> What is the best we can do? Should we always attempt to relabel if
>>>> selinux is disabled or not?
>>>
>>> The patch is the best we can do - we shouldn't exclude any mounts
>>> based
>>> on the absence of seclabel in /proc/mounts if SELinux is disabled.
>>> Historically setfiles has always supported relabeling filesystems  
>>> even
>>> if SELinux was disabled in the host.
>>
>> There's a fundamental confusion between the act (of labelling) and  
>> the
>> use of selinux labels.
>>
>> The issue shows up when there are multiple (and possibly  
>> incompatible)
>> sets of labels, such as in chroot's, or creating an image for a
>> different
>> installation.
>>
>> One can choose to not install labels condition on whether
>> is_selinux_enabled()
>> consistently and methodically.
>>
>> Perhaps a simpple example to illustrate:
>>
>> 	Should cp(1) always copy security labels or only if  
>> is_selinux_enabled
>> ()?
>>
>> What I'm hearing is "No. cp(1) should copy labels iff
>> is_selinux_senabled() is TRUE."
>
> That's a different issue.  Here we are talking about a recent change  
> to

Yes a different issue, but distribution (and the need for relabeling) !=
the use of the labels, yet applications (like cp(1)) have only  
is_selinux_enabled()
or (as in this report) the (non-)existence of sclable in /proc/mounts
to determine what behavior is "expected".

> setfiles that was preventing it from relabeling filesystems if SELinux
> was disabled (because then no filesystems were reporting the seclabel
> option in /proc/mounts).  As we want setfiles to support relabeling of
> filesystems even if SELinux is disabled, we want to skip the seclabel
> option processing in that case as the kernel won't report seclabel
> information when SELinux is disabled (seclabel means more than just
> "filesystem has an xattr handler").
>
> As far as cp goes, I believe you are correct - it will only preserve
> security contexts if SELinux is enabled, and even then, only if the
> caller specified -a or -c.  And in the -a case, it has to be able to
> gracefully fall back to not preserving the context if not permitted by
> policy, as not all callers will be able to do so for the security
> context even if they can do so for the DAC attributes.
>

I'd suggest changing cp(1) to always copy security.* xattr's if found,
overriding from CLI options when present.

But choosing a default behavior that is acceptable to everyone is a  
difficult
problem. There's no right or wrong if cp(1) copies security.* xattr's  
(or not),
only defacto expectations.

But please s/cp(1)/rpm(8)/ and consider what RPM should do if/when  
installing
modular policy in a chroot with /proc/selinux unmounted. I nearly  
implemented
	Always install security.* xattr's.
way back when, and (now that modular policy is headed into *.rpm  
packages somehow)
I am again considering what "default" behavior in RPM will lead to the  
fewest
RPM bug reports. I'm very likely to add a configurable policy install  
mode that achieves
	Always copy security.* xattr's when replacing a file.
with an appropriately automated conflict resolution when matchpathcon()
and *.pp (either from *.rpm packages or not) and what is currently  
present on
the file system all have differnt and incompatible security.* xattr's  
attached
to the path.

A "best effort" deterministic automation leads to fewer bug reports  
imho, ymmv.

And SELinux tools still relabel which can/will impose whatever labels  
you
want everywhere any time you choose. A tad costly, but known to work and
cannot be avoided. Yet.

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
