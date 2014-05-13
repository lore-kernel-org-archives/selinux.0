Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4DDqWhf015909
 for <selinux@tycho.nsa.gov>; Tue, 13 May 2014 09:52:32 -0400
Message-ID: <5372239D.3010007@redhat.com>
Date: Tue, 13 May 2014 09:52:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, dE <de.techno@gmail.com>,
 selinux@tycho.nsa.gov
Subject: Re: Presidency of user/role/type permissions.
References: <5371EA55.703@gmail.com> <53720F8C.8000205@tresys.com>
In-Reply-To: <53720F8C.8000205@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 05/13/2014 08:26 AM, Christopher J. PeBenito wrote:
> On 05/13/2014 05:48 AM, dE wrote:
>> For a process's security context (user, role, type), there maybe a conflict in the policy. for e.g. for user user_u, access to the kernel's ring buffer may not be allowed, but for role role_r, it may be allowed. The same process will have user_u and role_r.
>>
>> So in case of conflicting permissions between user, role and type who's permission will the security server respect -- user's, role's or type's?
> First, obviously, the access has to be allowed via type enforcement allow rule.  After that, the constraints can reduce the access.  All of the constraints have to be passed for the end result to be allowed, regardless of what is involved in the constraint (user, role, etc.)  There is no precedence in the constraints.
>
Users and Roles do not control access, only types and MCS/MLS Levels.

Users are a way of assinging  Roles and MCS/MLS ranges to a login user.
Roles control which types are available, then types control access. 
As Chris says MCS/MLS constraints can further restrict a label.
