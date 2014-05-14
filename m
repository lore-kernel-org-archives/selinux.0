Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4E6DRM2013887
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 02:13:27 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1256420pab.31
 for <selinux@tycho.nsa.gov>; Tue, 13 May 2014 23:13:20 -0700 (PDT)
Received: from [192.168.1.2] ([117.214.173.7])
 by mx.google.com with ESMTPSA id nx12sm3742217pab.6.2014.05.13.23.13.18
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 13 May 2014 23:13:19 -0700 (PDT)
Message-ID: <537308E1.4050705@gmail.com>
Date: Wed, 14 May 2014 11:40:41 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
 <5372239D.3010007@redhat.com> <53730743.1050900@gmail.com>
In-Reply-To: <53730743.1050900@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/14 11:33, dE wrote:
> On 05/13/14 19:22, Daniel J Walsh wrote:
>> On 05/13/2014 08:26 AM, Christopher J. PeBenito wrote:
>>> On 05/13/2014 05:48 AM, dE wrote:
>>>> For a process's security context (user, role, type), there maybe a 
>>>> conflict in the policy. for e.g. for user user_u, access to the 
>>>> kernel's ring buffer may not be allowed, but for role role_r, it 
>>>> may be allowed. The same process will have user_u and role_r.
>>>>
>>>> So in case of conflicting permissions between user, role and type 
>>>> who's permission will the security server respect -- user's, role's 
>>>> or type's?
>>> First, obviously, the access has to be allowed via type enforcement 
>>> allow rule.  After that, the constraints can reduce the access.  All 
>>> of the constraints have to be passed for the end result to be 
>>> allowed, regardless of what is involved in the constraint (user, 
>>> role, etc.)  There is no precedence in the constraints.
>>>
>> Users and Roles do not control access, only types and MCS/MLS Levels.
>>
>> Users are a way of assinging  Roles and MCS/MLS ranges to a login user.
>> Roles control which types are available, then types control access.
>> As Chris says MCS/MLS constraints can further restrict a label.
>
> Yes, the security context of dmesg changed --
>
> type=AVC msg=audit(1400039194.397:171): avc:  denied  { syslog_read } 
> for  pid=844 comm="dmesg" scontext=user_u:user_r:user_t:s0 
> tcontext=system_u:system_r:kernel_t:s0 tclass=system
>
> ls -Z $(which dmesg)
> -rwxr-xr-x. root root system_u:object_r:dmesg_exec_t:s0 /usr/bin/dmesg
>
> Then it must be quiet a difficulty task specifying for each user/role, 
> what type is allowed. Wouldn't it had been easier to specify allowed 
> permissions for each user and then make it SELinux's responsibility to 
> figure out what should be done (this could've been specified as per 
> user configuration)?

I mean there are 239 different security contexts currently in my system --

ls -Z ${PATH//:/ }  | sed -r 's/\ +/\//g' | cut -d \/ -f4 | cut -d ':' 
-f3 | uniq -u | wc --lines
239

That makes me think what I suggest is actually happening.
