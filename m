Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u89HFhBI026107
 for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2016 13:15:43 -0400
Received: by mail-pa0-f44.google.com with SMTP id cm16so30222821pac.0
 for <selinux@tycho.nsa.gov>; Fri, 09 Sep 2016 10:15:41 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix some cil_gen_policy() bugs.
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <4ae2a548-96a2-8e12-540e-8c2d86abe62a@android.com>
 <39fd2b40-b80c-db4e-f432-5091002761f5@tycho.nsa.gov>
 <2e635988-f9d4-353b-db3b-366f4c6349d3@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov
From: Daniel Cashman <dcashman@android.com>
Message-ID: <8f172ac0-30c4-4a33-507b-68b152cff415@android.com>
Date: Fri, 9 Sep 2016 10:10:37 -0700
MIME-Version: 1.0
In-Reply-To: <2e635988-f9d4-353b-db3b-366f4c6349d3@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/09/2016 07:35 AM, James Carter wrote:
> On 09/09/2016 08:29 AM, James Carter wrote:
>> On 09/08/2016 04:37 PM, Daniel Cashman wrote:
>>> On 09/08/2016 01:30 PM, Daniel Cashman wrote:
>>>> From: dcashman <dcashman@android.com>
>>>>
>>>> cil_gen_policy() appears to exist to generate a policy.conf
>>>> corresponding to the
>>>> original SELinux HLL from a cil_db struct.  All of
>>>> libsepol/cil/src/cil_policy.c
>>>> appears to exist to support this functionality.  This patchset
>>>> provides some
>>>> fixes for issues encountered when trying to go from android's
>>>> policy.conf to a
>>>> CIL representation (via checkpolicy) and then back to the HLL
>>>> representation via
>>>> cil_gen_policy().
>>>>
>>>> dcashman (5):
>>>>   libsepol: cil: Add userrole mapping to cil_gen_policy().
>>>>   libsepol: cil: Remove duplicate sid policy declaration.
>>>>   libsepol: cil: Replace sensitivityorder statement.
>>>>   libsepol: cil: Fix CIL_OP data assignment.
>>>>   libsepol: cil: Add cil_constraint_expr_to_policy()
>>>>
>>>>  libsepol/cil/src/cil_policy.c | 235
>>>> ++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 224 insertions(+), 11 deletions(-)
>>>>
>>>
>>> I suspect that the "proper" fix here is to just remove all of
>>> libsepol/cil/src/cil_policy.c, so I can put that patch together too if
>>> desired.
>>>
>>
>> Yes, that code was used early on to help with debugging the CIL
>> compiler, but
>> hasn't been maintained. I've wanted to go back and fix it, but there
>> didn't seem
>> to be any use case needing it before now.
>>
>> If that functionality would be valuable to you, I would be glad to
>> work on this.
>>
>> I think the right course would be to move this out of libsepol like
>> secilc is.
>>
> 
> The caffeine hadn't kicked in yet. cil_policy.c is like cil_binary.c and
> should stay where it is.
> 
> Jim
> 

Yes, it requires access to the cil_db internals, most-importantly the
ast.  I'm trying to do similar processing to replace types and
attributes to new attributes (what I'm calling 'attributizing') for
portions of policy.  Thus, I think any changes I make will also have to
live in libsepol, although we'll see eventually how acceptable they are
for upstream.

As for the usefulness of cil_gen_policy(), my actual desire was to get
some CIL -> CIL code, perhaps a cil_write_ast() used as part of a
cil_gen_cil() function, that would allow me to make some AST
modifications and then produce transformed CIL policy.  I noticed
cil_gen_policy() as a potential shortcut to allow me to postpone that
further.  I don't currently see a need for cil_gen_policy() outside of
testing other changes, so I submitted the fixes I'd come up with before
deciding to continue with another approach.

Dan
>> Jim
>>
>>> The patches in this patchset do not address all of the bugs I
>>> encountered trying to go from HLL -> CIL -> HLL. Since I was using this
>>> as a temporary work-around, I decided to move on and submit these, in
>>> case rescuing cil_gen_policy() is desired; the additional changes needed
>>> were becoming more invasive (similar to the 5th patch in this set) and
>>> less bug-fix-like.
>>>
>>> Thank You,
>>> Dan
>>>
>>
>>
> 
> 
