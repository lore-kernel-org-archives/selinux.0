Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4GHW7qE023762
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 13:32:07 -0400
Received: by mail-pg0-f45.google.com with SMTP id n9-v6so585414pgq.5
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 10:31:42 -0700 (PDT)
Date: Thu, 17 May 2018 01:31:38 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Message-ID: <20180516173138.GA12679@baraddur.perfinion.com>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <921a3a88-e10d-40dc-fde5-7ef12f775e32@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <921a3a88-e10d-40dc-fde5-7ef12f775e32@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace 2.8-rc3 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Just a quick note in case the release is soon.
I have a couple patches to make everything work on
Musl libc that im gonna clean them up and post in the morning.

On Thu, May 10, 2018 at 11:20:01AM -0400, Stephen Smalley wrote:
> A 2.8-rc3 release candidate for the SELinux userspace is now available at:
> https://github.com/SELinuxProject/selinux/wiki/Releases
> 
> Please give it a test and let us know if there are any issues.
> 
> A draft of the release notes is available from the Releases page, as
> is the full git log output and git shortlog output since the 2.7
> release.  If there are further items we should mention or if something
> should be amended in the release notes, let us know.
>  
> Thanks to all the contributors to this release candidate!
>  
> A shortlog of changes since the 2.8-rc2 release candidate is below.
> 
> Stephen Smalley (7):
>       libsepol: remove unused function and type
>       libselinux: fix build warning in save_booleans()
>       libselinux: avcstat: fix build warning
>       libselinux: audit2why: fix build warnings
>       libsemanage: prevent string overflow on final paths
>       libsepol: cil: prevent stack buffer overflow in cil_expr_to_string
>       Update VERSION files to 2.8-rc3
> 
> Vit Mojzis (1):
>       python/semanage/seobject.py: Fix undefined store check
