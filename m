Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4962C0I003387
 for <selinux@tycho.nsa.gov>; Fri, 9 May 2014 02:02:12 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so3904028pab.31
 for <selinux@tycho.nsa.gov>; Thu, 08 May 2014 23:02:12 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.81.202])
 by mx.google.com with ESMTPSA id qv3sm5375143pbb.87.2014.05.08.23.02.10
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 08 May 2014 23:02:11 -0700 (PDT)
Message-ID: <536C6EC4.1010709@gmail.com>
Date: Fri, 09 May 2014 11:29:32 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: sshd and default security context.
References: <536A51FE.1050506@gmail.com> <536A7F1B.1040008@tycho.nsa.gov>
In-Reply-To: <536A7F1B.1040008@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/08/14 00:14, Stephen Smalley wrote:
> On 05/07/2014 11:32 AM, dE wrote:
>> I was tying out default_contexts which has the following lines  --
>>
>> cat default_contexts | grep sshd
>> system_r:sshd_t:s0              user_r:user_t:s0
>>
>> And sshd does run with that type --
>>
>> ps auxZ | grep sshd
>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 279 0.0  0.6 80636 3392
>> ?        Ss   09:20   0:00 /usr/sbin/sshd -D
>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 458 0.0  0.9 131280 4652
>> ?        Ss   09:22   0:00 sshd: de [priv]
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 468 0.0 0.4
>> 131280 2144 ? S 09:22   0:00 sshd: de@pts/0
>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 5115 1.1  0.9 131280 4624
>> ?       Ss   20:22   0:00 sshd: de [priv]
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5121 0.0 0.4
>> 131280 2124 ? S 20:22   0:00 sshd: de@notty
>>
>> But the processes spawned by sshd do not have type user_t --
>>
>> ps auxZ | grep user_t
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5183 0.0 0.1
>> 112632 884 pts/0 S+ 20:25   0:00 grep --color=auto user_t
> The Linux user is mapped to a SELinux user based on the seusers mapping;
> you can run semanage login -l to see the mapping.  The __default__ entry
> is used when there is no other match, so under targeted policy, users
> default to being mapped to unconfined_u.  If you want them to run in a
> confined role, you can use semanage login -a to map their Linux username
> to a confined SELinux user like user_u or staff_u.
>
> libselinux asks the kernel for the set of security contexts for the
> SELinux user reachable from the current context, which in this case is
> system_u:system_r:sshd_t.  This is done via security_compute_user()
> which internally writes a query to /sys/fs/selinux/user and reads back a
> list of contexts.  The kernel computes this list from policy based on
> the user-role relation, the user-level relation, the role-type relation,
> and whether or not process transition permission is granted from the
> current context (i.e. sshd's context) to the context in policy.
>
> Then, libselinux looks to see if there is an
> /etc/selinux/$SELINUXTYPE/contexts/users/<selinux-user> file, e.g.
> /etc/selinux/targeted/contexts/unconfined_u, and if so, uses it to
> determine the most preferred context(s) to use.
>
> Then, libselinux looks to see if there is an
> /etc/selinux/$SELINUXTYPE/contexts/default_contexts file, and if so,
> uses it to determine the next most preferred context(s) to use.
>
> libselinux orders the list of contexts based on these two configuration
> files and then returns the result to the caller for selection.  Most
> current callers just use the most preferred context, but the design was
> to allow user selection via some interfaces, e.g. some people have
> implemented gdm extensions or the like that offered the user a choice of
> contexts at login time.
>
> If something goes wrong and it cannot obtain any valid contexts in this
> way, libselinux falls back to trying to use a context based on
> /etc/selinux/$SELINUXTYPE/contexts/failsafe_context.  This was to permit
> e.g. root login for emergency recovery.  If the user in question isn't
> authorized for that context however, this will fail, so it can only work
> if the user is authorized for that role.
>
> The mechanism is overly complex and can be fragile, which has led to
> some changes over time to try to reduce fragility at a cost in the
> original expressiveness/generality of the mechanism.  I'd prefer to
> rework it to avoid the kernel interaction altogether, but this would
> require some exporting some of the kernel policy information to
> userspace (either via other /sys/fs/selinux nodes or by extracting the
> information during policy build and placing it in configuration files
> made available to userspace) and reworking the userspace logic.
>
> There is a fair bit of complexity as well in the pam_selinux logic even
> before you reach libselinux that would benefit from streamlining and
> possibly taking to libselinux.

Thanks for clarifying. I forgot the check the user based security 
context, so it changed it to --

cat /etc/selinux/targeted/contexts/users/unconfined_u | grep sshd
system_r:sshd_t:s0              user_r:user_t:s0

 From unconfined_r:unconfined_t:s0

But apparently the policies don't allow that. I'm running as user 
unconfined_u.
