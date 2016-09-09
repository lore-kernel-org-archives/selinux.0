Subject: Re: [PATCH 0/5] Fix some cil_gen_policy() bugs.
To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <4ae2a548-96a2-8e12-540e-8c2d86abe62a@android.com>
Cc: sds@tycho.nsa.gov, jeffv@google.com
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <39fd2b40-b80c-db4e-f432-5091002761f5@tycho.nsa.gov>
Date: Fri, 9 Sep 2016 08:29:50 -0400
MIME-Version: 1.0
In-Reply-To: <4ae2a548-96a2-8e12-540e-8c2d86abe62a@android.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/08/2016 04:37 PM, Daniel Cashman wrote:
> On 09/08/2016 01:30 PM, Daniel Cashman wrote:
>> From: dcashman <dcashman@android.com>
>>
>> cil_gen_policy() appears to exist to generate a policy.conf corresponding to the
>> original SELinux HLL from a cil_db struct.  All of libsepol/cil/src/cil_policy.c
>> appears to exist to support this functionality.  This patchset provides some
>> fixes for issues encountered when trying to go from android's policy.conf to a
>> CIL representation (via checkpolicy) and then back to the HLL representation via
>> cil_gen_policy().
>>
>> dcashman (5):
>>   libsepol: cil: Add userrole mapping to cil_gen_policy().
>>   libsepol: cil: Remove duplicate sid policy declaration.
>>   libsepol: cil: Replace sensitivityorder statement.
>>   libsepol: cil: Fix CIL_OP data assignment.
>>   libsepol: cil: Add cil_constraint_expr_to_policy()
>>
>>  libsepol/cil/src/cil_policy.c | 235 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 224 insertions(+), 11 deletions(-)
>>
>
> I suspect that the "proper" fix here is to just remove all of
> libsepol/cil/src/cil_policy.c, so I can put that patch together too if
> desired.
>

Yes, that code was used early on to help with debugging the CIL compiler, but 
hasn't been maintained. I've wanted to go back and fix it, but there didn't seem 
to be any use case needing it before now.

If that functionality would be valuable to you, I would be glad to work on this.

I think the right course would be to move this out of libsepol like secilc is.

Jim

> The patches in this patchset do not address all of the bugs I
> encountered trying to go from HLL -> CIL -> HLL. Since I was using this
> as a temporary work-around, I decided to move on and submit these, in
> case rescuing cil_gen_policy() is desired; the additional changes needed
> were becoming more invasive (similar to the 5th patch in this set) and
> less bug-fix-like.
>
> Thank You,
> Dan
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
