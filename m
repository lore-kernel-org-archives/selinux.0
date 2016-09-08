Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KbGRk002506
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:37:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id g202so21622528pfb.0
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:37:14 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix some cil_gen_policy() bugs.
To: selinux@tycho.nsa.gov
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com
From: Daniel Cashman <dcashman@android.com>
Message-ID: <4ae2a548-96a2-8e12-540e-8c2d86abe62a@android.com>
Date: Thu, 8 Sep 2016 13:37:11 -0700
MIME-Version: 1.0
In-Reply-To: <1473366652-23929-1-git-send-email-dcashman@android.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/08/2016 01:30 PM, Daniel Cashman wrote:
> From: dcashman <dcashman@android.com>
> 
> cil_gen_policy() appears to exist to generate a policy.conf corresponding to the
> original SELinux HLL from a cil_db struct.  All of libsepol/cil/src/cil_policy.c
> appears to exist to support this functionality.  This patchset provides some
> fixes for issues encountered when trying to go from android's policy.conf to a
> CIL representation (via checkpolicy) and then back to the HLL representation via
> cil_gen_policy().
> 
> dcashman (5):
>   libsepol: cil: Add userrole mapping to cil_gen_policy().
>   libsepol: cil: Remove duplicate sid policy declaration.
>   libsepol: cil: Replace sensitivityorder statement.
>   libsepol: cil: Fix CIL_OP data assignment.
>   libsepol: cil: Add cil_constraint_expr_to_policy()
> 
>  libsepol/cil/src/cil_policy.c | 235 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 224 insertions(+), 11 deletions(-)
> 

I suspect that the "proper" fix here is to just remove all of
libsepol/cil/src/cil_policy.c, so I can put that patch together too if
desired.

The patches in this patchset do not address all of the bugs I
encountered trying to go from HLL -> CIL -> HLL. Since I was using this
as a temporary work-around, I decided to move on and submit these, in
case rescuing cil_gen_policy() is desired; the additional changes needed
were becoming more invasive (similar to the 5th patch in this set) and
less bug-fix-like.

Thank You,
Dan
