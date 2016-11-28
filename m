Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASJ8ZjT005202
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 14:08:35 -0500
Subject: Re: [PATCH 0/2 v2] Enable direct compare of policy file with kernel
 policy
To: selinux@tycho.nsa.gov
References: <1480357758-7025-1-git-send-email-sds@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <296348c7-1024-abb7-fad3-d7074bd3bcfd@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 14:11:41 -0500
MIME-Version: 1.0
In-Reply-To: <1480357758-7025-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/28/2016 01:29 PM, Stephen Smalley wrote:
> To date we have been unable to directly compare a policy file, 
> e.g. /etc/selinux/targeted/policy/policy.30, with the kernel policy,
> i.e. /sys/fs/selinux/policy, due to non-semantic differences in
> the two policy images (e.g. ordering issues).  sediff can be used
> to compare the two, but sediff is incomplete in its coverage and
> is necessarily less efficient than a simple cmp of two files.
> These two commits make it possible to directly compare a policy
> file with a kernel policy after normalizing them both through
> checkpolicy, ala:
> 
> checkpolicy -M -b /etc/selinux/targeted/policy/policy.30 -o policy.1
> checkpolicy -M -b /sys/fs/selinux/policy -o policy.2
> cmp policy.1 policy.2
> 
> Caveat:  Un-tested with Android policy; might still differ on xperms
> ordering issues.

Looks like you have to run the Android policy through checkpolicy a
couple of times to get it directly comparable this way:
adb pull /sepolicy
adb pull /sys/fs/selinux/policy
checkpolicy -M -b policy -o policy.1
checkpolicy -M -b sepolicy -o sepolicy.1
checkpolicy -M -b sepolicy.1 -o sepolicy.2
cmp policy.1 sepolicy.2

Likely avtab xperms entries just reversing their ordering through a
policydb_read();policydb_write() cycle.

> 
> Stephen Smalley (2):
>   libsepol: do not write object_r types to policy file
>   libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs
> 
>  checkpolicy/policy_define.c                |  57 ++---
>  checkpolicy/test/dispol.c                  |  36 +++-
>  libsepol/cil/src/cil_binary.c              |  79 ++++---
>  libsepol/include/sepol/policydb/context.h  |  40 ++++
>  libsepol/include/sepol/policydb/policydb.h |  18 +-
>  libsepol/src/expand.c                      | 152 +++++++-------
>  libsepol/src/mls.c                         |  52 +++--
>  libsepol/src/policydb.c                    | 321 +++++++++++++++++++----------
>  libsepol/src/write.c                       | 198 ++++++++++++------
>  9 files changed, 623 insertions(+), 330 deletions(-)
> 
