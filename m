Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UKhPhX015086
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 16:43:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 40x2cC1tJPz34qRY
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:43:23 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 40x2cB2Svtz34qRT
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:43:22 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id v135-v6so6351160lfa.9
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:43:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320174854.3154-1-richard_c_haines@btinternet.com>
References: <20180320174854.3154-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 16:42:18 -0400
Message-ID: <CAHC9VhRwG2SkHMMkYNrfEr0sSeoEr8y5vpXFYP93HxzPqYNU7A@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux-testsuite: Add SCTP test support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 20, 2018 at 1:48 PM, Richard Haines via Selinux
<selinux@tycho.nsa.gov> wrote:
> The sctp testsuite tests all new sctp SELinux functionality.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Now that the new SELinux userspace is out, I applied this to my test
tree and noticed two problems at the start (both easily fixed):

* We need to list the lksctp-tools-devel package as a dependency in README.md
* Minor merge conflict in policy/Makefile

... actually running the test went rather well, but there was one test
failure: test #11, the "asconf parameter chunk processing".  Looking a
bit closer at the failure, it appears that the address detection code
at the top of tests/sctp/test needs to be a bit more robust as
'hostname -I' returns multiple addresses, but they are a mix of IPv4
and IPv6 - all on one interface.

I would suggest taking a look at parsing the output of 'ip -o addr
show up scope global' and using that instead of 'hostname -I'.

-- 
paul moore
www.paul-moore.com
