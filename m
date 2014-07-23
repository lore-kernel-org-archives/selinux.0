Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6N66Y1E025423
 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2014 02:06:34 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so1049530pad.24
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 23:06:21 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.83.48])
 by mx.google.com with ESMTPSA id ce13sm1584592pdb.76.2014.07.22.23.06.19
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 22 Jul 2014 23:06:20 -0700 (PDT)
Message-ID: <53CF50D9.5000205@gmail.com>
Date: Wed, 23 Jul 2014 11:36:17 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a policy capability?
References: <53CA2650.2050608@gmail.com> <53CD0CCB.5080300@tycho.nsa.gov>
 <53CDF09D.4050304@gmail.com> <53CE5CDA.50901@tycho.nsa.gov>
In-Reply-To: <53CE5CDA.50901@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/14 18:15, Stephen Smalley wrote:
> On 07/22/2014 01:03 AM, dE wrote:
>> On 07/21/14 18:21, Stephen Smalley wrote:
>>> On 07/19/2014 04:03 AM, dE wrote:
>>>> I came cross this term and couldn't find much reference to it.
>>> A mechanism for telling the kernel that your policy supports some new
>>> feature/capability and therefore it is safe for the kernel to enable the
>>> corresponding check/logic.  Used as a way of supporting new
>>> checks/features in a backward-compatible manner:  old policies will not
>>> have defined the policy capability for the new feature and therefore
>>> will not enable the new check/logic by default, while new policies can
>>> opt into or out of the new check/logic at their discretion.
>>>
>>> ls /sys/fs/selinux/policy_capabilities will show the list of policy
>>> capabilities known to your kernel, while cat
>>> /sys/fs/selinux/policy_capabilities/<capability_name> will show whether
>>> that capability was enabled (1) or disabled (0) in the currently loaded
>>> policy.
>>>
>>> seinfo --polcap will list enabled policy capabilities in the current or
>>> specified policy.
>>>
>>> The set of policy capabilities to be enabled in the policy is declared
>>> in refpolicy/policy/policy_capabilities in the refpolicy source.
>>>
>>> The kernel uses the value of specific policy capabilities to decide
>>> whether to enable corresponding checks/logic in security/selinux/hooks.c
>>> in the kernel source; look for tests of selinux_policycap_*.
>>> These variables are set upon policy load by security_load_policycaps(),
>>> loaded from a bitmap read from the policy file.
>> Ok, thanks for clarifying.
>>
>> But just curious -- these new checks may not be not be backwards
>> compatible? I mean if the kernel has enabled a policy feature, but the
>> loaded policy does not have any such capability, then can it cause any
>> problems?
> Just to add to what Chris said:  while the handle_unknown=allow
> mechanism could already address the simple case of adding an entirely
> new permission to the kernel in a compatible manner, it could not
> address changes to the semantics of an already defined permission or
> replacing an older set of permission checks with new logic.  And with
> handle_unknown=allow, you could not distinguish on a per-feature basis;
> it was all allowed or none allowed for unknown classes/permissions.
> Thus, policy capabilities were introduced as a more general mechanism.
>
>> Also the policy has a version, using that it's capabilities can be known
>> to the kernel and it may enable disable the features based on that. So
>> in this case, why is policy capability required?
> We actually used the policy version that way when we first introduced
> finer-grained netlink socket classes, so that older policies would still
> use a single netlink socket class but newer policies could leverage the
> finer-grained classes.  However, as Chris pointed out, that version is
> intended to represent changes to the binary policy format, and this was
> a misuse of it.  Similarly to handle_unknown, you could also only use it
> to enable all or none of the newer features, not on a per-feature basis.
>

Thanks for clarifying everyone.
