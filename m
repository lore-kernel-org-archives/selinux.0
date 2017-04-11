Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BJRQBe027708
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 15:27:26 -0400
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
To: selinux@tycho.nsa.gov
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <27297f4a-b3ab-128c-7132-41c9add686a2@tycho.nsa.gov>
Date: Tue, 11 Apr 2017 15:27:59 -0400
MIME-Version: 1.0
In-Reply-To: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/11/2017 01:53 PM, James Carter wrote:
> The number of type attributes included in the binary policy is becomming a performance issue in some cases.
>
> This patch set more aggressives removes attributes and gives the options to expand and remove all auto-generated attributes and all attributes with fewer than a given amount of attributes assigned.
>
> Comparison of the number of attributes remaining in the binary policy
>      mls   normal  android
> org  310     286     255
> old  268     251     130
> max  154      20      17
> min  226     173     119
> def  224     170      80
> gen  221     170      46
> u5   191     112      59
>
> Org - Number of attributes in the CIL policy
> Old - Results without this patch set
> Max - Remove the maximum number of attributes: "-G -X 9999"
> Min - Remove the minimum number of attributes: "-X 0"
> Def - The new defaults for CIL
> Gen - Just removing auto-generated attributes: "-G"
> U5  - Remove attributes with less than five members: "-X 5"
>
>

In case you are interested in sizes:

        mls  normal  android
old   2.1M   2.0M     113K
max  68.3M  63.4M    5041K
min   2.1M   2.0M     122K
def   2.1M   2.0M     115K
gen   2.2M   2.0M     136K
u5    2.2M   2.0M     116K

I would not recommend expanding all attributes.

Jim

> James Carter (2):
>   libsepol/cil: Add ability to expand some attributes in binary policy
>   secilc: Add options to control the expansion of attributes
>
>  libsepol/cil/include/cil/cil.h     |   2 +
>  libsepol/cil/src/cil.c             |  12 ++
>  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----------
>  libsepol/cil/src/cil_internal.h    |   7 +-
>  libsepol/cil/src/cil_post.c        |  32 +++--
>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>  libsepol/src/libsepol.map.in       |   2 +
>  secilc/secil2conf.c                |   2 +
>  secilc/secilc.8.xml                |  10 ++
>  secilc/secilc.c                    |  31 ++++-
>  10 files changed, 275 insertions(+), 101 deletions(-)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
