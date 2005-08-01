Date: Mon, 1 Aug 2005 15:22:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
Message-ID: <20050801142212.GC10132@lkcl.net>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil> <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com> <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 01, 2005 at 09:41:05AM -0400, Stephen Smalley wrote:
> On Sun, 2005-07-31 at 11:59 -0400, James Morris wrote:
> > With these patches, on a 64-bit system, after boot:
> > 
> >   
> >             #objs  objsize   kernmem
> > Targeted:
> >   Before:  237888       40     9.1MB
> >   After:    19968       24     468KB
> > 
> > Strict:
> >   Before:  571680       40   21.81MB
> >   After:   221052       24    5.06MB
> 
> Ok, this along with the data I posted for 32-bit is certainly
> encouraging as far as memory savings are concerned.  Things that we need
> to resolve before committing/upstreaming these changes include:
> 
> - We need to measure the performance impact of the changes on the
> kernel, if any, and possibly optimize the compute_av code if it is
> measurable.

 little story for you that is comp-sci related [which if
 you're aware of these sorts of things i humbly apologise for
 mentioning - grandmas, eggs, suck, sorry :) ]

 andrew tridgell wrote an upper-case / lower-case unicode
 converter for samba.  it wasn't a 16-bit lookup table,
 because 65536 * 2 equals 128kbytes which is _way_ more memory
 than can fit into a first level cache of some processors.
 consequently, performance of a lookup table would be crap.
 what he wrote instead was a small algorithm with lookup ranges.
 it was heaps faster.
 
 anyway, what you're doing is reminiscent of that and so
 i thought i should mention it and i invite you to consider
 performing some tests on hardware ranging from ARM 2-400mhz
 with the usual shit-for-brains caches through PIIIs and
 AMD K7s to P4s, picking the most likely candidates where
 it's going to matter or even possibly consider offering /
 enabling / disabling different optimisations depending on
 the processor target (CONFIG_xxx).

 again though i respectfully ask you to totally ignore me
 should you have considered these things already - comp-sci
 being what it is.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
