Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6KLYEd1000679
 for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2017 17:34:14 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
 <1500405609.18445.14.camel@tycho.nsa.gov>
 <CAHC9VhQz686zC06smDZHf_GYF8EmHpErX5xXnx9bifU51EkwrQ@mail.gmail.com>
 <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
 <20170719071233.GA7053@julius.enp8s0.d30>
 <20170719204946.GA2890@julius.enp8s0.d30>
 <20170719213141.GB2890@julius.enp8s0.d30>
 <e8789b40-79e0-d19b-9278-14cec89cf674@ieee.org>
 <1500555858.22177.3.camel@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <4be29169-d043-1298-3288-dd813caf5b4b@ieee.org>
Date: Thu, 20 Jul 2017 17:08:07 -0400
MIME-Version: 1.0
In-Reply-To: <1500555858.22177.3.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/20/2017 09:04 AM, Stephen Smalley wrote:
> On Wed, 2017-07-19 at 21:17 -0400, Chris PeBenito wrote:
>> On 07/19/2017 05:31 PM, Dominick Grift wrote:
>>> On Wed, Jul 19, 2017 at 10:49:46PM +0200, Dominick Grift wrote:
>>>> On Wed, Jul 19, 2017 at 09:12:33AM +0200, Dominick Grift wrote:
>>>>> On Tue, Jul 18, 2017 at 09:07:45PM -0400, Chris PeBenito wrote:
>>>>>> Once this permission is implemented I'll likely add the
>>>>>> permission across
>>>>>> most if not all transitions out of systemd.
>>>>>
>>>>> Yes but do not expect that to ,always, be enough due to the
>>>>> inheritance aspect. A process may have inherited the NNP flag,
>>>>> not because its started by systemd but because its started by a
>>>>> process that inherited the NNP flag because it was started by
>>>>> systemd.
>>
>> That just makes me want to apply the permission to all transitions
>> for
>> all domains.  Not that I'm planning to do it in refpolicy.  I'm
>> definitely inclined to be very liberal in applying the permission in
>> refpolicy.  For my personal systems, I'd probably do an:
>>
>> allow domain domain:process nnp_nosuid_transition;
>>
>> so I don't ever have to think about it again.
>
> Caveats:
>
> 1. It would mean that transitions on any removable media would be
> possible, even when marked nosuid.  So, for example, if you were to
> mount (or have auto-mounted) removable media with nosuid but without
> noexec, and the removable media had been maliciously crafted with a
> file with an entrypoint type, then a user could use it to transition to
> a potentially more privileged SELinux domain, even though it could not
> gain capabilities or uid-0 that way (or, if the user can induce another
> process to execute from this filesystem, then this could produce a
> domain transition that would normally have been prevented).  Ditto for
> network filesystems.  This is perhaps an argument for introducing a
> separate check on nosuid; could be done via a file-based additional
> check (Can domain D nosuid_transition on file type T?) in addition to
> the nnp_nosuid_transition process-based permission check or by adding a
> process2 class and splitting nnp_nosuid_transition into
> nosuid_transition and nnp_transition process-based permissions.

This is a good point; however, if you're trusting removable media to do 
transitions on, you're already accepting a lot of risk of shooting 
yourself in the foot.  While I understand the logic of the nosuid fs 
behavior, it's always bugged me because it's not obvious to most people.


> 2. It would mean that all domains could enable NNP, install seccomp
> filters (allowed for unprivileged processes if NNP is enabled), and
> execve a domain-changing program with those filters in effect, which
> could potentially lead to subverting the new domain.  It is exactly for

To make sure I understand, by subvert you mean the child domain would 
malfunction because of having less perms than required?


> this reason that domain transitions under NNP were originally not
> allowed, and then only allowed for bounded transitions.  Also note that
> NNP is intended to be used to open up other previously unsafe actions
> for unprivileged processes, so this could be extended to more than just
> seccomp in the future (examples given in the past have included chroot,
> certain unshare/clone flags, etc, although it seems like some of this
> has been obsoleted/replaced by user namespaces).
>
> So from a safety POV, you really only want to allow this when the
> calling domain is more trusted than the callee domain; think of it as
> being similar (but not equivalent) to noatsecure and/or dyntransition.

Perhaps then the permission should be named something like 
nnp_nosuid_inh or inherit_nnp_nosuid or some variation thereof?

-- 
Chris PeBenito
