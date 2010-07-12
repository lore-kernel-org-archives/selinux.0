Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CEZSH7022000
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 10:35:28 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CEbNjj024455
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 14:37:23 GMT
Received: by bwz6 with SMTP id 6so2643946bwz.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 07:35:26 -0700 (PDT)
Date: Mon, 12 Jul 2010 17:35:21 +0300
From: =?UTF-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
To: Martin Orr <martin@martinorr.name>
Cc: russell@coker.com.au, Eric Paris <eparis@parisplace.org>,
        SE-Linux
 <selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
Message-ID: <20100712173521.1c436f94@debian>
In-Reply-To: <20100712153242.10606virkn0rqeos@webmail.tuffmail.net>
References: <201007121922.48247.russell@coker.com.au>
	<20100712140130.468b7b42@debian>
	<AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
	<201007122208.13078.russell@coker.com.au>
	<20100712154528.47864541@debian>
	<20100712153242.10606virkn0rqeos@webmail.tuffmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2010 15:32:42 +0100
Martin Orr <martin@martinorr.name> wrote:

> On Mon 12 Jul 13:45:28 2010, Török Edwin wrote:
> > On Mon, 12 Jul 2010 22:08:12 +1000
> > Russell Coker <russell@coker.com.au> wrote:
> >> On Mon, 12 Jul 2010, Eric Paris <eparis@parisplace.org> wrote:
> >> Now given that freshclam doesn't do any serious work with the data,
> >> is interpreting it going to cause any problem that we will care
> >> about?  If we are talking about 1 hour of CPU time vs 2 hours for
> >> jit vs interpreted for run- time stuff then it makes a difference,
> >> but if we are talking about 1 second vs 2 seconds for freshclam
> >> then maybe there's not much point.
> >>
> >
> > Well the purpose of loading the database with freshclam is to avoid
> > causing problems to clamd. So it is important that they are either
> > both JIT, or both non-JIT.
> 
> I configured clamd not to use the JIT by putting "Bytecode false" in  
> clamd.conf.  I put the same thing in freshclam.conf, but it
> continues to try to allocate executable memory.
> 

That sounds like a bug, please open a bugreport at bugs.clamav.net, and
attach the output of strace freshclam.

Best regards,
--Edwin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
