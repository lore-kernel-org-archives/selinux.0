Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6O0U0Ha028598
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 20:30:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6O0TxDW006899
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 00:29:59 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h6O0TxeN006896 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 00:29:59 GMT
Date: Thu, 24 Jul 2003 01:29:49 +0100
From: Dale Amon <amon@vnl.com>
To: Lukasz Luzar <lluzar@tigeraudits.com>
Cc: "Carsten P. Gehrke" <Carsten@rollinghorse.com>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Message-ID: <20030724002949.GI4900@vnl.com>
References: <5.1.1.6.2.20030723080629.0a198680@Shire> <Pine.LNX.4.44.0307232139200.9324-100000@chaos.tigeraudits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0307232139200.9324-100000@chaos.tigeraudits.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 23, 2003 at 10:26:42PM +0200, Lukasz Luzar wrote:
> Hello,
> 
> > Is this true of the GNU C compiler suite as well?  And if so, would it not 
> > be possible to remove it from the compiler?  How does it work?  Does it 
> > look at the code, or is anything called login.c susceptible?  Why has this 
> > not been removed in the open-source code?  How can I check to see if this 
> > backdoor exists?

Of course you could always create a file like this:

login.c
  main () { printf ("Hello World\n"); }

and the hand decompile the binary to see if there
is anything unexpected present.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
