Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56CS3rT029290
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 08:28:04 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i56CRwRQ005704
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 08:27:59 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [patch]
Date: Sun, 6 Jun 2004 22:27:54 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040605161213.GA5998@lkcl.net> <200406061814.50731.russell@coker.com.au> <20040606104814.GF9675@lkcl.net>
In-Reply-To: <20040606104814.GF9675@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406062227.54099.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 6 Jun 2004 20:48, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > - transport (-MC)
> > > - smtp in
> > > - alias (-bi)
> > > - initial daemon startup
> >
> > From a quick inspection it appears that you missed some calls to
> > child_exec_exim(), for example the "exim -q" operation when starting
> > exim.
>
>  oh, drat :)
>
>  thanks - that's the sort of thing i needed to know.
>
>  ... ah, yes, you're right!  _sometimes_ it does an execv inside
>  child_exec_exim and sometimes it doesn't.  *sigh*.

Well child_exec_exim() has code to check the main parameter for the purpose of 
error logging.  It shouldn't be difficult to add some code in that checks the 
parameter against a table to determine what (if anything) to append to the 
command name.

> > For SE Linux we need small executables that will exec exim4 with the same
> > parameters to give the domain transition.
>
>  ack.
>
>  i haven't changed any of the parameters, so you'd still get
>  exim-bi -bi ... and exim-MC -MC .... etc.

Yes, so the following code should be all that's needed for a minimal 
implementation.  It may be necessary to have the code check that argv[1] is 
appropriate for the domain that the new instance of exim4 is to be run in, 
but I'm not certain about that (we can do it later if necessary).  Also we 
need something similar for runq etc.

int main(int argc, char **argv, char **envp)
{
  return execve("/usr/sbin/exim4", argv, envp);
}

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
