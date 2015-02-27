Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1RDkaMK029006
 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2015 08:46:36 -0500
Message-ID: <54F0752D.9000705@tresys.com>
Date: Fri, 27 Feb 2015 08:46:21 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/2] Add option to remove HLL files and fix memory leaks
References: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/26/2015 02:15 PM, Yuli Khodorkovskiy wrote:
> This patchset adds a new option to semanage.conf to allow deleting HLL files after
> compilation into CIL. It also fixes a memory leak in semanage.conf that was exposed
> by the aforementioned patch.
> 
> An option to remove HLL files after compilation was originally discussed on the
> list [1]. If enabled, the module store will use about half as much space on disk.
> Additionally, less space will be used during a policy migration. Conversely, a
> user might not want to use this option if the HLL to CIL compiler changed. This 
> allows CIL files to be updated from undeleted HLL files in the module store when
> rebuilding with semodule. Otherwise, the HLL files must be reinstalled to get
> recompiled to CIL with an updated compiler.
> 
> [1] http://marc.info/?l=selinux&m=140562680432183&w=2
> 
> Yuli Khodorkovskiy (2):
>   libsemanage: Add option to remove HLL files after compilation
>   libsemanage: Fix memory leaks when parsing semanage.conf

Acked-by: Steve Lawrence <slawrence@tresys.com>

Thanks!

>  libsemanage/man/man5/semanage.conf.5 | 13 ++++++
>  libsemanage/src/conf-parse.y         | 28 +++++++++--
>  libsemanage/src/conf-scan.l          |  9 +---
>  libsemanage/src/direct_api.c         | 91 ++++++++++++++++++++++++------------
>  libsemanage/src/semanage_conf.h      |  1 +
>  5 files changed, 101 insertions(+), 41 deletions(-)
> 
