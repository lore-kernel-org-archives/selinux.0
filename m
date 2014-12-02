Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB2F3ppw013895
 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2014 10:03:51 -0500
Message-ID: <547DD4D5.4020209@tresys.com>
Date: Tue, 2 Dec 2014 10:03:49 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc6
References: <5463658D.7050702@tresys.com>
 <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
 <20141124112636.GA6200@e145.network2>
 <CAPzO=NyHcEdpQN9iVwEC5LXtYzWjaK0jajz2tFG3pf+-HXqDaA@mail.gmail.com>
 <CAPzO=Nxda_B6u8wX3UmM5DNdOSe568h8tiQmtLTdxHMJEQqMbw@mail.gmail.com>
 <20141127173851.GA16764@e145.network2>
 <CAPzO=NzR1kCWTE1fzNo7cFj8v=mEk1K81hFv1bQZLW2piUq7uQ@mail.gmail.com>
In-Reply-To: <CAPzO=NzR1kCWTE1fzNo7cFj8v=mEk1K81hFv1bQZLW2piUq7uQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/27/2014 03:14 PM, Sven Vermeulen wrote:
> On Thu, Nov 27, 2014 at 6:38 PM, Dominick Grift <dac.override@gmail.com> wrote:
>> On Thu, Nov 27, 2014 at 01:23:13PM +0100, Sven Vermeulen wrote:
>>>
>>> So in this case, object_r is assigned (during migration) to system_u,
>>> unconfined_u and user_u, but not to root, staff_u, sysadm_u and
>>> testrole_u.
>>>
>>> Those roles still work though. Is showing object_r in the "SELinux
>>> Roles" part cosmetic perhaps?
>>>
>>
>> Strange ... as far as i know object_r needs to be associated with everyone
>>
>> Is your output of seinfo -xu consistent with that of semanage user (as far as roles associated with identities is concerned)?
> 
> It is not. seinfo -xu shows object_r to be associated with *all* roles
> (as you suggested) whereas the "semanage user -l" output shows it
> missing with a few of them.
> 
> This is the only inconsistency though - the rest of the output does match.
> 

First of all, sorry about the delayed response.

I agree that this inconsistency is a problem. It looks like the problem
is in CIL. Dominick is right in that object_r is implicitly associated
with all roles, but CIL sets a bit to make the user/object_r
association, even though it is unnecessary. This appears to have caused
the behavior change in some of the tools. We just need to special case
object_r to not make the association and rely on the implied association
existing. This has been fixed in CIL [1] and will be part of the next
release candidate.

- Steve

[1]
https://github.com/SELinuxProject/cil/commit/08520e91db86bdbb8ce393afa35c1465bdc7f63b
