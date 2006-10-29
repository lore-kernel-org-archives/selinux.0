Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T66x84027149
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 01:07:00 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T663F5002657
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 06:06:03 GMT
Received: by wx-out-0506.google.com with SMTP id i26so1201881wxd
        for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 23:06:40 -0700 (PDT)
Subject: Re: New to SELinux -- any suggestions?
From: Michael Graffam <michael.graffam@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610291601.19715.russell@coker.com.au>
References: <1162086080.2566.16.camel@endless>
	 <200610291432.01272.russell@coker.com.au>
	 <1162096212.15530.22.camel@endless>
	 <200610291601.19715.russell@coker.com.au>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 01:05:58 -0500
Message-Id: <1162101958.2580.10.camel@endless>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-10-29 at 15:01 +1000, Russell Coker wrote:
> On Sunday 29 October 2006 15:30, Michael Graffam <michael.graffam@gmail.com> 
> wrote:
> > Thank you for the help. Can one AND/OR the contexts? Based on the above,
> > it would seem to me that if an executable violated two points of policy
> > it wouldn't be possible to 'bless' it -- since I'm sure this isn't the
> > case, I'm wondering how I might apply multiple contexts. Or am I still
> > out in left field here?
> 
> I don't know what you mean by "bless" in this message.

By "bless" I meant "Allow it to run regardless." Or "Give it the
blessing to misbehave."


> If however a file could have multiple types then such analysis would be 
> impossible unless you also had rules determining which pairs of contexts 
> might be applied to one file (in which case every permitted pair of contexts 
> could be mapped to a single context in the current SE Linux system for the 
> same result).

OK, that makes perfect sense. I had figured that multiple contexts would
be allowed, to prevent the possible need of expanding the number of
required 'base' contexts. But, I can certainly see your point about the
difficulty of analyzing all possible combinations. 

> > Whooo.. new ls fields too! Man, I feel like a kid again! This is
> > great! :) Having been using GNU/Linux for so long, I almost forgot how
> > fun it is to learn new stuff about it!
> 
> There is also "id -Z", "ps -Z" and "cp -Z".  There are also a few new 
> commands, in addition to chcon there's runcon and newrole (which isn't being 
> used so much nowadays) and there is semanage and getsebool/setsebool to 
> manage it.

Thanks again for your help. Would you happen to know if there is a
document somewhere which gives a general overview of the structure of
the SELinux mechanisms, maybe with some details on the common contexts
and so forth?

-M


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
