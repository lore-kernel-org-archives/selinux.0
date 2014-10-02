Message-ID: <542D64CF.809@tycho.nsa.gov>
Date: Thu, 02 Oct 2014 10:44:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>, Steve Lawrence <slawrence@tresys.com>
Subject: Re: [PATCH 0/3] pp2cil fixes based on feedback
References: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/02/2014 09:10 AM, Yuli Khodorkovskiy wrote:
> This patchset provides fixes to the pp2cil tool based on feedback for
> 2014-08-26-rc1.
>
> An issue was encountered in 2014-08-26-rc1 with missing roles [1].
> Role declarations will now be printed in base and modules, where
> before only module role declarations were printed. Also, roletype
> statements will only be created when a role or a type are in the
> correct scope. As a result of these changes, policies that declare
> roles mulitple times in different modules will result in pp2cil
> generating duplicate roles. Since CIL does not allow identical role
> delcarations in different modules, current policies must be rebuilt
> with a refpolicy patch that removes duplicate role declarations [2].
>

What about current policies? How does this effect backwards compatibility?

> A bug in creating filecon statements was also fixed where a missing
> trailing newline in .fc files would cause parsing issues.
>
> Finally, generated typeattribute/sets will now be printed immediately
> unless they are in avrule conditionals/blocks. The special case will
> have generated typeattributes/sets to be printed after the
> conditionals/blocks are printed.
>
> [1] http://marc.info/?l=selinux&m=140983712508791&w=2
> [2] https://github.com/TresysTechnology/refpolicy/commit/330b0fc3331d3b836691464734c96f3da3044490
>
>
> Yuli Khodorkovskiy (3):
>    policycoreutils/hll/pp: Fix role/roletype scoping
>    policycoreutils/hll/pp: fix '\n' parsing in filecon statements
>    policycoreutils/hll/pp: change printing behavior of typeattribute/sets
>
>   policycoreutils/hll/pp/pp.c | 763 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 529 insertions(+), 234 deletions(-)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
