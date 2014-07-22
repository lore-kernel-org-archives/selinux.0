Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6M53VoH005122
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 01:03:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so11232096pad.35
 for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2014 22:03:34 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.21.65])
 by mx.google.com with ESMTPSA id jb5sm15886537pbd.73.2014.07.21.22.03.30
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Jul 2014 22:03:33 -0700 (PDT)
Message-ID: <53CDF09D.4050304@gmail.com>
Date: Tue, 22 Jul 2014 10:33:25 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a policy capability?
References: <53CA2650.2050608@gmail.com> <53CD0CCB.5080300@tycho.nsa.gov>
In-Reply-To: <53CD0CCB.5080300@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/21/14 18:21, Stephen Smalley wrote:
> On 07/19/2014 04:03 AM, dE wrote:
>> I came cross this term and couldn't find much reference to it.
> A mechanism for telling the kernel that your policy supports some new
> feature/capability and therefore it is safe for the kernel to enable the
> corresponding check/logic.  Used as a way of supporting new
> checks/features in a backward-compatible manner:  old policies will not
> have defined the policy capability for the new feature and therefore
> will not enable the new check/logic by default, while new policies can
> opt into or out of the new check/logic at their discretion.
>
> ls /sys/fs/selinux/policy_capabilities will show the list of policy
> capabilities known to your kernel, while cat
> /sys/fs/selinux/policy_capabilities/<capability_name> will show whether
> that capability was enabled (1) or disabled (0) in the currently loaded
> policy.
>
> seinfo --polcap will list enabled policy capabilities in the current or
> specified policy.
>
> The set of policy capabilities to be enabled in the policy is declared
> in refpolicy/policy/policy_capabilities in the refpolicy source.
>
> The kernel uses the value of specific policy capabilities to decide
> whether to enable corresponding checks/logic in security/selinux/hooks.c
> in the kernel source; look for tests of selinux_policycap_*.
> These variables are set upon policy load by security_load_policycaps(),
> loaded from a bitmap read from the policy file.

Ok, thanks for clarifying.

But just curious -- these new checks may not be not be backwards 
compatible? I mean if the kernel has enabled a policy feature, but the 
loaded policy does not have any such capability, then can it cause any 
problems?


Also the policy has a version, using that it's capabilities can be known 
to the kernel and it may enable disable the features based on that. So 
in this case, why is policy capability required?
