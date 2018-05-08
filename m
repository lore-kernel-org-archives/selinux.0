Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w48CGW7p004583
 for <selinux@tycho.nsa.gov>; Tue, 8 May 2018 08:16:32 -0400
To: SELinux <selinux@tycho.nsa.gov>
References: <20180503184845.19790-1-sds@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <07f523e4-0650-e21f-2d5b-1bd3efb246dc@tycho.nsa.gov>
Date: Tue, 8 May 2018 08:17:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180503184845.19790-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 0/4] Fix build warnings with gcc 8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/03/2018 02:48 PM, Stephen Smalley wrote:
> I encountered a number of build warnings on the selinux userspace
> using gcc 8, which is the default now in F28 and rawhide. This fixes
> the ones that are treated as fatal errors by default.  There are still
> known warnings due to the flex skeleton and something to do with the
> python bindings, but those are not new.
> 
> Stephen Smalley (4):
>   libsepol: remove unused function and type
>   libselinux: fix build warning in save_booleans()
>   libselinux: avcstat: fix build warning
>   libselinux: audit2why: fix build warnings
> 
>  libselinux/src/audit2why.c                 | 2 +-
>  libselinux/src/booleans.c                  | 4 +++-
>  libselinux/utils/avcstat.c                 | 3 ++-
>  libsepol/include/sepol/policydb/policydb.h | 3 ---
>  libsepol/src/policydb.c                    | 8 --------
>  5 files changed, 6 insertions(+), 14 deletions(-)

Applied.
