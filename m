Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1RODs018409
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:27:47 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QAe8GK012082
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 10:41:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Mihai Maties <mihai@xcyb.org>
Subject: Re: writing zero bytes in bash
Date: Sat, 26 Feb 2005 21:39:42 +1100
Cc: fedora-devel-list@redhat.com, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200502261832.16337.russell@coker.com.au> <200502261048.28448.mihai@xcyb.org>
In-Reply-To: <200502261048.28448.mihai@xcyb.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502262139.45861.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 26 February 2005 19:48, Mihai Maties <mihai@xcyb.org> wrote:
> On Saturday 26 February 2005 09:32, Russell Coker wrote:
> > It opens the file with O_CREAT (so if you were to do `echo -n "" >
> > /tmp/flag` to create a flag file then it would work as expected), but
> > never calls the write(2) system call.
> >
> > To unset the fscreate or exec context you have to call write(fd, X, 0)
> > (the value of X doesn't seem to matter as the kernel code doesn't
> > dereference it).
>
> As a sidenote, dd behaves the same. dd if=/dev/null of=something does not
> call write(2) because it doesn't need to write anything. Since no records
> were read it assumes that no records must be written. Again, the output
> file would be created because of the open("something", O_CREAT) call.

However dd bs=0 is an error, so dd refuses to operate in a situation where the 
operater specifically requests a zero write.

> > So it seems reasonable to me to consider this to be a bug in bash where
> > it's optimisation of shell code results in the action requested by the
> > user not being performed correctly.
>
> It's quite logical since if you do not have something to write, to not try
> to write it.

That's one approach to the issue.  The other is that if the administrator 
requests an operation then it should be completed.  In the majority of 
situations where a user requests a strange operation Unix complies and does 
as requested.  The expectation of a Unix system is that what you request will 
be done even if it is bad for you, so why not do what is requested just 
because it seems redundant?

Someone who does "echo -n > foo" to create file foo could have just as easily 
done "touch foo".

> > I expect that the bash developers may disagree with this assessment so I
> > would like some more input on the lists before I file a bug report.
>
> If I were a bash developer I would disagree with you :) You would ask me to
> make a workaround in bash to solve an issue that has its roots somewhere
> else...

Actually I am not asking for a feature to be added, but for a feature to be 
removed.  There is special-case code in bash if(size >0) write() and I am 
merely suggesting that the if statement be removed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
