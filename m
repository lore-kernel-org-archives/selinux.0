Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAKKAudK032361
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 15:10:56 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id nAKK9rl2013340
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 20:09:53 GMT
Subject: Re: A question about genhomedircon
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com>
References: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 20 Nov 2009 15:11:28 -0500
Message-ID: <1258747888.27504.624.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-11-20 at 12:52 -0600, Manoj Srivastava wrote:
> Hi,
> 
>         Looking at policycoreutils-2.0.77/scripts/genhomedircon, I see:
> --8<---------------cut here---------------start------------->8---
> #!/bin/sh
> /usr/sbin/semodule -Bn
> --8<---------------cut here---------------end--------------->8---
> 
>         Looking at the man page for semodule, it says:
> --8<---------------cut here---------------start------------->8---
>  -B, --build
>         force a rebuild of policy (also reloads unless -n is used)
>  -n,--noreload
>         do not reload policy after commit
> --8<---------------cut here---------------end--------------->8---
> 
>         Given that, it would seem that genhomedircon rebuilds, but does
>  not reload policy. I would expect genhomedircon to generate SELinux
>  file context configuration entries for user home directories, or
>  something.
> 
>         What am I missing?

Theres no need to reload the policy, as the policy isn't changing.  It
does, however, regenerate the file contexts, including the home dir
contexts.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
