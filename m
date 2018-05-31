Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4VKQ8OB031974
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 16:26:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 40xf9q155Wz1pJ8x
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 20:26:07 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 40xf9p2lYCz1pJ99
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 20:26:06 +0000 (UTC)
Message-ID: <288948937c69526533c39c6f955c34349795ee7b.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 31 May 2018 21:26:01 +0100
In-Reply-To: <CAHC9VhRwG2SkHMMkYNrfEr0sSeoEr8y5vpXFYP93HxzPqYNU7A@mail.gmail.com>
References: <20180320174854.3154-1-richard_c_haines@btinternet.com>
 <CAHC9VhRwG2SkHMMkYNrfEr0sSeoEr8y5vpXFYP93HxzPqYNU7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux-testsuite: Add SCTP test support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-05-30 at 16:42 -0400, Paul Moore wrote:
> On Tue, Mar 20, 2018 at 1:48 PM, Richard Haines via Selinux
> <selinux@tycho.nsa.gov> wrote:
> > The sctp testsuite tests all new sctp SELinux functionality.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Now that the new SELinux userspace is out, I applied this to my test
> tree and noticed two problems at the start (both easily fixed):
> 
> * We need to list the lksctp-tools-devel package as a dependency in
> README.md
> * Minor merge conflict in policy/Makefile
> 
> ... actually running the test went rather well, but there was one
> test
> failure: test #11, the "asconf parameter chunk processing".  Looking
> a
> bit closer at the failure, it appears that the address detection code
> at the top of tests/sctp/test needs to be a bit more robust as
> 'hostname -I' returns multiple addresses, but they are a mix of IPv4
> and IPv6 - all on one interface.
> 
> I would suggest taking a look at parsing the output of 'ip -o addr
> show up scope global' and using that instead of 'hostname -I'.
> 

Thanks for the feedback, I'll fix these and post a new patch in a few
days.
