Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLI6Fk5016406
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 13:06:15 -0500
Received: by mail-wj0-f195.google.com with SMTP id o3so3895510wjo.2
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 10:06:14 -0800 (PST)
Subject: Re: [PATCH v2] selinux: use the kernel headers when building
 scripts/selinux
To: Paul Moore <pmoore@redhat.com>
References: <148233685348.23556.6766505841733321185.stgit@sifl>
Cc: selinux@tycho.nsa.gov
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <2ef38284-be9c-306f-979f-2507106af09b@m4x.org>
Date: Wed, 21 Dec 2016 19:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <148233685348.23556.6766505841733321185.stgit@sifl>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 21/12/16 17:14, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Commit 3322d0d64f4e ("selinux: keep SELinux in sync with new capability
> definitions") added a check on the defined capabilities without
> explicitly including the capability header file which caused problems
> when building genheaders for users of clang/llvm.  Resolve this by
> using the kernel headers when building genheaders, which is arguably
> the right thing to do regardless, and explicitly including the
> kernel's capability.h header file in classmap.h.  We also update the
> mdp build, even though it wasn't causing an error we really should
> be using the headers from the kernel we are building.

I tested this patch and it works fine on my configuration (no compiler
warning and the kernel headers are included as expected). Thanks!

Nicolas
