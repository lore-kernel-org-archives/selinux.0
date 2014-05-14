Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4EDHobQ007516
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 09:17:50 -0400
Message-ID: <53736433.1030107@redhat.com>
Date: Wed, 14 May 2014 08:40:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
 <5372239D.3010007@redhat.com> <53730743.1050900@gmail.com>
 <537308E1.4050705@gmail.com>
In-Reply-To: <537308E1.4050705@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We use M4 Macros, atttibutes/roleattributes to make this happen.

Users are only assigned a few roles.  Most confined users would only
have one role. A confined user that can become an admin would have a few
roles.  If you built a confined user that had lots of different admin
roles, it could get complicated but that has not been that common.

As far as roles/type combinations, most system roles get assigned the
system_r role.  This is the vast majority of role/type combination.
 seinfo -rsystem_r -x | wc -l
776

User roles are assigned based on the _run interfaces, and are built into
higher level interfaces to get assigned automatically when you define a
new user_r as a user.

seinfo -ruser_r -x | wc -l
175
seinfo -rguest_r -x | wc -l
95

On 05/14/2014 02:10 AM, dE wrote:
> On 05/14/14 11:33, dE wrote:
>> On 05/13/14 19:22, Daniel J Walsh wrote:
>>> On 05/13/2014 08:26 AM, Christopher J. PeBenito wrote:
>>>> On 05/13/2014 05:48 AM, dE wrote:
>>>>> For a process's security context (user, role, type), there maybe a
>>>>> conflict in the policy. for e.g. for user user_u, access to the
>>>>> kernel's ring buffer may not be allowed, but for role role_r, it
>>>>> may be allowed. The same process will have user_u and role_r.
>>>>>
>>>>> So in case of conflicting permissions between user, role and type
>>>>> who's permission will the security server respect -- user's,
>>>>> role's or type's?
>>>> First, obviously, the access has to be allowed via type enforcement
>>>> allow rule.  After that, the constraints can reduce the access. 
>>>> All of the constraints have to be passed for the end result to be
>>>> allowed, regardless of what is involved in the constraint (user,
>>>> role, etc.)  There is no precedence in the constraints.
>>>>
>>> Users and Roles do not control access, only types and MCS/MLS Levels.
>>>
>>> Users are a way of assinging  Roles and MCS/MLS ranges to a login user.
>>> Roles control which types are available, then types control access.
>>> As Chris says MCS/MLS constraints can further restrict a label.
>>
>> Yes, the security context of dmesg changed --
>>
>> type=AVC msg=audit(1400039194.397:171): avc:  denied  { syslog_read }
>> for  pid=844 comm="dmesg" scontext=user_u:user_r:user_t:s0
>> tcontext=system_u:system_r:kernel_t:s0 tclass=system
>>
>> ls -Z $(which dmesg)
>> -rwxr-xr-x. root root system_u:object_r:dmesg_exec_t:s0 /usr/bin/dmesg
>>
>> Then it must be quiet a difficulty task specifying for each
>> user/role, what type is allowed. Wouldn't it had been easier to
>> specify allowed permissions for each user and then make it SELinux's
>> responsibility to figure out what should be done (this could've been
>> specified as per user configuration)?
>
> I mean there are 239 different security contexts currently in my
> system --
>
> ls -Z ${PATH//:/ }  | sed -r 's/\ +/\//g' | cut -d \/ -f4 | cut -d ':'
> -f3 | uniq -u | wc --lines
> 239
>
> That makes me think what I suggest is actually happening.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
