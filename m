Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1DGOH4q019355
 for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2018 11:24:17 -0500
Message-ID: <1518538932.18249.14.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>, linux-sctp@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Date: Tue, 13 Feb 2018 16:22:12 +0000
In-Reply-To: <CAHC9VhR22eO9ugfAaY=PM9_aaHVa1hD05LFffNT-pXjz2Zt3Rw@mail.gmail.com>
References: <CAHC9VhR22eO9ugfAaY=PM9_aaHVa1hD05LFffNT-pXjz2Zt3Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: FYI: selinux/next rebased to v4.16-rc1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2018-02-12 at 16:13 -0500, Paul Moore wrote:
> A quick note to let you know that I've just rebased the selinux/next
> branch to v4.16-rc1.  Over the next day or two I'm going to be
> working
> through the backlog of kernel patches, most notably the SCTP work.
> 

I've just rebuilt the SCTP patch set on Fedora using:

kernel-4.16.0-0.rc1.git0.1.fc28.src.rpm

I found there were a number of changes required to get the SCTP
specific patches (2/4 and 3/4) to build as there have been many updates
since kernel 4.14.

The 4-16 kernel build passes my SCTP SELinux Testsuite although I also
added the "netlabel: If PF_INET6, check sk_buff ip header version" [1]
patch as well.

It's probably best I post these patches so the SCTP team can finally ok
them (or not). 

[1] https://marc.info/?l=selinux&m=151061619115945&w=2
