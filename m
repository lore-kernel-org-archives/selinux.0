Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H9RnrT012324
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 05:27:49 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H9RlKV009376
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 09:27:48 GMT
Date: Tue, 17 Aug 2004 10:38:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: how does this port binding happen?
Message-ID: <20040817093819.GM18321@lkcl.net>
References: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com> <200408171610.16785.russell@coker.com.au> <20040817084234.GK18321@lkcl.net> <200408171857.26056.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408171857.26056.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 17, 2004 at 06:57:26PM +1000, Russell Coker wrote:
> On Tue, 17 Aug 2004 18:42, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > On Tue, Aug 17, 2004 at 04:10:16PM +1000, Russell Coker wrote:
> > > On Tue, 17 Aug 2004 15:23, James Morris <jmorris@redhat.com> wrote:
> > > > On Tue, 17 Aug 2004, Russell Coker wrote:
> > > > > avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669
> > > > > scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t
> > > > > tclass=tcp_socket
> > > > >
> > > > > kview is a viewer for JPEG etc images.  It is never run as root.  How
> > > > > does it get to the stage of an SE Linux access check?
> > > >
> > > > This check is done before the kernel DAC check.
> > >
> > > Is it practical to get that changed?
> > >
> > > There are quite a number of programs that make bogus attempts to bind to
> > > low ports.  There is no excuse for a print client binding to port 631 or
> > > a POP client binding to port 110.
> >
> > there is _one_ necessary exception: due to a bug in network
> > neighbourhood code in windows systems.
> >
> > this bug was corrected and proper UDP behaviour observed in
> > ONE version of windows nt - 3.51 - whereup on the bug was
> > reintroduced thereafter.
> 
> It's for this sort of thing that we need to get the kernel code changed.  We 
> don't want to audit huge numbers of regular stupid operations from KDE 
> programs, but we also don't want a dontaudit rule to catch the few cases 
> where such access may be really needed (such as the example you gave).
 
 well... in this instance [137], the present scenario is:

 - nmbd binds to UDP port 137 and therefore no other program can

 - nmblookup binds to a high UDP port number and sends to port 137,
   expecting a response on the high UDP port.

 - nmbd receives the response that SHOULD have gone to the high UDP
   port, looks it up in its state tables, and goes "eek, i shouldn't
   have received that, _let's_ stick it in a file unexpected.tdb".

 - nmblookup, which is still waiting for data on the high UDP port,
   _also_ polls the same unexpected.tdb database file.

   therefore it receives its response.

 
 until recently, where the tdb program was GPL'd, it was impossible for
 any other open source project to do the same method.


 so the other scenario is:

 - The Wine team wrote their own (experimental) code which REPLACES
   all the GPL'd work done by the samba team with LGPL'd code.

   THEIR code binds to port 137.

   .... etc.
 
 i've been endeavouring to persuade people to do this properly
 (the unexpected.tdb database method has problems with the "state"
  records, namely that the lookup table has only 64k possible entries).
 
 
 anyway.

 one for the future, because the Wine team's code is experimental.

 l.

> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
