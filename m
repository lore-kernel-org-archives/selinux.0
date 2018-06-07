Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5711tSI032669
 for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2018 21:01:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 411S1F3mTzz4KRKV
 for <selinux@tycho.nsa.gov>; Thu,  7 Jun 2018 01:01:53 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 411S1D683Mz4KRKS
 for <selinux@tycho.nsa.gov>; Thu,  7 Jun 2018 01:01:52 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so11970068lfy.0
 for <selinux@tycho.nsa.gov>; Wed, 06 Jun 2018 18:01:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601074447.14112-1-richard_c_haines@btinternet.com>
References: <20180601074447.14112-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Jun 2018 21:00:49 -0400
Message-ID: <CAHC9VhSQrsbqs7mkK6vvQJO8O8-eOHpw7jOQTB1_Jo13-1xFtw@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V2] selinux-testsuite: Add SCTP test support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 1, 2018 at 3:44 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The sctp testsuite tests all new sctp SELinux functionality.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Add -v option to test
> Add info in README.md regarding lksctp-tools-devel requirements
> Fix asconf parameter chunk processing in test
> Fix merge error for policy/Makefile
> Fix buffer overflow in sctp_asconf_params_client.c

Merged with the understanding that this is a *massive* patch and I
went rather quickly through parts so I'm sure I may have missed a few
things, but it works on my test system now so that's good :)

Thanks again for all the time and effort that went into the SCTP
patches/tests, I know how difficult stuff like this can be at times.

-- 
paul moore
www.paul-moore.com
