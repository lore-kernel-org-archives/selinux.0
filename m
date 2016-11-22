Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMHwLP4012077
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 12:58:21 -0500
Received: by mail-wj0-f171.google.com with SMTP id qp4so46019423wjc.3
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 09:58:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f640a61d-9e8f-17ee-aff7-610eca121b55@tycho.nsa.gov>
References: <CAFJ0LnF39oRy0emD6JQn6ouQp0uwG_Q6a5NbWVczSfF=2t4yqg@mail.gmail.com>
 <f640a61d-9e8f-17ee-aff7-610eca121b55@tycho.nsa.gov>
From: Nick Kralevich <nnk@google.com>
Date: Tue, 22 Nov 2016 09:58:16 -0800
Message-ID: <CAFJ0LnFo47at_dcL6Xm=Ze4mjLLwz7Yh506-t7b_48GUHND5ug@mail.gmail.com>
Subject: Re: Finer grained SELinux controls for CAP_SYS_ADMIN functionality
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I briefly reviewed the current CAP_SYS_ADMIN capabilities, and I
didn't see any obvious commonality which would make it easy to define
an equivalence set. I'm not sure this is feasible or makes sense. I'm
also not confident of trying to split CAP_SYS_ADMIN as it's
traditionally been attempted (aka the CAP_SYSLOG type changes). It's
not going to scale to the hundreds of users of this capability.

Instead, as a strawman proposal, what if we introduced "capability
families"? A capability family is essentially a namespace for
capabilities. More specifically, instead of a call like:

  if (!capable(CAP_SYS_ADMIN))
    return -EPERM;

what if we modified the capable() call to take an extra string argument

  if (!capable(CAP_SYS_ADMIN, "virtual_mem_subsystem"))
    return -EPERM;

On the SELinux side, we can use the family string to assign names to
labels, and do a capability check against a particular label.

On the traditional DAC side, we could introduce a new prctl(), say
prctl(PR_CAPSET_FAMILIES), which took an array of strings which
restricted capabilities to the allowed families.

  prctl(PR_CAPSET_FAMILIES, [ "virtual_mem_subsystem", "dev_random_subsystem" ])

On the prctl side, we'd need to think through the process lifecycle
problem. For instance, we wouldn't want a process to be able to update
it's list of allowed capability families, otherwise a process could
gain capabilities it shouldn't have access to.

DAC backwards compatibility is straight forward. If a process doesn't
opt-in to capability families, security controls remain the same.

-- Nick

On Tue, Nov 22, 2016 at 6:15 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Has anyone given any thought into technically what we could do to have
> > finer grained LSM control here? I have some ideas here, but I'd like
> > to read about what has been previously been suggested...
>
> In general, we would audit the current set of CAP_SYS_ADMIN checks,
> prioritize the most significant ones, organize them into equivalence
> classes, and only define a single LSM hook and SELinux permission check
> for each equivalence class.  That's if you want to just add
> finer-grained LSM hooks and leave the CAP_SYS_ADMIN checks alone.
>
> If you want to split CAP_SYS_ADMIN into finer-grained capabilities, then
> an example of doing that in the past was CAP_SYSLOG; you can see how
> they provide backward compatibility there.  However, that is only
> sufficient if you only need to perform a check based on the process'
> credentials; if you want to take into consideration any object (e.g. in
> the case of swapon, the target file) or any other parameters, then
> you'll want a LSM hook instead.




-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
