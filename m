Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UEGTXR017171
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 10:16:29 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UEGOiN029315
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 14:16:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <jim@meyering.net>
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
Date: Sat, 31 Mar 2007 01:16:07 +1100
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
References: <87tzw3x9mo.fsf@rho.meyering.net> <200703302237.35950.russell@coker.com.au> <87odmayiw0.fsf@rho.meyering.net>
In-Reply-To: <87odmayiw0.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703310016.13634.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 March 2007 23:13, Jim Meyering <jim@meyering.net> wrote:
> What did you think of the proposal (in the link above) for
>
>     fscon CTX mkdir /new/directory
>
> IMHO, it's not so much less "user friendly" than this equivalent:
>
>     mkdir -C CTX /new/directory

How about:
umask whatever ; mkdir /new/directory

Instead of mkdir -m whatever /new/directory?

> > I think that all programs which set the uid and gid of a file should also
> > be able to set the SE Linux context.
> >
> > It also seems reasonable that a program which can create a file with
> > particular permissions should also be permitted to create it with a
> > particular context.
>
> I was hoping for feedback on whether the proposed alternative (using
> fscon and maybe runcon proxies) looked viable from a usability standpoint.

Firstly there is the issue that fscon needs kernel changes to implement, then 
there is the issue that inheriting fscon can potentially give undesired 
results if privileged programs such as /bin/passwd forget to unset it, so 
therefore we need a policy method to control whether such inheriting of the 
fscon is permitted.

Adding an option to utilities is by far the easiest option.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
