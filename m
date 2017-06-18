Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5I7WkAw002663
 for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2017 03:32:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so40334718pff.3
 for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2017 00:32:38 -0700 (PDT)
Date: Sun, 18 Jun 2017 15:32:33 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: ANN: SELinux userspace 2.7-rc2 release
Message-ID: <20170618073233.GA24080@meriadoc.perfinion.com>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1497632109.7898.5.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There is a bug that needs to be fixed before the final release:
https://bugs.gentoo.org/show_bug.cgi?id=621762

I think the fix is just add override in utils/Makefile to the LDLIBS and
LDFLAGS bits. I'm not sure I'll have time to get around to testing
it so just wanted to let you know before the final release.

-- Jason

On Fri, Jun 16, 2017 at 12:55:09PM -0400, Stephen Smalley wrote:
> A second release candidate for the SELinux userspace is now available
> at:
> https://github.com/SELinuxProject/selinux/wiki/Releases
> 
> Please give it a test and let us know if there are any issues.
> 
> Changes from the -rc1 release:
> 
> James Carter (2):
>       libsepol: Fix neverallow bug when checking conditional policy
>       libsepol/cil: Fix bugs when writing policy.conf rules
> 
> Nicolas Iooss (1):
>       libsepol: destroy the expanded level when
> mls_semantic_level_expand() fails
> 
> Richard Haines (2):
>       libsepol/cil: ibendportcon fails to resolve in CIL policy
>       secilc: Update test policy and documentation for Infiniband
> 
> Stephen Smalley (1):
>       Update VERSION files for 2.7-rc2 release.
> 
> Vit Mojzis (1):
>       policycoreutils/fixfiles: do not dereference link files in tmp
