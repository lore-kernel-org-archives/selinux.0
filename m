Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81LLHrT024906
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 17:21:17 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81LLFeu018671
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 21:21:15 GMT
Date: Wed, 1 Sep 2004 22:32:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
Subject: Re: dpkg and selinux
Message-ID: <20040901213222.GC6567@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <1094004762.6901.68.camel@descent.netsplit.com> <20040901101921.GC5882@lkcl.net> <1094045403.6901.112.camel@descent.netsplit.com> <20040901172551.GC4400@lkcl.net> <1094071829.6901.149.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094071829.6901.149.camel@descent.netsplit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 01, 2004 at 09:50:28PM +0100, Scott James Remnant wrote:
> On Wed, 2004-09-01 at 18:25 +0100, Luke Kenneth Casson Leighton wrote:
> 
> > On Wed, Sep 01, 2004 at 02:30:03PM +0100, Scott James Remnant wrote:
> > > However I'm loath to embed specific selinux support into dpkg if it
> > > introduces extra dependencies, or causes problems for those not using
> > > it.
> >  
> >  1) fortunately, the only extra dependency will be libselinux1 which
> >     needs to be made "Required" such that cron, coreutils, logrotate,
> > 	ssh etc. can use it.
> > 
> That rules that solution out, then.  

 ... temporarily.

> I'm not going to add a dpkg
> dependency on libselinux until selinux is the default (over chown/chmod/
> etc.)
 
 it's okay: the only reason that libselinux1 isn't presently "Required"
 is because of the sarge freeze...

 ... which brings us neatly back full circle as to why i contacted you
 last month to see if i could help in oxford :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
