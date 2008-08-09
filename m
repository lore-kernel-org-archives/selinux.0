Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m792KoOW009293
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 22:20:50 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m792Kndh029405
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 02:20:50 GMT
Received: by an-out-0708.google.com with SMTP id d30so217824and.75
        for <selinux@tycho.nsa.gov>; Fri, 08 Aug 2008 19:20:49 -0700 (PDT)
Message-ID: <a040ffdc0808081920x11526c91u33d2e3b3d079c4dd@mail.gmail.com>
Date: Fri, 8 Aug 2008 22:20:47 -0400
From: "max bianco" <maximilianbianco@gmail.com>
To: "Joshua Brindle" <method@manicmethod.com>
Subject: Re: Request for multiple mailing lists
Cc: russell@coker.com.au, "Vesa-Matti J Kari" <vmkari@cc.helsinki.fi>,
        "Andy Warner" <warner@rubix.com>,
        "Casey Schaufler" <casey@schaufler-ca.com>,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <489C7DEE.7090006@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <489B25B6.4080309@windriver.com> <489C1BB1.2060701@rubix.com>
	 <Pine.LNX.4.64L.0808081319150.25440@ruuvi.it.helsinki.fi>
	 <200808082048.53795.russell@coker.com.au>
	 <489C7DEE.7090006@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 8, 2008 at 1:10 PM, Joshua Brindle <method@manicmethod.com> wrote:
> Russell Coker wrote:
>> On Friday 08 August 2008 20:33, Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
>
> <snip>
>
> Back on topic:
>
> I've multiple times in the past that I'd like to have a policy list that was separate. The main problem here is that all the core developers would almost certainly be subscribed to both (all) of them so there is little motivation on this end to split the lists out.
>
> I completely disagree with splitting kernel and userland out as kernel changes almost always require userland changes, and userland changes are often created to address format changes, etc that are of interest to the kernel.
>
> That said, even if we had to be subscribed to both it would be easier to disregard the parts less interesting to us (for me, that is policy, for Chris that is the other).
>
> So I'll +1 the request but believe only 2 lists are necessary.
>
> --

This list is hardly what I would call high traffic. It is about the
only source of current SELinux info that I have found.  Splitting this
into more than one list would be a mistake.
Why?
The policy as pointed out by others is central to selinux. If you
separate the policy discussion from the kernel code discussion then
you start splitting SELinux into separate components and you
subsequently start looking at these separate components as though they
are not part of a cohesive whole. Then you'll fall prey to
communication breakdowns, silly mistakes that would have been caught
will start to slip through. SELinux isn't like any other open source
project. It involves security. That one subject that most people can
never agree on and are afraid to talk about, lest they be wrong,
someone forbid:^) Obviously not a field for the faint of heart or the
close minded. Good security requires an open approach and an
appreciation of the big picture. It's going to be hard to keep a
proper perspective on the big picture, if you forget to check you
policy list because you happen to be especially busy handling kernel
code changes or vice versa. Its easy enough to read the subject line
and disregard the ones that deal with policy if they don't interest
you. You cannot separate the body from the mind. One affects the
other. You cannot treat the kernel code discussion as separate from
the policy discussion. Each has an affect on the other. That's my
.000002.

-Max
-- 
We start decomposing the day we are born

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
