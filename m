Subject: Re: [PATCH 0/2] Add the ability to write policy.conf file from CIL AST
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <21dbe2db-8048-d166-d628-dca9fcd34be3@tycho.nsa.gov>
Date: Fri, 18 Nov 2016 13:26:59 -0500
MIME-Version: 1.0
In-Reply-To: <1479492328-12238-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2016 01:05 PM, James Carter wrote:
> The first patch adds the cil_gen_policy() function to libsepol and the second
> patch adds the cil2conf program to policycoreutils.
> 
> I am open to a different name and/or location for cil2conf.

Maybe add it to secilc (no need for a separate subdir, just add it to
the secilc Makefile), and rename it to secil2conf?  It isn't needed for
a production system in general, so doesn't really fit into
policycoreutils, and seems like the inverse of secilc (analogous to
dismod/dispol in checkpolicy).

> 
> James Carter (2):
>   libsepol/cil: Add ability to write policy.conf file from CIL AST
>   policycoreutils: Add cil2conf which creates a policy.conf from CIL
>     policy
> 
>  libsepol/cil/include/cil/cil.h      |    1 +
>  libsepol/cil/src/cil.c              |    6 +
>  libsepol/cil/src/cil_policy.c       | 2696 +++++++++++++++++++++--------------
>  libsepol/cil/src/cil_policy.h       |   12 +-
>  libsepol/src/libsepol.map.in        |    1 +
>  policycoreutils/Makefile            |    2 +-
>  policycoreutils/cil2conf/Makefile   |   33 +
>  policycoreutils/cil2conf/cil2conf.c |  192 +++
>  8 files changed, 1837 insertions(+), 1106 deletions(-)
>  create mode 100644 policycoreutils/cil2conf/Makefile
>  create mode 100644 policycoreutils/cil2conf/cil2conf.c
> 
