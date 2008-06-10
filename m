MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: tracking down execstack & execmem violations
Date: Tue, 10 Jun 2008 10:23:40 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9EACE@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net> <1213118122.30576.147.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Tuesday, June 10, 2008 10:15 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: tracking down execstack & execmem violations
> 
> 
> On Tue, 2008-06-10 at 10:10 -0700, Clarkson, Mike R (US SSA) wrote:
> > I'm writing a policy for a very large legacy CORBA application, with
> > many separate processes. Without fail, every one of our processes
> > requires execstack & execmem privileges. I would like to track down
the
> > cause, but I really don't have any idea how. Does anybody have any
good
> > recommendations?
> >
> > I'd like to at least be able to determine whether the offending code
is
> > ours or some vender's (like our CORBA vender), and if it is ours I'd
> > like to track down the source. I'm betting there is a common source
> > causing the issue.
> 
> Resources:
> http://people.redhat.com/drepper/selinux-mem.html
> http://people.redhat.com/drepper/nonselsec.pdf

I'll look at these. Thanks!
> 
> Also, what does execstack -q show for the executables in question?

I wasn't aware of the execstack cmd. This alone will help a lot. Thanks
again.

> And are these programs:
> - multi-threaded?,
> - Java-based?

Mostly C++ but a few Java. Nearly all are multi-threaded.

> 
> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
