Message-ID: <536CC75D.2010909@tycho.nsa.gov>
Date: Fri, 09 May 2014 08:17:33 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: sshd and default security context.
References: <536A51FE.1050506@gmail.com> <536A7F1B.1040008@tycho.nsa.gov>
 <536C6EC4.1010709@gmail.com>
In-Reply-To: <536C6EC4.1010709@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/09/2014 01:59 AM, dE wrote:
> On 05/08/14 00:14, Stephen Smalley wrote:
>> On 05/07/2014 11:32 AM, dE wrote:
>>> I was tying out default_contexts which has the following lines  --
>>>
>>> cat default_contexts | grep sshd
>>> system_r:sshd_t:s0              user_r:user_t:s0
>>>
>>> And sshd does run with that type --
>>>
>>> ps auxZ | grep sshd
>>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 279 0.0  0.6 80636 3392
>>> ?        Ss   09:20   0:00 /usr/sbin/sshd -D
>>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 458 0.0  0.9 131280 4652
>>> ?        Ss   09:22   0:00 sshd: de [priv]
>>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 468 0.0 0.4
>>> 131280 2144 ? S 09:22   0:00 sshd: de@pts/0
>>> system_u:system_r:sshd_t:s0-s0:c0.c1023 root 5115 1.1  0.9 131280 4624
>>> ?       Ss   20:22   0:00 sshd: de [priv]
>>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5121 0.0 0.4
>>> 131280 2124 ? S 20:22   0:00 sshd: de@notty
>>>
>>> But the processes spawned by sshd do not have type user_t --
>>>
>>> ps auxZ | grep user_t
>>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 de 5183 0.0 0.1
>>> 112632 884 pts/0 S+ 20:25   0:00 grep --color=auto user_t
>> The Linux user is mapped to a SELinux user based on the seusers mapping;
>> you can run semanage login -l to see the mapping.  The __default__ entry
>> is used when there is no other match, so under targeted policy, users
>> default to being mapped to unconfined_u.  If you want them to run in a
>> confined role, you can use semanage login -a to map their Linux username
>> to a confined SELinux user like user_u or staff_u.
>>
>> libselinux asks the kernel for the set of security contexts for the
>> SELinux user reachable from the current context, which in this case is
>> system_u:system_r:sshd_t.  This is done via security_compute_user()
>> which internally writes a query to /sys/fs/selinux/user and reads back a
>> list of contexts.  The kernel computes this list from policy based on
>> the user-role relation, the user-level relation, the role-type relation,
>> and whether or not process transition permission is granted from the
>> current context (i.e. sshd's context) to the context in policy.
>>
>> Then, libselinux looks to see if there is an
>> /etc/selinux/$SELINUXTYPE/contexts/users/<selinux-user> file, e.g.
>> /etc/selinux/targeted/contexts/unconfined_u, and if so, uses it to
>> determine the most preferred context(s) to use.
>>
>> Then, libselinux looks to see if there is an
>> /etc/selinux/$SELINUXTYPE/contexts/default_contexts file, and if so,
>> uses it to determine the next most preferred context(s) to use.
>>
>> libselinux orders the list of contexts based on these two configuration
>> files and then returns the result to the caller for selection.  Most
>> current callers just use the most preferred context, but the design was
>> to allow user selection via some interfaces, e.g. some people have
>> implemented gdm extensions or the like that offered the user a choice of
>> contexts at login time.
>>
>> If something goes wrong and it cannot obtain any valid contexts in this
>> way, libselinux falls back to trying to use a context based on
>> /etc/selinux/$SELINUXTYPE/contexts/failsafe_context.  This was to permit
>> e.g. root login for emergency recovery.  If the user in question isn't
>> authorized for that context however, this will fail, so it can only work
>> if the user is authorized for that role.
>>
>> The mechanism is overly complex and can be fragile, which has led to
>> some changes over time to try to reduce fragility at a cost in the
>> original expressiveness/generality of the mechanism.  I'd prefer to
>> rework it to avoid the kernel interaction altogether, but this would
>> require some exporting some of the kernel policy information to
>> userspace (either via other /sys/fs/selinux nodes or by extracting the
>> information during policy build and placing it in configuration files
>> made available to userspace) and reworking the userspace logic.
>>
>> There is a fair bit of complexity as well in the pam_selinux logic even
>> before you reach libselinux that would benefit from streamlining and
>> possibly taking to libselinux.
> 
> Thanks for clarifying. I forgot the check the user based security
> context, so it changed it to --
> 
> cat /etc/selinux/targeted/contexts/users/unconfined_u | grep sshd
> system_r:sshd_t:s0              user_r:user_t:s0
> 
> From unconfined_r:unconfined_t:s0
> 
> But apparently the policies don't allow that. I'm running as user
> unconfined_u.

That's correct; semanage user -l will show you that unconfined_u is only
authorized for system_r and unconfined_r, not for user_r.  To login as
user_r, you need to assign user_u to your Linux username via semanage
login -a.
