Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v35GTbib023159
 for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2017 12:29:37 -0400
Subject: Re: [PATCH 0/3 v3] libsepol and checkpolicy: Output CIL or
 policy.conf from kernel policy
To: selinux@tycho.nsa.gov
References: <1490287737-31103-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <c8c1b1ff-f830-d572-62b1-94a075b377e2@tycho.nsa.gov>
Date: Wed, 5 Apr 2017 12:30:07 -0400
MIME-Version: 1.0
In-Reply-To: <1490287737-31103-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2017 12:48 PM, James Carter wrote:
> It would sometimes be helpful for debugging or verification purposes to be able to convert
> a binary policy to a human-readable form.
>
> This patchset adds libsepol functions that take a kernel policydb in and outputs either
> a CIL or policy.conf text.
>
> Checkpolicy is modified to generate CIL text from a binary policy if using the "-C" option
> and to add the "-F" option to generate policy.conf text from a binary policy.
>
> Where possible rules are sorted in alphabetical or numerical order to aid in debugging.
>
> Changes from v1:
> - Moved __attribute__((format(printf...))) for printf-like functions to kernel_to_common.h
> - Incorporated patch from Nicolas Iooss to make const char* variables where appropriate
> - Fixed conditional block formatting problems when generating policy.conf
> - Initialize mls_constraints and non_mls_constraints to NULL in kernel_to_conf.c and kernel_to_cil.c so they are not accessed without initializaton if an error occurs.
> - Updated checkpolicy manpage to include the new option
> - Removed commented-out block from checkpolicy.c
>
> Changes from v2:
> - Fixed conditional block formatting problems when generating CIL.
> - Fixed improper range syntax for non-mls CIL policies.
> - Write types in alphabetical order in roletype rules for CIL and role rules for policy.conf.
> - Write roles in alphabetical order in userrole rules for CIL and user rules for policy.conf.
> - Write policy capability rules in alphabetical order
> - Separated writing of constrain and validatetrans constraint rules for both CIL and policy.conf.
> - Write constraints in alphabetical order for both CIL and policy.conf
> - Now continously creating a policy.conf and then a binary produces an identical binary (although for CIL, secilc will remove unused attributes during the first cycle.)
>
> James Carter (3):
>   libsepol: Add ability to convert binary policy to CIL
>   libsepol: Add ability to convert binary policy to policy.conf file
>   checkpolicy: Add options to convert binary policy to CIL or a
>     policy.conf
>
>  checkpolicy/checkpolicy.8               |    5 +-
>  checkpolicy/checkpolicy.c               |   55 +-
>  libsepol/include/sepol/kernel_to_cil.h  |    5 +
>  libsepol/include/sepol/kernel_to_conf.h |    5 +
>  libsepol/src/kernel_to_cil.c            | 3226 +++++++++++++++++++++++++++++++
>  libsepol/src/kernel_to_common.c         |  677 +++++++
>  libsepol/src/kernel_to_common.h         |  114 ++
>  libsepol/src/kernel_to_conf.c           | 3096 +++++++++++++++++++++++++++++
>  libsepol/src/libsepol.map.in            |    2 +
>  9 files changed, 7166 insertions(+), 19 deletions(-)
>  create mode 100644 libsepol/include/sepol/kernel_to_cil.h
>  create mode 100644 libsepol/include/sepol/kernel_to_conf.h
>  create mode 100644 libsepol/src/kernel_to_cil.c
>  create mode 100644 libsepol/src/kernel_to_common.c
>  create mode 100644 libsepol/src/kernel_to_common.h
>  create mode 100644 libsepol/src/kernel_to_conf.c
>

This series has been applied.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
