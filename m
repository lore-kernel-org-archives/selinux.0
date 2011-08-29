Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T5fnvX025011
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 01:41:50 -0400
Received: from snt0-omc3-s49.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T5fmuS028526
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 05:41:48 GMT
Message-ID: <SNT139-W630BDE83D83FC2A82CE970AB140@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_887ca05d-e8fd-4019-9334-8997d63626c0_"
From: HarryCiao <harrytaurus2002@hotmail.com>
CC: <selinux@tycho.nsa.gov>, <russell@coker.com.au>
Subject: RE: Toolchain is broken?
Date: Mon, 29 Aug 2011 05:41:47 +0000
In-Reply-To: 
 <CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
References: 
 <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>,<SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>,<CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_887ca05d-e8fd-4019-9334-8997d63626c0_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Yep, just verified that revert this commit and the problem would go away.

> Date: Sat, 27 Aug 2011 09:46:41 -0400
> Subject: Re: Toolchain is broken?
> From: eparis@parisplace.org
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov; russell@coker.com.au
> 
> Must have come from this patch.
> 
> commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a
> Author: Russell Coker <russell@coker.com.au>
> Date:   Wed Jan 5 19:30:25 2011 +1100
> 
>     libsemanage: patch for MCS/MLS in user files
> 
> Russell, do you know what's going on?
> 
> -Eric
> 
> 2011/8/27 HarryCiao <harrytaurus2002@hotmail.com>:
> > BTW, on my box this problem could temporarily worked around by specifying
> > "disable-genhomedircon = true".
> >
> > ________________________________
> > From: harrytaurus2002@hotmail.com
> > To: selinux@tycho.nsa.gov
> > Subject: Toolchain is broken?
> > Date: Sat, 27 Aug 2011 07:45:11 +0000
> >
> > Hi,
> >
> > When I am improving my patchset to discard unused branches of tunable
> > conditionals these days, I run into a new segfault issue that seems has
> > nothing to do with my patchset. After I checked back to the master branch
> > for both toolchain and refpolicy and pulled the latest codes, the segfault
> > still exist.
> >
> > Turns out the problem lies in genhomedircon.c, the level argument passed to
> > set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below
> > is the debug message I've seen:
> >
> > genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user,
> > level = (null)
> > Passing NULL to strdup would segfault
> > make: *** [load] Segmentation fault
> >
> > Has anyone else also run into the same problem? I didn't run into it before
> > Aug 23rd, if this is a real problem, then it must have been introduced after
> > that date.
> >
> > So far I am pretty new to the semanage code, any idea to fix this issue?
> >
> > Thanks,
> > Harry
> >
> >
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_887ca05d-e8fd-4019-9334-8997d63626c0_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Yep, just verified that revert this commit and the problem would go away.<br><br><div>&gt; Date: Sat, 27 Aug 2011 09:46:41 -0400<br>&gt; Subject: Re: Toolchain is broken?<br>&gt; From: eparis@parisplace.org<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov; russell@coker.com.au<br>&gt; <br>&gt; Must have come from this patch.<br>&gt; <br>&gt; commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a<br>&gt; Author: Russell Coker &lt;russell@coker.com.au&gt;<br>&gt; Date:   Wed Jan 5 19:30:25 2011 +1100<br>&gt; <br>&gt;     libsemanage: patch for MCS/MLS in user files<br>&gt; <br>&gt; Russell, do you know what's going on?<br>&gt; <br>&gt; -Eric<br>&gt; <br>&gt; 2011/8/27 HarryCiao &lt;harrytaurus2002@hotmail.com&gt;:<br>&gt; &gt; BTW, on my box this problem could temporarily worked around by specifying<br>&gt; &gt; "disable-genhomedircon = true".<br>&gt; &gt;<br>&gt; &gt; ________________________________<br>&gt; &gt; From: harrytaurus2002@hotmail.com<br>&gt; &gt!
 ; To: selinux@tycho.nsa.gov<br>&gt; &gt; Subject: Toolchain is broken?<br>&gt; &gt; Date: Sat, 27 Aug 2011 07:45:11 +0000<br>&gt; &gt;<br>&gt; &gt; Hi,<br>&gt; &gt;<br>&gt; &gt; When I am improving my patchset to discard unused branches of tunable<br>&gt; &gt; conditionals these days, I run into a new segfault issue that seems has<br>&gt; &gt; nothing to do with my patchset. After I checked back to the master branch<br>&gt; &gt; for both toolchain and refpolicy and pulled the latest codes, the segfault<br>&gt; &gt; still exist.<br>&gt; &gt;<br>&gt; &gt; Turns out the problem lies in genhomedircon.c, the level argument passed to<br>&gt; &gt; set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below<br>&gt; &gt; is the debug message I've seen:<br>&gt; &gt;<br>&gt; &gt; genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user,<br>&gt; &gt; level = (null)<br>&gt; &gt; Passing NULL to strdup would segfault<br>&gt; &gt; make: *** [load] Segmentat!
 ion fault<br>&gt; &gt;<br>&gt; &gt; Has anyone else also run into the 
same problem? I didn't run into it before<br>&gt; &gt; Aug 23rd, if this is a real problem, then it must have been introduced after<br>&gt; &gt; that date.<br>&gt; &gt;<br>&gt; &gt; So far I am pretty new to the semanage code, any idea to fix this issue?<br>&gt; &gt;<br>&gt; &gt; Thanks,<br>&gt; &gt; Harry<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_887ca05d-e8fd-4019-9334-8997d63626c0_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
