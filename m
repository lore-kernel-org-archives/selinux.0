Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k173JKXf017086
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 22:19:21 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k173Hxnx011737
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 03:18:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: MCS policy patch
Date: Tue, 7 Feb 2006 14:19:04 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
References: <200602040118.10784.russell@coker.com.au> <1139267067.13925.27.camel@sgc>
In-Reply-To: <1139267067.13925.27.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602071419.13087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 07 February 2006 10:04, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Sat, 2006-02-04 at 01:18 +1100, Russell Coker wrote:
> > +mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
> > +               ( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t
> > ) or +               ( t1 == kernel_t ));
> > +
> > +mlsconstrain process { sigkill sigstop signal } ( h1 dom h2 ) or
> > +               ( t1 == init_t ) or ( t1 == initrc_t );
>
> We can't have these hardcoded types.  What we need is similar to how the
> mls constraints are handled.  Attributes and interfaces need to be added
> to the mls module, then the above domains would use the interfaces to
> gain these attributes.

Actually I never planned to have it like that.  But the lack of support for 
range transition statements outside the base module prevents me from doing 
what I want.

I believe that the correct thing to do is to have kernel processes run with 
context s0:c0.c255, and have init scripts or daemons transition to 
s0-s0:c0.c255 or s0 as appropriate.  Therefore neither of the above 
statements would have any of the exceptions that are listed.

Adding attributes for things that we plan to remove is not desirable IMHO.  
Although I admit that it's likely that we won't get it all working the way we 
like before FC5 release and having the policy you quote above in FC5 would 
suck a little.

RHEL5 can't be released with the above policy, not because it's an enterprise 
product, but because it'll be around for 7 years...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
