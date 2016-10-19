Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9JEDY0b024062
 for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2016 10:13:34 -0400
Subject: Re: [PATCH 0/7] libsepol/cil: Fix bugs found by Nicolas Looss with AFL
To: selinux@tycho.nsa.gov
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <e4979c2a-5bfd-f4d2-34a3-160bda2807fd@tycho.nsa.gov>
Date: Wed, 19 Oct 2016 10:14:51 -0400
MIME-Version: 1.0
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/18/2016 02:58 PM, James Carter wrote:
> A series of patches to fix bugs found by Nicolas Looss while fuzzing
> secilc with AFL.
>
> James Carter (7):
>   libsepol/cil: Check for improper category range
>   libsepol/cil: Use empty list for category expression evaluated as
>     empty
>   libsepol/cil: Use an empty list to represent an unknown permission
>   libsepol/cil: Check if identifier is NULL when verifying name
>   libsepol/cil: Check that permission is not an empty list
>   libsepol/cil: Verify alias in aliasactual statement is really an alias
>   libsepol/cil: Verify neither child nor parent in a bounds is an
>     attribute
>
>  libsepol/cil/src/cil_build_ast.c   |  7 +++++
>  libsepol/cil/src/cil_post.c        | 13 ++++----
>  libsepol/cil/src/cil_resolve_ast.c | 61 +++++++++++++++++++-------------------
>  libsepol/cil/src/cil_verify.c      |  8 ++++-
>  4 files changed, 51 insertions(+), 38 deletions(-)
>

Applied series with Nicolas' correct last name.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
