Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3IMWPAn006838
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 18:32:25 -0400
Date: Wed, 19 Apr 2017 08:32:20 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux patches for 4.12
In-Reply-To: <CAHC9VhSX2R6+eof6JPVyjzCmL0gFMMO=Liw15vVyED502eJ2gQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1704190832040.22202@namei.org>
References: <CAHC9VhSX2R6+eof6JPVyjzCmL0gFMMO=Liw15vVyED502eJ2gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 18 Apr 2017, Paul Moore wrote:

> Hi James,
> 
> A whopping 31 SELinux patches for v4.12, although 25 of these are the
> small little patches from Markus.  Beyond those 25 patches, the
> remaining six are equally trivial with the only real standout being
> Stephen's patch to reorder the DAC_OVERRIDE and DAC_READ_SEARCH
> checks.  Everything passes selinux-testsuite and merges cleanly with
> the linux-security/next branch; please apply.

Pulled, thanks.


-- 
James Morris
<jmorris@namei.org>
