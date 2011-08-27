Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7RDkh7w004499
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 09:46:44 -0400
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7RDkgvQ005563
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 13:46:42 GMT
Received: by ywb5 with SMTP id 5so4596679ywb.12
        for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 06:46:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>
References: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
	<SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>
Date: Sat, 27 Aug 2011 09:46:41 -0400
Message-ID: <CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
Subject: Re: Toolchain is broken?
From: Eric Paris <eparis@parisplace.org>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Must have come from this patch.

commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a
Author: Russell Coker <russell@coker.com.au>
Date:   Wed Jan 5 19:30:25 2011 +1100

    libsemanage: patch for MCS/MLS in user files

Russell, do you know what's going on?

-Eric

2011/8/27 HarryCiao <harrytaurus2002@hotmail.com>:
> BTW, on my box this problem could temporarily worked around by specifying
> "disable-genhomedircon = true".
>
> ________________________________
> From: harrytaurus2002@hotmail.com
> To: selinux@tycho.nsa.gov
> Subject: Toolchain is broken?
> Date: Sat, 27 Aug 2011 07:45:11 +0000
>
> Hi,
>
> When I am improving my patchset to discard unused branches of tunable
> conditionals these days, I run into a new segfault issue that seems has
> nothing to do with my patchset. After I checked back to the master branch
> for both toolchain and refpolicy and pulled the latest codes, the segfault
> still exist.
>
> Turns out the problem lies in genhomedircon.c, the level argument passed to
> set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below
> is the debug message I've seen:
>
> genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user,
> level = (null)
> Passing NULL to strdup would segfault
> make: *** [load] Segmentation fault
>
> Has anyone else also run into the same problem? I didn't run into it before
> Aug 23rd, if this is a real problem, then it must have been introduced after
> that date.
>
> So far I am pretty new to the semanage code, any idea to fix this issue?
>
> Thanks,
> Harry
>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
