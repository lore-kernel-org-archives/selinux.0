Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6O6eqHa029335
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 02:40:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6O6epDW012892
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 06:40:51 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h6O6ebeN012886 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 06:40:46 GMT
Date: Thu, 24 Jul 2003 16:39:49 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Dale Amon <amon@vnl.com>
Cc: Lukasz Luzar <lluzar@tigeraudits.com>,
   "Carsten P. Gehrke" <Carsten@rollinghorse.com>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Message-ID: <20030724063949.GC16983@snoopy.apana.org.au>
References: <5.1.1.6.2.20030723080629.0a198680@Shire> <Pine.LNX.4.44.0307232139200.9324-100000@chaos.tigeraudits.com> <20030724002949.GI4900@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030724002949.GI4900@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 24, 2003 at 01:29:49AM +0100, Dale Amon wrote:
> On Wed, Jul 23, 2003 at 10:26:42PM +0200, Lukasz Luzar wrote:
> > > Is this true of the GNU C compiler suite as well?  And if so, would it not 
> > > be possible to remove it from the compiler?  How does it work?  Does it 
> > > look at the code, or is anything called login.c susceptible?  Why has this 
> > > not been removed in the open-source code?  How can I check to see if this 
> > > backdoor exists?
> 
> Of course you could always create a file like this:
> 
> login.c
>   main () { printf ("Hello World\n"); }
> 
> and the hand decompile the binary to see if there
> is anything unexpected present.

Does this proove anything though?

A trojon horse in the compiler could be clever enough not to insert
any back doors on such simple code...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
