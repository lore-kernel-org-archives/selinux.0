Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0LALMRb000447
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 05:21:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0LALLiV001293
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 10:21:21 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
        by jazzband.ncsc.mil  with SMTP id i0LALL06001290 for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 10:21:21 GMT
Message-ID: <3302.68.6.187.64.1074680162.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <200401211935.42235.russell@coker.com.au>
References: <1988.68.6.187.64.1074664098.squirrel@mxlx1.surveysavvy.com>
    <200401211935.42235.russell@coker.com.au>
Date: Wed, 21 Jan 2004 02:16:02 -0800 (PST)
Subject: Re: Debian and 2.6 selinux
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Wed, 21 Jan 2004 16:48, "Chris Babcock" <cbabcock@luthresearch.com>
> wrote:
>> Does the 2.6 version of SE work well on Debian Potato (r2) or do I need
>> to
>> run Sid to get good results with the 2.6 version?
>
> Potato has never been supported by SE Linux.

Sorry.  My brain crossed a few of the wrong wires...  I have been working
on some old third party Potato servers lately, and I blended projects
together.  I meant Woody in the original post.

>
> Woody now works for the "new SE Linux" which is back-ported to 2.4.x from
> 2.6.x with the following /etc/apt/sources.list line:
> deb http://www.microcomaustralia.com.au/debian/ stable selinux main
>
> However I have not tried woody with a 2.6.x kernel.  I don't know why you
> would want to run Debian/stable with a 2.6.x kernel though, as 2.6.x
> kernels
> are not stable in my experience!
>

Is that 2.6 alone is too unstable for your taste, or 2.6 with SE enabled
is too unstable?

I am looking to build a system that I don't have to deal with 2 moving
targets at the same time.  Sid/unstable lives up to its name at least in
the respect that it changes frequently.  Even if I find a working
combination that I like this week, the versioning and stability will
change next time I update.  SELinux also moves at a fair rate.  Over the
past year the guts of the system have been significantly changed.  It also
appears that the bulk of the development is being done on the 2.6 kernel.

So, I was thinking that perhaps running 2.6 w/SE on a known, stable
infrequently changing platform may be worth a try, since it would let me
compare Non-SE, 2.4-SE, and 2.6-SE on a common, easily reproducible base
platform.  It is probably a bad idea.  Most of the debian stable packages
are downright stale.  Odds are something in the system will end up causing
trouble with the 2.6 kernel.  Any thoughts on this?

Also, what combination of base distro and SE do you prefer for production
servers?

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
